   /* global console, exports, require */
    'use strict';

    // performs copy itself
     var doCopy = function (usr, pwd, src, dst) {
        console.log('- Copied ', src, ' to ', dst, ' with credentials ', usr, ':',pwd);
     };

    // copy from loca to remote
    exports.copyToRemote = function (win, fail, args) {
        // validating parameters
        if (args.length !== 4) {
            fail('Missing arguments for "copyToRemote" action.');
            return;

        } else {

            // launching copy
            doCopy.apply(args);

            // ending with success
            win();
        }

    };

    require('cordova/windows8/commandProxy').add('SecureCopy', exports);