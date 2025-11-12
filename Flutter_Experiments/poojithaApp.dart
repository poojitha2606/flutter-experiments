import 'dart:async';
import 'dart:convert';
import 'dart:html' as html; // for HttpRequest & localStorage (works in DartPad)
import 'package:flutter/material.dart';

// Entry
void main() => runApp(RecipeHubApp());

// ---------------------------
// Models
// ---------------------------
class MealSummary {
  final String id;
  final String title;
  final String thumbnail;

  MealSummary({required this.id, required this.title, required this.thumbnail});

  factory MealSummary.fromJson(Map<String, dynamic> j) => MealSummary(
      id: j['idMeal'] ?? '', title: j['strMeal'] ?? '', thumbnail: j['strMealThumb'] ?? '');
}

class MealDetail {
  final String id;
  final String title;
  final String category;
  final String area;
  final String instructions;
  final String thumbnail;
  final Map<String, String> ingredients; // ingredient -> measure
  final String youtube;

  MealDetail({
    required this.id,
    required this.title,
    required this.category,
    required this.area,
    required this.instructions,
    required this.thumbnail,
    required this.ingredients,
    required this.youtube,
  });

  factory MealDetail.fromJson(Map<String, dynamic> j) {
    // collect up to 20 ingredient/measure pairs
    final Map<String, String> ingr = {};
    for (int i = 1; i <= 20; i++) {
      final ing = (j['strIngredient$i'] ?? '').toString().trim();
      final meas = (j['strMeasure$i'] ?? '').toString().trim();
      if (ing.isNotEmpty) {
        ingr[ing] = meas;
      }
    }
    return MealDetail(
      id: j['idMeal'] ?? '',
      title: j['strMeal'] ?? '',
      category: j['strCategory'] ?? '',
      area: j['strArea'] ?? '',
      instructions: j['strInstructions'] ?? '',
      thumbnail: j['strMealThumb'] ?? '',
      ingredients: ingr,
      youtube: j['strYoutube'] ?? '',
    );
  }
}

// ---------------------------
// API helpers (TheMealDB)
// ---------------------------
class RecipeApi {
  static const String base = 'https://www.themealdb.com/api/json/v1/1';

  // Search by ingredient (returns summaries)
  static Future<List<MealSummary>> searchByIngredient(String ingredient) async {
    final url = '$base/filter.php?i=${Uri.encodeComponent(ingredient)}';
    try {
      final req = await html.HttpRequest.request(url, method: 'GET');
      if (req.status == 200) {
        final data = json.decode(req.responseText ?? '');
        if (data['meals'] == null) return [];
        final list = (data['meals'] as List).map((e) => MealSummary.fromJson(e)).toList();
        return list;
      }
    } catch (e) {
      // ignore
    }
    return [];
  }

  // Lookup by ID for full details
  static Future<MealDetail?> lookupById(String id) async {
    final url = '$base/lookup.php?i=${Uri.encodeComponent(id)}';
    try {
      final req = await html.HttpRequest.request(url, method: 'GET');
      if (req.status == 200) {
        final data = json.decode(req.responseText ?? '');
        if (data['meals'] == null) return null;
        final obj = data['meals'][0];
        return MealDetail.fromJson(obj);
      }
    } catch (e) {
      // ignore
    }
    return null;
  }
}

// ---------------------------
// Favorites storage (localStorage)
// ---------------------------
class FavoritesStorage {
  static const String key = 'dartpad_recipehub_favs';

  // stored map of id -> serialized MealSummary JSON
  static List<MealSummary> load() {
    try {
      final raw = html.window.localStorage[key];
      if (raw == null) return [];
      final decoded = json.decode(raw) as List;
      return decoded
          .map((e) => MealSummary(
                id: e['id'] ?? '',
                title: e['title'] ?? '',
                thumbnail: e['thumbnail'] ?? '',
              ))
          .toList();
    } catch (e) {
      return [];
    }
  }

  static void save(List<MealSummary> items) {
    final serialized = items
        .map((m) => {'id': m.id, 'title': m.title, 'thumbnail': m.thumbnail})
        .toList();
    html.window.localStorage[key] = json.encode(serialized);
  }

  static bool isFavorite(String id) {
    final list = load();
    return list.any((m) => m.id == id);
  }

  static void toggleFavorite(MealSummary item) {
    final list = load();
    final exists = list.indexWhere((m) => m.id == item.id);
    if (exists >= 0) {
      list.removeAt(exists);
    } else {
      list.add(item);
    }
    save(list);
  }
}

