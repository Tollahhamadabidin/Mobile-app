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
    const HomeScreen(),          // Fixed: Added const
    const SearchGridScreen(),
    const AddPostScreen(),
    const ReelsScreen(),
    const ProfileScreen(),       // Fixed: Added const if ProfileScreen supports it
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
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            decoration: const InputDecoration(
              hintText: 'Search',
              prefixIcon: Icon(Icons.search),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 10),
            ),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Search clicked')),
              );
            },
          ),
        ),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
        ),
        itemCount: 30,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Image ${index + 1} clicked')),
            );
          },
          child: Image.network(
            "https://picsum.photos/id/${index + 50}/200",
            fit: BoxFit.cover,
          ),
        ),
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
      appBar: AppBar(
        title: const Text("New Post"),
        actions: [
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Next clicked')),
              );
            },
            child: const Text("Next"),
          ),
        ],
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Select image clicked')),
              );
            },
            child: Container(
              height: 300,
              color: Colors.grey[300],
              child: const Center(
                child: Icon(Icons.image, size: 100, color: Colors.grey),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.location_on),
            title: const Text("Add Location"),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Add location clicked')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.person_add),
            title: const Text("Tag People"),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Tag people clicked')),
              );
            },
          ),
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
            Center(
              child: Image.network(
                "https://picsum.photos/id/${index + 10}/400/800",
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            Positioned(
              bottom: 20,
              right: 10,
              child: Column(
                children: [
                  IconButton(
                    icon: const Icon(Icons.favorite, color: Colors.white, size: 35),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Reel liked'),
                          duration: Duration(milliseconds: 500),
                        ),
                      );
                    },
                  ),
                  const Text("12k", style: TextStyle(color: Colors.white)),
                  const SizedBox(height: 20),
                  IconButton(
                    icon: const Icon(Icons.chat_bubble_outline, color: Colors.white, size: 35),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Comments clicked'),
                          duration: Duration(milliseconds: 500),
                        ),
                      );
                    },
                  ),
                  const Text("450", style: TextStyle(color: Colors.white)),
                  const SizedBox(height: 20),
                  IconButton(
                    icon: const Icon(Icons.send, color: Colors.white, size: 35),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Share clicked'),
                          duration: Duration(milliseconds: 500),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
