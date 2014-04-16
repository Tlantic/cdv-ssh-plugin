/* global module, require */
'use strict';

var exec = require('cordova/exec');

// secure copy definition
function SSH(){
    this.pluginRef = 'SSH';                              // *** Plugin reference for Cordova.exec calls
}

// copy method
SSH.prototype.scp = function (username, password, sourceFile, remoteFile, successCallback, errorCallback) {
    exec(successCallback, errorCallback, this.pluginRef, 'copyToRemote', [username, password, sourceFile, remoteFile]);
};

module.exports = new SSH();