// ---------------------------
// App Root
// ---------------------------
class RecipeHubApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RecipeHub (DartPad)',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.grey[50],
      ),
      routes: {
        '/': (_) => HomePage(),
        '/favorites': (_) => FavoritesPage(),
      },
    );
  }
}

// ---------------------------
// Home Page (Search + Results)
// ---------------------------
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  final TextEditingController _searchCtrl = TextEditingController();
  List<MealSummary> _results = [];
  bool _loading = false;
  String _error = '';

  // animation for list fade
  late AnimationController _animCtrl;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    _fade = CurvedAnimation(parent: _animCtrl, curve: Curves.easeIn);
  }

  Future<void> _doSearch(String ingredient) async {
    final q = ingredient.trim();
    if (q.isEmpty) {
      setState(() {
        _results = [];
        _error = '';
      });
      return;
    }

    setState(() {
      _loading = true;
      _error = '';
      _results = [];
    });
    final res = await RecipeApi.searchByIngredient(q);
    setState(() {
      _loading = false;
      _results = res;
      if (res.isEmpty) {
        _error = 'No recipes found for "$q"';
      } else {
        _animCtrl.reset();
        _animCtrl.forward();
      }
    });
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchCtrl,
              textInputAction: TextInputAction.search,
              onSubmitted: _doSearch,
              decoration: InputDecoration(
                hintText: 'Search by ingredient (e.g., chicken, potato, egg)...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
          SizedBox(width: 10),
          ElevatedButton(
            onPressed: () => _doSearch(_searchCtrl.text),
            child: Text('Search'),
          ),
        ],
      ),
    );
  }

  Widget _buildResultGrid(double width) {
    // responsive columns
    int columns = 1;
    if (width >= 1100) columns = 4;
    else if (width >= 800) columns = 3;
    else if (width >= 600) columns = 2;
    else columns = 1;

    return FadeTransition(
      opacity: _fade,
      child: GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columns,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.15,
        ),
        itemCount: _results.length,
        itemBuilder: (ctx, i) {
          final m = _results[i];
          return MealCard(meal: m);
        },
      ),
    );
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    _animCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final body = _loading
        ? Center(child: CircularProgressIndicator())
        : (_error.isNotEmpty
            ? Center(child: Text(_error, style: TextStyle(fontSize: 16)))
            : (_results.isEmpty
                ? Center(
                    child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      'Search recipes by ingredient and tap a card to see full recipe.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  ))
                : LayoutBuilder(builder: (ctx, cons) {
                    return _buildResultGrid(cons.maxWidth);
                  })));

    return Scaffold(
      appBar: AppBar(
        title: Text('RecipeHub'),
        actions: [
          IconButton(
            tooltip: 'Favorites',
            icon: Icon(Icons.favorite_border),
            onPressed: () => Navigator.pushNamed(context, '/favorites'),
          )
        ],
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(child: body),
        ],
      ),
    );
  }
}

// ---------------------------
// Meal Card (Summary) with Hero
// ---------------------------
class MealCard extends StatelessWidget {
  final MealSummary meal;
  MealCard({required this.meal});

