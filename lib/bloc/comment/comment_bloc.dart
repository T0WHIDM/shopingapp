import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_sample/Data/repository/comment_repository.dart';
import 'package:flutter_shop_sample/bloc/comment/comment_event.dart';
import 'package:flutter_shop_sample/bloc/comment/comment_state.dart';
import 'package:flutter_shop_sample/di/di.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final ICommentRepository commentRepository = locator.get();

  CommentBloc() : super(CommentLoadingState()) {
    on<CommentInitialEvent>((event, emit) async {
      final response = await commentRepository.getComment(event.productId);
      emit(CommentResponseState(response));
    });
  }
}
