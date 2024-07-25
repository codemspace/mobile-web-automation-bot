import 'package:flutter/material.dart';
import '../../widgets/appbar_widget.dart';

class EditFieldFormPage extends StatefulWidget {
  final String fieldLabel;
  final String currentValue;
  final Function(String) onUpdate;
  final String? Function(String?) validator;

  const EditFieldFormPage({
    Key? key,
    required this.fieldLabel,
    required this.currentValue,
    required this.onUpdate,
    required this.validator,
  }) : super(key: key);

  @override
  EditFieldFormPageState createState() => EditFieldFormPageState();
}

class EditFieldFormPageState extends State<EditFieldFormPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.currentValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 320,
              child: Text(
                "What's your ${widget.fieldLabel}?",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              )),
            Padding(
              padding: EdgeInsets.only(top: 40),
              child: SizedBox(
                height: 100,
                width: 320,
                child: TextFormField(
                  validator: widget.validator,
                  decoration: InputDecoration(
                      labelText: 'Your ${widget.fieldLabel.toLowerCase()}'),
                  controller: _controller,
                )),
            ),
            Padding(
              padding: EdgeInsets.only(top: 150),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: 320,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        widget.onUpdate(_controller.text);  // Calls the passed callback function
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${widget.fieldLabel} updated successfully!'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      'Update',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
