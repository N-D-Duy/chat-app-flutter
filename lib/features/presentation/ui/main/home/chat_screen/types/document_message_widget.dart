import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../../../../core/utils/functions/download.dart';
import '../../../../../../domain/models/message_model.dart';

class DocumentMessageWidget extends StatefulWidget {
  final Message messageData;
  final bool isSender;
  const DocumentMessageWidget({
    Key? key,
    required this.messageData,
    required this.isSender
  }): super(key: key);

  @override
  State<DocumentMessageWidget> createState() => _DocumentMessageWidgetState();
}

class _DocumentMessageWidgetState extends State<DocumentMessageWidget> {
  @override
  Widget build(BuildContext context) {
    String fileName = widget.messageData.content.split('=').last;
    String shortFileName = fileName.length > 15 ? "${fileName.substring(0, 15)}..." : fileName;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: const Icon(Icons.insert_drive_file), // Biểu tượng tài liệu
        title: Text(shortFileName), // Tên tài liệu
        trailing: const Icon(Icons.file_download), // Biểu tượng tải xuống
        onTap: () {
          // Xử lý khi người dùng nhấn vào tài liệu
          // Ví dụ: Mở tài liệu, tải xuống, hoặc hiển thị thông báo
          _handleDocumentTap(widget.messageData.content);

        },
      ),
    );
  }

  Future<void> _handleDocumentTap(String documentUrl) async {
    //download document
    String? path = await pickSavePath(context);
    if (path != null) {
      await downloadFile(documentUrl, path);
    }
  }

  /*Future<String?> getSavePath() async {
    try {
      // Lấy thư mục lưu trữ tạm thời trên thiết bị
      Directory? appDocDir = await getTemporaryDirectory();
      if (appDocDir != null) {
        return appDocDir.path;
      } else {
        throw Exception('Không thể truy cập thư mục lưu trữ tạm thời.');
      }
    } catch (e) {
      print('Đã xảy ra lỗi: $e');
      return null;
    }
  }*/

  Future<String?> pickSavePath(BuildContext context) async {
    try {
      // Hiển thị picker để người dùng chọn đường dẫn
      String? result = await FilePicker.platform.getDirectoryPath();
      if (result != null) {
        return '$result/${widget.messageData.content.split('=').last}';
      } else {
        throw Exception('Không có đường dẫn được chọn.');
      }
    } catch (e) {
      print('Đã xảy ra lỗi: $e');
      return null;
    }
  }
}

