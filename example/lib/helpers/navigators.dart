import 'package:flutter/material.dart';



void nextPage(context, component) {
  Navigator.of(context).push(MaterialPageRoute(builder: component));
}

void nextPageNoPop(context, component) {
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: component), (route) => false);
}


