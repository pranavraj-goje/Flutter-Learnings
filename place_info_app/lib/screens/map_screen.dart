import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/place.dart';
import '../helpers/location_helper.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelecting;
  final Function onSelectPlace;

  MapScreen({
    this.initialLocation =
        const PlaceLocation(latitude: 37.422, longitude: -122.084),
    this.isSelecting = false,
    this.onSelectPlace,
  });

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  String _previewImageUrl;

  final _cityController = TextEditingController();
  final _stateController = TextEditingController();

  Future<void> _selectCity() async {
    final staticMapImageUrl = await PositionHelper.generateLocationPreviewImage(
      city: _cityController.text,
      state: _stateController.text,
    );
    setState(() {
      _previewImageUrl = staticMapImageUrl[0];
    });
    widget.onSelectPlace(double.parse(staticMapImageUrl[1]), double.parse(staticMapImageUrl[2]));
  }

  void _doneButton() {
    Navigator.of(context).pop(_previewImageUrl);
  }
  // Future<void> _trial() async {
  //   print(_cityController.text);
  //   print(_stateController.text);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select City'),
        actions: <Widget>[
          IconButton(
            onPressed: _doneButton,
            icon: Icon(Icons.done),
          )
        ],
      ),
      // body: GoogleMap(
      //   initialCameraPosition: CameraPosition(
      //     target: LatLng(
      //       widget.initialLocation.latitude,
      //       widget.initialLocation.longitude,
      //     ),
      //     zoom: 16,
      //   ),
      // ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(labelText: 'City'),
                      controller: _cityController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'State'),
                      controller: _stateController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 170,
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.grey,
                        ),
                      ),
                      child: _previewImageUrl == null
                          ? Center(
                              child: Text('No Location Choose'),
                            )
                          : Image.network(
                              _previewImageUrl,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                    ),
                    // FlatButton(
                    //   onPressed: _trial,
                    //   child: Text('Click Me !'),
                    // ),
                  ],
                ),
              ),
            ),
          ),
          RaisedButton.icon(
            icon: Icon(Icons.add),
            label: Text('Add Place'),
            onPressed: _selectCity,
            elevation: 0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            color: Theme.of(context).accentColor,
          ),
        ],
      ),
    );
  }
}
