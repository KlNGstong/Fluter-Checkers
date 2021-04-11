import 'package:checkers/components/square.dart';
import 'package:checkers/enums/assets.dart';
import 'package:checkers/enums/game-type.dart';
import 'package:checkers/enums/routes.dart';
import 'package:checkers/providers/gameProvider.dart';
import 'package:checkers/utils/screen-manage.dart';
import 'package:checkers/utils/styles.dart';
import 'package:checkers/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:provider/provider.dart';
part 'main-root-page.g.dart';

@swidget
Widget logo() => Text(
  'Checkers',
  style: TextStyle(
    fontFamily: Assets.LOGO_FONT,
    fontSize: 32,
    fontWeight: FontWeight.bold
  ),
);

class MainRootPage extends StatefulWidget {
  @override
  _MainRootPageState createState() => _MainRootPageState();
}

class _MainRootPageState extends State<MainRootPage> {
  @override
  Widget build(BuildContext context) {
    print(Square(7, 6).isWhite);
    ScreenManage.init(context);
    return Scaffold(
      body: Consumer<GameProvider>(
        builder: (context, provider, child,) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Button(
                child: Text(
                  'Set single mode',
                  style: Styles.buttonText
                ),
                onTap: () => provider.setType(
                  GameType.single
                ),
              ),
              Button(
                child: Text(
                  'Set friend mode',
                  style: Styles.buttonText
                ),
                onTap: () => provider.setType(
                    GameType.friend
                ),
              ),

              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(ScreenManage.width * .15, 0, ScreenManage.width * .15, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text( 
                            'Current: ',
                            style: Styles.buttonText.copyWith(color: Colors.black)
                        ),
                        AnimatedSwitcher(
                          duration: Duration(
                              milliseconds: 200
                          ),
                          child:  Text(
                            provider.settings.type,
                            key: GlobalKey(),
                            style: Styles.buttonText.copyWith(color: Colors.lightGreen),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Button(
                    color: Colors.green,
                    child: Text(
                         'Start',
                        style: Styles.buttonText
                    ),
                    onTap: () {
                      provider.init();
                      Navigator.of(context).pushNamed(
                        Routes.GAME_PAGE
                      ); 
                    } 
                  ),
                ],
              ),
            ],
          );
        }
      ),
    );
  }
}

