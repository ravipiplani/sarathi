import 'package:flutter/material.dart';
import 'package:yathaarth/components/search.dart';
import 'package:yathaarth/constants/Constants.dart';
import 'package:yathaarth/keys.dart';
import 'package:yathaarth/models/establishment.dart';
import 'package:yathaarth/router.dart';
import 'package:yathaarth/screens/customers/show.dart';
import 'package:yathaarth/services/establishment_service.dart';

class Customers extends StatefulWidget {
  Customers({Key key}) : super(key: key);

  @override
  _CustomersState createState() => _CustomersState();
}

class _CustomersState extends State<Customers> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Constants.kPadding16),
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
      )
    );
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
              leading: Icon(Icons.input), title: Text(establishments[index].name), subtitle: Text(establishments[index].mobile), trailing: Text('Rs 1')),
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
