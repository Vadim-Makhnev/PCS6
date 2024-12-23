import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isEditing = false;
  String firstName = 'Имя';
  String lastName = 'Фамилия';
  String email = 'example@mail.com';
  String phone = '+123456789';

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize the controllers with the current values
    firstNameController.text = firstName;
    lastNameController.text = lastName;
    emailController.text = email;
    phoneController.text = phone;
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: const Text(
            'Game Store',
            style: TextStyle(fontSize: 30),
          ),
        ),
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
            icon: Icon(isEditing ? Icons.save : Icons.edit),
            onPressed: () {
              setState(() {
                isEditing = !isEditing; // Toggle edit mode
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Avatar
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/ponch.png'),
            ),
            const SizedBox(height: 16),

            // Name
            _buildTextField('', firstNameController),
            const SizedBox(height: 10),

            // Surname
            _buildTextField('', lastNameController),
            const SizedBox(height: 10),

            // Email
            _buildTextField('', emailController),
            const SizedBox(height: 10),

            // Phone
            _buildTextField('', phoneController),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0), // Add margin between fields
      child: TextField(
        controller: controller,
        enabled: isEditing, // Allow editing only if isEditing is true
        style: TextStyle(color: Colors.black), // Set text color to black
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.black), // Set label text color
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20), // Make the corners rounded
          ),
          filled: true,
          fillColor: isEditing ? Colors.white : Colors.grey[300], // Grey out when not in edit mode
        ),
      ),
    );
  }

}
