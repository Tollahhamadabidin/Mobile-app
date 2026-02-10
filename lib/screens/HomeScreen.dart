import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Instagram", style: TextStyle(fontFamily: 'Billabong', fontSize: 32)),
        actions: [
          IconButton(icon: Icon(Icons.favorite_border), onPressed: () {}),
          IconButton(icon: Icon(Icons.chat_bubble_outline), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Stories Section
            Container(
              height: 110,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) => StoryWidget(),
              ),
            ),
            Divider(height: 1),
            // Posts Section
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) => PostWidget(),
            ),
          ],
        ),
      ),
    );
  }
}

class StoryWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          CircleAvatar(radius: 35, backgroundColor: Colors.pink,
              child: CircleAvatar(radius: 32, backgroundImage: NetworkImage("https://picsum.photos/200"))),
          SizedBox(height: 5),
          Text("User", style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}

class PostWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: CircleAvatar(backgroundImage: NetworkImage("https://picsum.photos/100")),
          title: Text("username", style: TextStyle(fontWeight: FontWeight.bold)),
          trailing: Icon(Icons.more_vert),
        ),
        Image.network("https://picsum.photos/400", fit: BoxFit.cover),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(Icons.favorite_border, size: 30),
              SizedBox(width: 15),
              Icon(Icons.mode_comment_outlined, size: 30),
              SizedBox(width: 15),
              Icon(Icons.send_outlined, size: 30),
              Spacer(),
              Icon(Icons.bookmark_border, size: 30),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text("Liked by 1,234 others", style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}