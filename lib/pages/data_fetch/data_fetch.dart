import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:portal/models/models.dart';
import 'package:portal/services/services.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key? key,
    required this.iddata2,
  }) : super(key: key);

  List<String> iddata2;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future load;
  final ScrollController _scrollController = ScrollController();
  bool isLoading = false;
  final dio = Dio();
  List<ShipmentList> shipmentdata = [];
  String lastid = "null";
  int limit = 6;
  bool loadmore = true;
  bool endCmt = true;

  Future<void> _getMoreData(String templastid) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      setState(() {
        load =
            getToken(widget.iddata2[1], limit, templastid, widget.iddata2[0]);
      });
      List<ShipmentList> finalload = await load;
      print(finalload);
      shipmentdata.addAll(finalload.take(finalload.length - 1));
      if (finalload.length < limit) {
        shipmentdata.addAll(finalload);
        loadmore = false;
      }
      setState(() {
        lastid = finalload.last.id;
        print(lastid);
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getMoreData(lastid);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (loadmore == true) {
          _getMoreData(lastid);
        } else if (loadmore == false) {
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
          opacity: isLoading ? 1.0 : 0.0,
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
        itemCount: shipmentdata.length + 1,
        itemExtent: 130,
        itemBuilder: (BuildContext context, int index) {
          if (index == shipmentdata.length) {
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
                title: Text(shipmentdata[index].fileNumber),
                onTap: () {
                  print(shipmentdata[index].fileNumber);
                },
                trailing: Text(shipmentdata[index].status),
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