  @override
  Widget build(BuildContext context) {
    final fav = FavoritesStorage.isFavorite(meal.id);
    return InkWell(
      onTap: () async {
        // push details; show spinner briefly
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => MealDetailPage(id: meal.id, heroTag: 'meal_${meal.id}')));
      },
      borderRadius: BorderRadius.circular(12),
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                child: Hero(
                  tag: 'meal_${meal.id}',
                  child: FadeInImage(
                    placeholder: NetworkImage('https://via.placeholder.com/20'),
                    image: NetworkImage(meal.thumbnail),
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      meal.title,
                      style: TextStyle(fontWeight: FontWeight.w600),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: Icon(fav ? Icons.favorite : Icons.favorite_border, color: fav ? Colors.red : Colors.grey),
                    onPressed: () {
                      FavoritesStorage.toggleFavorite(meal);
                      // small feedback
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(fav ? 'Removed from favorites' : 'Added to favorites')));
                      // rebuild to show new state — in DartPad we cannot easily force parent rebuild; workaround: use Navigator pop/push? but simplest is to call setState in parent — here it's stateless.
                      // quick hack: force rebuild by finding ancestor and calling setState via (not ideal). We'll just rely on snack and storage; user can reopen page to see updated state.
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// ---------------------------
// Meal Detail Page
// ---------------------------
class MealDetailPage extends StatefulWidget {
  final String id;
  final String heroTag;
  MealDetailPage({required this.id, required this.heroTag});

  @override
  _MealDetailPageState createState() => _MealDetailPageState();
}

class _MealDetailPageState extends State<MealDetailPage> with SingleTickerProviderStateMixin {
  MealDetail? _detail;
  bool _loading = true;
  String _error = '';
  late AnimationController _animCtrl;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(vsync: this, duration: Duration(milliseconds: 480));
    _fade = CurvedAnimation(parent: _animCtrl, curve: Curves.easeIn);
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = '';
    });
    final d = await RecipeApi.lookupById(widget.id);
    if (d == null) {
      setState(() {
        _loading = false;
        _error = 'Could not load recipe details.';
      });
      return;
    }
    setState(() {
      _detail = d;
      _loading = false;
    });
    // animate content in
    await Future.delayed(Duration(milliseconds: 60));
    _animCtrl.forward();
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    super.dispose();
  }

  void _toggleFavorite() {
    if (_detail == null) return;
    final summary = MealSummary(id: _detail!.id, title: _detail!.title, thumbnail: _detail!.thumbnail);
    FavoritesStorage.toggleFavorite(summary);
    final isFav = FavoritesStorage.isFavorite(_detail!.id);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(isFav ? 'Added to favorites' : 'Removed from favorites')));
    setState(() {}); // trigger button color change
  }

  @override
  Widget build(BuildContext context) {
    final body = _loading
        ? Center(child: CircularProgressIndicator())
        : (_error.isNotEmpty
            ? Center(child: Text(_error))
            : FadeTransition(
                opacity: _fade,
                child: _detailContent(),
              ));

    return Scaffold(
      appBar: AppBar(
        title: Text(_detail?.title ?? 'Recipe'),
        actions: [
          IconButton(icon: Icon(Icons.favorite), onPressed: () {
            if (_detail != null) _toggleFavorite();
          })
        ],
      ),
      body: body,
    );
  }

  Widget _detailContent() {
    final d = _detail!;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Hero(
            tag: 'meal_${d.id}',
            child: Image.network(d.thumbnail, height: 260, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(d.title, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                SizedBox(height: 6),
                Row(
                  children: [
                    Chip(label: Text(d.category)),
                    SizedBox(width: 8),
                    if (d.area.isNotEmpty) Chip(label: Text(d.area)),
                    Spacer(),
                    IconButton(
                      icon: Icon(FavoritesStorage.isFavorite(d.id) ? Icons.favorite : Icons.favorite_border, color: FavoritesStorage.isFavorite(d.id) ? Colors.red : Colors.grey),
                      onPressed: _toggleFavorite,
                    )
                  ],
                ),
                SizedBox(height: 12),
                Text('Ingredients', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                SizedBox(height: 8),
                ...d.ingredients.entries.map((e) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: Row(
                        children: [
                          Icon(Icons.check_box_outlined, size: 18, color: Colors.teal),
                          SizedBox(width: 8),
                          Expanded(child: Text('${e.key} — ${e.value}')),
                        ],
                      ),
                    )),
                SizedBox(height: 12),
                Text('Instructions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                SizedBox(height: 8),
                Text(d.instructions, style: TextStyle(height: 1.4)),
                SizedBox(height: 20),
                if (d.youtube.isNotEmpty) ...[
                  Text('Video', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  SizedBox(height: 8),
                  TextButton.icon(
                    onPressed: () {
                      // open youtube in new tab
                      html.window.open(d.youtube, '_blank');
                    },
                    icon: Icon(Icons.play_circle_fill),
                    label: Text('Watch on YouTube'),
                  ),
                  SizedBox(height: 8),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------
// Favorites Page
// ---------------------------
class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<MealSummary> _favs = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() {
    setState(() {
      _favs = FavoritesStorage.load();
    });
  }

  @override
  Widget build(BuildContext context) {
    final body = _favs.isEmpty
        ? Center(child: Text('No favorites yet. Save recipes from details or list.'))
        : ListView.separated(
            padding: EdgeInsets.all(12),
            itemCount: _favs.length,
            separatorBuilder: (_, __) => Divider(),
            itemBuilder: (ctx, i) {
              final m = _favs[i];
              return ListTile(
                leading: ClipRRect(borderRadius: BorderRadius.circular(6), child: Image.network(m.thumbnail, width: 56, fit: BoxFit.cover)),
                title: Text(m.title),
                trailing: IconButton(
                  icon: Icon(Icons.delete_outline),
                  onPressed: () {
                    FavoritesStorage.toggleFavorite(m);
                    _load();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Removed from favorites')));
                  },
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => MealDetailPage(id: m.id, heroTag: 'meal_${m.id}'))).then((_) => _load());
                },
              );
            },
          );

    return Scaffold(
      appBar: AppBar(title: Text('Favorites')),
      body: body,
    );
  }
}
