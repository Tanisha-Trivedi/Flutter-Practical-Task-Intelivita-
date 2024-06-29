import 'package:flutter/material.dart';

import '../modules/home_module/model/user_model.dart';

class MultiSelectListView extends StatefulWidget {
  const MultiSelectListView({super.key});

  @override
  State<MultiSelectListView> createState() => _MultiSelectListViewState();
}

class _MultiSelectListViewState extends State<MultiSelectListView> {
  List<Map> userData = UserModel.userData;

  bool isSelectItem = false;
  Map<int, bool> selectedItem = {};
  List<int> selectedValues = [];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: userData.length,
        itemBuilder: (_, index) {
          Map data = userData[index];
          selectedItem[index] = selectedItem[index] ?? false;
          bool? isSelectedData = selectedItem[index];

          return ListTile(
            leading: changedUI(isSelectedData!, data),
            onLongPress: () {
              setState(() {
                selectedItem[index] = !isSelectedData;
                isSelectItem = selectedItem.containsValue(true);
                selectedValues.add(userData[index]["id"]);
              });
            },
            onTap: () {
              if (isSelectItem) {
                setState(() {
                  selectedItem[index] = !isSelectedData;
                  isSelectItem = selectedItem.containsValue(true);
                });
              }
            },
            title: Row(
              children: [
                const Text("Name : "),
                Text("${data["name"]}"),
              ],
            ),
          );
        });
  }

  Widget changedUI(bool isSelected, Map data) {
    if (isSelectItem) {
      return Icon(isSelected ? Icons.check_box : Icons.check_box_outline_blank);
    } else {
      return CircleAvatar(
        child: Text('${data["id"]}'),
      );
    }
  }
}
