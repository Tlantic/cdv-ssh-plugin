/* global module, require */
'use strict';

var exec = require('cordova/exec');

// secure copy definition
function SSH(){
    this.pluginRef = 'SSH';                              // *** Plugin reference for Cordova.exec calls
}

// connect method
SSH.prototype.connect = function (host, port, username, successCallback, errorCallback) {
                   exec(successCallback, errorCallback, this.pluginRef, 'connect', [host, port, username]);
};
               
// disconnect method
SSH.prototype.disconnect = function (connectionId, successCallback, errorCallback) {
	exec(successCallback, errorCallback, this.pluginRef, 'disconnect', [connectionId]);
};
               
// disconnect all method
SSH.prototype.disconnectAll = function (successCallback, errorCallback) {
	exec(successCallback, errorCallback, this.pluginRef, 'disconnectAll', []);
};
               
// authorize using keyboard interactive
SSH.prototype.authenticateByKeyboard = function (connectionId, password, successCallback, errorCallback) {
	exec(successCallback, errorCallback, this.pluginRef, 'authenticateByKeyboard', [connectionId, password]);
};

//perform secure copy
SSH.prototype.copyToRemote = function (connectionId, file, path, successCallback, errorCallback) {
	exec(successCallback, errorCallback, this.pluginRef, 'scp', [connectionId, file, path]);
};

module.exports = new SSH();