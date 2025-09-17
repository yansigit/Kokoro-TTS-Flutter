import 'package:flutter_test/flutter_test.dart';
import 'package:kokoro_tts_flutter/kokoro_tts_flutter.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('Kokoro should handle int8 model configuration without crashing', () async {
    // Test that creating a Kokoro instance with int8 config doesn't crash
    const config = KokoroConfig(
      modelPath: 'assets/kokoro-v1.0.int8.onnx',
      voicesPath: 'assets/voices.json',
      isInt8: true,
    );
    
    final kokoro = Kokoro(config);
    
    expect(kokoro.config.modelPath, equals('assets/kokoro-v1.0.int8.onnx'));
    expect(kokoro.config.isInt8, isTrue);
    
    // Note: We don't call initialize() here because it would require actual assets
    // This test just verifies the configuration and instantiation works
  });

  test('Kokoro should handle regular model configuration', () async {
    // Test that creating a Kokoro instance with regular model config works
    const config = KokoroConfig(
      modelPath: 'assets/kokoro-v1.0.onnx',
      voicesPath: 'assets/voices.json',
      isInt8: false,
    );
    
    final kokoro = Kokoro(config);
    
    expect(kokoro.config.modelPath, equals('assets/kokoro-v1.0.onnx'));
    expect(kokoro.config.isInt8, isFalse);
  });
}