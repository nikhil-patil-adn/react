import 'package:flutter/material.dart';

import 'review_page.dart';

class NewCustomDialog extends StatefulWidget {
  final String title, description, buttontext;
  final List custdata;

  NewCustomDialog(
      {required this.title,
      required this.description,
      required this.buttontext,
      required this.custdata});

  @override
  _NewCustomDialogState createState() => _NewCustomDialogState();
}

class _NewCustomDialogState extends State<NewCustomDialog> {
  var textboxController1 = TextEditingController();

  var textboxController2 = TextEditingController();

  var textboxController3 = TextEditingController();

  var textboxController4 = TextEditingController();

  var newotp = "";

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialogueContent(context),
    );
  }

  _textFieldBox(BuildContext context,
      {required first, last, textboxController}) {
    return Container(
      height: 70,
      child: AspectRatio(
        aspectRatio: 0.5,
        child: TextField(
          // controller: textboxController,
          autofocus: true,
          onChanged: (value) {
            setState(() {
              newotp += value;
            });
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.length == 1 && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: Offstage(),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(width: 2, color: Colors.black),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(width: 2, color: Colors.deepPurple),
            ),
          ),
        ),
      ),
    );
  }

  _checkOTP() async {
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    //var setotp = prefs.getString("otp_" + widget.mobilenumber);
    if (newotp == '1234') {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ReviewPage(customerdata: widget.custdata)));
      // return true;
    } else {
      return false;
    }
  }

  dialogueContent(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(
            top: 100,
            bottom: 16,
            left: 16,
            right: 16,
          ),
          margin: EdgeInsets.only(top: 16),
          decoration: BoxDecoration(
              color: Color(0xFFC5D6FD),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(17),
              boxShadow: [
                BoxShadow(
                  color: Colors.transparent,
                  blurRadius: 4.0,
                  offset: Offset(0.0, 4.0),
                )
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _textFieldBox(context,
                      first: true,
                      last: false,
                      textboxController: 'textboxController1'),
                  _textFieldBox(context,
                      first: true,
                      last: false,
                      textboxController: 'textboxController2'),
                  _textFieldBox(context,
                      first: true,
                      last: false,
                      textboxController: 'textboxController3'),
                  _textFieldBox(context,
                      first: true,
                      last: false,
                      textboxController: 'textboxController4'),
                ],
              ),
              SizedBox(
                height: 24.0,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                    onPressed: (() {
                      setState(() {
                        _checkOTP();
                        //.then((value) {
                        //   if (value == true) {
                        //     Navigator.pop(context);
                        //   } else {
                        //     final snackBar = SnackBar(
                        //         content: Text('Wrong otp',
                        //             style: TextStyle(color: Colors.white)));
                        //     ScaffoldMessenger.of(context)
                        //         .showSnackBar(snackBar);
                        //   }
                        // });
                      });
                    }),
                    child: Text(
                      "Verify",
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    )),
              )
            ],
          ),
        ),
        Positioned(
            top: 0,
            left: 16,
            right: 16,
            child: CircleAvatar(
              backgroundColor: Colors.blueAccent,
              radius: 40,
            ))
      ],
    );
  }
}
