import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  // Create instances for Firestore and Firebase Storage
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> incrementDownloadCounter() async {
    try {
      DocumentReference docRef =
          firestore.collection('counters').doc('downloads');
      await firestore.runTransaction((transaction) async {
        DocumentSnapshot snapshot = await transaction.get(docRef);
        if (!snapshot.exists) {
          transaction.set(docRef, {'count': 1});
        } else {
          int newCount = snapshot['count'] + 1;
          transaction.update(docRef, {'count': newCount});
        }
      });
    } catch (e) {
      print('Error incrementing download counter: $e');
    }
  }

  Future<void> _launchURL() async {
    const url =
        'https://github.com/TheKunal65/Unsung-Memer/releases/download/v1.0.0/UNSUNG.MEMER_v1.0.0.apk';
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error launching URL: $e');
    }
  }

  Future<void> _launchGitHubRepo() async {
    const url = 'https://github.com/TheKunal65/Unsung-Memer';
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error launching GitHub URL: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Transform.scale(
              scale: 1.1,
              child:
                  Lottie.asset('assets/HomeGradient.json', fit: BoxFit.cover),
            ),
          ),
          Center(
            child: ScreenTypeLayout(
              mobile: buildContent(context, DeviceScreenType.mobile),
              tablet: buildContent(context, DeviceScreenType.tablet),
              desktop: buildContent(context, DeviceScreenType.desktop),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildContent(BuildContext context, DeviceScreenType deviceType) {
    double titleFontSize = 40;
    double bodyFontSize = 16;
    double buttonWidth = 150;
    double buttonHeight = 50;
    double descriptionMaxWidth = double.infinity;
    double screenshotHeight = 200;

    if (deviceType == DeviceScreenType.mobile) {
      titleFontSize = 32;
      bodyFontSize = 14;
      screenshotHeight = 300;
    } else if (deviceType == DeviceScreenType.tablet) {
      descriptionMaxWidth = 600;
      screenshotHeight = 450;
    } else if (deviceType == DeviceScreenType.desktop) {
      descriptionMaxWidth = 800;
      screenshotHeight = 500;
    }

    return Center(
      child: Container(
        decoration: BoxDecoration(color: Color.fromARGB(131, 255, 255, 255)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  height: 200,
                  'assets/Design.png',
                ),
              ),
              const SizedBox(height: 3),
              Text(
                "UNSUNG MEMER",
                style: TextStyle(
                  fontSize: titleFontSize,
                  fontFamily: 'Lexend',
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 255, 185, 7),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Your Meme Hub",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Lexend',
                  color: Color.fromARGB(255, 255, 115, 0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: descriptionMaxWidth,
                  ),
                  child: Text(
                    "Welcome to Unsung Memer! 🎉 Your one-stop destination for the freshest, funniest memes straight from Reddit! Dive in and get your daily dose of laughter with just a click. Download now and let the memes begin! 😄📲",
                    style: TextStyle(
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w800,
                      fontSize: bodyFontSize,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset('assets/loading.json', height: 94),
                  Column(
                    children: [
                      Container(
                        width: buttonWidth,
                        height: buttonHeight,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: [
                            Color.fromRGBO(18, 194, 233, 10),
                            Color.fromRGBO(196, 113, 237, 10),
                            Color.fromRGBO(246, 79, 89, 10),
                          ]),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.black, width: 1.5),
                        ),
                        child: ElevatedButton(
                          onPressed: () async {
                            await incrementDownloadCounter();
                            await _launchURL();
                          },
                          child: SizedBox(
                            height: buttonHeight,
                            width: buttonWidth,
                            child: const Center(
                              child: Text(
                                "Download",
                                style: TextStyle(
                                  color: Colors.amber,
                                  fontSize: 17,
                                  fontFamily: "Lexend",
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            padding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: _launchGitHubRepo,
                        child: SvgPicture.asset(
                          'assets/cat.svg',
                          height: 40,
                        ),
                      ),
                    ],
                  ),
                  Transform.flip(
                    flipX: true,
                    child: Lottie.asset('assets/loading.json', height: 94),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Screenshots 👇",
                    style: TextStyle(fontFamily: 'Lexend', fontSize: 25),
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      _buildScreenshot(
                          context,
                          'https://firebasestorage.googleapis.com/v0/b/unsung-memer-ed337.appspot.com/o/Screenshots%2FSS1.jpg?alt=media&token=9c08b85f-4107-40aa-b767-8d8377288c0b',
                          screenshotHeight,
                          0),
                      const SizedBox(width: 10),
                      _buildScreenshot(
                          context,
                          'https://firebasestorage.googleapis.com/v0/b/unsung-memer-ed337.appspot.com/o/Screenshots%2FSS2.jpg?alt=media&token=4641d66d-a6e7-4d54-9a29-47d09b5a72f5',
                          screenshotHeight,
                          1),
                      const SizedBox(width: 10),
                      _buildScreenshot(
                          context,
                          'https://firebasestorage.googleapis.com/v0/b/unsung-memer-ed337.appspot.com/o/Screenshots%2FSS3.jpg?alt=media&token=a79fbd2b-ac3e-4342-a460-9042833e24ab',
                          screenshotHeight,
                          2),
                      const SizedBox(width: 10),
                      _buildScreenshot(
                          context,
                          'https://firebasestorage.googleapis.com/v0/b/unsung-memer-ed337.appspot.com/o/Screenshots%2FSS4.jpg?alt=media&token=3b0fe42e-7638-4208-8aa6-579b372a76eb',
                          screenshotHeight,
                          3),
                      const SizedBox(width: 10),
                      _buildScreenshot(
                          context,
                          'https://firebasestorage.googleapis.com/v0/b/unsung-memer-ed337.appspot.com/o/Screenshots%2FSS5.jpg?alt=media&token=6476bacb-97cd-4b51-b8b2-9c2ab2aa0a01',
                          screenshotHeight,
                          4),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //  Lottie.asset('assets/heart.json', height: 50),
                  Text(
                    'Thanks for Visiting',
                    style: TextStyle(
                      fontFamily: 'Lexend',
                      fontSize: bodyFontSize + 4,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Lottie.asset('assets/heart.json', height: 50),
                ],
              ),
              Text(
                "App created by:",
                style: TextStyle(
                  fontFamily: "Lexend",
                  fontSize: bodyFontSize - 2,
                  color: Colors.black,
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    const WidgetSpan(
                      child: Icon(
                        Icons.link,
                        size: 20,
                      ),
                    ),
                    TextSpan(
                      text: "Kunal",
                      style: TextStyle(
                        fontFamily: 'Lexend',
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: bodyFontSize + 4,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          launchUrlString(
                              'https://www.linkedin.com/in/kunal-prajapat-487079263/');
                        },
                    ),
                    // WidgetSpan(
                    //   child: Lottie.asset('assets/Kunal.json', height: 40),
                    // ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScreenshot(
      BuildContext context, String imagePath, double height, int initialPage) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            PageController pageController =
                PageController(initialPage: initialPage);
            return Dialog(
              backgroundColor: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Stack(
                  children: [
                    PageView(
                      controller: pageController,
                      children: [
                        _buildImageWithBorder(
                            'https://firebasestorage.googleapis.com/v0/b/unsung-memer-ed337.appspot.com/o/Screenshots%2FSS1.jpg?alt=media&token=9c08b85f-4107-40aa-b767-8d8377288c0b'),
                        _buildImageWithBorder(
                            'https://firebasestorage.googleapis.com/v0/b/unsung-memer-ed337.appspot.com/o/Screenshots%2FSS2.jpg?alt=media&token=4641d66d-a6e7-4d54-9a29-47d09b5a72f5'),
                        _buildImageWithBorder(
                            'https://firebasestorage.googleapis.com/v0/b/unsung-memer-ed337.appspot.com/o/Screenshots%2FSS3.jpg?alt=media&token=a79fbd2b-ac3e-4342-a460-9042833e24ab'),
                        _buildImageWithBorder(
                            'https://firebasestorage.googleapis.com/v0/b/unsung-memer-ed337.appspot.com/o/Screenshots%2FSS4.jpg?alt=media&token=3b0fe42e-7638-4208-8aa6-579b372a76eb'),
                        _buildImageWithBorder(
                            'https://firebasestorage.googleapis.com/v0/b/unsung-memer-ed337.appspot.com/o/Screenshots%2FSS5.jpg?alt=media&token=6476bacb-97cd-4b51-b8b2-9c2ab2aa0a01'),
                      ],
                    ),
                    _buildNavigationArrows(
                        context, pageController, initialPage),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 3),
          borderRadius: BorderRadius.circular(11),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: CachedNetworkImage(
            imageUrl: imagePath,
            height: height,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationArrows(
      BuildContext context, PageController pageController, int initialPage) {
    return Positioned.fill(
      child: Stack(
        children: [
          if (initialPage != 0)
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  color: Colors.white.withOpacity(0.7),
                  onPressed: () {
                    pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease);
                  },
                ),
              ),
            ),
          if (initialPage != 4)
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios),
                  color: Colors.white.withOpacity(0.7),
                  onPressed: () {
                    pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease);
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildImageWithBorder(String imagePath) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: CachedNetworkImage(
        imageUrl: imagePath,
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}
