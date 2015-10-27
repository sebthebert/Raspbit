# Raspbit
Raspberry Pi + Pretty Rabbit

## Hardware

  * Raspberry Pi 2 (1Gb of RAM)
  * Micro SD Card (8 Gb) with its Micro to SDCard Adapter
  * Wifi dongle
  * Camera
  * my old Nabaztag

## Software

### Operating System

Download the [latest release of Raspbian](http://downloads.raspberrypi.org/raspbian_latest) (based on Debian Wheezy / kernel version 3.18).

On my Mac: 
```
Applications -> Utilities -> Disk Utility.
Erase
Format: MS-DOS (FAT)
Name: RASPBERRY2
```

Get your SDCard partion with `diskutil list`:
```shell
imac:~ seb$ diskutil list
/dev/disk0
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:      GUID_partition_scheme                        *1.0 TB     disk0
   1:                        EFI EFI                     209.7 MB   disk0s1
   2:                  Apple_HFS Macintosh HD            999.3 GB   disk0s2
   3:                 Apple_Boot Recovery HD             650.0 MB   disk0s3
/dev/disk1
   #:                       TYPE NAME                    SIZE       IDENTIFIER
   0:     FDisk_partition_scheme                        *8.0 GB     disk1
   1:                 DOS_FAT_32 RASPBERRY2              8.0 GB     disk1s1
```

Unmout your SDCard partition with `diskutil unmountdisk`:
```shell
imac:~ seb$ diskutil unmountdisk /dev/disk1
Unmount of all volumes on disk1 was successful
```

Copy your Raspbian image with `dd`, it takes looong time (~35 minutes in my case):
```shell
imac:~ seb$ sudo dd if=/Users/seb/Downloads/2015-05-05-raspbian-wheezy.img of=/dev/disk1 bs=2m
Password:
dd1562+1 records in
1562+1 records out
3276800000 bytes transferred in 2127.989635 secs (1539857 bytes/sec)
```

Then eject it:
```shell
imac:~ seb$ sudo diskutil eject /dev/disk1
Password:
Disk /dev/disk1 ejected
```

Plug the Micro SD Card in the Raspberry Pi and power on.

Get the Raspberry IP address with `nmap`:
```shell
imac:~ seb$ nmap -sn 192.168.0.0/24
```

Connect to your Raspberry PI with login/password `pi/raspberry`:
```shell
imac:~ seb$ ssh pi@192.168.0.15
pi@192.168.0.15's password: 
Linux raspberrypi 3.18.11-v7+ #781 SMP PREEMPT Tue Apr 21 18:07:59 BST 2015 armv7l

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.

NOTICE: the software on this Raspberry Pi has not been fully configured. Please run 'sudo raspi-config'

pi@raspberrypi ~ $ df -h
Filesystem      Size  Used Avail Use% Mounted on
rootfs          2.9G  2.4G  335M  88% /
/dev/root       2.9G  2.4G  335M  88% /
devtmpfs        460M     0  460M   0% /dev
tmpfs            93M  244K   93M   1% /run
tmpfs           5.0M     0  5.0M   0% /run/lock
tmpfs           186M     0  186M   0% /run/shm
/dev/mmcblk0p1   56M   19M   37M  34% /boot
pi@raspberrypi ~ $
```

### System Configuration

You can configure your system with a simple interface `raspi-config`:
```
sudo raspi-config
```
  * Expand Filesystem (1)
  * Change your password (2)
  * Change your Internationalisation Options (4) / Timezone (I2)
  * Change your Hostname (8) / (A2) -> 'rpi2'
  * Enable the Camera Support (5)
 
And then Reboot.

After expanding filesystem...
```
pi@rpi2 ~ $ df -h
Filesystem      Size  Used Avail Use% Mounted on
rootfs          7.2G  2.4G  4.5G  35% /
/dev/root       7.2G  2.4G  4.5G  35% /
devtmpfs        428M     0  428M   0% /dev
tmpfs            87M  244K   87M   1% /run
tmpfs           5.0M     0  5.0M   0% /run/lock
tmpfs           173M     0  173M   0% /run/shm
/dev/mmcblk0p1   56M   19M   37M  34% /boot
```
Update your system with `rpi-update` and `apt-get`:
```
sudo rpi-update
sudo reboot

sudo apt-get update
sudo apt-get upgrade
```

### Network configuration

Configure your Wifi:
```shell
pi@rpi2 ~ $ sudo vi /etc/wpa_supplicant/wpa_supplicant.conf
```

`/etc/wpa_supplicant/wpa_supplicant.conf`:
```
network={
        ssid="your_wifi_SSID"
        psk="your_wifi_password"
}
```

Restart your Wifi interface:
```shell
pi@rpi2 ~ $ sudo ifdown wlan0
pi@rpi2 ~ $ sudo ifup wlan0
```

### Perl configuration

The Perl version on Raspbian is 5.14:
```
pi@rpi2 ~ $ perl -v

This is perl 5, version 14, subversion 2 (v5.14.2) built for arm-linux-gnueabihf-thread-multi-64int
(with 89 registered patches, see perl -V for more detail)
```

#### CPANMinus installation

```shell
curl -L https://cpanmin.us | perl - --sudo App::cpanminus
```

#### Mojolicious & Path::Tiny installation

```shell
sudo cpanm Mojolicious
sudo cpanm Mojolicious::Plugin::TtRenderer::Engine
sudo cpanm Path::Tiny
```

#### Raspbit Installation

```shell
git clone https://github.com/sebthebert/Raspbit.git
```
