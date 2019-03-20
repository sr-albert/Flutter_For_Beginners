import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';


class MapBloc{

  // Create controller
  StreamController mapController = new StreamController();

  // Get Stream from Controller
  Stream get mapStream =>  mapController.stream;

  // Config google map variables
  Completer<GoogleMapController> mapCompleter = Completer();
  LatLng centerLatLong = LatLng(45.521563, -122.677433);


  var currentLocation;
  var location = new Location();
  var permissionLocation;


  getCurrentLocation () async{
    //Location object
    try {

      bool hasPer = await location.hasPermission();

      if(hasPer){
         currentLocation = await location.getLocation();
         print(currentLocation);
       }else{
        // Request permission
        location.requestPermission();
        print("Has not permission");
       }
    }catch (e) {
      currentLocation = null;
    }

    print(currentLocation);
  }


  onCreatedMap(GoogleMapController ggMapController) {
    mapCompleter.complete(ggMapController);
  }

  // Close Controller when app dispose
  dispose(){
    mapController.close();
  }


}