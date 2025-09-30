import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class MotschgerBoxPage extends StatefulWidget {
  const MotschgerBoxPage({Key? key}) : super(key: key);

  @override
  State<MotschgerBoxPage> createState() => _MotschgerBoxPageState();
}

class _MotschgerBoxPageState extends State<MotschgerBoxPage> {
  final TextEditingController _controller = TextEditingController();
  bool _isSending = false;

  Future<bool> _sendMail(String message) async {
    const String senderEmail = 'junbiapp@gmail.com';
    const String password = 'jgzx zctg elft cose'; // ⚠️ consider moving to secure storage
    const String receiverEmail = 'thomaspucher2@gmail.com';

    final smtpServer = gmail(senderEmail, password);

    final mailMessage = Message()
      ..from = Address(senderEmail, 'Junbi App')
      ..recipients.add(receiverEmail)
      ..subject = 'Motschger Box'
      ..text = message;

    try {
      await send(mailMessage, smtpServer);
      return true;
    } on MailerException catch (e) {
      debugPrint('Failed to send mail: $e');
      return false;
    }
  }

  void _onSendPressed() async {
    final message = _controller.text.trim();
    if (message.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bitte zuerst eine Nachricht eingeben.')),
      );
      return;
    }

    setState(() => _isSending = true);
    _controller.clear();

    final success = await _sendMail(message);

    setState(() => _isSending = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(success
            ? 'Motschger unterwegs ✈️'
            : 'Motschger konnte nicht gesendet werden 😢'),
        backgroundColor: success ? Colors.green : Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: TextField(
                  controller: _controller,
                  cursorColor: Colors.white, 
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: const InputDecoration(
                    hintText: 'Was liegt dir am Herzen?',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: _isSending ? null : _onSendPressed,
                icon: _isSending
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.send),
                label: Text(
                  _isSending ? 'Senden...' : 'Anonym Senden',
                  style: const TextStyle(fontSize: 16), 
                ),
              ),
            ),
            Align(
                        alignment: Alignment.bottomRight,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back,
                              size: 28, color: Colors.white),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
