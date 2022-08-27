import 'package:flutter/material.dart';
import '../item/new_item_page.dart';

class ItemButton extends StatelessWidget {
  final String title;
  final Color color;
  final VoidCallback? onItemTap;

  const ItemButton({
    super.key,
    required this.title,
    this.color = const Color(0xff107980),
    this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: onItemTap,
            child: Container(
              height: 56,
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
