
var exec = require('cordova/exec');

var TextRecognitionPlugin = {
    getText: function (successCallback, errorCallback, imagePath) {
        exec(successCallback, errorCallback, "TextRecognitionPlugin", "recognizeText", [imagePath]);
    }
};

module.exports = TextRecognitionPlugin;