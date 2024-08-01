import 'package:flutter/material.dart';

class Transaction {
  final String namaTransaksi;
  final String nominal;
  final bool isIncome;

  Transaction({
    required this.namaTransaksi,
    required this.nominal,
    required this.isIncome,
  });
}

List<Transaction> transactions = [
  Transaction(
    namaTransaksi: 'Ibadah Minggu Pagi',
    nominal: '600.000',
    isIncome: true,
  ),
  Transaction(
    namaTransaksi: 'Sdri. Christin',
    nominal: '5.000.000',
    isIncome: true,
  ),
  Transaction(
    namaTransaksi: 'HUT Adik Santoso Palar',
    nominal: '250.000',
    isIncome: true,
  ),
  Transaction(
    namaTransaksi: 'Pemberian Bingkisan bagi Lansia',
    nominal: '65.000',
    isIncome: false,
  ),
];

class KeuanganPage extends StatelessWidget {
  const KeuanganPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Laporan Keuangan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Total Saldo Kas Gereja',
                        style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 8),
                    Text(
                      'Rp 5.885.000,00',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total Pemasukan'),
                        Text('Rp 12.335.000,00'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total Pengeluaran'),
                        Text('Rp 6.450.000,00'),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Saldo s/d 4 Juli 2023:'),
                        Text('Rp 5.885.000,00'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text('Transaksi Terkini Kas Gereja',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: Icon(
                        transactions[index].isIncome
                            ? Icons.arrow_upward
                            : Icons.arrow_downward,
                        color: transactions[index].isIncome
                            ? Colors.green
                            : Colors.red,
                      ),
                      title: Text(
                        transactions[index].namaTransaksi,
                        style: const TextStyle(fontSize: 16),
                      ),
                      subtitle: Text('2023-06-25'), // Adjust date accordingly
                      trailing: Text(
                        'Rp ${transactions[index].nominal.toString()}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
