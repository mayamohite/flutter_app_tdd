import 'package:flutter/material.dart';
import 'package:flutter_app_tdd/data/models/ticket_detail_models/ticket.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class TicketView extends StatefulWidget {
  final Ticket ticket;

  TicketView({Key key, @required this.ticket}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TicketViewState();
  }
}

class _TicketViewState extends State<TicketView> {
  bool _enabled = true;

  @override
  Widget build(BuildContext context) {
    var url = widget.ticket.airline.logo;
    return Container(
      child: Padding(
        padding: EdgeInsets.only(left: 16, right: 16, top: 5),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Image.network(
                          url,
                          fit: BoxFit.fill,
                          height: 20,
                          width: 20,
                        ),
                        Padding(padding: EdgeInsets.only(right: 5.0)),
                        Text(widget.ticket.airline.name),
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(top: 10)),
                    Text(
                      "${widget.ticket.departure} Dep",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      Icons.arrow_forward,
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text(
                      "${widget.ticket.numberOfStops} stops",
                      style: TextStyle(color: Colors.red),
                    ),
                    Padding(padding: EdgeInsets.only(top: 10)),
                    Text(
                      "${widget.ticket.arrival} Dest",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    )
                  ],
                ),
                Container(
                    child: (widget.ticket.price == null &&
                            widget.ticket.isPriceError == false
                        ? SpinKitWave(
                            color: Colors.cyan[100],
                            size: 20.0,
                          )
                        : (widget.ticket.price != null)
                            ? priceUI(widget.ticket)
                            : Text("Price: null")))
              ],
            ),
          ),
        ),
      ),
    );
  }

  priceUI(Ticket ticket) {
    return Column(
      children: <Widget>[
        Text(
          "${widget.ticket.price.seats} Seats",
          style: TextStyle(color: Colors.black),
        ),
        Padding(padding: EdgeInsets.only(top: 10)),
        Text(
          "${widget.ticket.price.currency} ${widget.ticket.price.price}",
          style: TextStyle(color: Colors.black, fontSize: 16),
        )
      ],
    );
  }
}
