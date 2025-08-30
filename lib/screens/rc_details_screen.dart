import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RCDetailsScreen extends StatefulWidget {
  @override
  _RCDetailsScreenState createState() => _RCDetailsScreenState();
}

class _RCDetailsScreenState extends State<RCDetailsScreen> {
  final _formKey = GlobalKey<FormState>();

  String ownerName = '';
  String vehicleNumber = '';
  String vehicleModel = '';
  String registrationNumber = '';
  String contactNumber = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('RC Details')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Owner Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Owner name cannot be empty';
                    }
                    return null;
                  },
                  onSaved: (value) => ownerName = value!,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Vehicle Number'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vehicle number cannot be empty';
                    }
                    return null;
                  },
                  onSaved: (value) => vehicleNumber = value!,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Vehicle Model'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vehicle model cannot be empty';
                    }
                    return null;
                  },
                  onSaved: (value) => vehicleModel = value!,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Registration Number'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Registration number cannot be empty';
                    }
                    return null;
                  },
                  onSaved: (value) => registrationNumber = value!,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Contact Number'),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Contact number cannot be empty';
                    } else if (value.length < 10) {
                      return 'Enter a valid 10-digit number';
                    }
                    return null;
                  },
                  onSaved: (value) => contactNumber = value!,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // TODO: Send RC details to backend API
                      Fluttertoast.showToast(
                          msg: "RC Details Saved Successfully",
                          toastLength: Toast.LENGTH_SHORT);
                      print(
                          'Owner: $ownerName, Vehicle: $vehicleNumber, Model: $vehicleModel, RegNo: $registrationNumber, Contact: $contactNumber');
                    }
                  },
                  child: Text('Save RC Details'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
