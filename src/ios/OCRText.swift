

import Foundation
import MLKitTextRecognition
import MLKitVision
import UIKit

@objc(TextRecognitionPlugin)
class TextRecognitionPlugin: CDVPlugin {

    @objc(recognizeText:)
    func recognizeText(command: CDVInvokedUrlCommand) {
        guard let imagePath = command.arguments[0] as? String else {
            self.sendErrorResult(command: command, message: "Invalid image path")
            return
        }

        // Remove any prefix (e.g., "data:image/png;base64,") if present
        let base64Data = imagePath.components(separatedBy: ",").last ?? imagePath
    
        // Decode the base64 string into Data
        guard let imageData = Data(base64Encoded: base64Data, options: .ignoreUnknownCharacters) else {
            self.sendErrorResult(command: command, message: "Failed to decode base64 string")
            return
        }
    

        guard let image = UIImage(data: imageData) else {
            self.sendErrorResult(command: command, message: "Failed to load image \(imagePath)")
            return
        }


        let visionImage = VisionImage(image: image)
        visionImage.orientation = image.imageOrientation

        let textRecognizer = TextRecognizer.textRecognizer()

        textRecognizer.process(visionImage) { result, error in
            if let error = error {
                self.sendErrorResult(command: command, message: error.localizedDescription)
                return
            }

            guard let result = result else {
                self.sendErrorResult(command: command, message: "No text recognized")
                return
            }

            let recognizedText = result.text
            self.sendSuccessResult(command: command, message: recognizedText)
        }
    }

    private func sendSuccessResult(command: CDVInvokedUrlCommand, message: String) {
        let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: message)
        self.commandDelegate.send(pluginResult, callbackId: command.callbackId)
    }

    private func sendErrorResult(command: CDVInvokedUrlCommand, message: String) {
        let pluginResult = CDVPluginResult(status: CDVCommandStatus_ERROR, messageAs: message)
        self.commandDelegate.send(pluginResult, callbackId: command.callbackId)
    }
}