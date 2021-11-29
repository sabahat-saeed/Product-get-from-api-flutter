import 'dart:ui';
import 'package:flutter/material.dart';
import '../../bars/bottombarNav.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import '../../sidebar/sidebar.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import '../home/home.dart';
import 'package:pinch_zoom_image_last/pinch_zoom_image_last.dart';
import '../../styles/styles.dart';

class Product extends StatefulWidget {
  static const routname = '/product';
  final String title;
  final String image;
  Product({this.title, this.image});
  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<Product> {
  var _isLoading = false;

  final bottomBarIndex = -1;
  String _name;
  String _call;
  String _email;
  String _byBoxStyle;
  var _stock = '12pt Cardboard Stock';
  String _length;
  String _width;
  String _height;
  String _qty1;
  String _qty2;
  var _unit = 'inches';
  var _color = 'none';
  var _purpose = 'Request for Quote';
  String _message;
  final GlobalKey<FormState> _productKey = GlobalKey<FormState>();
  Future<void> sendMail() async {
    String username = 'app@Product_get_from_api_in_fluttercircle.com';
    String password = '9(r@NW0hvS!r';
    String domainSmtp = 'Product_get_from_api_in_fluttercircle.com';
    final smtpServer = SmtpServer(domainSmtp,
        username: username, password: password, port: 465, ssl: true);
    final message = Message()
      ..from = Address(username, '$_name')
      ..recipients.add("info@Product_get_from_api_in_fluttercircle.com")
      ..subject = '$_name Send Request from Product Page --App'
      ..text =
          'Customer name : $_name \nPhone no: $_call \nEmail: $_email \nBy Box Style: $_byBoxStyle \nStock: $_stock\nLength: $_length \nWidth: $_width \nHeight: $_height\nUnit: $_unit\nQty1: $_qty1\nQty2: $_qty2\nColor: $_color\nPurpose: $_purpose\nMessage: $_message';
    try {
      setState(() => _isLoading = true);
      final sendReport = await send(message, smtpServer);
      setState(() => _isLoading = false);
      print('Message sent: ' + sendReport.toString());
      showGeneralDialog(
          context: context,
          barrierDismissible: true,
          barrierLabel:
              MaterialLocalizations.of(context).modalBarrierDismissLabel,
          barrierColor: Colors.black45,
          transitionDuration: const Duration(milliseconds: 1000),
          pageBuilder: (BuildContext buildContext, Animation animation,
              Animation secondaryAnimation) {
            return Align(
              alignment: Alignment.center,
              child: Container(
                width: 300,
                height: 215,
                padding: EdgeInsets.all(20),
                //color: Colors.white,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  image: DecorationImage(
                    image: AssetImage("assets/pattern5.png"),
                    colorFilter: new ColorFilter.mode(
                        Colors.grey[200].withOpacity(0.04), BlendMode.dstATop),
                    repeat: ImageRepeat.repeat,
                    fit: BoxFit.none,
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      'Success',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.w200),
                    ),
                    Divider(
                      height: 20,
                      thickness: 1.0,
                      color: Colors.black,
                      indent: 0,
                      endIndent: 0,
                    ),
                    Text(
                      'Your request has been submitted successfully...',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.w200),
                    ),
                    Divider(
                      height: 20,
                      thickness: 1.0,
                      color: Colors.black,
                      indent: 0,
                      endIndent: 0,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            Home.routname, (Route<dynamic> route) => false);
                      },
                      child: Text(
                        "Ok",
                        style: TextStyle(color: Colors.black),
                      ),
                    )
                  ],
                ),
              ),
            );
          });
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }

  Widget _buildCallField() {
    return TextFormField(
      decoration: InputDecoration(
        border: new OutlineInputBorder(
          borderSide: new BorderSide(color: Colors.pink[400]),
        ),
        contentPadding:
            new EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
        hintText: 'Phone',
        hintStyle: const TextStyle(color: Colors.black87),
        helperText: '',
        helperStyle: const TextStyle(color: Colors.pink),
        labelText: 'Phone',
        labelStyle: const TextStyle(color: Colors.pink),
        prefixText: '',
        suffixText: '',
        suffixStyle: const TextStyle(color: Colors.pink),
      ),
      keyboardType: TextInputType.number,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Enter Your Number';
        } else if (value.length < 10) {
          return 'Enter Your correct Number ';
        }
        return null;
      },
      onSaved: (value) {
        _call = value;
      },
    );
  }

  Widget _buildNameField() {
    return TextFormField(
      decoration: InputDecoration(
        border: new OutlineInputBorder(
          borderSide: new BorderSide(color: Colors.pink[400]),
        ),
        contentPadding:
            new EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
        hintText: 'Name',
        hintStyle: const TextStyle(color: Colors.black87),
        helperText: '',
        helperStyle: const TextStyle(color: Colors.pink),
        labelText: 'Name',
        labelStyle: const TextStyle(color: Colors.pink),
        prefixText: '',
        suffixText: '',
        suffixStyle: const TextStyle(color: Colors.pink),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return "Enter Name";
        } else if (value.length < 3) {
          return "Name Must have 3 charaters";
        }
        return null;
      },
      onSaved: (value) {
        _name = value;
      },
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      decoration: InputDecoration(
        border: new OutlineInputBorder(
          borderSide: new BorderSide(color: Colors.pink[400]),
        ),
        contentPadding:
            new EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
        hintText: 'Email',
        hintStyle: const TextStyle(color: Colors.black87),
        helperText: '',
        helperStyle: const TextStyle(color: Colors.pink),
        labelText: 'Email',
        labelStyle: const TextStyle(color: Colors.pink),
        prefixText: '',
        suffixText: '',
        suffixStyle: const TextStyle(color: Colors.pink),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (String value) {
        bool valueValid = RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value);
        if (value.isEmpty) {
          return "Enter email";
        } else if (value.length < 5) {
          return "Email Must have 5 charaters";
        } else if (!valueValid) {
          return "Enter valid email";
        }
        return null;
      },
      onSaved: (value) {
        _email = value;
      },
    );
  }

  Widget _buildStockField(screenWidth) {
    return Container(
      width: screenWidth - 145,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
              width: 1.0, style: BorderStyle.solid, color: Colors.grey),
        ),
      ),
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: 'Stock',
          labelStyle: const TextStyle(color: Colors.pink),
        ),
        value: _stock,
        dropdownColor: Colors.blue[400],
        isExpanded: true,
        icon: Icon(Ionicons.ios_arrow_down),
        items: [
          DropdownMenuItem(
            child: Text('12pt Cardboard Stock'),
            value: "12pt Cardboard Stock",
          ),
          DropdownMenuItem(
            child: Text('14pt Cardboard Stock'),
            value: "14pt Cardboard Stock",
          ),
          DropdownMenuItem(
            child: Text('16pt Cardboard Stock'),
            value: "16pt Cardboard Stock",
          ),
          DropdownMenuItem(
            child: Text('18pt Cardboard Stock'),
            value: "18pt Cardboard Stock",
          ),
          DropdownMenuItem(
            child: Text('20pt Cardboard Stock'),
            value: "20pt Cardboard Stock",
          ),
          DropdownMenuItem(
            child: Text('22pt Cardboard Stock'),
            value: "22pt Cardboard Stock",
          ),
          DropdownMenuItem(
            child: Text('24pt Cardboard Stock'),
            value: "24pt Cardboard Stock",
          ),
          DropdownMenuItem(
            child: Text('Kraft Stock'),
            value: "Kraft Stock",
          ),
          DropdownMenuItem(
            child: Text('Recycled BuxBoard'),
            value: "Recycled BuxBoard",
          ),
          DropdownMenuItem(
            child: Text('Corrugated Stock'),
            value: "Corrugated Stock",
          ),
          DropdownMenuItem(
            child: Text('No Product_get_from_api_in_flutter Required'),
            value: "No Product_get_from_api_in_flutter Required",
          ),
        ],
        onChanged: (value) {
          setState(() {
            _byBoxStyle = value;
          });
        },
      ),
    );
  }

  Widget _buildbyboxstyleField(screenWidth) {
    return TextFormField(
      decoration: InputDecoration(
        border: new OutlineInputBorder(
          borderSide: new BorderSide(color: Colors.pink[400]),
        ),
        contentPadding:
            new EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
        hintText: 'By Box',
        hintStyle: const TextStyle(color: Colors.black87),
        labelText: 'By Box',
        labelStyle: const TextStyle(color: Colors.pink),
        prefixText: '',
        suffixText: '',
        suffixStyle: const TextStyle(color: Colors.pink),
      ),
      enabled: false,
      initialValue: widget.title,
      validator: (String value) {
        if (value.isEmpty) {
          return "Enter Name";
        } else if (value.length < 3) {
          return "Name Must have 3 charaters";
        }
        return null;
      },
      onSaved: (value) {
        _byBoxStyle = value;
      },
    );
  }

  Widget _buildWidthField(screenWidth) {
    return Container(
      padding: EdgeInsets.only(left: 10.0),
      width: (screenWidth - 60) / 3,
      child: TextFormField(
        decoration: InputDecoration(
          border: new OutlineInputBorder(
            borderSide: new BorderSide(color: Colors.pink[400]),
          ),
          contentPadding:
              new EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
          hintText: 'Width',
          hintStyle: const TextStyle(color: Colors.black87),
          helperText: '',
          helperStyle: const TextStyle(color: Colors.pink),
          labelText: 'Width',
          labelStyle: const TextStyle(color: Colors.pink),
          prefixText: '',
          suffixText: '',
          suffixStyle: const TextStyle(color: Colors.pink),
        ),
        keyboardType: TextInputType.number,
        validator: (String value) {
          if (value.isEmpty) {
            return 'not valid';
          } else if (value.length > 10) {
            return 'not valid';
          }
          return null;
        },
        onSaved: (value) {
          _width = value;
        },
      ),
    );
  }

  Widget _buildLengthField(screenWidth) {
    return Container(
      width: (screenWidth - 60) / 3,
      child: TextFormField(
        decoration: InputDecoration(
          border: new OutlineInputBorder(
            borderSide: new BorderSide(color: Colors.pink[400]),
          ),
          contentPadding:
              new EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
          //icon: Icon(Icons.call),
          hintText: 'Length',
          hintStyle: const TextStyle(color: Colors.black87),
          helperText: '',
          helperStyle: const TextStyle(color: Colors.pink),
          labelText: 'Length',
          labelStyle: const TextStyle(color: Colors.pink),
          prefixText: '',
          suffixText: '',
          suffixStyle: const TextStyle(color: Colors.pink),
        ),
        keyboardType: TextInputType.number,
        validator: (String value) {
          if (value.isEmpty && double.tryParse(value) <= 0) {
            return 'Length*';
          } else if (value.length > 10) {
            return 'Length*';
          }
          return null;
        },
        onSaved: (value) {
          _length = value;
        },
      ),
    );
  }

  Widget _buildUnitField(screenWidth) {
    return Container(
      width: screenWidth - 145,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
              width: 1.0, style: BorderStyle.solid, color: Colors.grey),
        ),
      ),
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: 'Unit',
          labelStyle: const TextStyle(color: Colors.pink),
        ),
        value: _unit,
        dropdownColor: Colors.blue[400],
        isExpanded: true,
        icon: Icon(Ionicons.ios_arrow_down),
        items: [
          DropdownMenuItem(
            child: Text('Inches'),
            value: "inches",
          ),
          DropdownMenuItem(
            child: Text('cm'),
            value: "cm",
          ),
          DropdownMenuItem(
            child: Text('mm'),
            value: "mm",
          )
        ],
        onChanged: (value) {
          setState(() {
            _unit = value;
          });
        },
      ),
    );
  }

  Widget _buildHeightField(screenWidth) {
    return Container(
      padding: EdgeInsets.only(left: 10.0),
      width: (screenWidth - 65) / 3,
      child: TextFormField(
        decoration: InputDecoration(
          border: new OutlineInputBorder(
            borderSide: new BorderSide(color: Colors.pink[400]),
          ),
          contentPadding:
              new EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
          hintText: 'Height',
          hintStyle: const TextStyle(color: Colors.black87),
          helperText: '',
          helperStyle: const TextStyle(color: Colors.pink),
          labelText: 'Height',
          labelStyle: const TextStyle(color: Colors.pink),
          prefixText: '',
          suffixText: '',
          suffixStyle: const TextStyle(color: Colors.pink),
        ),
        keyboardType: TextInputType.number,
        validator: (String value) {
          if (value.isEmpty) {
            return 'height*';
          } else if (value.length > 10) {
            return 'height*';
          }
          return null;
        },
        onSaved: (value) {
          _height = value;
        },
      ),
    );
  }

  Widget _buildPurposeField(screenWidth) {
    return Container(
      width: screenWidth - 145,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
              width: 1.0, style: BorderStyle.solid, color: Colors.grey),
        ),
      ),
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: 'Purpose',
          labelStyle: const TextStyle(color: Colors.pink),
        ),
        value: _purpose,
        dropdownColor: Colors.blue[400],
        isExpanded: true,
        icon: Icon(Ionicons.ios_arrow_down),
        items: [
          DropdownMenuItem(
            child: Text('Request for Quote'),
            value: "Request for Quote",
          ),
          DropdownMenuItem(
            child: Text('Request for Template'),
            value: "Request for Template",
          ),
        ],
        onChanged: (value) {
          setState(() {
            _byBoxStyle = value;
          });
        },
      ),
    );
  }

  Widget _buildColorField(screenWidth) {
    return Container(
      width: screenWidth - 145,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
              width: 1.0, style: BorderStyle.solid, color: Colors.grey),
        ),
      ),
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: 'Color',
          labelStyle: const TextStyle(color: Colors.pink),
        ),
        value: _color,
        dropdownColor: Colors.blue[400],
        isExpanded: true,
        icon: Icon(Ionicons.ios_arrow_down),
        items: [
          DropdownMenuItem(
            child: Text('None'),
            value: "none",
          ),
          DropdownMenuItem(
            child: Text('1 Colour'),
            value: "1 Colour",
          ),
          DropdownMenuItem(
            child: Text('2 Colour'),
            value: "2 Colour",
          ),
          DropdownMenuItem(
            child: Text('3 Colour'),
            value: "3 Colour",
          ),
          DropdownMenuItem(
            child: Text('4 Colour'),
            value: "4 Colour",
          ),
          DropdownMenuItem(
            child: Text('4/1 Colour'),
            value: "4/1 Colour",
          ),
          DropdownMenuItem(
            child: Text('4/2 Colour'),
            value: "4/2 Colour",
          ),
          DropdownMenuItem(
            child: Text('4/3 Colour'),
            value: "4/3 Colour",
          ),
          DropdownMenuItem(
            child: Text('4/4 Colour'),
            value: "4/4 Colour",
          )
        ],
        onChanged: (value) {
          setState(() {
            _byBoxStyle = value;
          });
        },
      ),
    );
  }

  Widget _buildMessageField() {
    return TextFormField(
      decoration: InputDecoration(
        border: new OutlineInputBorder(
          borderSide: new BorderSide(color: Colors.pink[400]),
        ),
        hintText: 'Message',
        hintStyle: const TextStyle(color: Colors.black87),
        helperText: '',
        helperStyle: const TextStyle(color: Colors.pink),
        alignLabelWithHint: true,
        labelText: 'Message',
        labelStyle: const TextStyle(
          color: Colors.pink,
        ),
        prefixText: '',
        suffixText: '',
        suffixStyle: const TextStyle(color: Colors.pink),
      ),
      maxLines: 6,
      validator: (String value) {
        if (value.isEmpty) {
          return "Enter Message";
        } else if (value.length < 10) {
          return "Message Must have 10 charaters";
        }
        return null;
      },
      onSaved: (value) {
        _message = value;
      },
    );
  }

  Widget _buildQty1Field(screenWidth) {
    return Container(
      padding: EdgeInsets.only(left: 0.0),
      width: (screenWidth - 60) / 2,
      child: TextFormField(
        decoration: InputDecoration(
          border: new OutlineInputBorder(
            borderSide: new BorderSide(color: Colors.pink[400]),
          ),
          contentPadding:
              new EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
          hintText: 'Qty1',
          hintStyle: const TextStyle(color: Colors.black87),
          helperText: '',
          helperStyle: const TextStyle(color: Colors.pink),
          labelText: 'Qty1',
          labelStyle: const TextStyle(color: Colors.pink),
          prefixText: '',
          suffixText: '',
          suffixStyle: const TextStyle(color: Colors.pink),
        ),
        keyboardType: TextInputType.number,
        validator: (String value) {
          if (value.isEmpty) {
            return 'not valid';
          } else if (value.length > 10) {
            return 'not valid';
          }
          return null;
        },
        onSaved: (value) {
          _qty1 = value;
        },
      ),
    );
  }

  Widget _buildQty2Field(screenWidth) {
    return Container(
      padding: EdgeInsets.only(left: 10.0),
      width: (screenWidth - 60) / 2,
      child: TextFormField(
        decoration: InputDecoration(
          border: new OutlineInputBorder(
            borderSide: new BorderSide(color: Colors.pink[400]),
          ),
          contentPadding:
              new EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
          hintText: 'Qty2',
          hintStyle: const TextStyle(color: Colors.black87),
          helperText: '',
          helperStyle: const TextStyle(color: Colors.pink),
          labelText: 'Qty2',
          labelStyle: const TextStyle(color: Colors.pink),
          prefixText: '',
          suffixText: '',
          suffixStyle: const TextStyle(color: Colors.pink),
        ),
        keyboardType: TextInputType.number,
        validator: (String value) {
          if (value.isEmpty) {
            return 'not valid';
          } else if (value.length > 10) {
            return 'not valid';
          }
          return null;
        },
        onSaved: (value) {
          _qty2 = value;
        },
      ),
    );
  }

  Container requestForm(screenWidth) {
    return Container(
      child: SingleChildScrollView(
        child: Form(
          key: _productKey,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: screenWidth,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    child: _buildNameField(),
                  ),
                  Container(
                    width: screenWidth,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    child: _buildCallField(),
                  ),
                  Container(
                    width: screenWidth,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    child: _buildEmailField(),
                  ),
                  Container(
                    width: screenWidth,
                    padding: EdgeInsets.fromLTRB(30, 5, 30, 10),
                    child: _buildbyboxstyleField(screenWidth),
                  ),
                  Container(
                    width: screenWidth,
                    padding: EdgeInsets.fromLTRB(30, 5, 30, 10),
                    child: _buildStockField(screenWidth),
                  ),
                  Container(
                      width: screenWidth,
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                      child: Row(
                        children: [
                          _buildLengthField(screenWidth),
                          _buildWidthField(screenWidth),
                          _buildHeightField(screenWidth),
                        ],
                      )),
                  Container(
                    width: screenWidth,
                    padding: EdgeInsets.fromLTRB(30, 5, 30, 10),
                    child: _buildUnitField(screenWidth),
                  ),
                  Container(
                      width: screenWidth,
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                      child: Row(
                        children: [
                          _buildQty1Field(screenWidth),
                          _buildQty2Field(screenWidth),
                        ],
                      )),
                  Container(
                    width: screenWidth,
                    padding: EdgeInsets.fromLTRB(30, 5, 30, 10),
                    child: _buildColorField(screenWidth),
                  ),
                  Container(
                    width: screenWidth,
                    padding: EdgeInsets.fromLTRB(30, 5, 30, 10),
                    child: _buildPurposeField(screenWidth),
                  ),
                  Container(
                    width: screenWidth,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    child: _buildMessageField(),
                  ),
                  Container(
                    width: screenWidth / 1.2,
                    padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue[400],
                          onPrimary: Colors.pink[700],
                        ),
                        child: _isLoading
                            ? CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.pink[400]),
                                backgroundColor: Colors.blue[400],
                              )
                            : Text(
                                'Submit'.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 16,
                                  letterSpacing: 5.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                        onPressed: () {
                          if (!_productKey.currentState.validate()) {
                            return;
                          }
                          _productKey.currentState.save();
                          sendMail();
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Scaffold _page(dynamic context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final bottomBarIndex = -1;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                paddingVerticle(10.0),
                product(context, screenWidth, screenHeight, widget.title,
                    widget.image),
                requestForm(screenWidth),
                paddingVerticle(50.0),
              ],
            ),
          ),
          bottombarNav(context, bottomBarIndex),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _page(context),
          SideBar(),
        ],
      ),
    );
  }
}

Column product(context, screenWidth, screenHeight, title, image) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Stack(
        alignment: Alignment.topLeft,
        children: <Widget>[
          Container(
            width: screenWidth,
            child: Center(
              child: PinchZoomImage(
                image: Image.network(
                  image,
                ),
                zoomedBackgroundColor: Color.fromRGBO(240, 240, 240, 1.0),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(50, 8, 0, 0),
            child: ClipOval(
              child: Material(
                color: Color(0x22000000),
                child: InkWell(
                  splashColor: Colors.red,
                  child: SizedBox(
                      width: 56,
                      height: 56,
                      child: Icon(
                        CupertinoIcons.left_chevron,
                      )),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      Container(
        padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
        width: screenWidth - 10,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          image: DecorationImage(
            image: AssetImage("assets/pattern5.png"),
            colorFilter: new ColorFilter.mode(
                Colors.grey[200].withOpacity(0.04), BlendMode.dstATop),
            repeat: ImageRepeat.repeat,
            fit: BoxFit.none,
          ),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.black,
              letterSpacing: 1.5,
              fontWeight: FontWeight.w500,
              fontSize: 18),
        ),
      ),
    ],
  );
}
