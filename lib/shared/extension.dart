import 'package:flutter/material.dart';

extension PaddingExtension on Widget {
  Widget withAllPaddingFour() {
    return Padding(padding: const EdgeInsets.all(4.0), child: this);
  }

  Widget withAllPaddingEight() {
    return Padding(padding: const EdgeInsets.all(8.0), child: this);
  }
  Widget withAllPaddingSixteen() {
    return Padding(padding: const EdgeInsets.all(16.0), child: this);
  }

  Widget withLeftPaddingEight() {
    return Padding(padding: const EdgeInsets.only(left: 8.0), child: this);
  }

  Widget withRightPaddingFour() {
    return Padding(padding: const EdgeInsets.only(right: 4.0), child: this);
  }

  Widget withRightPaddingEight() {
    return Padding(padding: const EdgeInsets.only(right: 8.0), child: this);
  }

  Widget withBottomPaddingEight() {
    return Padding(padding: const EdgeInsets.only(bottom: 8.0), child: this);
  }

  Widget withBottomPaddingSixteen() {
    return Padding(padding: const EdgeInsets.only(bottom: 16.0), child: this);
  }

  Widget withTopPaddingEight() {
    return Padding(padding: const EdgeInsets.only(top: 8.0), child: this);
  }
}

extension QuickWidgetsExtension on Widget {
  Widget withOpacity({double opacity = .5}) {
    return Opacity(opacity: opacity, child: this);
  }
}
