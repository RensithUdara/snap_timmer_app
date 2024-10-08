import 'package:flutter/material.dart';

import 'timer_input_dialog.dart';

class CountdownTimerView extends StatefulWidget {
  const CountdownTimerView({super.key});

  @override
  _CountdownTimerViewState createState() => _CountdownTimerViewState();
}

class _CountdownTimerViewState extends State<CountdownTimerView>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  Duration _selectedDuration =
      const Duration(seconds: 60); // Default to 1 minute
  bool isPlaying = false; // To track play/pause state

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: _selectedDuration,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String get timerString {
    Duration duration = _controller.duration! * _controller.value;
    return '${duration.inHours}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  // Function to reset the timer
  void _resetTimer() {
    setState(() {
      _controller.reset();
      isPlaying = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Snap Timer",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white, // Ensures text stands out
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.pinkAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.timer,
                color: Colors.white), // Ensures icon color matches
            tooltip: "Set Timer", // Adds tooltip for accessibility
            onPressed: () {
              _selectTimerDuration(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh,
                color: Colors.white), // Reset icon for convenience
            tooltip: "Reset Timer", // Adds tooltip for accessibility
            onPressed:
                _resetTimer, // Calls the reset function directly from AppBar
          ),
        ],
        elevation: 10, // Emphasizes the shadow effect
        backgroundColor: Colors.transparent, // Keeps the gradient prominent
      ),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Stack(
            children: [
              // Gradient Background
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height:
                      _controller.value * MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.deepPurpleAccent,
                        Colors.pinkAccent,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Align(
                        alignment: FractionalOffset.center,
                        child: AspectRatio(
                          aspectRatio: 1.0,
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: Padding(
                                  padding: const EdgeInsets.all(30.0),
                                  child: CircularProgressIndicator(
                                    color: _controller.value < 0.5
                                        ? Colors.deepPurpleAccent
                                        : Colors.black,
                                    backgroundColor: _controller.isAnimating
                                        ? const Color.fromARGB(74, 0, 0, 0)
                                        : Colors.deepPurpleAccent,
                                    strokeWidth: 20,
                                    value: _controller.value,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: FractionalOffset.center,
                                child: Text(
                                  timerString,
                                  style: TextStyle(
                                    fontSize: 64.0,
                                    color: _controller.value < 0.5
                                        ? Colors.deepPurpleAccent
                                        : Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Play/Pause Button
                        FloatingActionButton.extended(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                _controller.isAnimating ? 10 : 20),
                          ),
                          backgroundColor: isPlaying
                              ? Colors.white
                              : Colors.deepPurpleAccent,
                          onPressed: () {
                            setState(() {
                              if (_controller.isAnimating) {
                                _controller.stop();
                                isPlaying = false; // Change button to play
                              } else {
                                _controller.reverse(
                                  from: _controller.value == 0.0
                                      ? 1.0
                                      : _controller.value,
                                );
                                isPlaying = true; // Change button to pause
                              }
                            });
                          },
                          icon: Icon(
                            isPlaying ? Icons.pause : Icons.play_arrow,
                            color: isPlaying
                                ? Colors.deepPurpleAccent
                                : Colors.white,
                          ),
                          label: Text(
                            isPlaying ? "Pause" : "Play",
                            style: TextStyle(
                              color: isPlaying
                                  ? Colors.deepPurpleAccent
                                  : Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Reset Button
                        FloatingActionButton.extended(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor: Colors.redAccent,
                          onPressed: _resetTimer,
                          icon: const Icon(Icons.refresh, color: Colors.white),
                          label: const Text(
                            "Reset",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _selectTimerDuration(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const TimerInputDialog();
      },
    ).then((selectedDuration) {
      if (selectedDuration != null) {
        setState(() {
          _selectedDuration = selectedDuration;
          _controller.duration = _selectedDuration;
          _controller.reset();
        });
      }
    });
  }
}
