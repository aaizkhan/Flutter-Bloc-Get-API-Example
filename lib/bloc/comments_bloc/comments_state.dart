part of 'comments_bloc.dart';

enum LoadingStatus { loading, success, failed }

class CommentsState extends Equatable {
  final LoadingStatus status;
  final List<CommentModel> commentsList;
  final String message;

  const CommentsState(
      {this.status = LoadingStatus.loading,
      this.commentsList = const <CommentModel>[],
      this.message = ''});

  CommentsState copyWith(
      {LoadingStatus? status,
      List<CommentModel>? commentsList,
      String? message}) {
    return CommentsState(
        status: status ?? this.status,
        commentsList: commentsList ?? this.commentsList,
        message: message ?? this.message);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [status, commentsList, message];
}
