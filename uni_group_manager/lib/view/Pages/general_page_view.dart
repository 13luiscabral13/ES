import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:uni/controller/interface_controller.dart';
import 'package:uni/controller/invites_controller.dart';
import 'dart:io';

import 'package:uni/controller/load_info.dart';
import 'package:uni/controller/local_storage/app_shared_preferences.dart';
import 'package:uni/controller/users_controller.dart';
import 'package:uni/model/app_state.dart';
import 'package:uni/model/profile_page_model.dart';
import 'package:uni/view/Pages/invites_page.dart';
import 'package:uni/view/Widgets/navigation_drawer.dart';
import 'package:uni/utils/constants.dart' as Constants;

/// Manages the  section inside the user's personal area.
abstract class GeneralPageViewState extends State<StatefulWidget> {
  final double borderMargin = 18.0;
  static FileImage decorageImage;

  @override
  Widget build(BuildContext context) {
    return this.getScaffold(context, getBody(context));
  }

  Widget getBody(BuildContext context) {
    return Container();
  }

  /// Returns the current user image.
  /// 
  /// If the image is not found / doesn't exist returns a generic placeholder.
  DecorationImage getDecorageImage(File x) {
    final fallbackImage = decorageImage == null
        ? AssetImage('assets/images/profile_placeholder.png')
        : decorageImage;

    final image = (x == null) ? fallbackImage : FileImage(x);
    final result = DecorationImage(fit: BoxFit.cover, image: image);
    if (x != null) {
      decorageImage = image;
    }
    return result;
  }

  Future<DecorationImage> buildDecorageImage(context) async {
    final storedFile =
        await loadProfilePic(StoreProvider.of<AppState>(context));
    return getDecorageImage(storedFile);
  }

  Widget refreshState(BuildContext context, Widget child) {
    return StoreConnector<AppState, VoidCallback>(
      converter: (store) {
        return () => handleRefresh(store);
      },
      builder: (context, refresh) {
        return RefreshIndicator(
            key: GlobalKey<RefreshIndicatorState>(),
            child: child,
            onRefresh: refresh,
            color: Theme.of(context).accentColor);
      },
    );
  }

  Widget getScaffold(BuildContext context, Widget body) {
    return Scaffold(
      appBar: buildAppBar(context),
      drawer: NavigationDrawer(parentContext: context),
      body: this.refreshState(context, body),
    );
  }

  /// Builds the upper bar of the app.
  /// 
  /// This method returns an instance of `AppBar` containing the app's logo,
  /// an option button and a button with the user's picture.
  AppBar buildAppBar(BuildContext context) {
    final MediaQueryData queryData = MediaQuery.of(context);

    return AppBar(
      bottom: PreferredSize(
        preferredSize: Size.zero,
        child: Container(
          margin: EdgeInsets.only(left: borderMargin, right: borderMargin),
          color: Theme.of(context).dividerColor,
          height: 1.5,
        ),
      ),
      elevation: 0,
      iconTheme: IconThemeData(color: Theme.of(context).accentColor),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      titleSpacing: 0.0,
      title: ButtonTheme(
          minWidth: 0,
          padding: EdgeInsets.only(left: 0),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: RoundedRectangleBorder(),
          child: TextButton(
            onPressed: () async {

              final currentRouteName = ModalRoute.of(context).settings.name;
              if (currentRouteName != Constants.navPersonalArea) {
                Navigator.pushNamed(context, '/${Constants.navPersonalArea}');
              }
            },
            child: SvgPicture.asset(
              'assets/images/logo_dark.svg',
              height: queryData.size.height / 25,
            ),
          )),
      actions: <Widget>[
        getNotificationsButton(context),
        getTopRightButton(context),
      ],
    );
  }

  Widget getNotificationsButton(BuildContext context){
    return IconButton(
        padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
        onPressed: () async {
          await UsersController.init();
          final String up = await AppSharedPreferences.getUserNumber();
          final InterfaceController interface = InterfaceController('users');
          final int id = await interface.getValue(up, 'users', 'id');

          await InvitesController.init(up, 'notificationsList');
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => InvitesPage(up: up, id: id,))
          );
        },
        icon: const Icon(Icons.notifications, size: 40),
        key: Key('NotificationsButton'),
    );
  }
  // Gets a round shaped button with the photo of the current user.
  Widget getTopRightButton(BuildContext context) {
    return FutureBuilder(
        future: buildDecorageImage(context),
        builder: (BuildContext context,
            AsyncSnapshot<DecorationImage> decorationImage) {
          return TextButton(
            onPressed: () => {
              Navigator.push(
                  context, MaterialPageRoute(builder: (__) => ProfilePage()))
            },
            child: Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, image: decorationImage.data)),
            key: Key('ProfilePageButton'),
          );
        });
  }
}
