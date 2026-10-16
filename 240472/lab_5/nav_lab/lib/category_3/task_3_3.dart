import 'package:flutter/material.dart';

class Contact {
  final String name;
  final String phone;
  final String email;

  const Contact({
    required this.name,
    required this.phone,
    required this.email,
  });
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<Contact> _contacts = const [
    Contact(name: 'Alice Smith', phone: '+1 555-0192', email: 'alice@example.com'),
    Contact(name: 'Bob Jones', phone: '+1 555-0143', email: 'bob@example.com'),
    Contact(name: 'Charlie Brown', phone: '+1 555-0188', email: 'charlie@example.com'),
    Contact(name: 'Diana Prince', phone: '+1 555-0177', email: 'diana@example.com'),
    Contact(name: 'Edward Elric', phone: '+1 555-0122', email: 'edward@example.com'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task 3.3: Contacts'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: _contacts.length,
        itemBuilder: (context, index) {
          final contact = _contacts[index];
          return ListTile(
            leading: CircleAvatar(child: Text(contact.name[0])),
            title: Text(contact.name),
            subtitle: Text(contact.phone),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ContactDetailScreen(contact: contact),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ContactDetailScreen extends StatelessWidget {
  final Contact contact;

  const ContactDetailScreen({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(contact.name),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 40,
                  child: Text(
                    contact.name[0],
                    style: const TextStyle(fontSize: 32),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  contact.name,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const Divider(height: 30),
                ListTile(
                  leading: const Icon(Icons.phone, color: Colors.indigo),
                  title: const Text('Phone'),
                  subtitle: Text(contact.phone),
                ),
                ListTile(
                  leading: const Icon(Icons.email, color: Colors.indigo),
                  title: const Text('Email'),
                  subtitle: Text(contact.email),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}