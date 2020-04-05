import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yathaarth/keys.dart';
import 'package:yathaarth/models/responses/home_response.dart';
import 'package:yathaarth/router.dart';
import 'package:yathaarth/screens/types/index.dart';

class StatSquare extends StatelessWidget {
  final HomeResponse type;

  const StatSquare({Key key, @required this.type}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: Color(int.parse(type.color)),
              borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(type.count.toString(),
                      style: Theme.of(context).textTheme.headline5.copyWith(
                          color: Colors.white
                      )
                  )
              ),
              Text(type.label,
                style: Theme.of(context).textTheme.subtitle1.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w900
                ),
                textAlign: TextAlign.center,
              ),
            ],
          )
      ),
      onTap: () {
        Keys.navigatorKey.currentState.pushNamed(Router.typesRoute, arguments: TypesArguments(type: type));
      },
    );
  }
}