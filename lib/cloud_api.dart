import 'dart:typed_data';

import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:gcloud/storage.dart';
import 'package:mime/mime.dart';

class CloudApi {
  final auth.ServiceAccountCredentials _credentials;
  auth.AutoRefreshingAuthClient? _client; // Make _client nullable

  CloudApi(String json)
      : _credentials = auth.ServiceAccountCredentials.fromJson(json);

  Future<ObjectInfo> save(String name, Uint8List imgBytes) async {
    print("inside save");
    // Initialize _client if it hasn't been initialized yet
    if (_client == null) {
      _client = await auth.clientViaServiceAccount(_credentials, Storage.SCOPES);
    }

    // Instantiate objects to cloud storage
    var storage = Storage(_client!, 'Image Upload Google Storage'); // Use _client!
    var bucket = storage.bucket('tareeq_app_bucket');

    // Save to bucket
    final timestamp = DateTime.now().microsecondsSinceEpoch;
    final type = lookupMimeType(name);
    var objectInfo = await bucket.writeBytes(name, imgBytes,
      metadata: ObjectMetadata(
        contentType: type,
        custom: {
          'timestamp': '$timestamp',
        }
      )
    );
    print("Object saved with URI: ${objectInfo.downloadLink}");
    return objectInfo;
  }
}
