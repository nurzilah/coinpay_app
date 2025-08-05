import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:coinpay_app/constants/color.dart';

class Support2Screen extends StatefulWidget {
  const Support2Screen({super.key});

  @override
  State<Support2Screen> createState() => _Support2ScreenState();
}

class _Support2ScreenState extends State<Support2Screen> {
  final TextEditingController messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  
  final List<Map<String, dynamic>> messages = [
    {
      'fromBot': true,
      'text': 'Welcome to CoinPay support!\nHow can we assist you today?',
      'timestamp': 'Sunday at 4:20 PM'
    },
    {
      'fromBot': true,
      'text': 'What is your question regarding?',
      'timestamp': 'Sunday at 4:20 PM'
    },
    {
      'fromBot': true,
      'text': 'Are you having a problem with a specific feature?\n\nHave you tried troubleshooting steps we provided in FAQ or other documentation?',
      'timestamp': 'Sunday at 4:20 PM'
    },
    {
      'fromBot': true,
      'text': 'I\'m here to help you resolve any issues quickly. Please describe your problem in detail so I can provide the best assistance.',
      'timestamp': 'Sunday at 4:21 PM'
    },
  ];

  void sendMessage() {
    final text = messageController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      messages.add({
        'fromBot': false, 
        'text': text,
        'timestamp': 'Sent'
      });
    });

    messageController.clear();
    
    // Auto scroll to bottom
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColors.contentPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Support', style: TextStyle(fontFamily: 'Poppins', color: AppColors.contentPrimary)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Chat header with bot info
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                // Bot avatar
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: SvgPicture.asset(
                    'assets/icons/chat-bot.svg',
                    width: 24,
                    height: 24,
                    // Fallback jika SVG tidak ditemukan
                    placeholderBuilder: (context) => const Icon(
                      Icons.support_agent,
                      size: 24,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'CoinPay Helper Bot',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.contentPrimary,
                        ),
                      ),
                      Text(
                        'We typically reply instantly',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          color: AppColors.contentTertiary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.border),
          
          // Chat messages
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                final isBot = msg['fromBot'] as bool;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Column(
                    crossAxisAlignment: isBot ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: isBot ? MainAxisAlignment.start : MainAxisAlignment.end,
                        children: [
                          if (isBot) ...[
                            // Bot avatar
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: SvgPicture.asset(
                                'assets/icons/chat-bot.svg',
                                width: 20,
                                height: 20,
                                // Fallback jika SVG tidak ditemukan
                                placeholderBuilder: (context) => const Icon(
                                  Icons.support_agent,
                                  size: 20,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                          ],
                          // Message bubble
                          Flexible(
                            child: Container(
                              constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width * 0.75,
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              decoration: BoxDecoration(
                                color: isBot ? const Color(0xFFF5F5F5) : AppColors.primary,
                                borderRadius: BorderRadius.only(
                                  topLeft: const Radius.circular(20),
                                  topRight: const Radius.circular(20),
                                  bottomLeft: isBot ? const Radius.circular(4) : const Radius.circular(20),
                                  bottomRight: isBot ? const Radius.circular(20) : const Radius.circular(4),
                                ),
                              ),
                              child: Text(
                                msg['text'] as String,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  color: isBot ? AppColors.contentPrimary : Colors.white,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ),
                          if (!isBot) ...[
                            const SizedBox(width: 8),
                            // User avatar
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.asset(
                                'assets/images/pp_linkedin.jpg',
                                width: 32,
                                height: 32,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: const Icon(
                                      Icons.person,
                                      size: 18,
                                      color: Colors.white,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ],
                      ),
                      // Timestamp
                      Padding(
                        padding: EdgeInsets.only(
                          top: 4,
                          left: isBot ? 40 : 0,
                          right: isBot ? 0 : 40,
                        ),
                        child: Text(
                          msg['timestamp'] as String,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 11,
                            color: AppColors.contentTertiary,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Chat input area
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: AppColors.border, width: 1),
              ),
            ),
            child: SafeArea(
              child: Row(
                children: [
                  // Attachment button
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: IconButton(
                      onPressed: () {
                        // Handle attachment
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Attachment feature coming soon')),
                        );
                      },
                      icon: const Icon(
                        Icons.attach_file,
                        color: AppColors.contentTertiary,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Text input
                  Expanded(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextField(
                        controller: messageController,
                        decoration: const InputDecoration(
                          hintText: 'Type a message',
                          hintStyle: TextStyle(
                            fontFamily: 'Poppins',
                            color: AppColors.contentTertiary,
                            fontSize: 14,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        ),
                        onSubmitted: (_) => sendMessage(),
                        textInputAction: TextInputAction.send,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Send button
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: sendMessage,
                      icon: const Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}