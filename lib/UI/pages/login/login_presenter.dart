
import 'package:my_movie_browser/data/rest_data.dart';
import 'package:my_movie_browser/data/user.dart';

abstract class LoginPageContract {
  void onLoginSuccess(User user);

  void onLoginError(String error);
}

class LoginPagePresenter {
  LoginPageContract _view;
  RestData api = new RestData();

  LoginPagePresenter(this._view);

  doLogin(String username, String password) {
    api
        .login(username, password)
        .then((user) => _view.onLoginSuccess(user))
        .catchError((onError) => _view.onLoginError(onError.toString()));
  }
}
