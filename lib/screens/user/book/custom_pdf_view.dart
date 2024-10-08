import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class CustomPdfViewer extends StatefulWidget {
  const CustomPdfViewer({
    super.key,
    required this.pdfUrl,
    this.unlockedPageLimit = 10,
    this.isPurchased = false,
    this.lastPage,
  });

  final String pdfUrl;
  final int unlockedPageLimit;
  final bool isPurchased;
  final int? lastPage;

  @override
  State<CustomPdfViewer> createState() => _CustomPdfViewerState();
}

class _CustomPdfViewerState extends State<CustomPdfViewer> {
  final PdfViewerController _pdfViewerController = PdfViewerController();
  // final int unlockedPageLimit = 10; // Number of pages that are unlocked
  bool isPageLocked = false; // To track if the page is locked

  @override
  void initState() {
    if (widget.isPurchased && widget.lastPage != null) {
      _pdfViewerController.jumpToPage(widget.lastPage ?? 1);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PDF Viewer"),
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       // Refresh the PDF Viewer or reset to the first page
        //       _pdfViewerController.jumpToPage(1);
        //       setState(() {});
        //     },
        //     icon: const Icon(Icons.refresh),
        //   ),
        // ],
      ),
      body: Stack(
        children: [
          SfPdfViewer.network(
            widget.pdfUrl,
            controller: _pdfViewerController,
            onPageChanged: (PdfPageChangedDetails details) {
              // Check if the user is trying to view a page beyond the allowed limit
              if (!widget.isPurchased) {
                if (details.newPageNumber > widget.unlockedPageLimit) {
                  setState(() {
                    isPageLocked = true;
                  });

                  // Jump back to the last allowed page
                  _pdfViewerController.jumpToPage(widget.unlockedPageLimit);
                } else {
                  setState(() {
                    isPageLocked = false;
                  });
                }
              }
            },
          ),
          // Overlay the lock message if the user tries to access locked pages
          if (isPageLocked)
            Container(
              color: Colors.black54, // Transparent overlay
              child: Center(
                child: AlertDialog(
                  title: const Text('Buy to unlock'),
                  content: const Text(
                      'You need to purchase book to view this page.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isPageLocked = false;
                        });
                      },
                      child: const Text('OK'),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
