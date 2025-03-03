import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _formKey =
      GlobalKey<FormState>(); // ใช้สำหรับการตรวจสอบความถูกต้องของฟอร์ม
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  String? _selectedCategory;
  DateTime? _selectedDate;

  final List<String> _categories = [
    'เครื่องมือวิจัย',
    'หุ่นยนต์',
    'เทคโนโลยีชีวภาพ',
    'วัสดุนาโน',
    'พลังงานทดแทน',
    'อวกาศ',
    'เทคโนโลยีสารสนเทศ',
  ];

  // ฟังก์ชันเมื่อกดปุ่มส่งข้อมูล
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // หากข้อมูลถูกต้อง
      final newInvention = {
        'name': _nameController.text,
        'category': _selectedCategory!,
        'quantity': _quantityController.text,
        'date': _selectedDate!.toLocal().toString(),
      };
      Navigator.pop(context, newInvention); // ส่งข้อมูลกลับไปที่ HomePage
    }
  }

  // ฟังก์ชันเลือกวันที่
  Future<void> _pickDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        _dateController.text = _selectedDate!
            .toLocal()
            .toString()
            .split(' ')[0]; // แสดงวันที่ในฟอร์ม
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('เพิ่มสิ่งประดิษฐ์'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ชื่อ/หัวข้อ
                TextFormField(
                  controller: _nameController,
                  decoration:
                      const InputDecoration(labelText: 'ชื่อสิ่งประดิษฐ์'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'กรุณากรอกชื่อสิ่งประดิษฐ์';
                    }
                    return null;
                  },
                ),
                // ช่องป้อนตัวเลข (จำนวน)
                TextFormField(
                  controller: _quantityController,
                  decoration: const InputDecoration(labelText: 'จำนวน'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'กรุณากรอกจำนวน';
                    }
                    if (int.tryParse(value) == null) {
                      return 'กรุณากรอกตัวเลขที่ถูกต้อง';
                    }
                    return null;
                  },
                ),
                // ตัวเลือกวันที่
                TextFormField(
                  controller: _dateController,
                  decoration: const InputDecoration(labelText: 'วันที่'),
                  readOnly: true,
                  onTap: _pickDate,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'กรุณาเลือกวันที่';
                    }
                    return null;
                  },
                ),
                // Dropdown (หมวดหมู่/ประเภท)
                DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  decoration: const InputDecoration(
                      labelText: 'หมวดหมู่สิ่งประดิษฐ์ทางวิทยาศาสตร์'),
                  items: _categories.map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'กรุณาเลือกหมวดหมู่สิ่งประดิษฐ์ทางวิทยาศาสตร์';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),
                // ปุ่มส่งข้อมูล
                ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('เพิ่มสิ่งประดิษฐ์'),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
