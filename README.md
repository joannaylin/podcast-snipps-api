## Podcast Snippets 
  * Rails API for Podcast Snippets. 
  * Makes Spotify API Calls for React[Frontend](https://github.com/joannaylin/podcast-snippets-frontend).

## Features
  * Authorizes user's through Spotify's Web API Authorization Code Flow, alongside front end.
  * Requires authorization for all API requests. 

## Architecture
  * App.js contains application code. 
  * Utilizes [Spotify Web API] (https://developer.spotify.com/documentation/web-api/) to authorize users and access private data. 
    * Must [register](https://developer.spotify.com/dashboard/) app with Spotify and store client id, secret key, redirect uri, etc. as environment variables. 
      * App uses [Figaro Gem] (https://github.com/laserlemon/figaro).
  
  
This project was bootstrapped with [Create React App](https://github.com/facebook/create-react-app).
