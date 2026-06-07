plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.cariq.cariq_mobile"
    compileSdk = flutter.compileSdkVersion
    // Fijamos build-tools y NDK ya instalados (las que pide el template/plugins
    // por defecto —36.0.0 y 28.2.x— no están y su descarga falla por permisos en
    // C:\Users\HP\.android\cache). NDK 29 es >= 28.2 (compatible hacia atrás), así
    // que satisface a shared_preferences. Ver también el bloque subprojects del
    // build.gradle.kts raíz, que aplica lo mismo a los módulos de plugins.
    buildToolsVersion = "36.1.0"
    ndkVersion = "29.0.14033849"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.cariq.cariq_mobile"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}
