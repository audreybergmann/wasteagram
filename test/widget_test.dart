

import '../models/food_waste_post.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Post created from may should have appropriate property values', () {
    final date = DateTime.parse('2020-01-01');
    const url = 'FAKE';
    const quantity = 1;
    const latitude = 1.0;
    const longitude = 2.0;

    final foodWastePost = FoodWastePost(
      date: date,
      url: url,
      quantity: quantity,
      latitude: latitude,
      longitude: longitude
    );
    expect(foodWastePost.date, date);
    expect(foodWastePost.url, url);
    expect(foodWastePost.quantity, quantity);
    expect(foodWastePost.latitude, latitude);
    expect(foodWastePost.longitude, longitude);
  });
}
