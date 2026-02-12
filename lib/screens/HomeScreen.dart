import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Instagram",
          style: TextStyle(
            fontFamily: 'Billabong',
            fontSize: 32,
            fontWeight: FontWeight.w400,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Notifications clicked')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.chat_bubble_outline),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Messages clicked')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Stories Section
            SizedBox(
              height: 110,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemBuilder: (context, index) => StoryWidget(index: index),
              ),
            ),
            const Divider(height: 1),
            // Posts Section
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) => PostWidget(index: index),
            ),
          ],
        ),
      ),
    );
  }
}

class StoryWidget extends StatelessWidget {
  final int index;

  const StoryWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Story ${index + 1} clicked')),
          );
        },
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Colors.purple, Colors.orange, Colors.pink],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding: const EdgeInsets.all(3),
              child: CircleAvatar(
                radius: 32,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 29,
                  backgroundImage: NetworkImage("https://picsum.photos/id/${index + 200}/200"),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              "user${index + 1}",
              style: const TextStyle(fontSize: 12),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class PostWidget extends StatefulWidget {
  final int index;

  const PostWidget({super.key, required this.index});

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  bool isLiked = false;
  bool isSaved = false;
  int likeCount = 1234;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // User Header
        ListTile(
          leading: GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Profile of user${widget.index + 1} clicked')),
              );
            },
            child: CircleAvatar(
              backgroundImage: NetworkImage("https://picsum.photos/id/${widget.index + 100}/100"),
            ),
          ),
          title: GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('user${widget.index + 1} profile clicked')),
              );
            },
            child: Text(
              "user${widget.index + 1}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              _showPostOptions(context);
            },
          ),
        ),

        // Post Image
        GestureDetector(
          onDoubleTap: () {
            setState(() {
              if (!isLiked) {
                isLiked = true;
                likeCount++;
              }
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('❤️ Liked!'),
                duration: Duration(milliseconds: 500),
              ),
            );
          },
          child: Image.network(
            "https://picsum.photos/id/${widget.index + 400}/600",
            fit: BoxFit.cover,
            width: double.infinity,
            height: MediaQuery.of(context).size.width, // Square image
          ),
        ),

        // Action Buttons
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              IconButton(
                icon: Icon(
                  isLiked ? Icons.favorite : Icons.favorite_border,
                  color: isLiked ? Colors.red : Colors.black,
                  size: 30,
                ),
                onPressed: () {
                  setState(() {
                    isLiked = !isLiked;
                    likeCount += isLiked ? 1 : -1;
                  });
                },
              ),
              IconButton(
                icon: const Icon(Icons.mode_comment_outlined, size: 30),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Comment section clicked')),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.send_outlined, size: 30),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Share clicked')),
                  );
                },
              ),
              const Spacer(),
              IconButton(
                icon: Icon(
                  isSaved ? Icons.bookmark : Icons.bookmark_border,
                  size: 30,
                ),
                onPressed: () {
                  setState(() {
                    isSaved = !isSaved;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(isSaved ? 'Post saved' : 'Post unsaved'),
                      duration: const Duration(milliseconds: 500),
                    ),
                  );
                },
              ),
            ],
          ),
        ),

        // Like Count
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            "Liked by $likeCount others",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        // Caption
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.black),
              children: [
                TextSpan(
                  text: "user${widget.index + 1} ",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const TextSpan(
                  text: "This is a sample caption for the post 📸 #instagram #flutter",
                ),
              ],
            ),
          ),
        ),

        // View Comments
        GestureDetector(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('View all comments clicked')),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Text(
              "View all 48 comments",
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
        ),

        // Post Time
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Text(
            "${widget.index + 1} hours ago",
            style: TextStyle(color: Colors.grey[600], fontSize: 12),
          ),
        ),

        const SizedBox(height: 10),
      ],
    );
  }

  void _showPostOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.link),
                title: const Text('Copy Link'),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Link copied')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.share),
                title: const Text('Share to...'),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Share options')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.report_outlined),
                title: const Text('Report'),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Report post')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.cancel_outlined),
                title: const Text('Cancel'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
