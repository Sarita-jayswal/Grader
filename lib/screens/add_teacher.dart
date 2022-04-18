import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AddTeacherPage extends StatefulWidget {
  const AddTeacherPage({Key? key}) : super(key: key);

  @override
  _AddTeacherPageState createState() => _AddTeacherPageState();
}

class _AddTeacherPageState extends State<AddTeacherPage> {
  List<Map<String, dynamic>> _items = [];

  final _teachersBox = Hive.box('teachers_box');

  @override
  void initState() {
    super.initState();
    _refreshItems(); // Load data when app starts
  }

  // Get all items from the database
  void _refreshItems() {
    final data = _teachersBox.keys.map((key) {
      final value = _teachersBox.get(key);
      return {
        "key": key,
        "name": value["name"],
        "subject": value["subject"],
        "class": value["class"]
      };
    }).toList();

    setState(() {
      _items = data.reversed.toList();
    });
  }

  // Create new item
  Future<void> _createItem(Map<String, dynamic> newItem) async {
    await _teachersBox.add(newItem);
    _refreshItems(); // update the UI
  }

  // Retrieve a single item from the database by using its key
  // Our app won't use this function but I put it here for your reference
  Map<String, dynamic> _readItem(int key) {
    final item = _teachersBox.get(key);
    return item;
  }

  // Update a single item
  Future<void> _updateItem(int itemKey, Map<String, dynamic> item) async {
    await _teachersBox.put(itemKey, item);
    _refreshItems(); // Update the UI
  }

  // Delete a single item
  Future<void> _deleteItem(int itemKey) async {
    await _teachersBox.delete(itemKey);
    _refreshItems(); // update the UI

    // Display a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An item has been deleted')));
  }

  // TextFields' controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _classController = TextEditingController();

  // This function will be triggered when the floating button is pressed
  // It will also be triggered when you want to update an item
  void _showForm(BuildContext ctx, int? itemKey) async {
    // itemKey == null -> create new item
    // itemKey != null -> update an existing item

    if (itemKey != null) {
      final existingItem =
          _items.firstWhere((element) => element['key'] == itemKey);
      _nameController.text = existingItem['name'];
      _subjectController.text = existingItem['subject'];
      _classController.text = existingItem['class'];
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
                    controller: _nameController,
                    decoration:
                        const InputDecoration(hintText: 'Enter Teacher Name'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _subjectController,
                    decoration:
                        const InputDecoration(hintText: 'Enter Subject Name'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _classController,
                    decoration: const InputDecoration(hintText: 'Enter Class'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      // Save new item
                      if (itemKey == null) {
                        _createItem({
                          "name": _nameController.text,
                          "subject": _subjectController.text,
                          "class": _classController.text
                        });
                      }

                      // update an existing item
                      if (itemKey != null) {
                        _updateItem(itemKey, {
                          'name': _nameController.text.trim(),
                          'subject': _subjectController.text.trim(),
                          'class': _classController.text.trim()
                        });
                      }

                      // Clear the text fields
                      _nameController.text = '';
                      _subjectController.text = '';
                      _classController.text = '';

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
        centerTitle: true,
        title: const Text(
          'Add Teacher',
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: _items.isEmpty
          ? const Center(
              child: Text(
                'Click to add New Teacher',
                style: TextStyle(fontSize: 30),
              ),
            )
          : ListView.builder(
              // the list of items
              itemCount: _items.length,
              itemBuilder: (_, index) {
                final currentItem = _items[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Card(
                    color: Colors.white,
                    //margin: const EdgeInsets.all(10),
                    elevation: 3,
                    child: ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcStq_o9fcHnMQwY5nb8EUI7KQtev_Grk--9Mg&usqp=CAU'))),
                          ),
                          Text(
                            "Name:" '${currentItem['name']}',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Subject.:"
                            '${currentItem['subject'].toString()}',
                            style: TextStyle(
                              color: Color.fromARGB(255, 113, 110, 110),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Class:" '${currentItem['class']}',
                            style: TextStyle(
                              color: Color.fromARGB(255, 113, 110, 110),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 50),
                            child: Row(
                              children: [
                                MaterialButton(
                                  onPressed: (() =>
                                      _showForm(context, currentItem['key'])),
                                  color: Colors.green,
                                  child: Text(
                                    "Edit",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                MaterialButton(
                                  onPressed: (() =>
                                      _deleteItem(currentItem['key'])),
                                  color: Colors.green,
                                  child: Text(
                                    "Delete",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
      // Add new item button
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Add New Teacher"),
        icon: Icon(Icons.add),
        onPressed: () => _showForm(context, null),
      ),
    );
  }
}
