#import <Cordova/CDV.h>

@interface TextRecognitionPlugin : CDVPlugin

- (void)recognizeText:(CDVInvokedUrlCommand*)command;

@end
