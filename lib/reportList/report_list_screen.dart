import 'dart:io';

import 'package:flutter/material.dart';
import 'package:reporting_system/appcolor/appcolor.dart';
import 'package:reporting_system/common/size.dart';
import 'package:reporting_system/database/app_database.dart';
import 'package:reporting_system/login/login_scren.dart';
import 'package:reporting_system/reportList/bloc.dart';

// ignore: must_be_immutable
class ReportListScreen extends StatelessWidget {
  final String userName;
  ReportListBloc _bloc;

  ReportListScreen({Key key, this.userName}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    _bloc = ReportListBloc(username: userName);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: userName != null ? true : false,
        title: Text("Report List"),
        backgroundColor: AppColor.kPrimaryColor,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: IconButton(
                tooltip: "Log out",
                icon: Icon(
                  Icons.logout,
                  size: 35,
                ),
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                }),
          )
        ],
      ),
      body: StreamBuilder<List<ReportMoorModelData>>(
          stream: _bloc.reportListController,
          builder: (context, snapshot) {
            return snapshot.hasData && snapshot.data.length > 0
                ? ListView(
                    children: List.generate(
                        snapshot.data.length,
                        (index) => snapshot.hasData
                            ? Card(
                                margin: EdgeInsets.only(top: 20),
                                child: ListTile(
                                  isThreeLine: true,
                                  subtitle:
                                      Text("- ${snapshot.data[index].username}",
                                          style: TextStyle(
                                            fontSize: CommonSize.kfontSize,
                                            color: AppColor.kPrimaryColor,
                                          )),
                                  leading: SizedBox(
                                    height: 140,
                                    width: 100,
                                    child: Image.file(
                                        File(snapshot.data[index].imagepath),
                                        fit: BoxFit.cover),
                                  ),
                                  title: Text(
                                    snapshot.data[index].description,
                                    maxLines: 4,
                                    style: TextStyle(
                                      fontSize: CommonSize.kheaderSize,
                                      color: AppColor.kPrimaryColor,
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox()),
                  )
                : Center(
                    child: Text("No Report to Show!",
                        style: TextStyle(
                          fontSize: CommonSize.kfontSize,
                          color: AppColor.kPrimaryColor,
                        )));
          }),
    );
  }
}