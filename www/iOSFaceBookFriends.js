var exec = require('cordova/exec');


var iOSFaceBookFriends = function(callback) {
  var iOSFaceBookFriendsReturn = function (json) {
    var data = JSON.parse(json);

    if (data.error)
      return callback(data.error, null);

    return callback(null, data.friends);
  }

  exec(iOSFaceBookFriendsReturn, iOSFaceBookFriendsReturn, 'iOSFaceBookFriends', 'iOSFaceBookFriends', []);
};

module.exports = iOSFaceBookFriends;
