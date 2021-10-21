part of 'sound_changer_screen.dart';

class _SoundChangerOptions extends StatefulWidget {
  const _SoundChangerOptions();

  @override
  State<_SoundChangerOptions> createState() => _SoundChangerOptionsState();
}

class _SoundChangerOptionsState extends State<_SoundChangerOptions> {
  late final TextEditingController _fileNameController;

  @override
  void initState() {
    super.initState();
    final soundChangerBlocState =
        BlocProvider.of<SoundChangerBloc>(context, listen: false).state;
    _fileNameController =
        TextEditingController(text: soundChangerBlocState.recording!.name);
  }

  @override
  void dispose() {
    _fileNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<SoundChangerBloc, SoundChangerBlocState>(
        builder: (context, soundChangerBlocState) {
          final soundChangerBloc = BlocProvider.of<SoundChangerBloc>(context);

          bool isProcessing = soundChangerBlocState.isProcessing;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '\nfile: ${soundChangerBlocState.recording?.name}\n\n'
                  'duration: ${soundChangerBlocState.recording?.duration}',
                  style: mediumText,
                ),
              ),
              const SizedBox(height: 10),
              const Divider(thickness: 3),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    _tempoSwitchListTile(
                        soundChangerBlocState, soundChangerBloc),
                    const Divider(thickness: 3),
                    _echoSwitchListTile(
                        soundChangerBlocState, soundChangerBloc),
                    const Divider(thickness: 3),
                    _trimSwitchListTile(
                        soundChangerBlocState, soundChangerBloc),
                    const Divider(thickness: 3),
                    _sampleRateSwitchListTile(
                        soundChangerBlocState, soundChangerBloc),
                    const Divider(thickness: 3),
                    _volumeSwitchListTile(
                        soundChangerBlocState, soundChangerBloc),
                    const Divider(thickness: 3),
                    _reverseSwitchListTile(
                        soundChangerBlocState, soundChangerBloc),
                    const Divider(thickness: 3),
                    _fileNameListTile(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _submitButton(isProcessing, soundChangerBloc),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      );

  SwitchListTile _trimSwitchListTile(
          SoundChangerBlocState soundChangerBlocState,
          SoundChangerBloc soundChangerBloc) =>
      SwitchListTile(
        title: Row(
          children: [
            const Icon(Icons.cut),
            const SizedBox(width: 10),
            Text(
                'Trim : ${soundChangerBlocState.trimStart} sec => ${soundChangerBlocState.trimEnd} sec',
                style: mediumText),
          ],
        ),
        subtitle: RangeSlider(
          min: 0.0,
          max:
              soundChangerBlocState.recording!.duration?.inSeconds.toDouble() ??
                  0,
          divisions: soundChangerBlocState.recording!.duration?.inSeconds ?? 0,
          values: RangeValues(soundChangerBlocState.trimStart.toDouble(),
              soundChangerBlocState.trimEnd.toDouble()),
          onChanged: !soundChangerBlocState.shouldTrim
              ? null
              : (rangeValues) {
                  if (rangeValues.start < rangeValues.end) {
                    soundChangerBloc.add(
                      SoundChangerBlocEvent.trimStartChanged(
                          rangeValues.start.round()),
                    );
                    soundChangerBloc.add(
                      SoundChangerBlocEvent.trimEndChanged(
                          rangeValues.end.round()),
                    );
                  }
                },
        ),
        value: soundChangerBlocState.shouldTrim,
        onChanged: (newValue) => soundChangerBloc.add(
          SoundChangerBlocEvent.shouldTrimChanged(newValue),
        ),
        contentPadding: const EdgeInsets.all(8.0),
      );

  SwitchListTile _echoSwitchListTile(
          SoundChangerBlocState soundChangerBlocState,
          SoundChangerBloc soundChangerBloc) =>
      SwitchListTile(
        title: Row(
          children: [
            const Icon(Icons.surround_sound_outlined),
            const SizedBox(width: 10),
            Text('Add Echo', style: mediumText),
          ],
        ),
        value: soundChangerBlocState.shouldAddEcho,
        onChanged: (newValue) => soundChangerBloc.add(
          SoundChangerBlocEvent.shouldAddEchoChanged(newValue),
        ),
        contentPadding: const EdgeInsets.all(8.0),
      );

  _tempoSwitchListTile(SoundChangerBlocState soundChangerBlocState,
          SoundChangerBloc soundChangerBloc) =>
      SwitchListTile(
        title: Row(
          children: [
            const Icon(Icons.speed_outlined),
            const SizedBox(width: 10),
            Text('Tempo : ${soundChangerBlocState.tempo.toStringAsFixed(1)}',
                style: mediumText),
          ],
        ),
        subtitle: Slider(
          min: 0.5,
          max: 2.0,
          value: soundChangerBlocState.tempo,
          onChanged: !soundChangerBlocState.shouldChangeTempo
              ? null
              : (newValue) => soundChangerBloc.add(
                    SoundChangerBlocEvent.tempoChanged(newValue),
                  ),
        ),
        value: soundChangerBlocState.shouldChangeTempo,
        onChanged: (newValue) => soundChangerBloc.add(
          SoundChangerBlocEvent.shouldChangeTempoChanged(newValue),
        ),
        contentPadding: const EdgeInsets.all(8.0),
      );

  _submitButton(bool isProcessing, SoundChangerBloc soundChangerBloc) =>
      isProcessing
          ? const CircularProgressIndicator()
          : ElevatedButton(
              child: Text('apply', style: largeText),
              onPressed: () {
                String? invalidMessage =
                    FileExtension.isValidFileName(_fileNameController.text);
                if (invalidMessage == null) {
                  soundChangerBloc.add(
                    SoundChangerBlocEvent.applyEffects(
                      _fileNameController.text,
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(invalidMessage),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                }
              },
            );

  InputDecoration _roundTextFieldDecoration(String hint) => InputDecoration(
        constraints: BoxConstraints.tight(Size(
            MediaQuery.of(context).size.width / 1.5,
            MediaQuery.of(context).size.height / 15)),
        hintText: hint,
        hintMaxLines: 2,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      );

  _sampleRateSwitchListTile(SoundChangerBlocState soundChangerBlocState,
          SoundChangerBloc soundChangerBloc) =>
      SwitchListTile(
        title: Row(
          children: [
            const Icon(Icons.waves),
            const SizedBox(width: 10),
            Text('sampleRate : ${soundChangerBlocState.sampleRate}',
                style: mediumText),
          ],
        ),
        subtitle: Slider(
          min: 8000,
          max: 120000,
          value: soundChangerBlocState.sampleRate.toDouble(),
          onChanged: !soundChangerBlocState.shouldChangeSampleRate
              ? null
              : (newValue) => soundChangerBloc.add(
                    SoundChangerBlocEvent.sampleRateChanged(newValue.round()),
                  ),
        ),
        value: soundChangerBlocState.shouldChangeSampleRate,
        onChanged: (newValue) => soundChangerBloc.add(
          SoundChangerBlocEvent.shouldChangeSampleRateChanged(newValue),
        ),
        contentPadding: const EdgeInsets.all(8.0),
      );

  _volumeSwitchListTile(SoundChangerBlocState soundChangerBlocState,
          SoundChangerBloc soundChangerBloc) =>
      SwitchListTile(
        title: Row(
          children: [
            const Icon(Icons.volume_down),
            const SizedBox(width: 10),
            Text('volume : ${soundChangerBlocState.volume.toStringAsFixed(0)}',
                style: mediumText),
          ],
        ),
        subtitle: Slider(
          min: 0.0,
          max: 100.0,
          value: soundChangerBlocState.volume,
          onChanged: !soundChangerBlocState.shouldChangeVolume
              ? null
              : (newValue) => soundChangerBloc.add(
                    SoundChangerBlocEvent.volumeChanged(newValue),
                  ),
        ),
        value: soundChangerBlocState.shouldChangeVolume,
        onChanged: (newValue) => soundChangerBloc.add(
          SoundChangerBlocEvent.shouldChangeVolumeChanged(newValue),
        ),
        contentPadding: const EdgeInsets.all(8.0),
      );

  _reverseSwitchListTile(SoundChangerBlocState soundChangerBlocState,
          SoundChangerBloc soundChangerBloc) =>
      SwitchListTile(
        title: Row(
          children: [
            const Icon(Icons.switch_left_outlined),
            const SizedBox(width: 10),
            Text('Reverse sound', style: mediumText),
          ],
        ),
        value: soundChangerBlocState.shouldReverse,
        onChanged: (newValue) => soundChangerBloc.add(
          SoundChangerBlocEvent.shouldReverseChanged(newValue),
        ),
        contentPadding: const EdgeInsets.all(8.0),
      );

  _fileNameListTile() => ListTile(
        title: Column(
          children: [
            Text('save to file', style: mediumText),
            const SizedBox(height: 10),
            TextField(
              controller: _fileNameController,
              decoration: _roundTextFieldDecoration('enter output file name'),
            ),
          ],
        ),
      );
}
