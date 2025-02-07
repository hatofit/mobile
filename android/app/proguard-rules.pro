# Keep Flutter classes
-keep class io.flutter.** { *; }

# Keep Joda-Time and Joda-Convert (For your specific issue)
-keep class org.joda.convert.** { *; }
-keep class org.joda.time.** { *; }

# Keep all Parcelable classes
-keep class * implements android.os.Parcelable { *; }

# Keep annotated classes
-keepattributes *Annotation*

# Keep serialized classes
-keepclassmembers class * implements java.io.Serializable { *; }

# This is generated automatically by the Android Gradle plugin.
-dontwarn com.google.android.play.core.splitcompat.SplitCompatApplication
-dontwarn com.google.android.play.core.splitinstall.SplitInstallException
-dontwarn com.google.android.play.core.splitinstall.SplitInstallManager
-dontwarn com.google.android.play.core.splitinstall.SplitInstallManagerFactory
-dontwarn com.google.android.play.core.splitinstall.SplitInstallRequest$Builder
-dontwarn com.google.android.play.core.splitinstall.SplitInstallRequest
-dontwarn com.google.android.play.core.splitinstall.SplitInstallSessionState
-dontwarn com.google.android.play.core.splitinstall.SplitInstallStateUpdatedListener
-dontwarn com.google.android.play.core.tasks.OnFailureListener
-dontwarn com.google.android.play.core.tasks.OnSuccessListener
-dontwarn com.google.android.play.core.tasks.Task
-dontwarn org.joda.convert.FromString
-dontwarn org.joda.convert.ToString