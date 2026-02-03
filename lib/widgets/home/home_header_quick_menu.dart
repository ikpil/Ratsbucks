import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import '../common/bouncing_button.dart';

class HomeHeaderQuickMenu extends StatelessWidget {
  const HomeHeaderQuickMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final quickMenus = [
      '베스트',
      '신메뉴',
      '쿠폰',
      '이벤트',
      '매장찾기',
      'QR주문',
      '선물하기',
      '프리퀀시',
    ];

    return SizedBox(
      height: 50,
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
          },
        ),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: quickMenus.length,
          itemBuilder: (context, index) {
            final isSelected = index == 0;

            return Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: BouncingButton(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(25),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color:
                          isSelected ? const Color(0xFF00704A) : Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFF00704A)
                            : Colors.grey.shade300,
                        width: 1,
                      ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: const Color(0xFF00704A).withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ]
                          : null,
                    ),
                    child: Text(
                      quickMenus[index],
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.grey[600],
                        fontSize: 14,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.w500,
                        letterSpacing: -0.3,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
