import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'model/product.dart';

class ViewCategory extends StatefulWidget {
  const ViewCategory({Key? key}) : super(key: key);

  @override
  State<ViewCategory> createState() => _ViewCategoryState();
}

class _ViewCategoryState extends State<ViewCategory> {

  Future<List>? alldata;

  Future<List> getdata() async
  {

    Uri url= Uri.parse("https://fakestoreapi.com/products");
    var response = await http.get(url);
    if(response.statusCode==200)
    {
      var body = response.body.toString();
      var json = jsonDecode(body);
      return json;

    }
    else
    {
      return [];
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      alldata = getdata();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ViewCategory"),),
      body:FutureBuilder(
        future: alldata,
        builder: (context,snapshots)
          {
            if(snapshots.hasData)
              {
                if(snapshots.data!.length<=0)
                  {
                    return Center(
                      child: Text("No Data"),
                    );
                  }
                else
                  {
                    return ListView.builder(
                        itemCount: snapshots.data!.length,
                        itemBuilder: (context,index)
                        {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.network(snapshots.data![index]["image"].toString(),
                                    width: 150.0,
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(snapshots.data![index]["title"].toString(),
                                          maxLines: 2,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                        SizedBox(height: 8.0),
                                        Text("Rs. " + snapshots.data![index]["price"].toString(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green,
                                            fontSize: 14.0,
                                          ),
                                        ),
                                        SizedBox(height: 5.0),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(snapshots.data![index]["category"].toString(),
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12.0,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Text(snapshots.data![index]["rating"]["rate"].toString(),
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 12.0,
                                                  ),
                                                ),
                                                IconButton(
                                                  icon: Icon(Icons.favorite_border),
                                                  onPressed: (){},
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                    );
                  }
              }
            else
              {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
          }
      )
    );
  }
}
