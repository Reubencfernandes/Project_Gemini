import 'package:ayumi/services/api_key_service.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController _apiKeyController = TextEditingController();
  bool _obscureKey = true;
  bool _hasKey = false;

  @override
  void initState() {
    super.initState();
    _loadApiKey();
  }

  Future<void> _loadApiKey() async {
    final key = await ApiKeyService.getApiKey();
    setState(() {
      _hasKey = key != null && key.isNotEmpty;
      if (_hasKey) {
        _apiKeyController.text = key!;
      }
    });
  }

  Future<void> _saveApiKey() async {
    final key = _apiKeyController.text.trim();
    if (key.isEmpty) {
      _showSnackBar('Please enter an API key', Colors.red);
      return;
    }
    await ApiKeyService.saveApiKey(key);
    setState(() => _hasKey = true);
    _showSnackBar('API key saved successfully', Colors.green);
  }

  Future<void> _removeApiKey() async {
    await ApiKeyService.removeApiKey();
    _apiKeyController.clear();
    setState(() => _hasKey = false);
    _showSnackBar('API key removed', Colors.orange);
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message, style: const TextStyle(fontFamily: 'Inter')),
      backgroundColor: color,
    ));
  }

  @override
  void dispose() {
    _apiKeyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 70, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Settings",
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),
          Card(
            margin: const EdgeInsets.only(left: 5, right: 5),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.key, size: 20),
                      const SizedBox(width: 8),
                      const Text(
                        "Gemini API Key",
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      if (_hasKey)
                        const Icon(Icons.check_circle,
                            color: Colors.green, size: 20),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Get your free API key from Google AI Studio (aistudio.google.com). Required for generating tasks.",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _apiKeyController,
                    obscureText: _obscureKey,
                    cursorColor: Colors.black87,
                    decoration: InputDecoration(
                      fillColor: Colors.grey[100],
                      filled: true,
                      border: const OutlineInputBorder(),
                      labelText: "Enter your Gemini API Key",
                      labelStyle: const TextStyle(fontFamily: 'Inter'),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureKey
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () =>
                            setState(() => _obscureKey = !_obscureKey),
                      ),
                    ),
                    style: const TextStyle(fontFamily: 'Inter'),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _saveApiKey,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black87,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: Text(
                            _hasKey ? "Update Key" : "Save Key",
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      if (_hasKey) ...[
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: _removeApiKey,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 20),
                          ),
                          child: const Text(
                            "Remove",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ],
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
