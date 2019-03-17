import 'package:flutter/material.dart';

import './internship_profile.dart';

class MyInternshipOffer extends StatefulWidget {
  @override
  _MyInternshipOfferState createState() => _MyInternshipOfferState();
}

class _MyInternshipOfferState extends State<MyInternshipOffer> {
  @override
  Widget build(BuildContext context) {
    List<String> internships = [
      'Chef de projet',
      'Consultant',
      'Développeur',
      'Chef des ventes',
      'Community manager',
      'Chef de projet',
      'Consultant',
      'Développeur',
      'Chef des ventes',
      'Community manager',
      'Chef de projet',
      'Consultant',
      'Développeur',
      'Chef des ventes',
      'Community manager'
    ];
    return Stack(
      children: <Widget>[
        ListView.builder(
          padding: EdgeInsets.only(top: 80),
          itemCount: internships.length,
          itemBuilder: (context, index) {
            final name = internships[index];
            return Dismissible(
              key: Key(index.toString()),
              background: Container(
                color: Colors.orange,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Archiver',
                  style: Theme.of(context).textTheme.display1,
                ),
              ),
              secondaryBackground: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Supprimer',
                  style: Theme.of(context).textTheme.display1,
                ),
              ),
              child: ListTile(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 3, horizontal: 20),
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).accentColor,
                  child: Text(
                    '26',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                title: Text(name),
                subtitle: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.group,
                          size: 15,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text('Air France'),
                      ],
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.timelapse,
                          size: 15,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text('6 mois'),
                      ],
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.location_on,
                          size: 15,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text('Paris, France'),
                      ],
                    )
                  ],
                ),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => InternshipProfile(name))),
              ),
              onDismissed: (direction) {
                final remove = direction == DismissDirection.endToStart;
                final message = remove ? 'supprimé' : 'archivé';
                setState(() {
                  internships.removeAt(index);
                });
                Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text(
                  '$name $message',
                  style: TextStyle(
                      color: Colors.orange, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                )));
              },
            );
          },
        ),
        Positioned(
          top: 0,
          right: 0,
          left: 0,
          child: AppBar(
            title: Text('Mes offres de stages'),
            centerTitle: true,
          ),
        )
      ],
    );
  }
}
