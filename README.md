ProlificLibrarySWAG
===================

Practice Project from Prolific (using SWAG architecture) 

Simple CRUD Application I created for Prolific Interactive. It's a nifty app that keeps track of library books and checkouts via a server.
I used CocoaPods and AFNetworking (both for the first time in a project).

Features:
AFNetworking
Cocoapods
IB Autolayout 
Swipe to Delete 
Sharing book details

Things I want to do to further build this project: 
Manage threading
Implement MUD 
Refresh upon scrolldown 
Keyboard resize and viewcontroller adjustments 
search function 
ability to store data locally either via coredata or plists (so the user doesn't lose everything just because they don't 
have access to the web) 
Make it look cooler! I wanted to put a splash page and add some more assets. I have a nifty icon but the app could look
even cooler. 

I use a helper class called APIConnection to manage the API requests. I also use a Constant file for the URL. Everything else is 
pretty straightforward. 
