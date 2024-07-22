import 'package:flutter/material.dart';

class CustomSlider extends StatefulWidget {
  final double min;
  final double max;
  final int divisions;
  final double initialValue;
  final String unit;
  final Function(double) onChanged;

  const CustomSlider({
    super.key,
    required this.min,
    required this.max,
    required this.divisions,
    required this.initialValue,
    required this.unit,
    required this.onChanged,
  });

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  late double _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.topCenter,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${widget.min.round()}'),
                Text('${widget.max.round()}'),
              ],
            ),
            Slider(
              value: _currentValue,
              min: widget.min,
              max: widget.max,
              divisions: widget.divisions,
              activeColor: Colors.red,
              inactiveColor: const Color.fromARGB(255, 239, 238, 245),
              onChanged: (value) {
                setState(() {
                  _currentValue = value;
                });
                widget.onChanged(value);
              },
              label: '$_currentValue',
            ),
          ],
        ),
      ],
    );
  }
}
