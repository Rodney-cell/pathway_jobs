plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    // END: FlutterFire Configuration
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.pathway_jobs"
    compileSdk = 34 // Specify the SDK version you want to compile against (using your provided value)

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.example.pathway_jobs" // This must match your configuration
        minSdk = 21 // Minimum SDK version
        targetSdk = 34 // Target SDK version
        versionCode = 1 // Version code
        versionName = "1.0" // Version name
    }

    buildTypes {
        release {
            isMinifyEnabled = false // Disable minification for release
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
            // Add your specific signing config if necessary
            signingConfig = signingConfigs.getByName("debug") // Change as needed
        }
    }
}

// Flutter configuration
flutter {
    source = "../.." // Adjust if needed
}