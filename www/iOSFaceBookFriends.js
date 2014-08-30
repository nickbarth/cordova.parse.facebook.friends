var exec = require('cordova/exec');


var iOSFaceBookFriends = function(callback) {
  var iOSFaceBookFriendsReturn = function (json) {
    var result = JSON.parse(json);
    var friends = null;
    
    if (result.error) {
      return callback(result.error);
    }
    
    if (!result.data) {
      return callback('could not connect to facebook');  
    }

    friends = result.data.map(function (friend) {
      return { id: friend.id, name: friend.name, picture: friend.picture.data.url };
    });
    
    return callback(null, friends);
  }

  exec(iOSFaceBookFriendsReturn, iOSFaceBookFriendsReturn, 'iOSFaceBookFriends', 'iOSFaceBookFriends', []);
};

module.exports = iOSFaceBookFriends;
