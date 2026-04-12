import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:fruit_ecosystem/app/modules/calculator/views/calculator_view.dart';
import 'package:fruit_ecosystem/app/modules/calculator/bindings/calculator_binding.dart';

void main() {
  testWidgets('Calculator smoke test', (WidgetTester tester) async {
    // 1. Khởi tạo ứng dụng với GetMaterialApp và Binding của Calculator
    await tester.pumpWidget(
      GetMaterialApp(
        initialRoute: '/calculator',
        getPages: [
          GetPage(
            name: '/calculator',
            page: () => const CalculatorView(),
            binding: CalculatorBinding(),
          ),
        ],
      ),
    );

    // 2. Kiểm tra xem màn hình máy tính có hiển thị số 0 mặc định không
    expect(find.text('0'), findsOneWidget);

    // 3. Kiểm tra xem có các nút bấm quan trọng không (Ví dụ nút AC)
    expect(find.text('AC'), findsOneWidget);

    // 4. Thử giả lập bấm số '7'
    await tester.tap(find.text('7'));
    await tester.pump(); // Cập nhật lại giao diện sau khi bấm

    // 5. Kiểm tra xem màn hình có hiện số 7 thay vì số 0 không
    expect(find.text('7'), findsOneWidget);
    expect(find.text('0'), findsNothing);
  });
}