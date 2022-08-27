import 'package:day008_todo/widget/item_button.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../item/item_details_page.dart';
import '../item/new_item_page.dart';
import '../model/item_model.dart';
import '../widget/item_list_display.dart';
import '../main.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //bool isChecked = false; //initial value of checkbox
  List<ItemModel> itemList = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: true,
      child: Scaffold(
        backgroundColor: const Color(0xffEDE1CF),
        appBar: AppBar(
          title: const Text("HOME"),
        ),
        body: Center(
          child: Stack(
            children: [
              SingleChildScrollView(
              child: FutureBuilder<Box>(
                  future: Hive.openBox('todo_items'),
                  builder: (context, todoBox) {
                    if (todoBox.data != null) {
                      final data = todoBox.data?.values.toList() ?? [];
                      final items = data.map((e) {
                        final cast = Map<String, dynamic>.from(e);
                        return ItemModel.fromJson(cast);
                      }).toList();
                      return ValueListenableBuilder(
                        valueListenable: todoBox.data!.listenable(),
                        builder: (context, box, widget) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              for (int i = 0; i < items.length; i++)
                                ItemListDisplay(
                                  title: items[i].title,
                                  desc: items[i].desc,
                                  date: items[i].date,
                                  onItem2Tap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (_) {
                                        return ItemDetailsPage(
                                          id: i,
                                          itemModel: items[i],
                                          onTapEdit: ((isUpdated) {
                                            setState(() {
                                              
                                            });
                                          }),
                                          onTapDelete: () {
                                            setState(() {
                                              final box = Hive.box('todo_items');
                                              box.deleteAt(i);
                                            });
                                          },
                                        );
                                      }),
                                    ); /////
                                  },
                                )
                            ],
                          );
                        },
                      );
                    }

                    return const Center(
                      child: Text('No items found.'),
                    );
                  }),
            ),
              // SingleChildScrollView(
              //   child: ValueListenableBuilder(
              //     valueListenable: Hive.box('todo_items'),
              //     builder: (context, todoBox) {
              //       if (todoBox.data != null) {
              //         final items =
              //             List<Map<String, dynamic>>.from(todoBox.data!.values)
              //                 .map((e) => ItemModel.fromJson(e))
              //                 .toList();
              //         return ValueListenableBuilder(
              //           valueListenable: todoBox.data!.listenable(),
              //           builder: (context, box, widget) {
              //         return Column(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: <Widget>[
              //           for (int i = 0; i < itemList.length; i++)
              //             ItemListDisplay(
              //               title: itemList[i].title,
              //               desc: itemList[i].desc,
              //               date: itemList[i].date,
              //               onItem2Tap: () {
              //                 Navigator.push(
              //                   context,
              //                   MaterialPageRoute(builder: (_) {
              //                     return ItemDetailsPage(
              //                       itemModel: itemList[i],
              //                       onTapDelete: (() {
              //                         setState(() {
              //                           itemList.removeAt(i);
              //                         });
              //                       }),
              //                     );
              //                   }),
              //                 );
              //               },
              //             )
              //         ],
              //         //     ),
              //         //   ),
              //         // ),
              //         // ],
              //       },  );
              //     }, //valueListenable: null,
              //   ),
              // ),
              Align(
              alignment: Alignment.bottomCenter,
              child: ItemButton(
                title: 'New Item',
                onItemTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) {
                      return const NewItemPage(
                        itemModel: null,
                        itemPageMode: ItemPageMode.add,
                      );
                    }),
                  ).then((value) {
                    /// This checks if the value from the
                    /// previous route is an instance of
                    /// `ItemModel`. If so, read
                    /// the value accordingly.
                    if (value is ItemModel) {
                      /// `setState` notifies the Flutter
                      /// to rebuild the UI
                      setState(() {
                        final todoBox = Hive.box('todo_items');
                        todoBox.add(value.toMap());
                      });
                    }
                  });
                },
              ),
            ),
              // Align(
              //   alignment: Alignment.bottomCenter,
              //   child: ItemButton(
              //     title: "New Item",
              //     onItemTap: () {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(builder: (_) {
              //           return const NewItemPage(
              //             itemModel: null,
              //             itemPageMode: ItemPageMode.add,);
              //         }),
              //       ).then((value) {
              //         if (value is ItemModel) {
              //           final todoBox = Hive.box('todo_items');
              //           todoBox.add(value);
              //         //   setState(() {
              //         //     itemList.add(value);
              //         //  });
              //         }
              //       });
              //     },
              //   )),
              const SizedBox(height: 150,)
            ],
          ),
        ),
      ),
    );
  }
}


// Container(
                    //   margin: const EdgeInsets.all(16),
                    //   decoration: BoxDecoration(
                    //     color: const Color(0xffD9C5BC),
                    //     borderRadius: BorderRadius.circular(8),
                    //   ),
                    //   height: 120,
                    //   child: 
                    //   Padding(
                    //     padding: const EdgeInsets.all(16),
                    //     child: Row(
                    //       children: [
                            // Checkbox(
                            //   value: isChecked,
                            //   onChanged: (bool? val) {
                            //     setState(() {
                            //       isChecked = val!;
                            //     });
                            //   },
                            // ),