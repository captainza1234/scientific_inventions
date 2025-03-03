import 'package:flutter/material.dart';
import 'add_page.dart'; // นำเข้า AddPage

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, String>> inventions = []; // เก็บข้อมูลสิ่งประดิษฐ์

  // ฟังก์ชันลบสิ่งประดิษฐ์
  void _deleteInvention(int index) {
    setState(() {
      inventions.removeAt(index); // ลบสิ่งประดิษฐ์ที่ตำแหน่ง index
    });
  }

  // ฟังก์ชันเพิ่มสิ่งประดิษฐ์
  void _addInvention(Map<String, String> newInvention) {
    setState(() {
      inventions.add(newInvention); // เพิ่มสิ่งประดิษฐ์ใหม่
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('สิ่งประดิษฐ์ทางวิทยาศาสตร์'),
        backgroundColor: Colors.blueAccent,
      ),
      body: inventions.isEmpty
          ? Center(
              child: Text(
                'ยังไม่มีข้อมูลสิ่งประดิษฐ์',
                style: TextStyle(fontSize: 20, color: Colors.grey[600]),
              ),
            )
          : ListView.builder(
              itemCount: inventions.length,
              itemBuilder: (context, index) {
                final invention = inventions[index];
                return Dismissible(
                  key: Key(invention['name']!),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    _deleteInvention(index);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${invention['name']} ถูกลบแล้ว'),
                      ),
                    );
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  child: Card(
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      title: Text(
                        invention['name']!,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[700],
                        ),
                      ),
                      subtitle: Text(
                        'หมวดหมู่: ${invention['category']}',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // ไปหน้า AddPage
          final newInvention = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddPage()),
          );
          if (newInvention != null) {
            _addInvention(newInvention);
          }
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }
}
