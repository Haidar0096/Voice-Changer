part of 'recordings_screen.dart';

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints.tight(const Size.square(80)),
              child: const CircularProgressIndicator(),
            ),
            const SizedBox(height: 10),
            Text('Loading...', style: largeText),
          ],
        ),
      ),
    );
  }
}
