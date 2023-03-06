import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:portal/models/models.dart';
import 'package:portal/pages/pages.dart';
import 'package:portal/services/services.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key? key,
    required this.iddata2,
  }) : super(key: key);

  final List<String> iddata2;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future load;
  final ScrollController _scrollController = ScrollController();
  //final ScrollController bar = ScrollController();
  bool isLoading = false;
  final dio = Dio();
  List<ShipmentList> shipmentdata = [];
  String lastid = "null";
  int limit = 8;
  bool loadmore = true;
  bool endCmt = true;
  String filter = "null";

  Future<void> _getMoreData(String templastid, String filter) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
        endCmt = true;
      });
      setState(() {
        load = getToken(
            widget.iddata2[1], limit, templastid, widget.iddata2[0], filter);
      });
      List<ShipmentList> finalload = await load;
      setState(() {
        if (finalload.isNotEmpty) {
          lastid = finalload.last.id;
        } else if (finalload.isEmpty) {
          endCmt = false;
        }
        isLoading = false;
      });
      shipmentdata.addAll(finalload);
      //finalload.take(finalload.length - 1));
      if (finalload.length < limit) {
        shipmentdata.addAll(finalload);
        loadmore = false;
      } else {
        loadmore = true;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _getMoreData(lastid, filter);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (loadmore == true) {
          _getMoreData(lastid, filter);
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
    return RefreshIndicator(
      onRefresh: () {
        shipmentdata.clear();
        return _getMoreData("null", filter);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Shipments"),
          actions: [
            PopupMenuButton(
              icon: Icon(Icons.filter_list_rounded),
              itemBuilder: (BuildContext context) => [
                PopupMenuItem(
                  value: 'Active',
                  child: Text('Active'),
                ),
                PopupMenuItem(
                  value: 'New',
                  child: Text('New'),
                ),
                PopupMenuItem(
                  value: 'Suspend',
                  child: Text('Suspend'),
                ),
                PopupMenuItem(
                  value: 'Cancel',
                  child: Text('Cancel'),
                ),
                PopupMenuItem(
                  value: 'Completed',
                  child: Text('Completed'),
                ),
              ],
              onSelected: (value) {
                shipmentdata.clear();
                lastid = "null";
                filter = value;
                _getMoreData(lastid, filter);
              },
            )
          ],
        ),
        body: DraggableScrollbar.arrows(
          alwaysVisibleScrollThumb: true,
          labelTextBuilder: (double offset) => Text("${offset ~/ 100}"),
          controller: _scrollController,
          backgroundColor: Colors.grey,
          //thickness: 30,
          child: ListView.builder(
            controller: _scrollController,
            itemCount: shipmentdata.length + 1,
            itemExtent: 130,
            itemBuilder: (BuildContext context, int index) {
              if (index == shipmentdata.length) {
                if (!endCmt) {
                  return const Center(
                    child: Text("No data"),
                  );
                } else {
                  return _buildProgressIndicator();
                }
              } else {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Icon(Icons.local_shipping),
                    title: Text(shipmentdata[index].fileNumber),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => DownloaderPage()));
                    },
                    trailing: Text(shipmentdata[index].status),
                  ),
                );
              }
            },
            // controller: _scrollController,
          ),
        ),
      ),
    );
  }
}
