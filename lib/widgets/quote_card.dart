import 'package:flutter/material.dart';
import '../models/quote.dart';
import '../providers/app_provider.dart';
import 'package:provider/provider.dart';
class QuoteCard extends StatelessWidget {
  final Quote quote;
  final bool isFavorite;
  final VoidCallback onToggleFavorite;

  const QuoteCard({
    super.key,
    required this.quote,
    required this.isFavorite,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    final myprovider = Provider.of<AppProvider>(context);

    return Card(

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 18,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '"${quote.text}"',
              style: const TextStyle(fontSize: 22, fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              "- ${quote.author}",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: myprovider.isDarkMode? Colors.brown : Colors.indigo,
              ),
            ),
            const SizedBox(height: 10),
            IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.grey,
              ),
              onPressed: onToggleFavorite,
            ),
          ],
        ),
      ),
    );
  }
}
