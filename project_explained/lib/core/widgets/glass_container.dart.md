# File: `lib/core/widgets/glass_container.dart`

This file defines a reusable UI widget that creates a "Glassmorphism" effect (frosted glass look). This is a key design element of the app.

### 1. Imports
```dart
import 'dart:ui';
import 'package:flutter/material.dart';
```
**Explanation:**
- `dart:ui`: Required for `ImageFilter.blur`, which is needed to create the blur effect.
- `package:flutter/material.dart`: Provides the standard Widget class and other UI tools.

### 2. GlassContainer Class Properties
```dart
class GlassContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;
  final Color? color;
  final double blur;
  final Border? border;

  const GlassContainer({
    super.key,
    required this.child,
    // ... optional parameters with defaults
  });
//...
```
**Explanation:**
- `GlassContainer`: A custom widget we created to wrap other widgets.
- It accepts a `child` (the content inside the glass).
- It allows customization of `padding`, `margin`, `borderRadius`, `color`, and `blur` intensity.
- Defaults are provided (`borderRadius = 16.0`, `blur = 10.0`) so it looks good out of the box.

### 3. Build Method & The Glass Effect
```dart
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: color ?? Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(borderRadius),
              border: border ?? Border.all(color: Colors.white.withOpacity(0.2)),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
```
**Explanation:**
- `ClipRRect`: Clips the content to rounded corners, ensuring the blur effect doesn't leak outside the rounded edges.
- `BackdropFilter`: This is the magic widget. It applies a filter to everything *behind* this widget.
- `ImageFilter.blur`: We use this filter to blur the background content (`sigmaX` and `sigmaY` control the strength).
- `Container (Inner)`: This sits on top of the blur.
    - `color`: We use a semi-transparent white (`Colors.white.withOpacity(0.1)`) to give it a "tint".
    - `border`: A thin, semi-transparent border (`Colors.white.withOpacity(0.2)`) simulates the edge of a glass pane catching light.
- `child`: Finally, the actual content (like text or buttons) is rendered inside.
