# recipe-den
Personal Recipe For Display On Google Nest Hub.


## About

[View website](https://recipe-den.web.app/)

Designed to allow writing of personal recipes in Recipe scehma Json-LD format (read and displayed in webpage via Elm) to be indexed by Google for display on nest hub.

Website design needs improving, but as proof of concept is good enough for now. Waiting to see if Google index the content.

## Deployment

Happens automatically using GitHub actions.


## Running Locally

Firebase SDK now includes local hosting server:

```
firebase emulators:start
```

## Steps To Add Recipe

1. Copy html page and rename
2. Copy JS recipe file and rename/populate
3. Edit carousel.js with new item

These are a bit tedious and could do without the html page step by refactoring code to serve homepage too. (Another day)
