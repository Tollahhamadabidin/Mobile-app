import 'package:flutter/material.dart';
import 'HomeScreen.dart';
import 'ProfileScreen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  // Updated List of screens with actual content
  final List<Widget> _pages = [
    HomeScreen(),
    const SearchGridScreen(),  // New Search Content
    const AddPostScreen(),    // New Add Post Content
    const ReelsScreen(),      // New Reels Content
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.add_box_outlined), label: 'Add'),
          BottomNavigationBarItem(icon: Icon(Icons.movie_outlined), label: 'Reels'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

// --- 1. SEARCH GRID SCREEN ---
class SearchGridScreen extends StatelessWidget {
  const SearchGridScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 40,
          decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
          child: const TextField(
            decoration: InputDecoration(hintText: 'Search', prefixIcon: Icon(Icons.search), border: InputBorder.none),
          ),
        ),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, crossAxisSpacing: 2, mainAxisSpacing: 2),
        itemCount: 30,
        itemBuilder: (context, index) => Image.network("https://picsum.photos/id/${index + 50}/200", fit: BoxFit.cover),
      ),
    );
  }
}

// --- 2. ADD POST SCREEN ---
class AddPostScreen extends StatelessWidget {
  const AddPostScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("New Post"), actions: [TextButton(onPressed: () {}, child: const Text("Next"))]),
      body: Column(
        children: [
          Container(height: 300, color: Colors.grey[300], child: const Center(child: Icon(Icons.image, size: 100, color: Colors.grey))),
          const ListTile(leading: Icon(Icons.location_on), title: Text("Add Location")),
          const ListTile(leading: Icon(Icons.person_add), title: Text("Tag People")),
        ],
      ),
    );
  }
}

// --- 3. REELS SCREEN ---
class ReelsScreen extends StatelessWidget {
  const ReelsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 5,
        itemBuilder: (context, index) => Stack(
          children: [
            Center(child: Image.network("https://picsum.photos/id/${index + 10}/400/800", fit: BoxFit.cover, width: double.infinity, height: double.infinity)),
            const Positioned(
              bottom: 20, right: 10,
              child: Column(
                children: [
                  Icon(Icons.favorite, color: Colors.white, size: 35), Text("12k", style: TextStyle(color: Colors.white)),
                  SizedBox(height: 20),
                  Icon(Icons.chat_bubble_outline, color: Colors.white, size: 35), Text("450", style: TextStyle(color: Colors.white)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}