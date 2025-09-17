# Changelog

## 0.1.0
- Initial release of Kokoro TTS Flutter.
- Multi-language TTS support via ONNX Runtime.
- Includes tokenizer, phonemizer, and audio synthesis utilities.
- Example and integration tests included.

## 0.1.1
- Update Malsami library version to 0.0.2

## 0.1.2
- Update Malsami library version to 0.0.3

## 0.2.0
- Add int8 model support

## 0.2.1-exp
- Fix int8 model casting error (GitHub issue #8)
- Always return float32 audio samples for proper audio processing
- Improve macOS compatibility with deployment target 14.0
- Add comprehensive test coverage for int8 functionality
- Clean up unnecessary imports and improve code quality