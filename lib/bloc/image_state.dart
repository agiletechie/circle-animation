part of 'image_bloc.dart';

class ImageState extends Equatable {
  const ImageState();

  @override
  List<Object> get props => [];
}

final class ImageInitial extends ImageState {}

final class ImageLoading extends ImageState {}

final class ImageLoaded extends ImageState {
  const ImageLoaded(this.url);
  final String url;
}

final class ImageError extends ImageState {}
