import 'package:flutter/material.dart';
import 'package:sarathi/keys.dart';
import 'package:sarathi/models/establishment.dart';
import 'package:sarathi/pages/customers/show.dart';
import 'package:sarathi/router.dart';
import 'package:sarathi/services/establishment_service.dart';
import 'package:sarathi/theme.dart';
import 'package:sarathi/widgets/search.dart';

class Customers extends StatefulWidget {
  Customers({Key key}) : super(key: key);

  @override
  _CustomersState createState() => _CustomersState();
}

class _CustomersState extends State<Customers> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(SarathiTheme.kPadding16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Search(),
            FutureBuilder<List<Establishment>>(
              future: fetchEstablishments(),
              builder: (context, snapshot) {
                if (snapshot.hasError) print(snapshot.error);

                return snapshot.hasData
                    ? Expanded(
                        child: _createList(snapshot.data),
                      )
                    : Padding(padding: EdgeInsets.symmetric(vertical: 20), child: CircularProgressIndicator());
              },
            )
          ],
        ));
  }

  Widget _createList(List<Establishment> establishments) {
    if (establishments.length == 0) {
      return Container(padding: EdgeInsets.only(top: 10), child: Text('No Data Found!'));
    }
    return ListView.builder(
      itemCount: establishments.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Keys.navigatorKey.currentState.pushNamed(Router.showCustomerRoute, arguments: CustomerArguments(establishmentId: establishments[index].id));
          },
          child: ListTile(
              leading: CircleAvatar(child: Text((index + 1).toString()),), title: Text(establishments[index].name), subtitle: Text(establishments[index].mobile), trailing: Text('Rs 1')),
        );
      },
    );
  }
}

Future<List<Establishment>> fetchEstablishments() async {
  EstablishmentService _establishmentService = EstablishmentService();
  List<Establishment> response = await _establishmentService.index();
  return response;
}
