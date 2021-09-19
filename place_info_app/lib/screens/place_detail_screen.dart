import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/great_places.dart';

const MAPBOX_API_KEY =
    'pk.eyJ1IjoicHJhbmF2cmFqZzIzIiwiYSI6ImNrdDM1YnBhbDBxdmsyb21tdHJidGU5a3YifQ.YaWor9L-iObK1DT-pnT_tQ';

class PlaceDetailScreen extends StatelessWidget {
  static const routeName = '/place-detail';

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final selectedPlace =
        Provider.of<GreatPlaces>(context, listen: false).findById(id);
    String _previewImageUrl =
        'https://api.mapbox.com/styles/v1/mapbox/streets-v11/static/pin-l(${selectedPlace.location.longitude},${selectedPlace.location.latitude})/${selectedPlace.location.longitude},${selectedPlace.location.latitude},14.25,0,0/600x300?access_token=$MAPBOX_API_KEY';
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlace.title),
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
              bottom: 20,
              right: 10,
              left: 10,
            ),
            height: 250,
            width: double.infinity,
            child: Image.file(
              selectedPlace.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            selectedPlace.location.address,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: Colors.blueGrey,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.only(
              top: 20,
              right: 20,
              left: 20,
            ),
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
          // Text(
          //   '(Location)',
          //   textAlign: TextAlign.center,
          //   style: TextStyle(
          //     fontSize: 12,
          //     color: Colors.blueGrey,
          //   ),
          // )
          // FlatButton(
          //   onPressed: () {},
          //   child: Text('View on map'),
          //   textColor: Theme.of(context).primaryColor,
          // ),
        ],
      ),
    );
  }
}
