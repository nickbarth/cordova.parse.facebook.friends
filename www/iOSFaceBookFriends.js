var exec = require('cordova/exec');


var iOSFaceBookFriends = function(callback) {
  var iOSFaceBookFriendsReturn = function (json) {
    var data = JSON.parse(json);

    if (data.error)
      return callback(err, null);

    return callback(null, data.contacts);
  }

  exec(iOSFaceBookFriendsReturn, iOSFaceBookFriendsReturn, 'iOSFaceBookFriends', 'iOSFaceBookFriends', []);
};

module.exports = iOSFaceBookFriends;
