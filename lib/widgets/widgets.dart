import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_shop_app/models/favorites_model_List.dart';
import 'package:flutter_app_shop_app/shop_app/home/cubit/cubit.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

navigatorToPush({@required context, @required screen}) =>
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (BuildContext context) => screen),
    );

navigatorTo({@required context, @required screen}) => Navigator.push(
      context,
      MaterialPageRoute(builder: (BuildContext context) => screen),
    );

Widget buildButtonContinue({required BuildContext context, onTap}) {
  return Container(
    margin: EdgeInsets.all(25),
    child: SizedBox(
      width: double.infinity,
      height: 50,
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Colors.deepOrange,
        onPressed: onTap,
        child: Text(
          "Continue",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 26),
        ),
      ),
    ),
  );
}

Widget buildTextFormField(
    {@required textTitle,
    @required controller,
    @required validatorText,
    @required hintText,
    @required icon,
    @required keyboardType,
    isObscureText,
    suffixIcon,
    context,
    onSubmit,
    enabled = true,
    radius = 25.0}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          textTitle,
          style: TextStyle(color: Colors.deepOrange),
        ),
        SizedBox(
          height: 5,
        ),
        TextFormField(
          enabled: enabled,
          onFieldSubmitted: onSubmit,
          keyboardType: keyboardType,
          obscureText: isObscureText,
          controller: controller,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return validatorText;
            }
            return null;
          },
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius),
              borderSide: BorderSide(
                width: 1.0,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(
                color: Colors.deepOrange,
              ),
            ),
            hintText: hintText,
            prefixIcon: Icon(
              icon,
              color: Colors.deepOrange,
            ),
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    ),
  );
}

void showToastFunction({@required msg, @required color, @required context}) =>
    showToast(
      msg,
      context: context,
      animation: StyledToastAnimation.scale,
      reverseAnimation: StyledToastAnimation.fade,
      position: StyledToastPosition.bottom,
      animDuration: Duration(seconds: 1),
      duration: Duration(seconds: 4),
      curve: Curves.elasticOut,
      reverseCurve: Curves.linear,
      backgroundColor: color,
      borderRadius: BorderRadius.circular(25),
      textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    );


class buildListItem extends StatelessWidget {
  const buildListItem({
    Key? key,
    required this.product,
  }) : super(key: key);

  final  product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 120,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.network(
                  "${product.image}",
                  height: 120,
                  width: 150,
                  fit: BoxFit.contain,
                ),
                if (product.oldPrice != product.price)
                  Positioned(
                    child: Container(
                      width: 100,
                      decoration: BoxDecoration(
                          color: Colors.red.shade400,
                          borderRadius:
                          BorderRadius.circular(20)),
                      child: Center(
                        child: Text(
                          "DISCOUNT",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16),
                        ),
                      ),
                    ),
                    bottom: 2,
                  )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 210,
                  child: Text(
                    "${product.name}",
                    style: TextStyle(
                        fontWeight: FontWeight.bold),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Spacer(),
                Row(
                  crossAxisAlignment:
                  CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      "LE ${product.price}",
                      style: TextStyle(
                          color: Colors.deepOrange,
                          fontSize: 20),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    if (product.oldPrice != product.price)
                      Text(
                        "LE ${product.oldPrice}",
                        style: TextStyle(
                          fontSize: 16,
                          decoration:
                          TextDecoration.lineThrough,
                          textBaseline:
                          TextBaseline.ideographic,
                        ),
                      ),
                  ],
                )
              ],
            ),
            Expanded(
              child: Column(
                children: [
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      AppCubit.get(context)
                          .postDataFavorites(product.id);
                    },
                    icon: Icon(
                      AppCubit.get(context)
                          .favoritesMap["${product.id}"]
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Colors.deepOrange,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
