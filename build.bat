@ECHO OFF
REM Simple build script for ActionScript

REM Compile with Adobe Flex SDK
mxmlc -source-path "." -default-size 800 600 -default-frame-rate 120 -o "dinorunner.swf" "dinorunner\Main.as"
