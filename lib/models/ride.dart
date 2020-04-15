import 'package:cloud_firestore/cloud_firestore.dart';

class Ride {
  final String id;
  final String driver;
  final List<String> passengers;
  final DateTime time;
  final int seats;
  final String startLocation;
  final String endLocation;
  final String description;
  final String rating;
  final DocumentReference reference;

  int getAvailableSeats() => (seats - passengers.length);

  String formatStartCity() => startLocation.split('_')[0] + ', ' + startLocation.split('_')[1];
  String formatEndCity() => endLocation.split('_')[0] + ', ' + endLocation.split('_')[1];

  Ride.fromMap(Map<String, dynamic> map, {this.reference, this.id})
      : assert(map['driver'] != null),
        assert(map['passengers'] != null),
        assert(map['time'] != null),
        assert(map['seats'] != null),
        assert(map['start_location'] != null),
        assert(map['end_location'] != null),
        assert(map['description'] != null),
        rating = map['rating'],
        driver = map['driver'],
        passengers = List<String>.from(map['passengers']),
        time = (map['time'] as Timestamp).toDate(),
        seats = map['seats'],
        startLocation = map['start_location'],
        endLocation = map['end_location'],
        description = map['description'];

  Ride.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data,
            reference: snapshot.reference, id: snapshot.reference.documentID);
}
