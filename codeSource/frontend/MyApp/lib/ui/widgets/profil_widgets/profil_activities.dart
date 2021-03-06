import 'package:MyApp/core/models/employee.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



class ProfilActivities extends StatelessWidget {
  final Employee employee;

  ProfilActivities({@required this.employee});

  @override
  Widget build(BuildContext context) {
    Employee user = Provider.of<Employee>(context);
    return Container(
      height: 70.0,
      margin: EdgeInsets.all(8.0),
      child: user.id == employee.id ? rowForActuelUser() : rowForNotActuelUser(context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xFFFF9F9F9),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
    );
  }


Widget rowForActuelUser(){
return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('${employee.publicationsObjects?.length}'),
              Text(
                "publications",
                style: TextStyle(fontFamily: "Times"),
              ),
            ],
          ),
        ],
      );
}



Widget rowForNotActuelUser(BuildContext context){
 return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('${employee.publicationsObjects?.length}'),
              Text(
                "publications",
                style: TextStyle(fontFamily: "Times"),
              ),
            ],
          ),
          VerticalDivider(
            indent: 15,
            width: 35,
            endIndent: 15,
            color: Colors.black38,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                  icon: FaIcon(FontAwesomeIcons.envelopeOpenText,size: 20,),
                  onPressed: () async{
                     Navigator.pop(context);
                    await Navigator.pushNamed(context, '/Chat', arguments: employee);
                  },
                  color: Colors.black38,
                ),
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text("message", style: TextStyle(fontFamily: "Times")),
              ),
            ],
          ),
        ],
      );
}

}
