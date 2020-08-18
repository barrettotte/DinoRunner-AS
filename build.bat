@ECHO OFF
REM Simple build script for ActionScript

REM Compile with Adobe Flex SDK
mxmlc -source-path "src/" -default-size 640 512 -default-frame-rate 120 -o "game.swf" "src/Main.as"
