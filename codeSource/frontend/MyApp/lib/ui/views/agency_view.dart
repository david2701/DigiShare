import 'package:MyApp/core/enum/viewstate.dart';
import 'package:flutter/cupertino.dart';
import '../shared/CustomAppBar.dart';
import '../../core/models/employee.dart';
import 'package:provider/provider.dart';
import 'base_view.dart';
import '../../core/viewmodels/agency_model.dart';
import 'package:flutter/material.dart';
import '../shared/agency_header.dart';
import '../shared/divider_with_title.dart';
import '../widgets/agency_widgets/agency_info.dart';
import '../widgets/agency_widgets/subsidiaries_map_container.dart';
import '../widgets/agency_widgets/employees_section.dart';
import 'package:MyApp/ui/shared/SideMenuWidget.dart';
import 'package:MyApp/ui/shared/floatingButton.dart';

class AgencyView extends StatelessWidget {
  final String id;

  AgencyView({@required this.id});

  @override
  Widget build(BuildContext context) {
    // if no parameter passed to this view , by default we display the logged in user's agency
    //else we consider agency's id parameter
    var agencyId = id == null ? Provider.of<Employee>(context).agency.id : id;
    // in the rest of this view we will use agencyId variable instead of id
    return BaseView<AgencyModel>(
      onModelReady: (model) => model.getAgencyInfo(agencyId),
      builder: (context, model, child) => Scaffold(
        appBar: CustomAppBar(height: 60,),
        floatingActionButton: FloatingButton(),
        //App background
        backgroundColor: Colors.blueGrey[50],
        body: model.state == ViewState.Busy
            ? Center(child: CircularProgressIndicator())
            : ListView(
                children: <Widget>[
                  //********************************************************************
                  //Header Section
                  AgencyHeader(agency: model.agency),

                  //********************************************************************
                  //Body Section

                  //Agency Info Container
                  AgencyInfo(agency: model.agency),

                  //Map Label
                  DividerWithTitle(title: "Trouvez Nous"),

                  // Map Container
                  // loading subsidiaries data and constructing the map
                  MapContainerWidget(agency: model.agency),

                  //Employees Section Label
                  DividerWithTitle(title: "Nos Collaborateurs"),

                  // Employees Container
                  // loading and then displaying employees data
                  EmployeesSection(agencyId: agencyId),

                  //Copyright Section
                  Padding(
                    padding:
                        EdgeInsets.only(right: 10, left: 10, top: 8, bottom: 8),
                    child: Center(child: Text("Copyright  © 2020")),
                  ),
                ],
              ),
      ),
    );
  }
}
