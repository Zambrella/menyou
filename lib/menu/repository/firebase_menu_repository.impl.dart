import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_vertexai/firebase_vertexai.dart';
import 'package:logger/logger.dart';
import 'package:men_you/common/extensions/string_extensions.dart';
import 'package:men_you/menu/domain/menu_item.dart';
import 'package:men_you/menu/domain/menu_repository.abs.dart';
import 'package:men_you/menu/domain/restaurant_menu.dart';
import 'package:men_you/photos/domain/photo.dart';
import 'package:uuid/uuid.dart';

class FirebaseMenuRepository implements MenuRepository {
  const FirebaseMenuRepository(
    this._aiModel,
    this._firestore,
    this._auth,
    this._logger,
  );

  final GenerativeModel _aiModel;
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final Logger _logger;

  static const _menuCollection = 'menus';
  static const _userCollection = 'users';

  @override
  Future<void> addMenu(RestaurantMenu menu) async {
    await _firestore.collection(_userCollection).doc(_auth.currentUser!.uid).collection(_menuCollection).doc(menu.id).set(menu.toJson());
    return;
  }

  @override
  Future<List<MenuItem>> analysePhoto(Photo photo) async {
    // Sometimes running into this error: https://github.com/google-gemini/generative-ai-dart/issues/184
    try {
      final textContent = TextPart('''
From the following restaurant menu picture, provide a list of the items on the menu.
Each item should be output as a JSON object with the following schema:
${MenuItem.getUnprocessedSchema()}
Do not include the price.
''');
      _logger.d('Text content: ${textContent.text}');
      final imageContent = DataPart(photo.mimeType, photo.photoData);
      final multiContent = Content.multi([textContent, imageContent]);
      final response = await _aiModel.generateContent(
        [multiContent],
        generationConfig: GenerationConfig(
          responseMimeType: 'application/json',
          temperature: 0.1,
        ),
      );
      final rawText = response.text;
      if (rawText == null) {
        throw Exception('No text found in the image');
      }
      _logger.d('Raw text: $rawText');
      final json = (jsonDecode(rawText) as List<dynamic>).cast<Map<String, dynamic>>();
      final items = json.map(
        (e) {
          final title = (e['title'] as String).trim().replaceAll('\n', ' ');
          final subtitle = (e['subtitle'] as String?)?.trim().replaceAll('\n', ' ');
          return MenuItem.unprocessed(
            id: const Uuid().v4(),
            title: title,
            subtitle: subtitle,
          );
        },
      ).toList();
      _logger.d('Unprocessed menu items: $items');
      return items;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  Future<void> deleteMenu(String menuId) async {
    try {
      final docRef = _firestore.collection(_userCollection).doc(_auth.currentUser!.uid).collection(_menuCollection).doc(menuId);
      await docRef.delete();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<RestaurantMenu>> getAllMenus() async {
    try {
      final collectionRef = _firestore.collection(_userCollection).doc(_auth.currentUser!.uid).collection(_menuCollection);
      final snapshot = await collectionRef.get();
      final menus = snapshot.docs.map((doc) => RestaurantMenu.fromJson(doc.data())).toList();
      return menus;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<RestaurantMenu> getMenuById(String id) {
    // TODO: implement getMenuById
    throw UnimplementedError();
  }

  @override
  Future<MenuItem> processMenuItem(MenuItem menuItem) async {
    try {
      final textContent = Content.text('''
Given the following information about an item on a restaurant menu, provide a description and list of potential allergens.
Return the information as a JSON object with the following schema:
${MenuItem.getProcessedSchema()}
The list of allergens should be zero or more of the following: celery, gluten, crustacean, egg, fish, lupin, milk, molluscs, mustard, nuts, peanuts, sesame, soya, and sulphur dioxide.
## Menu Item
- Title: ${menuItem.title}
- Subtitle: ${menuItem.subtitle}
''');
      _logger.d('Text content: ${textContent.toJson()}');
      final response = await _aiModel.generateContent(
        [textContent],
        generationConfig: GenerationConfig(
          responseMimeType: 'application/json',
          temperature: 0.1,
        ),
      );
      final rawText = response.text;
      _logger.d('Raw text: $rawText');
      if (rawText == null) {
        throw Exception('No text found in the image');
      }
      final json = jsonDecode(rawText) as Map<String, dynamic>;
      final description = json['description'] as String;
      final allergens = (json['allergens'] as List<dynamic>).cast<String>().map((e) => e.trim().capitalizeEachWord()).toList();
      final processedMenuItem = MenuItem.processed(
        id: menuItem.id,
        title: menuItem.title,
        subtitle: menuItem.subtitle,
        description: description,
        allergens: allergens,
      );
      _logger.d('Processed menu item: $processedMenuItem');
      return processedMenuItem;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateMenu(RestaurantMenu menu) async {
    await _firestore.collection(_userCollection).doc(_auth.currentUser!.uid).collection(_menuCollection).doc(menu.id).set(menu.toJson());
    return;
  }

  @override
  Future<String> generateImage(ProcessedMenuItem menuItem) async {
    throw UnimplementedError();
  }

  @override
  Future<String> sendMessageAboutMenuItem(ProcessedMenuItem menuItem, String message) async {
    try {
      final chat = _aiModel.startChat(
          // // Apparently having the first message as a model doesn't work - https://stackoverflow.com/a/78403270
//         history: [
//           Content.model(
//             [
//               TextPart(
//                 '''
// You are an expert about restaurant food. Answer questions about the following menu item:\n
// - Title: ${menuItem.title}
// - Subtitle: ${menuItem.subtitle}
// ''',
//               ),
//             ],
//           ),
//         ],
          );
      final initialMessage = Content.text('''
You are an expert about restaurant food. Answer questions about the following menu item:
## Menu Item
- Title: ${menuItem.title}
- Subtitle: ${menuItem.subtitle}

## Question
$message
''');
      final response = await chat.sendMessage(initialMessage);
      final responseText = response.text;
      _logger.d('Response text: $responseText');
      if (responseText == null) {
        throw Exception('No text found in the response');
      }
      return responseText;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
