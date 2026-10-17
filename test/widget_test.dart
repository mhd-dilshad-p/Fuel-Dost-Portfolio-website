import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fueldost_website/main.dart';
import 'package:fueldost_website/sections/navbar_section.dart';

void main() {
  group('FuelDost Website - Responsive Viewport Smoke Tests', () {
    const targetWidths = [
      360.0, // Small mobile
      390.0, // Standard mobile (iPhone)
      768.0, // Tablet portrait (iPad mini)
      820.0, // Tablet portrait (iPad Air)
      1024.0, // Small desktop / tablet landscape
      1280.0, // Standard laptop
      1440.0, // Large desktop monitor
    ];

    for (final width in targetWidths) {
      testWidgets(
        'renders HomeScreen without layout overflow at ${width.toInt()}px width',
        (WidgetTester tester) async {
          tester.view.physicalSize = Size(width, 900.0);
          tester.view.devicePixelRatio = 1.0;
          addTearDown(() => tester.view.resetPhysicalSize());

          await tester.pumpWidget(const MyApp());
          await tester.pump();
          await tester.pump(const Duration(milliseconds: 100));

          expect(tester.takeException(), isNull);
          expect(find.byType(NavbarSection), findsOneWidget);

          // Teardown: unmount widget tree to cancel periodic timers
          await tester.pumpWidget(const SizedBox());
          await tester.pump(const Duration(seconds: 5));
        },
      );
    }

    testWidgets(
      'compact viewports (< 1000px) display menu button and functional drawer',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(768.0, 1024.0);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() => tester.view.resetPhysicalSize());

        await tester.pumpWidget(const MyApp());
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));

        // Hamburger menu button must be visible
        final menuButton = find.byIcon(Icons.menu);
        expect(menuButton, findsOneWidget);

        // Open drawer
        await tester.tap(menuButton);
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 400));

        // Verify drawer navigation content is mounted
        expect(find.byType(Drawer), findsOneWidget);
        expect(find.text('Features'), findsOneWidget);
        expect(find.text('How It Works'), findsOneWidget);
        expect(find.text('Screenshots'), findsOneWidget);
        expect(find.text('Reviews'), findsOneWidget);

        // Close drawer via close icon
        final closeButton = find.byIcon(Icons.close);
        expect(closeButton, findsOneWidget);
        await tester.tap(closeButton);
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 400));

        expect(find.byType(Drawer), findsNothing);

        // Teardown
        await tester.pumpWidget(const SizedBox());
        await tester.pump(const Duration(seconds: 5));
      },
    );

    testWidgets(
      'desktop viewports (>= 1024px) display inline navigation links and CTA',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(1280.0, 900.0);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(() => tester.view.resetPhysicalSize());

        await tester.pumpWidget(const MyApp());
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));

        // Desktop inline navigation links
        expect(find.text('Features'), findsOneWidget);
        expect(find.text('How It Works'), findsOneWidget);
        expect(find.text('Screenshots'), findsOneWidget);
        expect(find.text('Reviews'), findsOneWidget);
        expect(find.text('Download Free'), findsOneWidget);

        // Hamburger button should NOT be rendered on desktop
        expect(find.byIcon(Icons.menu), findsNothing);

        // Teardown
        await tester.pumpWidget(const SizedBox());
        await tester.pump(const Duration(seconds: 5));
      },
    );
  });
}
