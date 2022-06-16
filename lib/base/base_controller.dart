import 'package:get/get.dart';

import '../data/interceptors/listen_error_graphql_interceptor.dart';
import '../shared/dialog_manager/data_models/request/common_dialog_request.dart';
import '../shared/dialog_manager/services/dialog_service.dart';
import '../shared/methods/call_methods.dart';
import '../shared/network/constants/constants.dart';
import '../shared/network/controllers/network_controller.dart';
import '../shared/network/managers/network_manager.dart';
import '../shared/services/firebase_cloud_messaging.dart';

class BaseController extends GetxController
    with NetworkManager, ListenErrorGraphQL {
  final _hasNetwork = true;

  final _networkController = Get.find<NetworkController>();

  // FirebaseMessageConfig firebaseMessageConfig = FirebaseMessageConfig();
  final CallMethods callMethods = CallMethods();

  @override
  Future<void> onInit() async {
    super.onInit();

    // check network
    await checkConnectNetwork();

    // await firebaseMessageConfig.handleMessage(); 
  }

  @override
  Future<void> onReady() async {
    super.onReady();
  }

  Future<void> checkConnectNetwork() async {
    // if (_networkController.connectionStatus.value == 0) {
    //   _hasNetwork = false;
    //   await callDialogErrorNetwork();
    // }
    // _networkController.connectionStatus.listen((status) {
    //   if (status == 0) {
    //     _hasNetwork = false;
    //     callDialogErrorNetwork();
    //   } else {
    //     _hasNetwork = true;
    //   }
    // });
  }

  Future<void> callDialogErrorNetwork() async {
    final dialogRequest = CommonDialogRequest(
      title: 'Network error',
      description: 'Network error',
      defineEvent: NO_CONNECT_NETWORK,
    );
    await doShowDialog(dialogRequest);
  }

  Future<void> doShowDialog(CommonDialogRequest dialogRequest) async {
    final locator = Get.find<DialogService>();
    final dialogResult = await locator.showDialog(dialogRequest);

    if (dialogResult.confirmed) {
      print('User press confirm');
      await _handleEventDialog(dialogRequest.defineEvent);
    } else {
      print('User press cancel!');
    }
  }

  Future<void> _handleEventDialog(String? defineEvent) async {
    switch (defineEvent) {
      case NO_CONNECT_NETWORK:
        if (_hasNetwork == false) {
          await callDialogErrorNetwork();
        }
        break;
      default:
        break;
    }
  }

  CommonDialogRequest handleErrorResponse(Object e) {
    return handleErrorGraphQLResponse(e);
  }
}
