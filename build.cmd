elm make ./src/Main.elm --output=./output/js/recipe-display-1.0.0.js  || goto :error
ECHO OFF
REM uglifyjs ./output/js/recipe-display.min.js --compress | uglifyjs --mangle --output=./output/js/recipe-display.min.js
ECHO ON
elm-minify ./output/js/recipe-display-1.0.0.js


goto :EOF

:error
echo -------------------------------
echo FAILED WITH ERROR!!! #%errorlevel%.
echo -------------------------------
echo off
exit /b %errorlevel%