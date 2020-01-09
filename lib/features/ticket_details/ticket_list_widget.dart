import 'package:flutter/material.dart';
import 'package:flutter_app_tdd/core/network/server_error.dart';
import 'package:flutter_app_tdd/features/ticket_details/ticket_row.dart';
import 'package:flutter_app_tdd/data/models/ticket_detail_models/ticket.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app_tdd/features/ticket_details/ticket_list_provider.dart';

class TicketList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TicketListState();
  }
}

class _TicketListState extends State<TicketList> {
  TicketDetailsProvider ticketListProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ticketListProvider = Provider.of<TicketDetailsProvider>(context);
    getData();
  }

  getData() async {
    await ticketListProvider.getList("DEL","TO");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Flight Tickets"),
      ),
      body: StreamBuilder(
          stream: ticketListProvider.subject.stream,
          builder: (context, AsyncSnapshot<List<Ticket>> snapshot) {
            if (snapshot.hasData) {
              return _buildUserWidget(snapshot.data);
            } else if (snapshot.hasError) {
              return _buildErrorWidget(snapshot.error as ServerError);
            } else {
              return _buildLoadingWidget();
            }
          }),
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [CircularProgressIndicator()],
    ));
  }

  Widget _buildErrorWidget(ServerError error) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("error ${error.getErrorMessage()}"),
      ],
    ));
  }

  Widget _buildUserWidget(List<Ticket> data) {
    return ListView.builder(
      itemBuilder: (BuildContext context, index) {
        Ticket ticket = data[index];
        return TicketView(ticket: ticket);
      },
      itemCount: data == null ? 0 : data.length,
    );
  }
}
