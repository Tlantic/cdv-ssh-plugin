cdv-ssh-plugin
=================

Cordova SSH Plugin


Follows the [Cordova Plugin spec](https://github.com/apache/cordova-plugman/blob/master/plugin_spec.md), so that it works with [Plugman](https://github.com/apache/cordova-plugman)

## Cordova/Phonegap Support ##

This plugin was tested and qualified using Cordova 3.4. The demo app contains implementation for Android and iOS. You can check that out at [demo app repository](https://github.com/Tlantic/SshPluginDemo)

## Adding the plugin ##

To add the plugin, just run the following command through cordova CLI:

```
cordova plugin add com.tlantic.plugins.ssh
```

## Using the plugin ##

The plugin creates a "SSH" object exposed on window.tlantic.plugins.ssh. The following methods can be accessed:

* connect: opens a socket connection;
* disconnect: closes a socket connection;
* disconnectAll: closes ALL opened connections;
* authenticateByKeyboard: authenticate on SSH channel using keyboard-interactive method;
* copyToRemote: performs a SCP file copy to remote host;

### connect (host, port, username, successCallback, errorCallback)

This method returns a connection ID, to be used on future operations.

Example:

```
window.tlantic.plugins.ssh.connect(
  '192.168.2.5',       // target host
  22,                  // SSH port (22 is the default)
  'myuser',
  function () {
    console.log('worked!');  
  },
  
  function () {
    console.log('failed!');
  }
);
```

### disconnect (connectionId, successCallback, errorCallback)

Disconnects any connection opened for a given connection id.

Example:

```
window.tlantic.plugins.ssh.disconnect(
  myConnectioId,
  function () {
    console.log('worked!');  
  },
  
  function () {
    console.log('failed!');
  }
);
```

### disconnectAll (successCallback, errorCallback)

Example:

```
window.tlantic.plugins.ssh.connect(
  function () {
    console.log('worked!');  
  },
  
  function () {
    console.log('failed!');
  }
);
```

### authenticateByKeyboard (connectionId, password, successCallback, errorCallback)

Authenticates on SSH channel to be authorized on future operations, like SCP, SFTP, etc...
This passsword must to match with the username used to open the SSH channel on Connect method call.

Example:

```
window.tlantic.plugins.ssh.authenticateByKeyboard (
  myConnectionId,
  'password123',
  function () {
    console.log('worked!');  
  },
  
  function () {
    console.log('failed!');
  }
);
```

### copyToRemote (connectionId, filename, remotePath, successCallback, errorCallback) 

Performs a file copy to a remote host as SCP command. The VERY IMPORTANT part is to be aware
this plugin is compliant with cordova file specifications. In other words: cordova file plugin obfuscate
the file absolute path, using a proprietary url, like cdvfile://localhost/persistent/myfile.txt.

You must be aware the file path changes based on file type (PERSISTENT OR TEMPORARY). The current plugin implementation
ONLY WORKS WITH TEMPORARY files. You just have to inform the file name for that.

```
window.tlantic.plugins.ssh.copyToRemote(
  connectionId,
  'MyFile.txt', 
  '/var/myremotefolder/', 
  
  function () {
    console.log('worked!');  
  },
  
  function () {
    console.log('failed!');
  }    
);
```

If you want to copy the file changing the file name, you can append the destination file name on remote path.


## License terms

    Cordova SSH Plugin
    Copyright (C) 2014  Tlantic SI

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>
