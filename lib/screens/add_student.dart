import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AddStudentPage extends StatefulWidget {
  const AddStudentPage({Key? key}) : super(key: key);

  @override
  _AddStudentPageState createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  bool _validate = false;
  List<Map<String, dynamic>> _items = [];

  final _studentsBox = Hive.box('students_box');

  @override
  void initState() {
    super.initState();
    _refreshItems(); // Load data when app starts
  }

  // Get all items from the database
  void _refreshItems() {
    final data = _studentsBox.keys.map((key) {
      final value = _studentsBox.get(key);
      return {
        "key": key,
        "name": value["name"],
        "rollno": value['rollno'],
        "email": value['email'],
        "grade": value['grade']??"",
      };
    }).toList();

    setState(() {
      _items = data.reversed.toList();
      print(_items);
    });
  }

  // Create new item
  Future<void> _createItem(Map<String, dynamic> newItem) async {
    await _studentsBox.add(newItem);
    _refreshItems(); // update the UI
  }

  // Retrieve a single item from the database by using its key
  // Our app won't use this function but I put it here for your reference
  Map<String, dynamic> _readItem(int key) {
    final item = _studentsBox.get(key);
    return item;
  }

  // Update a single item
  Future<void> _updateItem(int itemKey, Map<String, dynamic> item) async {
    await _studentsBox.put(itemKey, item);
    _refreshItems(); // Update the UI
  }

  // Delete a single item
  Future<void> _deleteItem(int itemKey) async {
    await _studentsBox.delete(itemKey);
    _refreshItems(); // update the UI

    // Display a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An item has been deleted')));
  }

  // TextFields' controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _rollnoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  // This function will be triggered when the floating button is pressed
  // It will also be triggered when you want to update an item
  void _showForm(BuildContext ctx, int? itemKey) async {
    // itemKey == null -> create new item
    // itemKey != null -> update an existing item

    if (itemKey != null) {
      final existingItem =
          _items.firstWhere((element) => element['key'] == itemKey);
      _nameController.text = existingItem['name'];
      _rollnoController.text = existingItem['rollno'];
      _emailController.text = existingItem['email'];
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
                    decoration: InputDecoration(
                      hintText: 'Enter Student Name',
                      errorStyle: TextStyle(fontSize: 8),
                      errorText:
                          _validate ? 'Student Name Can\'t Be Empty' : null,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _rollnoController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Enter Roll no.',
                      errorStyle: TextStyle(fontSize: 8),
                      errorText: _validate ? 'Roll No. Can\'t Be Empty' : null,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: 'Enter Email',
                      errorStyle: TextStyle(fontSize: 8),
                      errorText: _validate ? 'Email Can\'t Be Empty' : null,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        _emailController.text.isEmpty
                            ? _validate = true
                            : _validate = false;
                        _nameController.text.isEmpty
                            ? _validate = true
                            : _validate = false;
                        _rollnoController.text.isEmpty
                            ? _validate = true
                            : _validate = false;
                      });
                      // Save new item
                      if (itemKey == null) {
                        _createItem({
                          "name": _nameController.text,
                          "rollno": _rollnoController.text,
                          "email": _emailController.text,
                          "grade": "",
                        });
                      }

                      // update an existing item
                      if (itemKey != null) {
                        _updateItem(itemKey, {
                          'name': _nameController.text.trim(),
                          'rollno': _rollnoController.text.trim(),
                          'email': _emailController.text.trim(),
                          'grade': "",
                        });
                      }

                      // Clear the text fields
                      _nameController.text = '';
                      _rollnoController.text = '';
                      _emailController.text = '';

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
          'Add Student',
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: _items.isEmpty
          ? const Center(
              child: Text(
                'Click to add New Student',
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
                            "Roll No.:"
                            '${currentItem['rollno'].toString()}',
                            style: TextStyle(
                              color: Color.fromARGB(255, 113, 110, 110),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Email:" '${currentItem['email']}',
                            style: TextStyle(
                              color: Color.fromARGB(255, 113, 110, 110),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                                Text(
                            "Grade:" '${currentItem['grade']}',
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
                    // child: ListTile(
                    //     title: Text("Name:" '${currentItem['name']}'),
                    //     subtitle: Text("Roll No.:"
                    //         '${currentItem['rollno'].toString()}'),
                    //     trailing: Row(
                    //       mainAxisSize: MainAxisSize.min,
                    //       children: [
                    //         // Edit button
                    //         IconButton(
                    //             icon: const Icon(Icons.edit),
                    //             onPressed: () =>
                    //                 _showForm(context, currentItem['key'])),
                    //         // Delete button
                    //         IconButton(
                    //           icon: const Icon(Icons.delete),
                    //           onPressed: () => _deleteItem(currentItem['key']),
                    //         ),
                    //       ],
                    //     )),
                  ),
                );
              }),
      // Add new item button
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showForm(context, null),
        child: const Icon(Icons.add),
      ),
    );
  }
}
