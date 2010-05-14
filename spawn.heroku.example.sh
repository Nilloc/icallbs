#!/bin/bash

APPNAME = 'myapp.com'

# Install Heroku gem
sudo gem install heroku

# Create a heroku app
heroku create $APPNAME

#Add your custom domain
heroku domains:add $APPNAME

#Push master branch to heroku
git push heroku master

#Show your newly spawned site in the browser
open "http://$APPNAME"