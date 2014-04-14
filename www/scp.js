/* global module, require */
'use strict';

var exec = require('cordova/exec');

// secure copy definition
function SCP(){
    this.pluginRef = 'SecureCopy';                              // *** Plugin reference for Cordova.exec calls
}

// copy method
SCP.prototype.copy = function (username, password, sourceFile, remoteFile, successCallback, errorCallback) {
    exec(successCallback, errorCallback, this.pluginRef, 'copyToRemote', [username, password, sourceFile, remoteFile]);
};

module.exports = new SCP();