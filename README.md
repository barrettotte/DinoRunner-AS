# DinoRunner-AS
A simple clone of Chrome's Dino Runner to learn the basics of ActionScript before Adobe Flash is put to rest.





## Setting Up ActionScript Environment
* Install Apache Flex - https://www.apache.org/dyn/closer.lua/flex/installer/3.3.2/binaries/apache-flex-sdk-installer-3.3.2-bin.exe
* Change to install directory - ```cd D:\Development\apache-flex\bin```
* ```mkdir -p frameworks\libs\player\31.0\```
* Setup **playerglobal.swc**
  * Download from https://www.adobe.com/support/flashplayer/debug_downloads.html
  * place in **frameworks\libs\player\31.0**
  * version numbers didn't match up, but whatever
* ```ant -f installer.xml -Dair.sdk.version=2.6```
