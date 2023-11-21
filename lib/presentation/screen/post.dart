import 'package:flutter/material.dart';
import 'package:flutter_bottom_aierke/presentation/bloc/bloc/marsh_bloc.dart';
import 'package:flutter_bottom_aierke/presentation/bloc/bloc/marsh_event.dart';
import 'package:flutter_bottom_aierke/presentation/bloc/bloc/marsh_state.dart';

class PostsPage extends StatefulWidget {
  @override
  _PostsPageState createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  final _bloc = MarshBloc();

  @override
  void initState() {
    super.initState();
    _bloc.eventSink.add(FetchPostsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Posts')),
      body: StreamBuilder<MarshState>(
        stream: _bloc.stateStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: Text("Waiting for data..."));
          }

          if (snapshot.data is LoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.data is ErrorState) {
            final errorState = snapshot.data as ErrorState;
            return Center(child: Text('Error: ${errorState.message}'));
          } else if (snapshot.data is LoadedState) {
            final loadedState = snapshot.data as LoadedState;
            final posts = loadedState.posts;
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ListTile(title: Text(post.title)),
                    ListTile(title: Text('UserID: ${post.userId}')),
                    ListTile(title: Text('ID: ${post.id}')),
                    ListTile(title: Text('Body: ${post.body}')),
                    Divider(color: Colors.grey),
                  ],
                );
              },
            );
          } else {
            return Center(child: Text("Unknown state"));
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }
}
