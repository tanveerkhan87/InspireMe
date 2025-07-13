import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:confetti/confetti.dart';
import '../data/quote_data.dart';
import '../providers/app_provider.dart';
import '../widgets/quote_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CarouselSliderController _controller = CarouselSliderController();
  final ConfettiController _confettiController =
  ConfettiController(duration: const Duration(seconds: 1));

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void _handleToggleFavorite(BuildContext context, quote) {
    final provider = Provider.of<AppProvider>(context, listen: false);
    if (!provider.isFavorite(quote)) {
      _confettiController.play();
    }
    provider.toggleFavorite(quote);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);


    final bool isDarkMode = provider.isDarkMode;
    final Color primaryColor = isDarkMode ? const Color(0xFF121212) : const Color(0xFFF5F5F5);
    final Color accentColor = isDarkMode ? Colors.white30 :Colors.tealAccent.shade400;
    final Color textColor = isDarkMode ? Colors.white.withOpacity(0.87) : Colors.black87;
    final Color subtleTextColor = isDarkMode ? Colors.white60 : Colors.black54;

    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: Text(
          'A Daily Motivation App',
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              provider.isDarkMode ? Icons.wb_sunny_outlined : Icons.nightlight_round,
              color: subtleTextColor,
            ),
            onPressed: provider.toggleTheme,
          ),
          IconButton(
            icon: Icon(Icons.favorite, color: subtleTextColor),
            onPressed: () => _showFavoritesDialog(context, provider),
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CarouselSlider.builder(
                  itemCount: quotesList.length,
                  itemBuilder: (context, index, realIdx) {
                    final quote = quotesList[index];
                    return QuoteCard(
                      quote: quote,
                      isFavorite: provider.isFavorite(quote),
                      onToggleFavorite: () => _handleToggleFavorite(context, quote),
                    );
                  },
                  carouselController: _controller,
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height * 0.5,
                    autoPlay: false,
                    enlargeCenterPage: true,
                    viewportFraction: 0.8,
                    aspectRatio: 16 / 9,
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton.icon(
                  onPressed: () {
                    _controller.nextPage(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    );
                  },
                  icon: const Icon(Icons.psychology_alt),
                  label: const Text("Inspire Me"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accentColor,
                    foregroundColor: provider.isDarkMode ? Colors.greenAccent : Colors.black,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 18),
                    textStyle: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    elevation: 8,
                  ),
                ),
              ],
            ),
          ),
          ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            particleDrag: 0.05,
            emissionFrequency: 0.02,
            numberOfParticles: 25,
            gravity: 0.1,
            shouldLoop: false,
            colors: [
              Colors.green.shade200,
              Colors.blue.shade200,
              accentColor,
              Colors.pink.shade200,
              Colors.orange.shade200,
            ],
          ),
        ],
      ),
    );
  }

  void _showFavoritesDialog(BuildContext context, AppProvider provider) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Favorite Quotes"),
        content: SizedBox(
          height: 300,
          width: double.maxFinite,
          child: provider.favorites.isEmpty
              ? const Center(child: Text("No favorites yet."))
              : ListView(
            children: provider.favorites.map((quote) {
              return ListTile(
                title: Text('"${quote.text}"'),
                subtitle: Text("- ${quote.author}"),
              );
            }).toList(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }
}