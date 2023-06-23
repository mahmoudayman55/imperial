import 'package:url_launcher/url_launcher.dart';

class CustomUrlLauncher {
  static void launchEmailApp(String email) async {
    final Uri uri = Uri(
      scheme: 'mailto',
      path: email,
    );


    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch email app';
    }
  }

  static void launchCallApp(String phoneNumber) async {
    final Uri uri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunch(uri.toString())) {
      await launch(uri.toString());
    } else {
      throw 'Could not launch call app';
    }
  }

  static void launchWebUrl(String url) async {
    Uri uri=Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri,mode: LaunchMode.externalApplication,);
    } else {
      throw 'Could not launch URL';
    }
  }
}