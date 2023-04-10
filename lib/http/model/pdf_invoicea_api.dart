import 'dart:io';

import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:rudrashop/http/model/Invoice.dart';

class PdfInvoiceApi {
  static Future<File> generate(Invoice invoice) async {
    final pdf = Document();
    pdf.addPage(MultiPage(build: (context) => [
        buildTitle(invoice),
        buildInvoice(invoice),
    ]));

    return PdfApi.saveDocument(name: "my_invoice.pdf", pdf: pdf);
  }

  static Widget buildTitle(Invoice invoice ){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("INVOICE", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        SizedBox(height: 0.8 * PdfPageFormat.cm),
        Text(invoice.info.description),
        SizedBox(height: 0.8 * PdfPageFormat.cm),
      ]
    );
  }
  static Widget buildInvoice(Invoice invoice ){

    final headers = [
      "Products Name",
      "Quantity",
      "Unit Price",
      "GST",
      "Total"
    ];


    return Table.fromTextArray(
      headers: headers,
    );
  }
}

class PdfApi {
  static Future<File> saveDocument({required String name, required Document pdf}) async {
    final bytes = await pdf.save();
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');
    await file.writeAsBytes(bytes);
    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;
    await OpenFile.open(url);
  }

}
