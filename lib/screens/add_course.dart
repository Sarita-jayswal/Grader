import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AddCoursePage extends StatefulWidget {
  const AddCoursePage({Key? key}) : super(key: key);

  @override
  _AddCoursePageState createState() => _AddCoursePageState();
}

class _AddCoursePageState extends State<AddCoursePage> {
  bool _validate = false;
  List<Map<String, dynamic>> _items = [];

  final _courseBox = Hive.box('course_box');

  @override
  void initState() {
    super.initState();
    _refreshItems(); // Load data when app starts
  }

  // Get all items from the database
  void _refreshItems() {
    final data = _courseBox.keys.map((key) {
      final value = _courseBox.get(key);
      return {
        "key": key,
        "coursename": value["coursename"],
      };
    }).toList();

    setState(() {
      _items = data.reversed.toList();
    });
  }

  // Create new item
  Future<void> _createItem(Map<String, dynamic> newItem) async {
    await _courseBox.add(newItem);
    _refreshItems(); // update the UI
  }

  // Retrieve a single item from the database by using its key
  // Our app won't use this function but I put it here for your reference
  Map<String, dynamic> _readItem(int key) {
    final item = _courseBox.get(key);
    return item;
  }

  // Update a single item
  Future<void> _updateItem(int itemKey, Map<String, dynamic> item) async {
    await _courseBox.put(itemKey, item);
    _refreshItems(); // Update the UI
  }

  // Delete a single item
  Future<void> _deleteItem(int itemKey) async {
    await _courseBox.delete(itemKey);
    _refreshItems(); // update the UI

    // Display a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An item has been deleted')));
  }

  // TextFields' controllers
  final TextEditingController _coursenameController = TextEditingController();

  // This function will be triggered when the floating button is pressed
  // It will also be triggered when you want to update an item
  void _showForm(BuildContext ctx, int? itemKey) async {
    // itemKey == null -> create new item
    // itemKey != null -> update an existing item

    if (itemKey != null) {
      final existingItem =
          _items.firstWhere((element) => element['key'] == itemKey);
      _coursenameController.text = existingItem['coursename'];
    }

    showModalBottomSheet(
        context: ctx,
        elevation: 5,
        isScrollControlled: true,
        builder: (_) => Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(ctx).viewInsets.bottom,
                  top: 15,
                  left: 15,
                  right: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    textCapitalization: TextCapitalization.words,
                    controller: _coursenameController,
                    decoration: InputDecoration(
                      hintText: 'Enter Course Name',
                      errorStyle: TextStyle(fontSize: 8),
                      errorText:
                          _validate ? 'Course Name Can\'t Be Empty' : null,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        _coursenameController.text.isEmpty
                            ? _validate = true
                            : _validate = false;
                      });
                      // Save new item
                      if (itemKey == null) {
                        _createItem({
                          "coursename": _coursenameController.text,
                        });
                      }

                      // update an existing item
                      if (itemKey != null) {
                        _updateItem(itemKey, {
                          'coursename': _coursenameController.text.trim(),
                        });
                      }

                      // Clear the text fields
                      _coursenameController.text = '';

                      Navigator.of(context).pop(); // Close the bottom sheet
                    },
                    child: Text(itemKey == null ? 'Create New' : 'Update'),
                  ),
                  const SizedBox(
                    height: 15,
                  )
                ],
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        centerTitle: true,
        title: const Text(
          'Course Section',
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: _items.isEmpty
          ? const Center(
              child: Text(
                'Add New Course',
                style: TextStyle(fontSize: 30),
              ),
            )
          : ListView.builder(
              // the list of items
              itemCount: _items.length,
              itemBuilder: (_, index) {
                final currentItem = _items[index];
                return Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.book_outlined),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: (() =>
                                  _showForm(context, currentItem['key'])),
                              icon: Icon(Icons.edit)),
                          IconButton(
                              onPressed: (() =>
                                  _deleteItem(currentItem['key'])),
                              icon: Icon(Icons.delete)),
                          // IconButton(
                          //     onPressed: () {}, icon: Icon(Icons.arrow_drop_down))
                        ],
                      ),
                      title: Text(
                        currentItem['coursename'],
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                    ),
                    Divider(thickness: 2, color: Colors.green)
                  ],
                );
              }),

      // Add new item button
      floatingActionButton: FloatingActionButton.extended(
        label: Text("New Course"),
        icon: Icon(Icons.add),
        onPressed: () => _showForm(context, null),
      ),
    );
  }
}
