import 'package:flutter/material.dart';

class Interactive3DPhone extends StatefulWidget {
  final Widget child;

  const Interactive3DPhone({
    super.key,
    required this.child,
  });

  @override
  State<Interactive3DPhone> createState() => _Interactive3DPhoneState();
}

class _Interactive3DPhoneState extends State<Interactive3DPhone> {
  double _rotationX = 0.0;
  double _rotationY = 0.0;
  double _lightX = 0.5;
  double _lightY = 0.5;
  bool _isHovered = false;

  void _onPointerMove(PointerEvent event, Size size) {
    // Relative coordinates between -1.0 and 1.0
    final double relX = (event.localPosition.dx / size.width) * 2 - 1;
    final double relY = (event.localPosition.dy / size.height) * 2 - 1;

    setState(() {
      _rotationX = -relY * 0.15; // Max tilt 8.5 degrees
      _rotationY = relX * 0.15;
      _lightX = event.localPosition.dx / size.width;
      _lightY = event.localPosition.dy / size.height;
      _isHovered = true;
    });
  }

  void _onPointerExit() {
    setState(() {
      _rotationX = 0.0;
      _rotationY = 0.0;
      _lightX = 0.5;
      _lightY = 0.5;
      _isHovered = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);

        return MouseRegion(
          onHover: (event) => _onPointerMove(event, size),
          onExit: (_) => _onPointerExit(),
          child: TweenAnimationBuilder<Matrix4>(
            duration: const Duration(milliseconds: 150),
            curve: Curves.easeOutCubic,
            tween: Matrix4Tween(
              begin: Matrix4.identity(),
              end: Matrix4.identity()
                ..setEntry(3, 2, 0.001) // perspective
                ..rotateX(_rotationX)
                ..rotateY(_rotationY),
            ),
            builder: (context, matrix, child) {
              return Transform(
                transform: matrix,
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    // Base device mockup
                    widget.child,

                    // Gloss reflection overlay
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: IgnorePointer(
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 200),
                            opacity: _isHovered ? 0.3 : 0.0,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: RadialGradient(
                                  colors: [
                                    Colors.white.withValues(alpha: 0.4),
                                    Colors.transparent,
                                  ],
                                  center: FractionalOffset(_lightX, _lightY),
                                  radius: 0.65,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
