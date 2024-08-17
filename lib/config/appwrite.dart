import 'package:appwrite/appwrite.dart';

class Appwrite {
  static const projectId = '66b0e7d800227d6c9abc';
  static const endpoint = 'https://cloud.appwrite.io/v1';
  static const databaseId = '66b1b1f90019414e1d67';
  static const collectionUsers = '66b1b28b00200c672b4a';
  static const collectionWorkers = '66b1b2a60012cbf20fa1';
  static const collectionBooking = '66b1b2b800260125bf65';
  static const bucketWorker = '66b1eaf40003c9252a20';

  static Client client = Client();
  static late Account account;
  static late Databases databases;
  static init() {
    client.setEndpoint(endpoint).setProject(projectId).setSelfSigned(
        status: true); // For self signed certificates, only use for development

    account = Account(client);
    databases = Databases(client);
  }

  static String imageURL(String fileId) {
    return '$endpoint/storage/buckets/$bucketWorker/files/$fileId/view?project=$projectId';
  }
}
