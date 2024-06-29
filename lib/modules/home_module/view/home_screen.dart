import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../constants/common_header.dart';
import '../../../constants/muti_select_list_view.dart';
import '../view_model/bloc/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _dropdownList = ['Android', 'iOS', 'Web'];
  final GlobalKey<FormState> _formKey = GlobalKey();
  String _dropdownValue = 'Android';
  final ValueNotifier<int> _selectedIndex = ValueNotifier(1);
  final ValueNotifier<DateTime> _selectedDateTime =
      ValueNotifier(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is HomeSuccess) {
            log("Home Success State Emmited");
            log("CONTROLLER VALUE ${state.controllerValue}");
            log("SelectedDate VALUE ${state.selectedDate}");
            log("Selected Index VALUE ${state.gridSelectedIndex}");
          }
          if (state is HomeFailure) {
            log("Home Success State Emmited");
          }
        },
        builder: (context, state) {
          return Container(
            padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 20.0, vertical: 10.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 1. Edit field
                  const CommonHeader(header: '1. Edit Field'),
                  TextFormField(
                    controller: _controller,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) =>
                        value!.isEmpty ? 'Email cannot be blank' : null,
                    decoration: InputDecoration(
                      hintText: 'Please Enter Your Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),

                  // 2. DatePicker
                  const CommonHeader(header: '2. DatePicker'),
                  Row(
                    children: [
                      ValueListenableBuilder(
                          valueListenable: _selectedDateTime,
                          builder: (context, value, child) {
                            return Text(
                                "Selected Date : ${DateFormat('dd/MM/yyyy').format(_selectedDateTime.value)}");
                          }),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () => _chooseDate(context),
                        child: const Text('Please Select Date'),
                      ),
                    ],
                  ),

                  // 3. Dropdown
                  const CommonHeader(header: '3. Dropdown'),
                  DropdownButton(
                    value: _dropdownValue,
                    icon: const Icon(Icons.arrow_downward_outlined),
                    items: _dropdownList.map(
                      (String items) {
                        return DropdownMenuItem(
                            value: items, child: Text(items));
                      },
                    ).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        _dropdownValue = value!;
                      });
                    },
                  ),
                  // const Spacer(),

                  // 4. Grid (single selection)
                  const CommonHeader(header: '4. Grid (single selection)'),
                  Expanded(
                    child: ValueListenableBuilder(
                        valueListenable: _selectedIndex,
                        builder: (context, value, child) {
                          return GridView.builder(
                              itemCount: 10,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: MediaQuery.of(context)
                                              .size
                                              .width /
                                          (MediaQuery.of(context).size.height /
                                              3)),
                              itemBuilder: (_, int index) => GestureDetector(
                                    onTap: () => _selectedIndex.value = index,
                                    child: Card(
                                      color: _selectedIndex.value == index
                                          ? Colors.green
                                          : Colors.blue,
                                      child: SizedBox(
                                        height: 200,
                                        width: 200,
                                        child: Center(
                                          child: Text(
                                            '${index + 1}',
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ));
                        }),
                  ),

                  // 5. List with multiple selection
                  const CommonHeader(header: '5. List with multiple selection'),
                  const Expanded(child: MultiSelectListView()),
                  Center(
                      child: ElevatedButton(
                          onPressed: () {
                            if (!_formKey.currentState!.validate()) return;
                            //Add Data to Server
                            addDataToServer(
                                controllerValue: _controller.text,
                                selectedDate:
                                    _selectedDateTime.value.toString(),
                                gridSelectedIndex:
                                    (_selectedIndex.value + 1).toString());
                          },
                          child: const Text("Save")))
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _chooseDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if ((pickedDate != null) && (pickedDate != _selectedDateTime.value)) {
      _selectedDateTime.value = pickedDate;
    }
  }

  void addDataToServer({
    required String controllerValue,
    required selectedDate,
    required gridSelectedIndex,
    // multiSelectionValues,
  }) {
    context.read<HomeBloc>().add(GetHomeData(
        controllerValue: controllerValue,
        gridSelectedIndex: gridSelectedIndex,
        // multiSelectionValues: multiSelectionValues,
        selectedDate: selectedDate));
  }
}
