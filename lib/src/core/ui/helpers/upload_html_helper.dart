import 'dart:html';

import 'package:flutter/foundation.dart';

typedef UploadCallBack = void Function(Uint8List file, String fileName);

class UploadHtmlHelper {
  void startUpload(UploadCallBack callBack) {
    final uploadInput = FileUploadInputElement();
    uploadInput.click();
    uploadInput.onChange.listen((_) {
      handleFileupload(uploadInput, callBack);
    });
  }

  void handleFileupload(
    FileUploadInputElement uploadInput,
    UploadCallBack callBack,
  ) {
    final files = uploadInput.files;
    if (files != null && files.isNotEmpty) {
      final file = files.first;
      final reader = FileReader();
      reader.readAsArrayBuffer(file);
      reader.onLoadEnd.listen((_) {
        final bytes = Uint8List.fromList(reader.result as List<int>);
        callBack(bytes, file.name);
      });
    }
  }
}
