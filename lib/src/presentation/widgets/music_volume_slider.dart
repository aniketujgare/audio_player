import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/volume_slider_cubit.dart';

class MusicVolumeSlider extends StatelessWidget {
  const MusicVolumeSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VolumeSliderCubit, double>(
      builder: (context, state) {
        return Slider(
          label: 'Volume',
          value: state,
          max: 1.0,
          min: 0.0,
          onChanged: (value) {
            context.read<VolumeSliderCubit>().updateSliderValue(value);
          },
        );
      },
    );
  }
}
