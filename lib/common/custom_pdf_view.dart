import 'package:book_heaven/models/book_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class CustomPdfViewer extends StatefulWidget {
  const CustomPdfViewer({
    Key? key,
    this.unlockedPageLimit = 10,
    this.isPurchased = false,
    this.lastPage,
    required this.book,
  }) : super(key: key);

  final BookModel book;
  final int unlockedPageLimit;
  final bool isPurchased;
  final int? lastPage;

  @override
  State<CustomPdfViewer> createState() => _CustomPdfViewerState();
}

class _CustomPdfViewerState extends State<CustomPdfViewer> {
  final PdfViewerController _pdfViewerController = PdfViewerController();
  bool isPageLocked = false;
  bool isLoading = true; // To track loading state

  @override
  void initState() {
    super.initState();
    _setSecureFlag();
    if (widget.isPurchased && widget.lastPage != null) {
      _pdfViewerController.jumpToPage(widget.lastPage!);
    }
  }

  Future<void> _setSecureFlag() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book.title, overflow: TextOverflow.ellipsis),
      ),
      body: Stack(
        children: [
          // PDF Viewer
          SfPdfViewer.network(
            widget.book.pdfUrl!,
            controller: _pdfViewerController,
            onPageChanged: (PdfPageChangedDetails details) {
              _handlePageChange(details.newPageNumber);
            },
            onDocumentLoaded: (PdfDocumentLoadedDetails details) {
              setState(() {
                isLoading = false; // Hide loading indicator when PDF is loaded
              });
            },
          ),
          // Loading Indicator
          if (isLoading)
            Center(child: CircularProgressIndicator()),

          // Overlay for locked pages
          if (isPageLocked)
            _buildLockedOverlay(),
        ],
      ),
    );
  }

  void _handlePageChange(int newPageNumber) {
    if (!widget.isPurchased && newPageNumber > widget.unlockedPageLimit) {
      setState(() {
        isPageLocked = true;
      });
      _pdfViewerController.jumpToPage(widget.unlockedPageLimit);
    } else {
      setState(() {
        isPageLocked = false;
      });
    }
  }

  Widget _buildLockedOverlay() {
    return Container(
      color: Colors.black54,
      child: Center(
        child: AlertDialog(
          title: const Text('Buy to Unlock'),
          content: const Text('You need to purchase the book to view this page.'),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  isPageLocked = false; // Dismiss the lock overlay
                });
              },
              child: const Text('OK'),
            ),
          ],
        ),
      ),
    );
  }
}
