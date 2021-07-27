class BarcodeValidation {
  final String barcodeNumber;

  BarcodeValidation(this.barcodeNumber);

  bool isValidNumber() {
    if (barcodeNumber.length < 7) return false;
    if (barcodeNumber.length > 15) return false;
    return int.tryParse(barcodeNumber) != null;
  }


}