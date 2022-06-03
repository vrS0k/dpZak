import 'package:flutter/material.dart';

class ProfileRow extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final Function() onTap;

  const ProfileRow(
      {Key? key,
      required this.label,
      required this.controller,
      required this.onTap})
      : super(key: key);

  @override
  State<ProfileRow> createState() => _ProfileRowState();
}

class _ProfileRowState extends State<ProfileRow> {
  bool viewState = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width > 300 ? MediaQuery.of(context).size.width / 4 : MediaQuery.of(context).size.width / 2 - 30,
            child: Text(widget.label, textAlign: TextAlign.left),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: TextFormField(
              keyboardType:
                  widget.label == 'Телефон' ? TextInputType.number : null,
              enabled: !viewState, // состояние редактирования
              controller: widget.controller,
              decoration: InputDecoration(
                border:
                    viewState ? InputBorder.none : const OutlineInputBorder(),
              ),
            ),
          ),
          MediaQuery.of(context).size.width > 300
              ? IconButton(
                  onPressed: () {
                    if (!viewState) {
                      widget.onTap();
                    }
                    setState(() {
                      viewState = !viewState;
                    });
                  },
                  icon: viewState
                      ? const Icon(Icons.create)
                      : const Icon(Icons.save),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
