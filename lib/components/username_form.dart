import 'package:flutter/material.dart';

class UsernameForm extends StatefulWidget {
  ValueChanged<String>? onUsernameChange;

  UsernameForm({super.key, this.onUsernameChange});

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<UsernameForm> {
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();
  var _errorText = "";

  _handlePressed() {
    if (_formKey.currentState!.validate()) {
      widget.onUsernameChange?.call(_textController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Getting user's balance"),
        ),
      );

      setState(() {
        _errorText = "";
      });
    }
  }

  _handleSubmit(String value) {
    _handlePressed();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _textController,
            decoration: InputDecoration(hintText: "Username"),
            onFieldSubmitted: _handleSubmit,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter a username";
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: _handlePressed,
              child: Text(
                "Submit",
              ),
            ),
          ),
          Text(
            _errorText,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    );
  }
}
