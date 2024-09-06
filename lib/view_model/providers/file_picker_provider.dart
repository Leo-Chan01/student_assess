import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdf_text/flutter_pdf_text.dart';
import 'package:similarity/similarity.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class FilePickerProvider extends ChangeNotifier {
  PlatformFile? _selectedAsset;
  PlatformFile? get selectedAsset => _selectedAsset;

  AssetEntity? _selectedImageAsset;
  AssetEntity? get selectedImageAsset => _selectedImageAsset;

  String _fileName = "No file selected";
  String get fileName => _fileName;

  String _feedbackText = "Submit Summary";
  String get feedbackText => _feedbackText;

  String _pdfText = '';
  String get pdfText => _pdfText;
  String _userInput = '';
  String get userInput => _userInput;
  double _similarityScore = 0.0;
  double get similarityScore => _similarityScore;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> pickImageFile(BuildContext context) async {
    List<AssetEntity>? resultList = await AssetPicker.pickAssets(
      context,
      pickerConfig: const AssetPickerConfig(
        maxAssets: 1,
        requestType: RequestType.image,
      ),
    );
    if (resultList != null && resultList.isNotEmpty) {
      _selectedImageAsset = resultList.first;
      notifyListeners();

      // _extractTextFromFile(_selectedAsset!);
    }
  }

  Future<void> pickPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      _fileName = file.name;
      notifyListeners();

      File pdfFile = File(result.files.single.path!);
      _isLoading = true;
      _feedbackText = "...Extracting Text";
      notifyListeners();
      PDFDoc pdfDoc = await PDFDoc.fromFile(pdfFile);
      String text = await pdfDoc.text;
      _pdfText = text;
      _isLoading = false;
      _feedbackText = "Submit Summary";
      notifyListeners();
    } else {
      _fileName = "No file selected.";
      notifyListeners();
    }
  }

  Future<void> updateUserInput(String userInput) async {
    _userInput = userInput;
    notifyListeners();
  }

  void calculateSimilarity() {
    _isLoading = true;
    _feedbackText = "...Extracting Text";
    notifyListeners();
    final similarity = osaStringSimilarity(_pdfText, _userInput);
    final accuracy = similarity * 100;

    _similarityScore = accuracy;
    _isLoading = false;
    _feedbackText = "Submit Summary";
    notifyListeners();
  }
}
