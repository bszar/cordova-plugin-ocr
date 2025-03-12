|[Introduction](#cordova-plugin-ocr) | [Supported_Platforms](#supported-platforms) | [Installation_Steps](#installation-steps) |:---:|:---:|:---:|
|:---:|:------:|:---:|:---:|:---:|:---:|
|||||||


# cordova-plugin-ocr

> This plugin was made possible because of Google's [ML Kit](https://firebase.google.com/docs/ml-kit/) SDK, as it is a dependency of this plugin. The supported languages are listed [here](https://developers.google.com/vision/android/text-overview). This plugin is absolutely free and will work offline once install is complete. All required files required for Text Recognition are downloaded during install if necessary space is available.

This plugin defines a global `ocrtext` object, which provides an method that accepts image uri or base64 inputs. If some text was detected in the image, this text will be returned in an object. The imageuri or base64 can be send to the plugin using any another plugin like [cordova-plugin-camera](https://github.com/apache/cordova-plugin-camera) or [cordova-plugin-document-scanner](https://github.com/NeutrinosPlatform/cordova-plugin-document-scanner). Although the object is attached to the global scoped `window`, it is not available until after the `deviceready` event.

```
document.addEventListener("deviceready", onDeviceReady, false);
function onDeviceReady() {
console.log(ocrtext);
}
```

# Supported Platforms

- Android
- iOS

# Installation Steps

This requires cordova 12.0.0+ , cordova android 6.4.0+ and cordova ios 4.3.0+

`cordova plugin add cordova-plugin-ocr`

> Note : This might take a while!

**Optional installation variable for Android**
*MLKIT_TEXT_RECOGNITION_VERSION*
Version of `com.google.android.gms:play-services-mlkit-text-recognition`. This defaults to `16.1.0` but by using this variable you can specify a different version if you like:

`cordova plugin add cordova-plugin-ocr --variable MLKIT_TEXT_RECOGNITION_VERSION=16.1.0`

Also add the following plugin :- 

- `cordova plugin add cordova-plugin-camera`


**Firebase Setup :-**
This version of the plugin only uses the on-device functionality and no longer requires Firebase.

# Plugin Usage

`ocrtext.getText(onSuccess, onFail, imgdata);`
- **ocrtext.getText**
The **`ocrtext.getText`** function accepts image data as uri or base64 and uses google mobile vision to recognize text and return the recognized text as string on its successcallback.
- **imgdata**
  BASE64 encoded image .

- **successCallback**
The return value is sent to the **`successCallback`** callback function, in string format if no errors occured. 


- **errorCallback**
The **`errorCallback`** function returns `Scan Failed: Found no text to scan` if no text was detected on the image. It also return other messages based on the error conditions.

>*Note :- After install the OCR App using this plugin does not need an internet connection for Optical Character Recognition since all the required data is downloaded locally on install.*

