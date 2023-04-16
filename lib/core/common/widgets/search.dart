// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:avatar_glow/avatar_glow.dart';

import 'package:ecommerce_app/features/search/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../palette.dart';

class Search extends StatefulWidget {
  final TextEditingController searchController;
  const Search({
    Key? key,
    required this.searchController,
  }) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  //for voicerecognition
  bool _isVoiceSupport = false;
  bool _isListening = false;
  String _text = "Hold the button and speak..";

  //instants
  SpeechToText _speechToText = SpeechToText();

  //check phone is voice supported or not
  void voiceSupportCheck() async {
    try {
      var available = await _speechToText.initialize();
      if (available) {
        setState(() {
          _isVoiceSupport = true;
        });
      }
    } catch (e) {
      //
    }
  }

  @override
  void initState() {
    super.initState();
    voiceSupportCheck();
  }

  void navigateToSearchScreen(BuildContext context) {
    Navigator.pushNamed(context, SearchScreen.routeName,
        arguments: widget.searchController);
  }

  @override
  Widget build(BuildContext context) {
    bool shouldIGotoSearchScreen = true;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            height: 42,
            margin: const EdgeInsets.only(left: 10),
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                TextFormField(
                  onChanged: (value) {
                    if (shouldIGotoSearchScreen) {
                      navigateToSearchScreen(context);
                    }
                  },
                  controller: widget.searchController,
                  cursorColor: blackColor,
                  onFieldSubmitted: (value) {},
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(width: 0, style: BorderStyle.none),
                    ),
                    prefixIcon: InkWell(
                      onTap: () => navigateToSearchScreen(context),
                      child: const Padding(
                        padding: EdgeInsets.only(left: 7, right: 8),
                        child: Icon(
                          Icons.search_rounded,
                          color: blackColorShade1,
                          size: 30,
                        ),
                      ),
                    ),
                    filled: true,
                    fillColor: blackColorShade2,
                    contentPadding: const EdgeInsets.only(top: 10),
                    hintText: _isListening ? _text : 'Search here...',
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                    ),
                  ),
                ),
                _isVoiceSupport
                    ? AvatarGlow(
                        glowColor: primaryColor,
                        repeat: true,
                        repeatPauseDuration: const Duration(milliseconds: 100),
                        showTwoGlows: true,
                        endRadius: 20.0,
                        animate: _isListening,
                        duration: const Duration(milliseconds: 2000),
                        child: GestureDetector(
                          onTapDown: (details) async {
                            if (!_isListening) {
                              setState(() {
                                _text = "Hold the button and speak..";
                                _isListening = true;
                              });
                              var available = await _speechToText.initialize();
                              if (available) {
                                setState(() {
                                  _speechToText.listen(
                                    onResult: (result) {
                                      setState(() {
                                        _text = result.recognizedWords;
                                        widget.searchController.text =
                                            result.recognizedWords;
                                      });
                                    },
                                  );
                                });
                              }
                            }
                          },
                          onTapUp: (details) async {
                            _speechToText.stop();

                            setState(() {
                              _isListening = false;
                            });

                            if (_text != "Hold the button and speak..") {
                              navigateToSearchScreen(context);
                            }
                          },
                          child: Icon(
                            _isListening ? Icons.mic : Icons.mic_none,
                            color: blackColor,
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {},
          radius: 10,
          child: Container(
            height: 42,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: const Icon(
              Icons.shopping_cart_outlined,
              color: primaryColor,
              size: 30,
            ),
          ),
        ),
      ],
    );
  }
}
