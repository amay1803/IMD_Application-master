import 'package:flutter/material.dart';
import '../values/MyColors.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        //color: MyColors.main_bg_color,
        child: ListView(
          children: <Widget>[
            Container(
                color: MyColors.main_bg_color,
                child: Column(
                  children: <Widget>[
                    DrawerHeader(
                        
                        child: Image.asset('assets/images/imd_logo.png')
                        
                        ),
                    Text('Indian Meteorological department',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: MyColors.main_black,
                            fontFamily: 'OpenSans Light',
                            fontSize: 25.0)),
                  ],
                )),
            SizedBox(height: 0.0),
            DrawerItem(
                title: 'Mumbai',
                route: '/location',
                args: {'location': 'Mumbai'}),
            DrawerItem(title: 'Warnings', route: '/warnings'),
            DrawerItem(title: 'Stations', route: '/stations_data'),
          ],
        ),
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final String title;
  final String route;
  final Map args;
  const DrawerItem(
      {Key key, @required this.title, @required this.route, this.args})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: MyColors.main_bg_color,
      child: ListTile(
        title: Text(title,
            style: TextStyle(
                color: MyColors.main_black,
                fontFamily: 'OpenSans',
                fontSize: 20.0)),
        trailing: Icon(Icons.arrow_forward, color: Color(0xfee6579e0)),
        onTap: () {
          Navigator.pop(context);
          Navigator.pushNamed(context, route, arguments: args);
        },
      ),
    );
  }
}
