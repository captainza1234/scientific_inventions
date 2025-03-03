import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, String>> inventions = []; // เก็บข้อมูลในหน่วยความจำ

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('รายการสิ่งประดิษฐ์')),
      body: ListView.builder(
        itemCount: inventions.length,
        itemBuilder: (context, index) {
          final invention = inventions[index];
          return ListTile(
            title: Text(invention['name']!),
            subtitle: Text('หมวดหมู่: ${invention['category']}'),
            trailing: Text(invention['date']!),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // ไปหน้า AddPage แล้วรับข้อมูลที่ส่งกลับมา
          final result = await Navigator.pushNamed(context, '/add');
          if (result != null && result is Map<String, String>) {
            setState(() {
              inventions.add(result); // เพิ่มข้อมูลที่ได้รับมาลงใน List
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
