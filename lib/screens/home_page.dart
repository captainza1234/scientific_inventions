import 'package:flutter/material.dart';
import 'add_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, String>> inventions = []; // เก็บข้อมูลสิ่งประดิษฐ์

  void _addInvention(Map<String, String> newInvention) {
    setState(() {
      inventions.add(newInvention); // เพิ่มสิ่งประดิษฐ์ใหม่
    });
  }

  void _deleteInvention(int index) {
    setState(() {
      inventions.removeAt(index); // ลบสิ่งประดิษฐ์ที่ตำแหน่ง index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('สิ่งประดิษฐ์ทางวิทยาศาสตร์'),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {
              // เพิ่มฟังก์ชันค้นหาถ้าต้องการ
            },
          ),
        ],
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
                  key: Key(invention['name']!), // ใช้ชื่อเป็น key เพื่อการปัดที่แม่นยำ
                  direction: DismissDirection.endToStart, // กำหนดทิศทางการปัด
                  onDismissed: (direction) {
                    // เมื่อถูกปัดแล้ว ลบรายการ
                    _deleteInvention(index);
                    // แสดง snackbar เมื่อรายการถูกลบ
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${invention['name']} ถูกลบแล้ว'),
                      ),
                    );
                  },
                  background: Container(
                    color: Colors.red, // สีพื้นหลังเมื่อปัด
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  child: Card(
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    color: Colors.blue[50],
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      title: Text(
                        invention['name']!,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[700],
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 4),
                          Text(
                            'จำนวน: ${invention['quantity']}',
                            style: TextStyle(color: Colors.grey[700], fontSize: 16),
                          ),
                          Text(
                            'หมวดหมู่: ${invention['category']}',
                            style: TextStyle(color: Colors.grey[700], fontSize: 16),
                          ),
                          Text(
                            'วันที่: ${invention['date']}',
                            style: TextStyle(color: Colors.grey[700], fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // ไปหน้า AddPage แล้วรับข้อมูลที่ส่งกลับมา
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddPage()),
          );
          if (result != null) {
            _addInvention(result); // เพิ่มข้อมูลที่ได้รับจาก AddPage
          }
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }
}
