import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:ronda/viewModel/auth/loginvm.dart';
import 'package:ronda/viewModel/auth/post_view_model.dart';
import 'package:ronda/viewModel/auth/registervm.dart';
import 'package:ronda/viewModel/conversation/conversation_view_model.dart';
import 'package:ronda/viewModel/profile/edit_profile_view_model.dart';
import 'package:ronda/viewModel/status/statusView.dart';
import 'package:ronda/viewModel/theme/theme_view_model.dart';
import 'package:ronda/viewModel/user/user_view_model.dart';
import 'package:ronda/components/manuController.dart';
//import 'package:ronda/utils/constants.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (_) => RegisterViewModel()),
  ChangeNotifierProvider(create: (_) => LoginViewModel()),
  ChangeNotifierProvider(create: (_) => PostsViewModel()),
  ChangeNotifierProvider(create: (_) => EditProfileViewModel()),
  ChangeNotifierProvider(create: (_) => ConversationViewModel()),
  ChangeNotifierProvider(create: (_) => StatusViewModel()),
  ChangeNotifierProvider(create: (_) => UserViewModel()),
  ChangeNotifierProvider(create: (_) => ThemeProvider()),
  ChangeNotifierProvider(create: (_) => MenuAppController())
];
