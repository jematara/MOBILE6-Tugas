import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BMIScreen extends StatefulWidget {
  const BMIScreen({super.key});

  @override
  State<BMIScreen> createState() => _BMIScreenState();
}

class BmiThreshold {
    final double underweight;
    final double ideal;
    final double overweight;

    const BmiThreshold(this.underweight, this.ideal, this.overweight);
}

const Map<String, BmiThreshold> _batasBMI = {
  'Laki-laki': BmiThreshold(20.1, 25.0, 30.0),
  'Perempuan': BmiThreshold(18.7, 23.8, 30.0),
};

class _BMIScreenState extends State<BMIScreen> {
  final _bbController = TextEditingController();
  final _tbController = TextEditingController();

  String _gender = 'Laki-laki';
  String? _genderHasil;
  double? _hasilBMI;
  String _keterangan = "Masukkan data anda";

  void _hitungBMI() {
    final double bb = double.tryParse(_bbController.text) ?? 0;
    final double tbCm = double.tryParse(_tbController.text) ?? 0;

    setState(() {
      if (bb > 0 && tbCm > 0) {
        final double tbM = tbCm / 100;
        final double hasil = bb / (tbM * tbM);
        final batas = _batasBMI[_gender]!;
 
        _hasilBMI = hasil;
        _genderHasil = _gender;
 
        if (hasil < batas.underweight) {
          _keterangan = "Underweight";
        } else if (hasil < batas.ideal) {
          _keterangan = "Ideal";
        } else if (hasil < batas.overweight) {
          _keterangan = "Overweight";
        } else {
          _keterangan = "Obesity";
        }
      } else {
        _hasilBMI = null;
        _genderHasil = null;
        _keterangan = "Data tidak valid";
      }
    });
  }

  @override
  void dispose() {
    _bbController.dispose();
    _tbController.dispose();
    super.dispose();
  }

  void _resetBMI() {
    _bbController.clear();
    _tbController.clear();
    FocusScope.of(context).unfocus();

    setState(() {
      _gender = 'Laki-laki';
      _genderHasil = null;
      _hasilBMI = null;
      _keterangan = "Data tidak valid";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Kalkulator BMI',
          style: GoogleFonts.montserrat(
              color: Colors.brown,
              fontWeight: .w700,
              letterSpacing: -1,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 216, 253, 226),
        leading: Icon(Icons.calculate, color: Colors.brown,),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: .stretch,
            children: [
              SegmentedButton<String>(
                segments: const [
                  ButtonSegment(
                    value: 'Laki-laki',
                    label: Text('Laki-laki'),
                    icon: Icon(Icons.male),
                  ),
                  ButtonSegment(
                    value: 'Perempuan',
                    label: Text('Perempuan'),
                    icon: Icon(Icons.female),
                  ),
                ],
                selected: {_gender},
                onSelectionChanged: (s) => setState(() => _gender = s.first),
                style: SegmentedButton.styleFrom(
                  foregroundColor: Colors.brown,
                  selectedForegroundColor: Colors.brown,
                ),
              ),
              SizedBox(height: 30),
              TextField(
                controller: _bbController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  icon: Icon(Icons.monitor_weight, size: 25, color: Colors.brown,),
                  labelText: 'Berat Badan',
                  labelStyle: TextStyle(
                    color:  Color.fromARGB(164, 0, 0, 0),
                  ),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              SizedBox(height: 30),
              TextField(
                controller: _tbController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  icon: Icon(Icons.height, size: 25, color: Colors.brown,),
                  labelText: 'Tinggi Badan',
                  labelStyle: TextStyle(
                    color:  Color.fromARGB(164, 0, 0, 0),
                  ),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: ElevatedButton.icon(
                        onPressed: _hitungBMI,
                        icon: const Icon(Icons.calculate_outlined),
                        label: const Text(
                        'Hitung BMI',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                        style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown,
                        foregroundColor: Colors.white,
                        elevation: 4,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _resetBMI,
                        icon: const Icon(Icons.refresh),
                        label: const Text(
                        'Reset',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                        style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.brown,
                        backgroundColor: Colors.white,
                        side: const BorderSide(color: Colors.brown, width: 1.5),
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Text(
                'Hasil',
                textAlign: .center,
                style: GoogleFonts.montserrat(
                  color: Colors.brown,
                  fontSize: 20,
                  fontWeight: .w700,
                  letterSpacing: -1,
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 216, 253, 226),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    if (_genderHasil != null)
                      Text(
                        _genderHasil!,
                        style: const TextStyle(
                          color: Colors.brown,
                          fontSize: 18,
                          fontWeight: .w600,
                        ),
                      ),
                    Text(
                      _hasilBMI?.toStringAsFixed(1) ?? 'Nilai kosong',
                      style: const TextStyle(
                        color: Colors.brown,
                        fontSize: 50,
                        fontWeight: .bold,
                        letterSpacing: -1,
                      ),
                    ),
                    Text(
                      _keterangan,
                      style: const TextStyle(
                        color: Colors.brown,
                        fontSize: 30,
                        letterSpacing: -1,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}