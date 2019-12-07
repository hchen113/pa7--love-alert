# CS 441 - Programming Assignment 07: Love Alert

//////////////////////////////////////////////////////////// About the app //////////////////////////////////////////////////////////// 

For this final project, I thought about making an app allow someone to anoymuous annouce that they like someone in their immediate phicinitiy vicinity, of a range of 200 meter radius.

When they push the heart button on the button of the screen, their location data will be send a Firebase database for 5 sec, during which user that is on the app during that 5 secs will be able to know that someone around has liked someone. It follows the idea of snapchat, with the users' location data automatically removed after a timer as well as their lcoation data being keyed in the Firebase database with their device UUID, rather then an email/password.





//////////////////////////////////////////////////////////// Building the app  //////////////////////////////////////////////////////////// 

This project involved the usage of Google's Firebase backend solution for mobile applications as well as Geofire's location/query API for retreival and tempoary storage of user location data for sharing. 

When I was installing cocoapods and initilzing the PODS file for my project, I somehow messed up the appliciation's storyboard file or the info.plist file so I had to start over, which i find was easier with a new repoistory so thus I made a new Github repo, reorganizing the project as I rebuild. This is why the commit date start on the 6th. 
