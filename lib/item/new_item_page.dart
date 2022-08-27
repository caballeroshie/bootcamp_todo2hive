import 'package:day008_todo/widget/item_button.dart';
import 'package:flutter/material.dart';
import '../widget/item_button.dart';
import '../model/item_model.dart';

enum ItemPageMode {
  add,
  edit,
}

class NewItemPage extends StatefulWidget {
  final ItemModel? itemModel;
  final ItemPageMode itemPageMode;

  const NewItemPage({
    super.key, 
    this.itemModel, 
    required this.itemPageMode});

  @override
  State<NewItemPage> createState() {
    return _NewItemPageState();
  }
}

class _NewItemPageState extends State<NewItemPage> {

  final _title = TextEditingController();
  final _desc = TextEditingController();
  final _date = TextEditingController();

  String appTitle = "NEW ITEM";

  @override
  void initState() {
    if (widget.itemPageMode == ItemPageMode.edit && widget.itemModel != null) {
      _title.text = widget.itemModel!.title;
      _desc.text = widget.itemModel!.desc;
      _date.text = widget.itemModel!.date;
      appTitle = "EDIT ITEM";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffEDE1CF),
      appBar: AppBar(
        title: Text(appTitle),
      ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column (
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextField(
                      autofocus: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Title',
                      ),
                      controller: _title
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, ),
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Description"),
                      ),
                      controller: _desc
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextField(
                      autofocus: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Date',
                      ),
                      controller: _date
                    ),
                  ),
                ]
              ,),
            ),
            Align(
            alignment: Alignment.bottomCenter,
            child: ItemButton(
              title: widget.itemPageMode == ItemPageMode.add ? "Save" : "Update",
              color: const Color(0xff107980),
              onItemTap: () {
                if (_title.text.isNotEmpty && _desc.text.isNotEmpty && _date.text.isNotEmpty) {
                  Navigator.pop(context,
                    ItemModel(
                      title: _title.text,
                      desc: _desc.text,
                      date: _date.text,
                    ),);
                }
              }, //onItemTap
            ),
          ),
        ],)
      ),
    );
  }
}