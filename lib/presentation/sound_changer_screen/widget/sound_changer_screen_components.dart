part of 'sound_changer_screen.dart';

class _SoundChangerScreenComponents extends StatelessWidget {
  const _SoundChangerScreenComponents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            'Sound Editor',
            style: mediumText,
          ),
          centerTitle: true,
        ),
        body: const _SoundChangerOptions(),
      );
}
