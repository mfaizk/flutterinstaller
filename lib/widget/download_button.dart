import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterinstaller/helpers/provider_class.dart';
import 'package:lottie/lottie.dart';

class DownloadButton extends ConsumerWidget {
  const DownloadButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Theme.of(context).primaryColor,
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width * 0.35,
      alignment: Alignment.center,
      child: Container(
          height: MediaQuery.of(context).size.height * 0.1,
          width: MediaQuery.of(context).size.width * 0.2,
          color: Theme.of(context).primaryColor,
          child: AbsorbPointer(
            absorbing: ref.watch(progress).dStared,
            child: GestureDetector(
              onTap: () {
                ref.read(progress).flutterDownloader();
              },
              child: Stack(
                children: [
                  Positioned(
                    child: Lottie.asset(
                      'assets/button.json',
                      fit: BoxFit.fill,
                      alignment: Alignment.center,
                    ),
                    bottom: 0,
                    top: 0,
                    left: 0,
                    right: 0,
                  ),
                  Center(
                    child: Text(
                      'Download',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
