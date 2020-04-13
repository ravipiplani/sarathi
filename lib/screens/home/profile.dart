import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            leading: Container(),
            snap: true,
            stretch: true,
            expandedHeight: 200,
            floating: true,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.symmetric(vertical: 9),
              collapseMode: CollapseMode.parallax,
              centerTitle: true,
              background: Opacity(
                opacity: 0.3,
                child: Image(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/img/icon.png"),
                )
              ),
              title: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("Ravi Piplani", style: Theme.of(context).textTheme.headline6.copyWith(color: Theme.of(context).accentColor)),
                  Text("7042401008", style: Theme.of(context).textTheme.caption.copyWith(color: Theme.of(context).primaryColorLight))
                ],
              )
            )
          )
        ];
      },
      body: Container(
        padding: EdgeInsets.only(top: 0),
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return ListTile(title: Text('Test'), subtitle: Text('Test desc'), trailing: Text('Rs 1'));
          },
        )
      )
    );
  }
}