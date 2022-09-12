# Entwicklungsumgebung für Raspberry Pi

## WSL2

[WSL2 aktivieren und Ubuntu installieren](https://docs.microsoft.com/en-us/windows/wsl/install)

Die Powershell als Administrator öffnen und folgendes eingeben:
`wsl --install`

Weitere nützliche tools für Windows:

[Windows Terminal](https://docs.microsoft.com/en-us/windows/terminal/install)
Kann über GitHub oder Mocrosoft Store installier werden

[Visual Studio Code](https://code.visualstudio.com/)


## Raspberry OS

Headless installation unter Linux

1. Image herunterladen: [Raspberry Pi OS Lite 64bit](https://www.raspberrypi.com/software/operating-systems/)
2. Image auf sd-karte schreiben: 

```bash
# extract image
unxz 2022-09-06-raspios-bullseye-arm64-lite.img.xz

# block devices anzeigen
lsblk

# image auf sd-karte schreiben: 'mmcblk0' mit device für sd-karte ersetzen
dd if=2022-09-06-raspios-bullseye-arm64-lite.img of=/dev/mmcblk0

# es wurden zwei partitionen auf der SD-Karte erstellt: boot und rootfs.
```

3. SSH aktivieren: auf der SD-Karte in `boot` eine leere Datei `ssh` erstellen.
SSH mit default Passwort funktioniert leider nicht. 
Man kann auf `rootfs` in `home/pi/.ssh/authorized_keys` einen public key ablegen.
[Nach dieser Anleitung](https://phoenixnap.com/kb/ssh-with-key) Wichtig: File-Permission richtig setzen.
Danach ist das einloggen via ssh ohne Passwort möglich.

4. Booten: SD-Karte im Raspberry Pi einsetzen, Ethernet und Strom einstecken. Warten...
5. Einloggen: 

```bash
# hostname: raspberrypi
# user: pi

ssh pi@raspberrypi
uname -a
# Linux raspberrypi 5.15.61-v8+ #1579 SMP PREEMPT Fri Aug 26 11:16:44 BST 2022 aarch64 GNU/Linux
```


## GNU Assembler

Toolchain unter Debian oder Ubuntu installieren:
`sudo apt install gcc-arm-none-eabi`

Template Projekt übersetzen: `make` ausführen. `kernel.img` wird erstellt.


## LED anschliessen

![LED](doc/led.jpg)

Weiderstand ist 220 Ohm. Wiederstand an GND. 
Kurzer PIN (-) von LED bei Wiederstand. 
Langer (+) PIN bei GPIO 24


## Test LED mit Python

[Morse Code on an LED](https://www.cl.cam.ac.uk/projects/raspberrypi/tutorials/robot/morse_code/)

1. Auf Raspberry Pi einloggen
2. Python script erstellen `vi test.py`:
```python
import RPi.GPIO as GPIO
import time
pinNum = 24 # gleiche nummer wie auf breakout board
GPIO.setmode(GPIO.BCM) #numbering scheme that corresponds to breakout board and pin layout
GPIO.setup(pinNum,GPIO.OUT) #replace pinNum with whatever pin you used, this sets up that pin as an output
#set LED to flash forever
while True:
  GPIO.output(pinNum,GPIO.HIGH)
  time.sleep(0.5)
  GPIO.output(pinNum,GPIO.LOW)
  time.sleep(0.5)	   
```

3. Ausführen: `sudo python test.py`. LED Blinkt

![LED](doc/pi.jpg)

