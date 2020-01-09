import 'package:flutter_app_tdd/core/network/api_client.dart';
import 'package:flutter_app_tdd/features/ticket_details/get_ticket_details_usecase.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:flutter_app_tdd/data/datasource/local/local_datasource.dart';
import 'package:flutter_app_tdd/data/datasource/remote/remote_datasource.dart';
import 'package:flutter_app_tdd/data/repositories/ticket_detail_repository_impl.dart';
import 'package:dio/dio.dart' hide Headers;

class ModuleContainer {
  Injector initialise(Injector injector) {
    injector.map<Dio>((i) => Dio());
    injector.map<ApiClient>((i) => ApiClient(i.get<Dio>()));
    injector.map<LocalDatasource>((i) => LocalDatasource(), isSingleton: true);
    injector.map<RemoteDatasource>(
        (i) =>
            RemoteDatasource(dio: i.get<Dio>(), apiClient: i.get<ApiClient>()),
        isSingleton: true);
    injector.map<RepositoryImpl>(
        (i) => RepositoryImpl(
            localDatasource: i.get<LocalDatasource>(),
            remoteDatasource: i.get<RemoteDatasource>()),
        isSingleton: true);
    injector.map<TicketDetailsUsecase>(
        (i) => TicketDetailsUsecase(repository: i.get<RepositoryImpl>()));
    return injector;
  }
}
