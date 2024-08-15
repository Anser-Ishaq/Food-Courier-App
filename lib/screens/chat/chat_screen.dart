import 'package:flutter/material.dart';
import 'package:food_couriers/components/back_notification_row.dart';
import 'package:food_couriers/constants/colors/app_colors.dart';
import 'package:food_couriers/constants/images/images.dart';
import 'package:food_couriers/providers/auth_provider.dart';
import 'package:food_couriers/screens/chat/widgets/attachment_button.dart';
import 'package:food_couriers/screens/chat/widgets/bot_icon.dart';
import 'package:food_couriers/screens/chat/widgets/message_box.dart';
import 'package:food_couriers/screens/chat/widgets/text_input_box.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key,
    required this.index,
    required this.onTapBack,
    required this.dismissKeyboard,
  });

  final int index;
  final void Function(int) onTapBack;
  final VoidCallback dismissKeyboard;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final _messageController = TextEditingController();
  late AuthProvider _authProvider;

  List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    super.initState();
    _authProvider = Provider.of<AuthProvider>(context, listen: false);
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      Map<String, dynamic> message = {
        'text': _messageController.text,
        'sender': _authProvider.user!.uid,
        'type': 'text',
        'sentAt': DateTime.now().toIso8601String(),
      };

      setState(() {
        messages.add(message);
        _messageController.clear();
      });
    }
  }

  void _sendBotMessage() {
    if (_messageController.text.isNotEmpty) {
      Map<String, dynamic> message = {
        'text': _messageController.text,
        'sender': '!@#,123asdjkl',
        'type': 'text',
        'sentAt': DateTime.now().toIso8601String(),
      };

      setState(() {
        messages.add(message);
        _messageController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                Images.primaryPattern,
                alignment: Alignment.topRight,
              ),
            ),
            SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  BackNotificationRow(
                    index: widget.index,
                    onTapBack: () async {
                      widget.dismissKeyboard();
                      await Future.delayed(
                        const Duration(
                          milliseconds: 90,
                        ),
                      );
                      widget.onTapBack(widget.index);
                    },
                    onTapNotification: () {},
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 32),
                    child: const Text(
                      'Chat',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        height: 32.76 / 25,
                      ),
                    ),
                  ),
                  const BotIcon(),
                  const SizedBox(
                    height: 12,
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        var message = messages[index];
                        return MessageBox(
                          message: message,
                          uid: _authProvider.user!.uid,
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        AttachmentButton(onTap: _sendBotMessage),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextInputBox(
                            textEditingController: _messageController,
                            onTap: _sendMessage,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
