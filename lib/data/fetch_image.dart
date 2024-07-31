class GetImage {
  Future<String> fetchImage() async {
    String image = '';

    try {
      // just to mimic network call
      final String res = await Future.delayed(
        const Duration(milliseconds: 200),
        () {
          return 'https://images.unsplash.com/photo-1719453400869-5ee4d6c5bf59?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';
        },
      );
      image = res;
    } catch (e) {
      throw Exception('couldn\'t fetch image');
    }
    return image;
  }
}
