import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_get_api_example/bloc/comments_bloc/comments_bloc.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({super.key});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<CommentsBloc>().add(CommentsFetched());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Comments"),
      ),
      body: BlocBuilder<CommentsBloc, CommentsState>(builder: (context, state) {
        if (state.status == LoadingStatus.loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.message != "success") {
          return Center(
            child: Text(state.message.toString()),
          );
        } else if (state.status == LoadingStatus.success &&
            state.message == "success") {
          return ListView.builder(
              itemCount: state.commentsList.length,
              itemBuilder: (context, index) {
                var commentData = state.commentsList[index];
                return ListTile(
                  title: Text(
                    commentData.name.toString(),
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(commentData.body.toString()),
                );
              });
        }
        return SizedBox();
      }),
    );
  }
}
