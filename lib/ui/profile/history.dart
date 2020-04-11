import 'package:flutter/material.dart';
import 'package:uf_ride_share_app/ui/posting/posting_list.dart';

class History extends StatelessWidget{
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        child: PostList(),
      ),
    );
  }

}