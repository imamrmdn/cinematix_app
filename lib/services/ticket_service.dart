part of 'services.dart';

class TicketServices {
  static CollectionReference ticketCollection =
      Firestore.instance.collection('tickets');

  static Future<void> saveTicket(String id, Ticket ticket) async {
    await ticketCollection.document().setData({
      'movieID': ticket.movieDetail.id ?? '',
      'userID': id ?? '',
      'namaBioskop': ticket.bioskop.nama ?? 0,
      'time': ticket.time.microsecondsSinceEpoch ??
          DateTime.now().microsecondsSinceEpoch,
      'bookingCode': ticket.bookingCode,
      'seats': ticket.seatsInString,
      'name': ticket.name,
      'totalPrice': ticket.totalPrice,
    });
  }

  //
  static Future<List<Ticket>> getTicket(String userId) async {
    QuerySnapshot snapshot = await ticketCollection.getDocuments();
    var documents = snapshot.documents
        .where((document) => document.data['userID'] == userId);

    List<Ticket> tickets = [];
    for (var document in documents) {
      MovieDetail movieDetail =
          await MovieService.getDetails(document.data['movieID']);

      tickets.add(Ticket(
        movieDetail,
        Bioskop(document.data['namaBioskop']),
        DateTime.fromMicrosecondsSinceEpoch(document.data['time']),
        document.data['bookingCode'],
        document.data['seats'].toString().split(','),
        document.data['name'],
        document.data['totalPrice'],
      ));
    }

    return tickets;
  }
}
