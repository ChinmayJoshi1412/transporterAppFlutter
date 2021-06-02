import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//constants
import 'package:liveasy/constants/color.dart';
import 'package:liveasy/constants/spaces.dart';
import 'package:liveasy/models/truckModel.dart';
import 'package:liveasy/widgets/addTruckButton.dart';
//widgets
import 'package:liveasy/widgets/backButtonWidget.dart';
import 'package:liveasy/widgets/headingTextWidget.dart';
import 'package:liveasy/widgets/helpButtonWidget.dart';
import 'package:liveasy/widgets/loadingWidget.dart';
import 'package:liveasy/widgets/myTrucksCard.dart';
import 'package:liveasy/widgets/searchLoadWidget.dart';
//functions
import 'package:liveasy/functions/getDataFromApi.dart';

class MyTrucks extends StatefulWidget {

  @override
  _MyTrucksState createState() => _MyTrucksState();
}

class _MyTrucksState extends State<MyTrucks> {

  GetDataFromApi getDataFromApi = GetDataFromApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        padding: EdgeInsets.fromLTRB(space_4, space_8, space_4, space_4),
        child: Column(
          children: [
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    BackButtonWidget(),
                    SizedBox(
                      width: space_3,
                    ),
                    HeadingTextWidget("My Trucks"),
                    // HelpButtonWidget(),
                  ],
                ),
                HelpButtonWidget(),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(
                vertical: space_3
              ),
                //TODO: make search widget dynamic
                child: SearchLoadWidget('Search')),
            // Container(
            //   height: MediaQuery.of(context).size.height * 0.6,
            //   child: SingleChildScrollView(
            //     child: Column(
            //       children: [
            //         MyTruckCard(),
            //         MyTruckCard(),
            //         MyTruckCard()
            //       ],
            //     ),
            //   ),
            // ),
            Container(
              height: MediaQuery.of(context).size.height * 0.6,
              child: FutureBuilder(
                future: getDataFromApi.getTruckData(),
                builder: (BuildContext context , AsyncSnapshot snapshot){
                  if(snapshot.data == null){
                    return LoadingWidget();
                  }
                  print('in future builder');
                  print(snapshot.data[0]);
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                      itemBuilder: (context , index){
                          // print('in item builder');
                          // print(snapshot.data[index].truckNo);
                          return MyTruckCard(
                            truckId: snapshot.data[index].truckId,
                            transporterId:  snapshot.data[index].transporterId,
                            truckNo:  snapshot.data[index].truckNo,
                            truckApproved:  snapshot.data[index].truckApproved,
                            imei:  snapshot.data[index].imei,
                            passingWeight:  snapshot.data[index].passingWeight,
                            driverId:  snapshot.data[index].driverId,
                            truckType:  snapshot.data[index].truckType,
                            tyres:  snapshot.data[index].tyres,
                          );
                      });
                },
              ),
            ),
            //TODO: placement of add truck button and determine optimum length of listview container
            AddTruckButton(),
          ],
        ),
      ),
    );
  }


}
