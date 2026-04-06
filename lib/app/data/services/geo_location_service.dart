import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:psicApp/app/presentation/shared/handlers/snack_bar_handler.dart';
import 'package:psicApp/app/domain/models/geo_fire_point.dart';
import 'package:psicApp/app/domain/models/geo_location_point.dart';
import 'package:psicApp/app/data/services/geo_location_place_service.dart';

class GeolocationService extends GetxController {
  final Rx<PermissionStatus> _permissionStatus = Rx<PermissionStatus>(
    PermissionStatus.denied,
  );
  Rx<Position>? _position;
  final Rx<GeoFirePoint> _geoFirePoint = Rx<GeoFirePoint>(
    GeolocationPlacePoint.floripaGeoFirePoint,
  );

  @override
  void onInit() async {
    await status();
    super.onInit();
  }

  static GeolocationService get instance => Get.find<GeolocationService>();

  bool get granted => permissionStatus == PermissionStatus.granted;

  set permissionStatus(PermissionStatus value) {
    _permissionStatus.value = value;
    _permissionStatus.refresh();
  }

  PermissionStatus get permissionStatus => _permissionStatus.value;

  Position? get position => _position?.value;

  GeoFirePoint get geoFirePoint => _geoFirePoint.value;

  GeolocationPoint get geolocationPoint =>
      GeolocationPoint(geoFirePoint.latitude, geoFirePoint.longitude);

  set geoFirePoint(GeoFirePoint value) {
    _geoFirePoint.value = value;
    _geoFirePoint.refresh();
  }

  set position(Position? value) {
    _position = Rx<Position>(value!);
    _position!.refresh();
  }

  Future<PermissionStatus> status() async {
    try {
      permissionStatus = await Permission.location.status;
      return permissionStatus;
    } catch (e) {
      return permissionStatus;
    }
  }

  Future<PermissionStatus> requestPermission({bool showMessage = false}) async {
    try {
      permissionStatus = await status();
      if (!granted) {
        permissionStatus = await Permission.location.request();
      }
      if (!granted && showMessage) {
        SnackBarHandler.snackBarError('denied_location_permission_info'.tr);
      }
      return permissionStatus;
    } catch (e) {
      return permissionStatus;
    }
  }
}
