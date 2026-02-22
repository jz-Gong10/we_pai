import 'package:shared_preferences/shared_preferences.dart';
import 'package:we_pai/module/recieve_zishenxinxi.dart';
import 'dart:convert';

class UserStorage {
  static const String _userKey = 'user_info';
  static const String _tokenKey = 'access_token';

  static Future<SharedPreferences> get _prefs async {
    return await SharedPreferences.getInstance();
  }

  static Future<void> saveUser(UserInfo user) async {
    final prefs = await _prefs;
    final userJson = jsonEncode(user.toJson());
    await prefs.setString(_userKey, userJson);
  }

  static Future<UserInfo?> getUser() async {
    final prefs = await _prefs;
    String? userJson = prefs.getString(_userKey);
    if (userJson != null) {
      try {
        Map<String, dynamic> json = jsonDecode(userJson);
        return UserInfo.fromJson(json);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  // // 接收自身信息(网络请求并获取返回数据模板)
  // UserInfo? _userInfo;
  // bool _loadingProfile = false;

  // @override
  // void initState() {
  //   super.initState();
  //   _loadProfile();
  // }

  // Future<void> _loadProfile() async {
  //   setState(() {
  //     _loadingProfile = true;
  //   });
  //   try {
  //     final response = await Http().get(path: '/user/getProfile');
  //     if (response.statusCode == 200) {
  //       final Map<String, dynamic> responseData =
  //           response.data as Map<String, dynamic>;
  //       final Map<String, dynamic>? userData =
  //           responseData['data'] as Map<String, dynamic>?;
  //       if (userData != null) {
  //         setState(() {
  //           _userInfo = UserInfo.fromJson(userData);
  //           //获取个人数据
  //           name = _userInfo!.name;
  //           casId = _userInfo!.casId;
  //           avatarUrl = _userInfo!.avatarUrl ?? '';
  //         });
  //       }
  //     } else {
  //       printToast('个人数据同步失败：${response.statusCode}');
  //     }
  //   } catch (e) {
  //     debugPrint('load profile error: $e');
  //   } finally {
  //     if (mounted) {
  //       setState(() {
  //         _loadingProfile = false;
  //       });
  //     }
  //   }
  // }
}
