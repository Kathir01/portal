import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:portal/services/services.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({
    super.key,
    //required this.filenum,
    required this.iddata2,
    //required this.lastid
  });
  // List filenum;
  List<String> iddata2;
  // List lastid;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future load;
  final ScrollController _scrollController = ScrollController();
  bool isLoading = false;
  final dio = Dio();
  List<String> filenumbers = [];
  String lastid = "null";
  int limit = 6;
  bool loadmore = true;
  bool endCmt = true;

  void _getMoreData(templastid) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      setState(() {
        load =
            getToken(widget.iddata2[1], limit, templastid, widget.iddata2[0]);
      });
      List finalload = await load;
      List onlyfilenum = finalload[0];
      String nextlastid = finalload[1];
      setState(() {
        for (int i = 0; i < onlyfilenum.length; i++) {
          filenumbers.add(onlyfilenum[i]);
        }
        lastid = nextlastid;
        isLoading = false;
      });
    }
  }

  @override
  initState() {
    super.initState();
    _getMoreData(lastid);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (lastid != "stop") {
          _getMoreData(lastid);
        } else if (lastid == "stop") {
          setState(() {
            endCmt = false;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildProgressIndicator() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: Opacity(
          opacity: isLoading ? 1.0 : 00,
          child: const CircularProgressIndicator(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shipments"),
      ),
      body: ListView.builder(
        itemCount: filenumbers.length + 1,
        itemExtent: 130,
        itemBuilder: (BuildContext context, int index) {
          if (index == filenumbers.length) {
            if (!endCmt) {
              return Center(
                child: Text("No data"),
              );
            } else {
              return _buildProgressIndicator();
            }
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: Icon(Icons.local_shipping_sharp),
                title: Text((filenumbers[index])),
                onTap: () {
                  print(filenumbers[index]);
                },
              ),
            );
          }
        },
        controller: _scrollController,
      ),
      //resizeToAvoidBottomInset: false,
    );
  }
}
