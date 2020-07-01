# Demo Flutter app Using Bloc architect
## Overview
Currently, there are 4 screens:

 1. **Barcode Scanning Screen**: only contains a button, allowing user to scan a Barcode or QRcode.
 2. **Signing Up Screen**: where user input username and password for signing up
 3. **User Info Screen**: 
		 - displays Barcode/QRcode from screen (1) and username info from screen (2)
		 - capture images with GPS)
		 - delete captured images 
		 - sign out and re-register
  4. **Image capture screen**

## Flow
### First open
(screen 1 🎬 scan barcode/qrcode) ➡ (screen 2 🎬 input username & password) ➡ (screen 3 🎬 signout) ➡ (screen 1 🎬 re-register)

(screen 3 🎬 capture image) ➡ (screen 4 🎬 captured) ➡ (screen 3 🎬 view images)

### Open after registered
(screen 3 🎬 signout) ➡ (screen 1 🎬 re-register)

(screen 3 🎬 capture image) ➡ (screen 4 🎬 captured) ➡ (screen 3 🎬 view images)

***Explanation***: All input info from screen (1) and (2) is loaded and displayed directly on screen (3). Data is persisted using SharedPref.
# TODO
- Improve project structure
- Beautify UI
