class ApiConfig {
  static const String baseUrl = 'http://172.24.37.149:8080';//这里改成了zerotier的前置

  static const String userInfo = '/user/getProfile';
  static const String sysList = '/photographer/list';

  static const int connectTimeout = 30000;
  static const int recieveTimeout = 30000;
}
