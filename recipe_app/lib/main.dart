import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_html/flutter_html.dart'; 

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

class RecipeListScreen extends StatefulWidget {
  const RecipeListScreen({super.key});

  @override
  State<RecipeListScreen> createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  List<Recipe> recipes = [];
  @override
  void initState() {
    super.initState();
    _loadRecipes();
  }

  Future<void> _loadRecipes() async {
    // Load the JSON file from assets
    final String response = await DefaultAssetBundle.of(context).loadString('assets/data/recipe-list.json');
    final List<dynamic> data = json.decode(response) as List<dynamic>;

    // Parse the JSON data into Recipe objects
    setState(() {
      recipes = data.map((json) => Recipe.fromJson(json as Map<String, dynamic>)).toList();
      recipes = recipes + recipes;
    });
  }
  
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
              subtitle: Text('${recipe.description}\nServes: ${recipe.serves}'),
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
  final String id;
  final String title;
  final String description;
  final String img;
  final String imgCredits;
  final String imgAlt;
  final List<String> tags;
  final int serves;
  final int prep;
  final int cook;
  final List<String> ingredients;
  final List<String> tools;
  final List<String> instructions;

  const Recipe({
    required this.id,
    required this.title,
    required this.description,
    required this.img,
    required this.imgCredits,
    required this.imgAlt,
    required this.tags,
    required this.serves,
    required this.prep,
    required this.cook,
    required this.ingredients,
    required this.tools,
    required this.instructions,
  });

  // Factory to create a Recipe from JSON
  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      img: json['img'],
      imgCredits: json['imgCredits'],
      imgAlt: json['imgAlt'],
      tags: List<String>.from(json['tags']),
      serves: json['serves'],
      prep: json['prep'],
      cook: json['cook'],
      ingredients: List<String>.from(json['ingredients']),
      tools: List<String>.from(json['tools']),
      instructions: List<String>.from(json['instructions']),
    );
  }
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(recipe.img, fit: BoxFit.cover),
            Html(data: recipe.imgCredits),
            Text(recipe.description, style: const TextStyle(fontSize: 16.0)),
            Text('Tags: ${recipe.tags.join(', ')}'),
            Text('Serves: ${recipe.serves}'),
            Text('Prep Time: ${recipe.prep} min'),
            Text('Cook Time: ${recipe.cook} min'),
            Text('Ingredients:', style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: recipe.ingredients.map((ingredient) => Text('• $ingredient')).toList(),
            ),
            const SizedBox(height: 16.0),
            Text('Tools:', style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: recipe.tools.map((tool) => Text('• $tool')).toList(),
            ),
            const SizedBox(height: 16.0),
            Text('Instructions:', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: recipe.instructions.map((instruction) => Text('• $instruction')).toList(),
              spacing: 5.0,
            ),
          ],
        ),
      ),
    );
  }
}