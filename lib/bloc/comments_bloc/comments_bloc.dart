import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_get_api_example/model/comment_model.dart';
import 'package:flutter_bloc_get_api_example/repository/comment_repository.dart';
import 'package:meta/meta.dart';

part 'comments_event.dart';
part 'comments_state.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  CommentsRepository commentsRepository = CommentsRepository();

  CommentsBloc() : super(CommentsState()) {
    on<CommentsFetched>(_fetchComments);
  }

  Future<void> _fetchComments(
      CommentsEvent event, Emitter<CommentsState> emit) async {
    await commentsRepository.fetchComments().then((value) {
      emit(state.copyWith(
          status: LoadingStatus.success,
          commentsList: value,
          message: 'success'));
    }).onError((error, stackTrace) {
      emit(state.copyWith(status: LoadingStatus.failed, message: 'success'));
    });
  }
}
