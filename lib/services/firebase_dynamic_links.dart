import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:share_plus/share_plus.dart';

///[DynamicLinkParameters]
class DynamicLinkService {
  // static final DynamicLinkService _singleton = DynamicLinkService._internal();
  // DynamicLinkService._internal();
  // static DynamicLinkService get instance => _singleton;

  // create a new link
  Future<String> createDynamicLinkForProject(String? projectID) async {
    final dynamicLinkParams = DynamicLinkParameters(
      link:
          Uri.parse("https://videoreview.page.link.com/?projectID=$projectID"),
      uriPrefix: "https://videoreview.page.link",
      androidParameters:
          const AndroidParameters(packageName: "com.example.Video_Reviews"),
      iosParameters: const IOSParameters(bundleId: "com.example.videodemo"),
    );
    final dynamicLink =
        await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);
    return dynamicLink.shortUrl.toString();
  }

  Future<void> initDynamicLink(Uri? link) async {
    final PendingDynamicLinkData? initialLink = await FirebaseDynamicLinks
        .instance
        .getDynamicLink(Uri.parse(link.toString()));

    FirebaseDynamicLinks.instance.onLink.listen(
      (PendingDynamicLinkData? dynamicLink) async {
        if (initialLink != null) {
          //  print("the initial link is : $initialLink");
          final Uri reflink = initialLink.link;
          final queryParameters = reflink.queryParameters;
          if (queryParameters.isNotEmpty) {
            String? projectIDExt = queryParameters['projectID'];
            //     print("Extracted project Id is:$projectIDExt");
          } else {
            //   print("initial link is nulll");
          }
        }
      },
      onError: (e) async {
        //  print('Error handling dynamic link: $e');
      },
    );
  }
}
