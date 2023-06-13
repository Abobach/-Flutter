package com.example.diplom_flutter

import io.flutter.embedding.android.FlutterActivity
import androidx.annotation.NonNull

import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import com.yandex.mapkit.MapKitFactory


class MainActivity: FlutterActivity() {
      override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
    MapKitFactory.setApiKey("c2d1b3cc-e8d9-4e55-97b5-beefddd56c9b") // Your generated API key
    super.configureFlutterEngine(flutterEngine)
  }
}
