import 'package:flutter/material.dart';

class RcDetailsScreen extends StatefulWidget {
  const RcDetailsScreen({super.key});

  @override
  _RcDetailsScreenState createState() => _RcDetailsScreenState();
}

class _RcDetailsScreenState extends State<RcDetailsScreen> {
  final _formKey = GlobalKey<FormState>();

  final _rcController = TextEditingController();
  final _ownerController = TextEditingController();
  final _modelController = TextEditingController();
  final _chassisController = TextEditingController();
  final _engineController = TextEditingController();
  DateTime? _regDate;
  String? _vehicleType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("RC Details")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // RC Number
              TextFormField(
                controller: _rcController,
                decoration: const InputDecoration(
                  labelText: "RC Number",
                  hintText: "e.g. KA01AB1234",
                ),
                validator: (value) {
                  final pattern = RegExp(r'^[A-Z]{2}[0-9]{2}[A-Z]{2}[0-9]{4}$');
                  if (value == null || value.isEmpty) {
                    return "RC Number is required";
                  } else if (!pattern.hasMatch(value)) {
                    return "Enter valid RC (e.g. KA01AB1234)";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 15),

              // Owner Name
              TextFormField(
                controller: _ownerController,
                decoration: const InputDecoration(
                  labelText: "Owner Name",
                  hintText: "Full name",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Owner name is required";
                  } else if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                    return "Name must only contain letters";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 15),

              // Vehicle Type
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: "Vehicle Type"),
                items: ["Car", "Bike", "Truck", "Bus", "Other"]
                    .map((type) => DropdownMenuItem(
                          value: type,
                          child: Text(type),
                        ))
                    .toList(),
                onChanged: (value) => setState(() => _vehicleType = value),
                validator: (value) =>
                    value == null ? "Select vehicle type" : null,
              ),

              const SizedBox(height: 15),

              // Vehicle Model
              TextFormField(
                controller: _modelController,
                decoration: const InputDecoration(
                  labelText: "Vehicle Model",
                  hintText: "e.g. Maruti Swift",
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? "Model is required" : null,
              ),

              const SizedBox(height: 15),

              // Chassis Number
              TextFormField(
                controller: _chassisController,
                decoration: const InputDecoration(
                  labelText: "Chassis Number",
                  hintText: "17 character VIN",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Chassis number required";
                  } else if (!RegExp(r'^[A-HJ-NPR-Z0-9]{17}$')
                      .hasMatch(value)) {
                    return "Invalid chassis number";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 15),

              // Engine Number
              TextFormField(
                controller: _engineController,
                decoration: const InputDecoration(
                  labelText: "Engine Number",
                  hintText: "10–12 characters",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Engine number required";
                  } else if (value.length < 10 || value.length > 12) {
                    return "Engine number must be 10–12 characters";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 15),

              // Registration Date
              ListTile(
                title: Text(_regDate == null
                    ? "Select Registration Date"
                    : "Registration Date: ${_regDate!.toLocal().toString().split(' ')[0]}"),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1980),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) {
                    setState(() => _regDate = picked);
                  }
                },
              ),
              if (_regDate == null)
                const Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: Text(
                    "Registration date is required",
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate() && _regDate != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("RC Details Saved")),
                    );
                    Navigator.pushReplacementNamed(context, '/home');
                  }
                },
                child: const Text("Submit RC Details"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
