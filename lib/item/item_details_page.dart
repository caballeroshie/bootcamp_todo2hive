import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../model/item_model.dart';
import '../widget/item_button.dart';
import 'new_item_page.dart';


class ItemDetailsPage extends StatefulWidget {
  final int id;
  final ItemModel itemModel;
  final Function(bool isUpdated)? onTapEdit;
  final VoidCallback? onTapDelete;
  // a function calling another function


  const ItemDetailsPage({
    super.key, 
    required this.id,
    required this.itemModel,
    this.onTapEdit,
    this.onTapDelete});

  @override
  State<ItemDetailsPage> createState() => _ItemDetailsPageState();
}

class _ItemDetailsPageState extends State<ItemDetailsPage> {

  //List<ItemModel> ItemList = [];

  String? upd_title;
  String? upd_desc;
  String? upd_date;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffEDE1CF),
        appBar: AppBar(
          title: Text(upd_title ?? widget.itemModel.title),
          // if upd is null then use the fallback
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(upd_desc ?? widget.itemModel.desc,style: const TextStyle(fontSize: 18),),
                  const SizedBox(height: 10),
                  Text(upd_date ?? widget.itemModel.date),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ItemButton(
                      title: 'Edit',
                      onItemTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) {
                            return NewItemPage(
                              itemModel: upd_title != null && upd_desc != null && upd_date != null 
                              ? ItemModel(title: upd_title!, desc: upd_desc!, date: upd_date!)
                              : widget.itemModel,
                              itemPageMode: ItemPageMode.edit,);
                          }),
                        ).then((value) {
                            setState(() { //rebuilds the UI
                              //update local value of the item models
                              //to display it on the current page
                              upd_title = value.title;
                              upd_desc = value.desc;
                              upd_date = value.date;
                              
                              //Stores updated value of the item in the database
                              final box = Hive.box('todo_items');
                              box.putAt(widget.id, value.toMap());

                              //Re-loads homepage when there is an update
                              if(widget.onTapEdit != null) {
                                widget.onTapEdit!(true);
                              }
                            });
                          }
                        );
                      },
                    ),
                    ItemButton(
                      title: 'Delete',
                      color: Colors.red.shade400,
                      onItemTap: () {
                        widget.onTapDelete!();
                        Navigator.pop(context,);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}