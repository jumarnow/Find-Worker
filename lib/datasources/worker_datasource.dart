import 'package:appwrite/appwrite.dart';
import 'package:dartz/dartz.dart';
import 'package:myapp/config/app_log.dart';
import 'package:myapp/config/appwrite.dart';
import 'package:myapp/models/worker_model.dart';

class WorkerDatasource {
  static Future<Either<String, List<WorkerModel>>> fetchAvailable(
      String category) async {
    try {
      final response = await Appwrite.databases.listDocuments(
        databaseId: Appwrite.databaseId,
        collectionId: Appwrite.collectionWorkers,
        queries: [
          Query.equal('category', category),
          Query.equal('status', 'Available'),
        ],
      );

      if (response.total < 1) {
        AppLog.error(body: 'Not Found', title: 'Worker - fetchAvailable');
        return const Left('Tidak ditemukan');
      }

      AppLog.success(
        body: response.toMap().toString(),
        title: 'Worker - fetchAvailable',
      );

      List<WorkerModel> workers = response.documents.map((e) {
        return WorkerModel.fromJson(e.data);
      }).toList();

      return Right(workers);
    } catch (e) {
      AppLog.success(
        body: e.toString(),
        title: 'Worker - fetchAvailable',
      );

      String defaultMessage = 'Terjadi suatu masalah';
      String message = defaultMessage;

      if (e is AppwriteException) {
        message = e.message ?? defaultMessage;
      }

      return Left(message);
    }
  }
}
