import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdf_text/flutter_pdf_text.dart';
import 'package:similarity/similarity.dart';
import 'package:student_assess/services/api_service.dart';
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
      _selectedAsset = file;
      notifyListeners();

      File pdfFile = File(result.files.single.path!);
      _isLoading = true;
      _feedbackText = "...Extracting Text";
      notifyListeners();
      PDFDoc pdfDoc = await PDFDoc.fromFile(pdfFile);
      String text = await pdfDoc.text;
      _pdfText = text;
      log("Text for this file is $_pdfText");
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
    log("User input is $userInput");
    notifyListeners();
  }

  void calculateSimilarity() {
    log("Calculalting in here");
    _isLoading = true;
    _feedbackText = "...Analyzing";
    notifyListeners();
    Future.delayed(const Duration(seconds: 2), () {});
    final similarity = osaStringSimilarity(_pdfText, _userInput);
    final accuracy = similarity * 100;
    log("Similarity is $similarity and accuracy is ${accuracy.roundToDouble()}");

    _similarityScore = accuracy;
    _isLoading = false;
    _feedbackText = "Submit Summary";
    notifyListeners();
  }

  void calculateSimilarityFromAPI() async {
    ApiService apiService = ApiService();
    _isLoading = true;
    _feedbackText = "Calculating similarity";
    notifyListeners();
    try {
      log("Trying request");
      Map<String, dynamic>? responsedata = await apiService
          .postData('compare', {"pdfText": _pdfText, "userInput": _userInput});
      log("Request result is $responsedata");
      notifyListeners();
      if (responsedata != null) {
        _isLoading = false;
        _feedbackText = "Submit Summary";
        _similarityScore = responsedata["similarityScore"];
        notifyListeners();
      } else {
        _isLoading = false;
        _feedbackText = "Submit Summary";
        _similarityScore = 0.00;
        notifyListeners();
      }
    } catch (e) {
      _feedbackText = "Submit Summary";
      notifyListeners();
      log("Error occured => $e");
    }
  }
}
