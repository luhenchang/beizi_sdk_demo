plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.beizi_sdk_demo"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.beizi_sdk_demo"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }
    signingConfigs {

        getByName("debug") {
            storeFile = file("C:\\Users\\12769\\Desktop\\key")
            storePassword = "123456"
            keyAlias = "key"
            keyPassword = "123456"
        }
    }
    buildTypes {
        release {
            // 启用代码压缩和混淆
            isMinifyEnabled = true  // 注意：Kotlin 中用 is 前缀（布尔属性的规范）

            // 启用资源收缩（仅在 minifyEnabled 为 true 时有效）
            isShrinkResources = true  // 同样使用 is 前缀

            // 指定混淆规则文件
            // getDefaultProguardFile 是函数，需要用括号调用
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
    repositories {
        flatDir {
            dirs("libs") // 指向app/libs目录
        }
    }
    dependencies {
        implementation(files("libs/beizi_fusion_sdk_5.2.2.2.aar"))
    }
}

flutter {
    source = "../.."
}
