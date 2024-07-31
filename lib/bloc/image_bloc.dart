import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:wyb_app/data/fetch_image.dart';

part 'image_event.dart';
part 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  ImageBloc() : super(ImageInitial()) {
    debugPrint('came');
    on<FetchImageEvent>(_fetchImage);
  }

  void _fetchImage(event, emit) async {
    emit(ImageLoading());
    try {
      final String url = await GetImage().fetchImage();
      emit(ImageLoaded(url));
    } catch (e) {
      emit(ImageError());
    }
  }
}
