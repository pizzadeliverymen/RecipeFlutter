import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Recipes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RecipeListScreen(),
    );
  }
}

class RecipeListScreen extends StatelessWidget {
  const RecipeListScreen({super.key});

  // Dummy recipe data for now
  final List<Recipe> recipes = const [
    Recipe(title: 'Spaghetti Carbonara', ingredients: ['Pasta', 'Eggs', 'Pecorino Romano', 'Guanciale', 'Black Pepper']),
    Recipe(title: 'Chocolate Cake', ingredients: ['Flour', 'Sugar', 'Cocoa Powder', 'Eggs', 'Butter', 'Milk']),
    Recipe(title: 'Tomato Soup', ingredients: ['Tomatoes', 'Onion', 'Garlic', 'Vegetable Broth', 'Basil']),
  ];

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Recipes'),
      ),
      body: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          final recipe = recipes[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(recipe.title, style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
              subtitle: Text('Ingredients: ${recipe.ingredients.join(', ')}'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RecipeDetailScreen(recipe: recipe),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class Recipe {
  const Recipe({required this.title, required this.ingredients});
  final String title;
  final List<String> ingredients;
}

class RecipeDetailScreen extends StatelessWidget {
  const RecipeDetailScreen({super.key, required this.recipe});
  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Ingredients:', style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8.0),
            Text(recipe.ingredients.join('\n')),
            const SizedBox(height: 16.0),
            const Text('Instructions:', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8.0),
            const Text('Instructions will go here in the future.'), // Placeholder
          ],
        ),
      ),
    );
  }
}