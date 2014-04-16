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

module.exports = new SSH();