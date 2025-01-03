import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class EmailService {
  static Future<void> sendDeleteAccountRequest(String email, String reason) async {
    final smtpServer = gmail('khanhk66uet@gmail.com', 'eqgq llqp htsl yxgz');

    final message = Message()
      ..from = Address('khanhk66uet@gmail.com', 'Ứng dụng Hà Nội Vibe')
      ..recipients.add('baokhanhntby@gmail.com')
      ..subject = 'Delete Account Request'
      
      ..text = 'A user with email $email has requested to delete their account.\n\nReason: $reason';


    try {
      await send(message, smtpServer);
      print('Delete account request email sent successfully.');
    } catch (e) {
      print('Error sending delete account request email: $e');
    }
  }
}