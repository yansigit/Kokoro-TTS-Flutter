# Kokoro TTS Flutter

Kokoro TTS Flutter is a text-to-speech (TTS) library for Flutter, powered by ONNX Runtime and the Kokoro-TTS model. It supports multi-language synthesis and advanced phonemization using the `malsami` G2P engine.

## Features
- Multi-language text-to-speech synthesis
- ONNX Runtime support for fast inference
- Advanced phonemization with `malsami`
- Example code for generating audio from text

## Installation
Add to your `pubspec.yaml`:
```yaml
dependencies:
  kokoro_tts_flutter: ^0.2.1-exp
```

## Model Files Required
**Before using the library, download the following model files and place them in your project's `assets` folder:**
- [kokoro-v1.0.onnx](https://github.com/thewh1teagle/kokoro-onnx/releases/download/model-files-v1.0/kokoro-v1.0.onnx)
- [voices-v1.0.bin](https://github.com/thewh1teagle/kokoro-onnx/releases/download/model-files-v1.0/voices-v1.0.bin)

## Using voices.json

For better compatibility with Flutter, you can convert the binary voices file to JSON format:
Use this Python script to convert the binary voices file to JSON:

```python
import numpy as np
import json

data = np.load("voices-v1.0.bin")

# Export all voices to voices.json
all_voices = {k: v.tolist() for k, v in data.items()}
with open("voices.json", "w") as f:
    json.dump(all_voices, f)

# Optionally, export just af_heart
if "af_heart" in data:
    af_heart = data["af_heart"].tolist()
    with open("af_heart.json", "w") as f:
        json.dump(af_heart, f)
```

This allows you to use JSON files instead of binary files in your Flutter app, making it easier to work with the voice data.

## Usage Example
Your folder structure should look like:
```
assets/
  kokoro-v1.0.onnx
  voice.json
  ... (other assets)
```

Update your `pubspec.yaml` to include the assets:
```yaml
flutter:
  assets:
    - assets/
```
See [`example/`](example/) for a complete example. Basic usage:

```dart
import 'package:kokoro_tts_flutter/kokoro_tts_flutter.dart';

void main() async {
  const config = KokoroConfig(
    modelPath: 'assets/kokoro-v1.0.onnx',
    voicesPath: 'assets/voices.json',
  );

  final kokoro = Kokoro(config);
  await kokoro.initialize();

  final tokenizer = Tokenizer();
  await tokenizer.ensureInitialized();
  final phonemes = await tokenizer.phonemize('Hello world!', lang: 'en-us');

  final ttsResult = await kokoro.createTTS(
    text: phonemes,
    voice: 'af_heart',
    isPhonemes: true,
  );
  // ttsResult.audio contains the generated audio samples
}
```

## Using Int8 Quantized Models

This library supports `int8`-quantized ONNX models for improved performance and a smaller memory footprint. If you have an `int8` model, you can enable it by setting the `isInt8` flag in the `KokoroConfig`.

1.  **Place your `int8` model** in the `assets` folder.
2.  **Update your `KokoroConfig`** to point to the new model and set the `isInt8` flag to `true`.

```dart
import 'package:kokoro_tts_flutter/kokoro_tts_flutter.dart';

void main() async {
  // Example configuration for an int8 model
  const config = KokoroConfig(
    modelPath: 'assets/kokoro-v1.0-int8.onnx', // Path to your int8 model
    voicesPath: 'assets/voices.json',
    isInt8: true, // Enable int8 model support
  );

  final kokoro = Kokoro(config);
  await kokoro.initialize();

  // ... rest of your code
}
```

## Troubleshootings
Additional configurations may be required for certain platforms.
Check the [troubleshooting section](https://github.com/masicai/flutter_onnxruntime/blob/main/doc/troubleshooting.md) of flutter_onnxruntime library for the details.

## License
This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.
