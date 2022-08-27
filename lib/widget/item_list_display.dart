import 'package:flutter/material.dart';

class ItemListDisplay extends StatelessWidget {
  
  final String title;
  final String desc;
  final String date;
  final VoidCallback onItem2Tap;

  const ItemListDisplay({
    super.key, 
    required this.title, 
    required this.desc, 
    required this.date, 
    required this.onItem2Tap});
  
  
  @override
  Widget build(BuildContext context) {
    return  InkWell(
      /// This is how you use the custom function callback.
      onDoubleTap: onItem2Tap,
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 120,
              margin: const EdgeInsets.only(top: 12, left: 16, right: 16),
              decoration: BoxDecoration(
                color: const Color(0xffD9C5BC),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [ 
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,),),
                    const SizedBox(height: 5,),
                    Text(
                      desc,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,),
                    const SizedBox(height: 5,),
                    Text(date,
                      style: const TextStyle(
                        fontSize: 10,),
                  ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );

              // Column(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Text(title),
              //     Text(description),
              //     Text(date),
              //   ],
              // ),
    //   ),
    // );
  }
}