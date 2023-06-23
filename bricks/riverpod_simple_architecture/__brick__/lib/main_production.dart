import 'package:{{project_name.snakeCase()}}/app/app.dart';
import 'package:{{project_name.snakeCase()}}/bootstrap.dart';

void main() {
  ///You can override your environment variable in bootstrap method here for providers
  bootstrap(() => const App());
}
