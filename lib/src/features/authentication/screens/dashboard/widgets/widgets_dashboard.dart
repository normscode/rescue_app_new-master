import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

Container userStat(String attribute, String value, {String? unit}) {
  return Container(
      margin: EdgeInsets.all(8),
      child: Neumorphic(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 3.0),
                  child: Row(
                    children: [
                      Text(
                        value,
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      unit == null
                          ? Container()
                          : Text(
                              ' ' + unit,
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.black,
                              ),
                            ),
                    ],
                  ),
                ),
                Text(
                  attribute,
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          style: NeumorphicStyle(
              border: NeumorphicBorder(
                color: Colors.blue,
                width: 1,
              ),
              depth: 20,
              intensity: 0.5,
              lightSource: LightSource.topLeft,
              shape: NeumorphicShape.convex)));
}
