import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:tech_task/locator.dart';
import 'package:tech_task/models/ingredientModel/ingredients_model.dart';
import 'package:tech_task/models/recipeModel/recipe_model.dart';
import 'package:tech_task/service/networks/api_client.dart';

class MockDio extends Mock implements Dio {}

final provider = myLocator<ApiClient>();
void main() {
  group(
    'getRecipes',
    () {
      final String baseUrl =
          "https://lb7u7svcm5.execute-api.ap-southeast-1.amazonaws.com/dev";
      final ingredients = [
        IngredientModel(title: 'Ham', useBy: '2022-12-31'),
        IngredientModel(title: 'Bread', useBy: '2022-12-31'),
        IngredientModel(title: 'Cheese', useBy: '2022-12-31'),
      ];

      test('returns a list of recipes when successful', () async {
        final dio = MockDio();
        when(dio.get('$baseUrl/recipes', queryParameters: {"": ""}))
            .thenAnswer((_) async => Response(
                  statusCode: 200,
                  data: [
                    {'name': 'Ham and Cheese Sandwich', 'instructions': '...'},
                    {'name': 'Grilled Cheese Sandwich', 'instructions': '...'},
                  ],
                  requestOptions: null,
                ));

        final recipes = await provider.getRecipes(ingredients);

        expect(recipes.length, 2);
        expect(recipes[0], isA<RecipeModel>());
        expect(recipes[1], isA<RecipeModel>());
        expect(recipes[0].title, 'Ham and Cheese Sandwich');
        expect(recipes[1].title, 'Grilled Cheese Sandwich');

        verify(dio.get('$baseUrl/recipes', queryParameters: {
          'ingredients': '<<Ham>>, <<Bread>>, <<Cheese>>',
        })).called(1);
      });

      test('returns an empty list when response is not successful', () async {
        final dio = MockDio();
        when(dio.get('$baseUrl/recipes', queryParameters: any)).thenAnswer(
            (_) async => Response(statusCode: 500, requestOptions: null));

        final recipes = await provider.getRecipes(ingredients);

        expect(recipes, isEmpty);

        verify(dio.get('$baseUrl/recipes', queryParameters: {
          'ingredients': '<<Ham>>, <<Bread>>, <<Cheese>>',
        })).called(1);
      });
    },
  );

  group('getIngredients', () {
    final String baseUrl =
        "https://lb7u7svcm5.execute-api.ap-southeast-1.amazonaws.com/dev";

    test('Get Ingredients Test', () async {
      final mockDio = MockDio();

      final mockResponse = Response(
        statusCode: 200,
        data: [
          {'title': 'Ham', 'use-by': '2023-04-01'},
          {'title': 'Bread', 'use-by': '2023-03-25'},
          {'title': 'Cheese', 'use-by': '2023-03-29'},
        ],
        requestOptions: null,
      );
      when(mockDio.get('$baseUrl/ingredients'))
          .thenAnswer((_) async => mockResponse);

      final result = await provider.getIngredients();

      expect(result.length, 3);
      expect(result[0].title, 'Ham');
      expect(result[1].useBy, DateTime.parse('2023-03-25'));
      expect(result[2].toJson(), {'title': 'Cheese', 'use-by': '2023-03-29'});
    });
  });
}
