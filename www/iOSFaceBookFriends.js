var exec = require('cordova/exec');


var iOSFaceBookFriends = function(callback) {
  var iOSFaceBookFriendsReturn = function (json) {
    var result = JSON.parse(json);

    if (!result.data)
      return callback('unable to connect to facebook');

    return callback(null, data.data);
  }

  exec(iOSFaceBookFriendsReturn, iOSFaceBookFriendsReturn, 'iOSFaceBookFriends', 'iOSFaceBookFriends', []);
};

module.exports = iOSFaceBookFriends;
