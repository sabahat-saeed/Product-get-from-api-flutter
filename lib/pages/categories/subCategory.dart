import 'package:flutter/material.dart';
import '../../styles/styles.dart';
import '../../gesture_detector/swipe_up_section/category.dart';
import '../../gesture_detector/customGestureDetector.dart';
import 'package:provider/provider.dart';
import '../../providers/subCategoriesProvider.dart';
import '../product/product.dart';

class SubCategory extends StatefulWidget {
  static const routname = '/subcategory';
  final String id;
  final String title;
  final String image;
  SubCategory({this.id, this.title, this.image});
  @override
  _SubCategoryState createState() => _SubCategoryState();
}

class _SubCategoryState extends State<SubCategory> {
  bool showBottomAddress = false;
  double threshold = 100;
  var isInit = true;
  SubCategoriesProvider item;
  var _isLoading = false;
  bool isStyle;

  @override
  void didChangeDependencies() async {
    if (isInit) {
      setState(() => _isLoading = true);
      item = Provider.of<SubCategoriesProvider>(context);

      try {
        await item.fetchSubCategories(widget.id);
      } catch (error) {
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
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    image: DecorationImage(
                      image: AssetImage("assets/pattern5.png"),
                      colorFilter: new ColorFilter.mode(
                          Colors.grey[200].withOpacity(0.04),
                          BlendMode.dstATop),
                      repeat: ImageRepeat.repeat,
                      fit: BoxFit.none,
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Error',
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
                        'Internet Connection problem. Please try again later',
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
      }

      setState(() => _isLoading = false);
    }
    isInit = false;
    super.didChangeDependencies();
  }

  Scaffold _page(dynamic context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final bottomBarIndex = -1;
    return Scaffold(
      appBar: headerNav(
          context,
          widget.title.length > 15
              ? "${widget.title.substring(0, 15)}.."
              : widget.title,
          screenWidth),
      body: CustomGestureDetector(
        axis: CustomGestureDetector.AXIS_Y,
        velocity: threshold,
        onSwipeUp: () {
          this.setState(() {
            showBottomAddress = true;
          });
        },
        onSwipeDown: () {
          this.setState(() {
            showBottomAddress = false;
          });
        },
        child: Container(
          height: screenHeight,
          child: Stack(
            children: <Widget>[
              SingleChildScrollView(
                child: _isLoading
                    ? Center(
                        child: Container(
                          margin: EdgeInsets.only(top: 300),
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.pink[400]),
                            backgroundColor: Colors.white,
                          ),
                        ),
                      )
                    : Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.fromLTRB(20, 60, 10, 0),
                            child: GridView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio:
                                    (screenHeight / (screenHeight / .7)),
                                mainAxisSpacing: 10.0,
                                crossAxisSpacing: 10.0,
                              ),
                              itemCount: item.categoriesList.length,
                              itemBuilder: (context, index) {
                                return card(
                                    context,
                                    item.categoriesList[index].title,
                                    item.categoriesList[index].imageUrl,
                                    screenHeight,
                                    screenWidth);
                              },
                            ),
                          ),
                          paddingVerticle(80.0),
                        ],
                      ),
              ),
              category(
                  showBottomAddress, screenHeight, widget.title, widget.image),
              bottombarNav(context, bottomBarIndex),
            ],
          ),
        ),
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

Card card(context, title, image, screenHeight, screenWidth) {
  return new Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10), // if you need this
      side: BorderSide(
        color: Colors.grey.withOpacity(0.9),
        width: 1,
      ),
    ),
    color: Colors.white,
    child: GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => Product(title: title, image: image),
          ),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: new EdgeInsets.fromLTRB(10, 10, 10, 0),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Image.network(
              image,
              semanticLabel: title,
              filterQuality: FilterQuality.none,
              fit: BoxFit.cover,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.pink[400]),
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes
                        : null,
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  'assets/demi.PNG',
                  fit: BoxFit.cover,
                  width: screenWidth / 2.5,
                  height: screenWidth / 2.5,
                  filterQuality: FilterQuality.high,
                );
              },
            ),
          ),
          paddingVerticle(5.0),
          Container(
            child: Text(
              title.length > 20 ? "${title.substring(0, 20)}.." : title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
