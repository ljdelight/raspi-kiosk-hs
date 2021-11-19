# Raspberrypi Kiosk HS

## Install the RaspiOS to the sdcard

1. Download `Raspberry Pi Imager` from https://www.raspberrypi.org/software/
   - If you're not familiar with the tool, watch this 45 second how-to video https://www.youtube.com/watch?v=ntaXWS8Lk34
1. Connect the raspi SD card to the computer
1. Run the `Raspberry Pi Imager` tool and select Raspberry Pi OS 32-bit
   - Note: This guide was written using 2021-05-07. The latest version is okay to use.
1. Select the SD card and do the `WRITE`! This will take some time.

## Initial Boot Walkthrough and Configuration

The image is written to the SD card and is ready to boot!

Plug in a keyboard, mouse, display, and ethernet (if you have it or wifi configuration is available later). The pi will perform first-boot steps, such as resizing the filesystem, and will load a desktop:

![](images/install-1.jpeg?raw=true)

1. Set Country: Select US, English, Chicago timezone, and check English language/keyboard
    ![Set Country](images/install-2.jpeg?raw=true)

1. Set a password
    ![Set Password](images/install-3.jpeg?raw=true)

1. Set Up Screen: Check the box to avoid TV resolution issues
    ![Set Up Screen](images/install-4.jpeg?raw=true)

1. If you're not on an ethernet connection, Select WiFi Network
1. Update Software: `skip`
    - While it is safest to update the system before deploying to production,wifi and bluetooth are later disabled so the only way to hack this setup is physical USB access.
    - ![SKIP Update Software](images/install-5.jpeg?raw=true)

1. Initial OS Setup Complete: Restart the OS
    ![Setup Complete](images/install-6.jpeg?raw=true)

## Provision the Kiosk Software

In this step, we run the provision script and it will modify the OS and create the kiosk.

**ATTENTION: the script makes the following changes**:

1. the OS partition will be `READ-ONLY` and no changes can be made
1. Bluetooth is disabled
1. Wifi is disabled

In the SSH connection or terminal run these commands

```sh
wget https://raw.githubusercontent.com/ljdelight/raspi-kiosk-hs/main/raspi-kiosk-hs-setup.sh
chmod +x raspi-kiosk-hs-setup.sh
./raspi-kiosk-hs-setup.sh
sudo systemctl reboot
```

After a reboot, the pi will start the kiosk and load images from the USB drive.
