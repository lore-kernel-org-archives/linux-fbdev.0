From: Martin Michlmayr <tbm@cyrius.com>
Subject: cyber2000 corruption/hang on Netwinder on 2.6.15
Date: Thu, 12 Jan 2006 13:59:48 +0000
Message-ID: <20060112135948.GA32352@deprecation.cyrius.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="9jxsPFA5p3P2qPhR"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ex2zt-00083R-UC
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 12 Jan 2006 06:00:13 -0800
Received: from sorrow.cyrius.com ([65.19.161.204])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1Ex2zq-0006sr-6O
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 12 Jan 2006 06:00:14 -0800
Content-Disposition: inline
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: linux-fbdev-devel@lists.sourceforge.net


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I just upgraded my Netwinder from 2.4.27 to 2.6.15 and the framebuffer
no longer works.  Console works but when I start X.org I first get a
corrupted screen and a little bit later the whole machine hangs.
There's no panic or any information on the serial console.

I've no idea how to debug this but I'm happy to provide information to
developers willing to take a look.  The output of dmesg from 2.4 and
2.6 are attached; the output from X.org as well.

0000:00:09.0 VGA compatible controller: Intergraphics Systems CyberPro 2000A (rev 01) (prog-if 00 [VGA])
	Subsystem: Unknown device 0202:0202
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at c0000000 (32-bit, non-prefetchable) [size=16M]
	Expansion ROM at 80040000 [disabled] [size=64K]

Kernel config on 2.4:

CONFIG_FB=y
CONFIG_FB_CLGEN=y
CONFIG_FB_CYBER2000=y
CONFIG_FB_VGA16=y
CONFIG_FB_VIRTUAL=m
CONFIG_FBCON_ADVANCED=y
CONFIG_FBCON_MFB=y
CONFIG_FBCON_CFB2=y
CONFIG_FBCON_CFB4=y
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_CFB16=y
CONFIG_FBCON_CFB24=y
CONFIG_FBCON_CFB32=y
CONFIG_FBCON_VGA_PLANES=y
CONFIG_FBCON_VGA=y
CONFIG_FBCON_FONTS=y

Kernel config on 2.6:

CONFIG_FB=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y
CONFIG_FB_CYBER2000=y

The X.org logs show no difference between 2.4 and 2.6 (but 2.4 works while
2.6 doesn't):

--- Xorg.0.log-2.4	2006-01-10 22:26:31.000000000 +0000
+++ Xorg.0.log-2.6	2006-01-10 22:26:31.000000000 +0000
@@ -3,16 +3,16 @@
 Release Date: 9 February 2005
 X Protocol Version 11, Revision 0, Release 6.8.2
 Build Operating System: Linux 2.4.27-netwinder armv4l [ELF] 
-Current Operating System: Linux netwinder 2.4.27-netwinder #1 Sat Oct 29 19:55:43 BST 2005 armv4l
+Current Operating System: Linux netwinder 2.6.15 #13 Tue Jan 10 22:06:13 GMT 2006 armv4l
 Build Date: 30 November 2005
 	Before reporting problems, check http://wiki.X.Org
 	to make sure that you have the latest version.
 Module Loader present
-OS Kernel: Linux version 2.4.27-netwinder (vince@gerald) (gcc version 2.95.3 20010315 (release)) #1 Sat Oct 29 19:55:43 BST 2005 
+OS Kernel: Linux version 2.6.15 (Debian 2.6.15-1) (luther@debian.org) (gcc version 4.0.3 20051201 (prerelease) (Debian 4.0.2-5)) #13 Tue Jan 10 22:06:13 GMT 2006 
 Markers: (--) probed, (**) from config file, (==) default setting,
 	(++) from command line, (!!) notice, (II) informational,
 	(WW) warning, (EE) error, (NI) not implemented, (??) unknown.
-(==) Log file: "/var/log/Xorg.0.log", Time: Tue Jan 10 22:10:56 2006
+(==) Log file: "/var/log/Xorg.0.log", Time: Tue Jan 10 22:16:27 2006
 (==) Using config file: "/etc/X11/xorg.conf"
 (==) ServerLayout "Default Layout"
 (**) |-->Screen "Default Screen" (0)
@@ -417,4 +417,3 @@
 Warning: font renderer for ".bdf.Z" already registered at priority 0
 Warning: font renderer for ".bdf.gz" already registered at priority 0
 Warning: font renderer for ".pmf" already registered at priority 0
-Could not init font path element unix/:7100, removing from list!

This is with depth 16.  With depth 4, I get the following on 2.6:

(**) FBDEV(0): Depth 4, (--) framebuffer bpp 4
(==) FBDEV(0): Default visual is StaticColor
(==) FBDEV(0): Using gamma correction (1.0, 1.0, 1.0)
(II) FBDEV(0): hardware: CyberPro2010 (video memory: 2048kB)
(II) FBDEV(0): checking modes against framebuffer device...
(II) FBDEV(0):  mode "800x600" test failed
(II) FBDEV(0):  mode "640x480" test failed
(II) FBDEV(0): checking modes against monitor...
(--) FBDEV(0): Virtual size is 640x480 (pitch 640)
(**) FBDEV(0):  Built-in mode "current": 25.2 MHz, 31.5 kHz, 59.9 Hz
(II) FBDEV(0): Modeline "current"   25.17  640 656 744 800  480 489 491 525 -hsync +vsync +csync
(++) FBDEV(0): DPI set to (100, 100)
(EE) FBDEV(0): unsupported number of bits per pixel: 4

Interestingly, after this the console no longer shows anything (but
the machine still works).  But the real problem is the corruption plus
crash with depth 16.
-- 
Martin Michlmayr
http://www.cyrius.com/

--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg-2.4"

Linux version 2.4.27-netwinder (vince@gerald) (gcc version 2.95.3 20010315 (release)) #1 Sat Oct 29 19:55:43 BST 2005
CPU: StrongARM-110 revision 4
Machine: Rebel-NetWinder
Converting old-style param struct to taglist
On node 0 totalpages: 32768
zone(0): 32768 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: ide0=autotune root=/dev/hda2 console=ttyS0,115200 netconfig_eth0=dhcp eth0=192.168.1.9/24 netconfig_eth1=disk R1=0.0.0.0:192.168.7.1:n R2=0.0.0.0:192.168.7.1:n R3=0.0.0.0:192.168.7.1:n R4=0.0.0.0:192.168.7.1:n nfsroot=undefined nfsaddrs=192.168.1.9:undefined:192.168.7.1:255.255.255.0::eth0:
ide_setup: ide0=autotune
Console: colour dummy device 80x30
Calibrating delay loop... 185.95 BogoMIPS
Memory: 128MB = 128MB total
Memory: 127268KB available (1733K code, 509K data, 104K init)
Dentry cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
CPU: Testing write buffer: FAIL - enabling work-around
POSIX conformance testing by UNIFIX
PCI: DC21285 footbridge, revision 03, in central function mode
PCI: bus0: Fast back to back transfers disabled
PCI: Ignore bogus resource 1 [3f6:3f6] of Symphony Labs SL82c105
PCI: Ignore bogus resource 3 [376:376] of Symphony Labs SL82c105
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Disk quotas vdquot_6.5.1
Journalled Block Device driver loaded
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
tts/%d0 at I/O 0x3f8 (irq = 4) is a 16550A
tts/%d1 at I/O 0x2f8 (irq = 3) is a 16550A
CyberPro2010: enabling PCI bursts
CyberPro2010: 2048KiB VRAM, using 640x480, 31.468kHz, 59Hz
Console: switching to colour frame buffer device 80x30
clgen: Driver for Cirrus Logic based graphic boards, v1.9.9.1
clgenfb: couldn't find Cirrus Logic PCI device
vga16fb: initializing
vga16fb: mapped to 0xc9801000
fb1: VGA16 VGA frame buffer device
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.10f
Thermostat: high 50.0, low 48.0, current 42.5 C, fan on.
COMX: driver version 0.85 (C) 1995-1999 ITConsult-Pro Co. <info@itc.hu>
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
W82C105: IDE controller at PCI slot 00:0c.1
W82C105: chipset revision 5
W82C105: 100% native mode on irq 14
    ide0: BM-DMA at 0x10a0-0x10a7, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0x10a8-0x10af, BIOS settings: hdc:DMA, hdd:DMA
hda: IBM-DARA-212000, ATA DISK drive
hda: selected PIO 4 (120ns) (0240)
ide0 at 0x10c0-0x10c7,0x3f6 on irq 14
hda: attached ide-disk driver.
hda: 23579136 sectors (12073 MB) w/418KiB Cache, CHS=23392/16/63
Partition check:
 /dev/ide/host0/bus0/target0/lun0: [PTBL] [1467/255/63] p1 p2 p3 < p5 >
DC21285 flash support (8-bit buswidth)
Search for id:(89 a6) interleave(1) type(1)
Found: Intel 28F008S5
DC21285 flash: Found 1 x8 devices at 0x0 in 8-bit mode
DC21285 flash: Found an alias at 0x100000 for the chip at 0x0
DC21285 flash: Found an alias at 0x200000 for the chip at 0x0
DC21285 flash: Found an alias at 0x300000 for the chip at 0x0
DC21285 flash: Found an alias at 0x400000 for the chip at 0x0
DC21285 flash: Found an alias at 0x500000 for the chip at 0x0
DC21285 flash: Found an alias at 0x600000 for the chip at 0x0
DC21285 flash: Found an alias at 0x700000 for the chip at 0x0
DC21285 flash: Found an alias at 0x800000 for the chip at 0x0
DC21285 flash: Found an alias at 0x900000 for the chip at 0x0
DC21285 flash: Found an alias at 0xa00000 for the chip at 0x0
DC21285 flash: Found an alias at 0xb00000 for the chip at 0x0
DC21285 flash: Found an alias at 0xc00000 for the chip at 0x0
DC21285 flash: Found an alias at 0xd00000 for the chip at 0x0
DC21285 flash: Found an alias at 0xe00000 for the chip at 0x0
DC21285 flash: Found an alias at 0xf00000 for the chip at 0x0
0: offset=0x0,size=0x10000,blocks=16
Using word write method
DC21285 Flash: no partition info available, registering whole flash at once
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
NET4: AppleTalk 0.18a for Linux NET4.0
NetWinder Floating Point Emulator V0.97 (extended precision)
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing init memory: 104K
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Adding Swap: 377488k swap-space (priority -1)
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,2), internal journal
Linux Tulip driver version 0.9.15-pre12 (Aug 9, 2002)
tulip0:  MII transceiver #1 config 3000 status 7809 advertising 01e1.
eth0: Digital DS21143 Tulip rev 65 at 0x1000, 00:10:57:57:1D:57, IRQ 22.
ne2k-pci.c:v1.02 10/19/2000 D. Becker/P. Gortmaker
  http://www.scyld.com/network/ne2k-pci.html
eth1: Winbond W89C940F found at 0x1080, IRQ 21, 00:10:57:00:1D:57.
usb.c: registered new driver hub
uhci.c: USB Universal Host Controller Interface driver v1.1
usb-uhci.c: $Revision: 1.275 $ time 20:06:15 Oct 29 2005
usb-uhci.c: High bandwidth mode enabled
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
Linux video capture interface: v1.00
i2c-core.o: i2c core module version 2.6.1 (20010830)
i2c-algo-bit.o: i2c bit algorithm module
bttv: driver version 0.7.108 loaded
bttv: using 4 buffers with 2080k (8320k total) for capture
Linux video capture interface: v1.00
i2c-core.o: i2c core module version 2.6.1 (20010830)
i2c-algo-bit.o: i2c bit algorithm module
bttv: driver version 0.7.108 loaded
bttv: using 4 buffers with 2080k (8320k total) for capture
eth1: bogus packet: status=0x80 nxpg=0x4c size=1518
Linux video capture interface: v1.00
i2c-core.o: i2c core module version 2.6.1 (20010830)
i2c-algo-bit.o: i2c bit algorithm module
bttv: driver version 0.7.108 loaded
bttv: using 4 buffers with 2080k (8320k total) for capture
Linux video capture interface: v1.00
i2c-core.o: i2c core module version 2.6.1 (20010830)
i2c-algo-bit.o: i2c bit algorithm module
bttv: driver version 0.7.108 loaded
bttv: using 4 buffers with 2080k (8320k total) for capture

--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg-2.6"

Linux version 2.6.15 (Debian 2.6.15-1) (luther@debian.org) (gcc version 4.0.3 20051201 (prerelease) (Debian 4.0.2-5)) #13 Tue Jan 10 22:06:13 GMT 2006
CPU: StrongARM-110 [4401a104] revision 4 (ARMv4)
Machine: Rebel-NetWinder
Converting old-style param struct to taglist
ATAG_INITRD is deprecated; please update your bootloader.
Memory policy: ECC disabled, Data cache writeback
On node 0 totalpages: 32768
  DMA zone: 32768 pages, LIFO batch:7
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 0 pages, LIFO batch:0
  HighMem zone: 0 pages, LIFO batch:0
Built 1 zonelists
Kernel command line: ide0=autotune root=/dev/hda2 console=tty console=ttyS0,115200 netconfig_eth0=dhcp eth0=192.168.1.9/24 netconfig_eth1=disk R1=0.0.0.0:192.168.7.1:n R2=0.0.0.0:192.168.7.1:n R3=0.0.0.0:192.168.7.1:n R4=0.0.0.0:192.168.7.1:n nfsroot=undefined nfsaddrs=192.168.1.9:undefined:192.168.7.1:255.255.255.0::eth0:
ide_setup: ide0=autotune -- OBSOLETE OPTION, WILL BE REMOVED SOON!
PID hash table entries: 1024 (order: 10, 16384 bytes)
Console: colour dummy device 80x30
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 128MB = 128MB total
Memory: 126976KB available (2170K code, 459K data, 104K init)
Calibrating delay loop... 185.95 BogoMIPS (lpj=929792)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Capability LSM initialized
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: failed, enabling work-around
NET: Registered protocol family 16
PCI: DC21285 footbridge, revision 03, in central function mode
PCI: bus0: Fast back to back transfers disabled
PCI: Ignore bogus resource 1 [3f6:3f6] of 0000:00:0c.1
PCI: Ignore bogus resource 3 [376:376] of 0000:00:0c.1
Linux Plug and Play Support v0.97 (c) Adam Belay
NetWinder Floating Point Emulator V0.97 (extended precision)
audit: initializing netlink socket (disabled)
audit(1136931225.308:1): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
CyberPro2010: enabling PCI bursts
CyberPro2010: 2048KiB VRAM, using 640x480, 31.468kHz, 59Hz
Console: switching to colour frame buffer device 80x30
isapnp: ISA Plug & Play support disabled
Real Time Clock Driver v1.12
Thermostat: high 50.0, low 48.0, current 42.5 C, fan on.
NetWinder Button Driver Version 0.3 (C) Alex Holden <alex@linuxhacker.org> 1998.
Software Watchdog Timer: 0.07 initialized. soft_noboot=0 soft_margin=60 sec (nowayout= 0)
serio: i8042 AUX port at 0x60,0x64 irq 5
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 21285 driver $Revision: 1.37 $
ttyFB0 at MMIO 0x42000160 (irq = -1) is a DC21285
Serial: 8250/16550 driver $Revision: 1.90 $ 16 ports, IRQ sharing disabled
serial8250.0: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250.0: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 [PCSPP,TRISTATE,EPP]
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
W82C105: IDE controller at PCI slot 0000:00:0c.1
W82C105: chipset revision 5
W82C105: 100% native mode on irq 14
Probing IDE interface ide0...
hda: IBM-DARA-212000, ATA DISK drive
hda: selected PIO 4 (120ns) (0240)
ide0 at 0x10c0-0x10c7,0x3f6 on irq 14
Probing IDE interface ide1...
Probing IDE interface ide1...
hda: max request size: 128KiB
hda: 23579136 sectors (12072 MB) w/418KiB Cache, CHS=23392/16/63
hda: cache flushes not supported
 hda: hda1 hda2 hda3 < hda5 >
DC21285 flash support (8-bit bankwidth)
Found: Intel 28F008S5
DC21285 flash: Found 1 x8 devices at 0x0 in 8-bit bank
DC21285 flash: Found an alias at 0x100000 for the chip at 0x0
DC21285 flash: Found an alias at 0x200000 for the chip at 0x0
DC21285 flash: Found an alias at 0x300000 for the chip at 0x0
DC21285 flash: Found an alias at 0x400000 for the chip at 0x0
DC21285 flash: Found an alias at 0x500000 for the chip at 0x0
DC21285 flash: Found an alias at 0x600000 for the chip at 0x0
DC21285 flash: Found an alias at 0x700000 for the chip at 0x0
DC21285 flash: Found an alias at 0x800000 for the chip at 0x0
DC21285 flash: Found an alias at 0x900000 for the chip at 0x0
DC21285 flash: Found an alias at 0xa00000 for the chip at 0x0
DC21285 flash: Found an alias at 0xb00000 for the chip at 0x0
DC21285 flash: Found an alias at 0xc00000 for the chip at 0x0
DC21285 flash: Found an alias at 0xd00000 for the chip at 0x0
DC21285 flash: Found an alias at 0xe00000 for the chip at 0x0
DC21285 flash: Found an alias at 0xf00000 for the chip at 0x0
erase region 0: offset=0x0,size=0x10000,blocks=16
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 3, 32768 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP reno registered
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 8
NET: Registered protocol family 20
IP-Config: Device `eth0' not found.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing init memory: 104K
input: AT Raw Set 2 keyboard as /class/input/input0
input: ImPS/2 Logitech Wheel Mouse as /class/input/input1
Adding 377488k swap on /dev/hda5.  Priority:-1 extents:1 across:377488k
EXT3 FS on hda2, internal journal
Linux Tulip driver version 1.1.13 (May 11, 2002)
PCI: enabling device 0000:00:0a.0 (0000 -> 0003)
tulip0:  MII transceiver #1 config 3000 status 7809 advertising 01e1.
eth0: Digital DS21143 Tulip rev 65 at ff001000, 00:10:57:57:1D:57, IRQ 22.
ne2k-pci.c:v1.03 9/22/2003 D. Becker/P. Gortmaker
  http://www.scyld.com/network/ne2k-pci.html
eth1: Winbond W89C940F found at 0x1080, IRQ 21, 00:10:57:00:1D:57.
usbcore: registered new driver usbfs
usbcore: registered new driver hub
usbcore: deregistering driver usbfs
usbcore: khubd exiting
usbcore: deregistering driver hub
Linux video capture interface: v1.00

--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="Xorg.0.log-2.6"


X Window System Version 6.8.2 (Debian 6.8.2.dfsg.1-11 20051129171901 root@cats)
Release Date: 9 February 2005
X Protocol Version 11, Revision 0, Release 6.8.2
Build Operating System: Linux 2.4.27-netwinder armv4l [ELF] 
Current Operating System: Linux netwinder 2.6.15 #13 Tue Jan 10 22:06:13 GMT 2006 armv4l
Build Date: 30 November 2005
	Before reporting problems, check http://wiki.X.Org
	to make sure that you have the latest version.
Module Loader present
OS Kernel: Linux version 2.6.15 (Debian 2.6.15-1) (luther@debian.org) (gcc version 4.0.3 20051201 (prerelease) (Debian 4.0.2-5)) #13 Tue Jan 10 22:06:13 GMT 2006 
Markers: (--) probed, (**) from config file, (==) default setting,
	(++) from command line, (!!) notice, (II) informational,
	(WW) warning, (EE) error, (NI) not implemented, (??) unknown.
(==) Log file: "/var/log/Xorg.0.log", Time: Tue Jan 10 22:16:27 2006
(==) Using config file: "/etc/X11/xorg.conf"
(==) ServerLayout "Default Layout"
(**) |-->Screen "Default Screen" (0)
(**) |   |-->Monitor "Generic Monitor"
(**) |   |-->Device "Intergraphics Systems CyberPro 2000A"
(**) |-->Input Device "Generic Keyboard"
(**) Option "XkbRules" "xorg"
(**) XKB: rules: "xorg"
(**) Option "XkbModel" "pc105"
(**) XKB: model: "pc105"
(**) Option "XkbLayout" "gb"
(**) XKB: layout: "gb"
(==) Keyboard: CustomKeycode disabled
(**) |-->Input Device "Configured Mouse"
(WW) The directory "/usr/lib/X11/fonts/cyrillic" does not exist.
	Entry deleted from font path.
(WW) The directory "/usr/lib/X11/fonts/CID" does not exist.
	Entry deleted from font path.
(**) FontPath set to "unix/:7100,/usr/lib/X11/fonts/misc,/usr/lib/X11/fonts/100dpi/:unscaled,/usr/lib/X11/fonts/75dpi/:unscaled,/usr/lib/X11/fonts/Type1,/usr/lib/X11/fonts/100dpi,/usr/lib/X11/fonts/75dpi"
(==) RgbPath set to "/usr/X11R6/lib/X11/rgb"
(==) ModulePath set to "/usr/X11R6/lib/modules"
(WW) Open APM failed (/dev/apm_bios) (No such file or directory)
(II) Module ABI versions:
	X.Org ANSI C Emulation: 0.2
	X.Org Video Driver: 0.7
	X.Org XInput driver : 0.4
	X.Org Server Extension : 0.2
	X.Org Font Renderer : 0.4
(II) Loader running on linux
(II) LoadModule: "bitmap"
(II) Loading /usr/X11R6/lib/modules/fonts/libbitmap.a
(II) Module bitmap: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 1.0.0
	Module class: X.Org Font Renderer
	ABI class: X.Org Font Renderer, version 0.4
(II) Loading font Bitmap
(II) LoadModule: "pcidata"
(II) Loading /usr/X11R6/lib/modules/libpcidata.a
(II) Module pcidata: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 1.0.0
	ABI class: X.Org Video Driver, version 0.7
(--) using VT number 7

(II) PCI: PCI scan (all values are in hex)
(II) PCI: 00:00:0: chip 1011,1065 card 0000,0000 rev 03 class 0b,40,01 hdr 00
(II) PCI: 00:09:0: chip 10ea,2010 card 0202,0202 rev 01 class 03,00,00 hdr 00
(II) PCI: 00:0a:0: chip 1011,0019 card 0000,0000 rev 41 class 02,00,00 hdr 00
(II) PCI: 00:0c:0: chip 10ad,0565 card 0000,0000 rev 10 class 06,01,00 hdr 80
(II) PCI: 00:0c:1: chip 10ad,0105 card 0000,0000 rev 05 class 01,01,8f hdr 80
(II) PCI: 00:0d:0: chip 1050,5a5a card 0000,0000 rev 00 class 02,00,00 hdr 00
(II) PCI: End of PCI scan
(II) PCI-to-ISA bridge:
(II) Bus -1: bridge is at (0:12:0), (0,-1,-1), BCTRL: 0x0008 (VGA_EN is set)
(II) Host-to-PCI bridge:
(II) Bus 0: bridge is at (0:0:0), (0,0,0), BCTRL: 0x0008 (VGA_EN is set)
(II) Bus 0 I/O range:
	[0] -1	0	0x00000000 - 0x0000ffff (0x10000) IX[B]
(II) Bus 0 non-prefetchable memory range:
	[0] -1	0	0x00000000 - 0xffffffff (0x0) MX[B]
(II) Bus 0 prefetchable memory range:
	[0] -1	0	0x00000000 - 0xffffffff (0x0) MX[B]
(--) PCI: (0:0:0) Digital Equipment Corporation StrongARM DC21285 rev 3, Mem @ 0xf4000000/0, 0xe0000000/0, I/O @ 0xff00/0
(--) PCI:*(0:9:0) Intergraphics Systems CyberPro 2000A rev 1, Mem @ 0x40000000/24, BIOS @ 0x00040000/16
(II) Addressable bus resource ranges are
	[0] -1	0	0x00000000 - 0xffffffff (0x0) MX[B]
	[1] -1	0	0x00000000 - 0x0000ffff (0x10000) IX[B]
(II) OS-reported resource ranges:
	[0] -1	0	0xffffffff - 0xffffffff (0x1) MX[B]
	[1] -1	0	0x00000000 - 0x00000000 (0x1) MX[B]
	[2] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[3] -1	0	0x00000000 - 0x00000000 (0x1) IX[B]
(II) Active PCI resource ranges:
	[0] -1	0	0x41000000 - 0x410003ff (0x400) MX[B]
	[1] -1	0	0x00040000 - 0x0004ffff (0x10000) MX[B](B)
	[2] -1	0	0x40000000 - 0x40ffffff (0x1000000) MX[B](B)
	[3] -1	0	0xe0000000 - 0xe0000000 (0x1) MX[B]
	[4] -1	0	0xf4000000 - 0xf4000000 (0x1) MX[B]
	[5] -1	0	0x00001080 - 0x0000109f (0x20) IX[B]
	[6] -1	0	0x000010b0 - 0x000010bf (0x10) IX[B]
	[7] -1	0	0x000010a0 - 0x000010af (0x10) IX[B]
	[8] -1	0	0x00000374 - 0x00000374 (0x1) IX[B]
	[9] -1	0	0x000010c8 - 0x000010cf (0x8) IX[B]
	[10] -1	0	0x000003f4 - 0x000003f4 (0x1) IX[B]
	[11] -1	0	0x000010c0 - 0x000010c7 (0x8) IX[B]
	[12] -1	0	0x00001000 - 0x0000107f (0x80) IX[B]
	[13] -1	0	0x0000ff00 - 0x0000ff00 (0x1) IX[B]
(II) Active PCI resource ranges after removing overlaps:
	[0] -1	0	0x41000000 - 0x410003ff (0x400) MX[B]
	[1] -1	0	0x00040000 - 0x0004ffff (0x10000) MX[B](B)
	[2] -1	0	0x40000000 - 0x40ffffff (0x1000000) MX[B](B)
	[3] -1	0	0xe0000000 - 0xe0000000 (0x1) MX[B]
	[4] -1	0	0xf4000000 - 0xf4000000 (0x1) MX[B]
	[5] -1	0	0x00001080 - 0x0000109f (0x20) IX[B]
	[6] -1	0	0x000010b0 - 0x000010bf (0x10) IX[B]
	[7] -1	0	0x000010a0 - 0x000010af (0x10) IX[B]
	[8] -1	0	0x00000374 - 0x00000374 (0x1) IX[B]
	[9] -1	0	0x000010c8 - 0x000010cf (0x8) IX[B]
	[10] -1	0	0x000003f4 - 0x000003f4 (0x1) IX[B]
	[11] -1	0	0x000010c0 - 0x000010c7 (0x8) IX[B]
	[12] -1	0	0x00001000 - 0x0000107f (0x80) IX[B]
	[13] -1	0	0x0000ff00 - 0x0000ff00 (0x1) IX[B]
(II) OS-reported resource ranges after removing overlaps with PCI:
	[0] -1	0	0xffffffff - 0xffffffff (0x1) MX[B]
	[1] -1	0	0x00000000 - 0x00000000 (0x1) MX[B]
	[2] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[3] -1	0	0x00000000 - 0x00000000 (0x1) IX[B]
(II) All system resource ranges:
	[0] -1	0	0xffffffff - 0xffffffff (0x1) MX[B]
	[1] -1	0	0x00000000 - 0x00000000 (0x1) MX[B]
	[2] -1	0	0x41000000 - 0x410003ff (0x400) MX[B]
	[3] -1	0	0x00040000 - 0x0004ffff (0x10000) MX[B](B)
	[4] -1	0	0x40000000 - 0x40ffffff (0x1000000) MX[B](B)
	[5] -1	0	0xe0000000 - 0xe0000000 (0x1) MX[B]
	[6] -1	0	0xf4000000 - 0xf4000000 (0x1) MX[B]
	[7] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[8] -1	0	0x00000000 - 0x00000000 (0x1) IX[B]
	[9] -1	0	0x00001080 - 0x0000109f (0x20) IX[B]
	[10] -1	0	0x000010b0 - 0x000010bf (0x10) IX[B]
	[11] -1	0	0x000010a0 - 0x000010af (0x10) IX[B]
	[12] -1	0	0x00000374 - 0x00000374 (0x1) IX[B]
	[13] -1	0	0x000010c8 - 0x000010cf (0x8) IX[B]
	[14] -1	0	0x000003f4 - 0x000003f4 (0x1) IX[B]
	[15] -1	0	0x000010c0 - 0x000010c7 (0x8) IX[B]
	[16] -1	0	0x00001000 - 0x0000107f (0x80) IX[B]
	[17] -1	0	0x0000ff00 - 0x0000ff00 (0x1) IX[B]
(II) LoadModule: "bitmap"
(II) Reloading /usr/X11R6/lib/modules/fonts/libbitmap.a
(II) Loading font Bitmap
(II) LoadModule: "dbe"
(II) Loading /usr/X11R6/lib/modules/extensions/libdbe.a
(II) Module dbe: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 1.0.0
	Module class: X.Org Server Extension
	ABI class: X.Org Server Extension, version 0.2
(II) Loading extension DOUBLE-BUFFER
(II) LoadModule: "ddc"
(II) Loading /usr/X11R6/lib/modules/libddc.a
(II) Module ddc: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 1.0.0
	ABI class: X.Org Video Driver, version 0.7
(II) LoadModule: "dri"
(WW) Warning, couldn't open module dri
(II) UnloadModule: "dri"
(EE) Failed to load module "dri" (module does not exist, 0)
(II) LoadModule: "extmod"
(II) Loading /usr/X11R6/lib/modules/extensions/libextmod.a
(II) Module extmod: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 1.0.0
	Module class: X.Org Server Extension
	ABI class: X.Org Server Extension, version 0.2
(II) Loading extension SHAPE
(II) Loading extension MIT-SUNDRY-NONSTANDARD
(II) Loading extension BIG-REQUESTS
(II) Loading extension SYNC
(II) Loading extension MIT-SCREEN-SAVER
(II) Loading extension XC-MISC
(II) Loading extension XFree86-VidModeExtension
(II) Loading extension XFree86-Misc
(II) Loading extension XFree86-DGA
(II) Loading extension DPMS
(II) Loading extension FontCache
(II) Loading extension TOG-CUP
(II) Loading extension Extended-Visual-Information
(II) Loading extension XVideo
(II) Loading extension XVideo-MotionCompensation
(II) Loading extension X-Resource
(II) LoadModule: "freetype"
(II) Loading /usr/X11R6/lib/modules/fonts/libfreetype.a
(II) Module freetype: vendor="X.Org Foundation & the After X-TT Project"
	compiled for 6.8.2, module version = 2.1.0
	Module class: X.Org Font Renderer
	ABI class: X.Org Font Renderer, version 0.4
(II) Loading font FreeType
(II) LoadModule: "glx"
(II) Loading /usr/X11R6/lib/modules/extensions/libglx.a
(II) Module glx: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 1.0.0
	ABI class: X.Org Server Extension, version 0.2
(II) Loading sub module "GLcore"
(II) LoadModule: "GLcore"
(II) Loading /usr/X11R6/lib/modules/extensions/libGLcore.a
Skipping "/usr/X11R6/lib/modules/extensions/libGLcore.a:m_debug_clip.o":  No symbols found
Skipping "/usr/X11R6/lib/modules/extensions/libGLcore.a:m_debug_norm.o":  No symbols found
Skipping "/usr/X11R6/lib/modules/extensions/libGLcore.a:m_debug_xform.o":  No symbols found
(II) Module GLcore: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 1.0.0
	ABI class: X.Org Server Extension, version 0.2
(II) Loading extension GLX
(II) LoadModule: "int10"
(II) Loading /usr/X11R6/lib/modules/libint10.a
(II) Module int10: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 1.0.0
	ABI class: X.Org Video Driver, version 0.7
(II) LoadModule: "record"
(II) Loading /usr/X11R6/lib/modules/extensions/librecord.a
(II) Module record: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 1.13.0
	Module class: X.Org Server Extension
	ABI class: X.Org Server Extension, version 0.2
(II) Loading extension RECORD
(II) LoadModule: "type1"
(II) Loading /usr/X11R6/lib/modules/fonts/libtype1.a
(II) Module type1: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 1.0.2
	Module class: X.Org Font Renderer
	ABI class: X.Org Font Renderer, version 0.4
(II) Loading font Type1
(II) Loading font CID
(II) LoadModule: "v4l"
(II) Loading /usr/X11R6/lib/modules/drivers/linux/v4l_drv.o
(II) Module v4l: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 0.0.1
	ABI class: X.Org Video Driver, version 0.7
(II) LoadModule: "vbe"
(II) Loading /usr/X11R6/lib/modules/libvbe.a
(II) Module vbe: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 1.1.0
	ABI class: X.Org Video Driver, version 0.7
(II) LoadModule: "fbdev"
(II) Loading /usr/X11R6/lib/modules/drivers/fbdev_drv.o
(II) Module fbdev: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 0.1.0
	ABI class: X.Org Video Driver, version 0.7
(II) LoadModule: "keyboard"
(II) Loading /usr/X11R6/lib/modules/input/keyboard_drv.o
(II) Module keyboard: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 1.0.0
	Module class: X.Org XInput Driver
	ABI class: X.Org XInput driver, version 0.4
(II) LoadModule: "mouse"
(II) Loading /usr/X11R6/lib/modules/input/mouse_drv.o
(II) Module mouse: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 1.0.0
	Module class: X.Org XInput Driver
	ABI class: X.Org XInput driver, version 0.4
(II) v4l driver for Video4Linux
(II) FBDEV: driver for framebuffer: fbdev
(II) Primary Device is: PCI 00:09:0
(II) Loading sub module "fbdevhw"
(II) LoadModule: "fbdevhw"
(II) Loading /usr/X11R6/lib/modules/linux/libfbdevhw.a
(II) Module fbdevhw: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 0.0.2
	ABI class: X.Org Video Driver, version 0.7
(II) resource ranges after xf86ClaimFixedResources() call:
	[0] -1	0	0xffffffff - 0xffffffff (0x1) MX[B]
	[1] -1	0	0x00000000 - 0x00000000 (0x1) MX[B]
	[2] -1	0	0x41000000 - 0x410003ff (0x400) MX[B]
	[3] -1	0	0x00040000 - 0x0004ffff (0x10000) MX[B](B)
	[4] -1	0	0x40000000 - 0x40ffffff (0x1000000) MX[B](B)
	[5] -1	0	0xe0000000 - 0xe0000000 (0x1) MX[B]
	[6] -1	0	0xf4000000 - 0xf4000000 (0x1) MX[B]
	[7] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[8] -1	0	0x00000000 - 0x00000000 (0x1) IX[B]
	[9] -1	0	0x00001080 - 0x0000109f (0x20) IX[B]
	[10] -1	0	0x000010b0 - 0x000010bf (0x10) IX[B]
	[11] -1	0	0x000010a0 - 0x000010af (0x10) IX[B]
	[12] -1	0	0x00000374 - 0x00000374 (0x1) IX[B]
	[13] -1	0	0x000010c8 - 0x000010cf (0x8) IX[B]
	[14] -1	0	0x000003f4 - 0x000003f4 (0x1) IX[B]
	[15] -1	0	0x000010c0 - 0x000010c7 (0x8) IX[B]
	[16] -1	0	0x00001000 - 0x0000107f (0x80) IX[B]
	[17] -1	0	0x0000ff00 - 0x0000ff00 (0x1) IX[B]
(**) FBDEV(0): claimed PCI slot 0:9:0
(II) FBDEV(0): using default device
(II) resource ranges after probing:
	[0] -1	0	0xffffffff - 0xffffffff (0x1) MX[B]
	[1] -1	0	0x00000000 - 0x00000000 (0x1) MX[B]
	[2] -1	0	0x41000000 - 0x410003ff (0x400) MX[B]
	[3] -1	0	0x00040000 - 0x0004ffff (0x10000) MX[B](B)
	[4] -1	0	0x40000000 - 0x40ffffff (0x1000000) MX[B](B)
	[5] -1	0	0xe0000000 - 0xe0000000 (0x1) MX[B]
	[6] -1	0	0xf4000000 - 0xf4000000 (0x1) MX[B]
	[7] 0	0	0x000a0000 - 0x000affff (0x10000) MS[B]
	[8] 0	0	0x000b0000 - 0x000b7fff (0x8000) MS[B]
	[9] 0	0	0x000b8000 - 0x000bffff (0x8000) MS[B]
	[10] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[11] -1	0	0x00000000 - 0x00000000 (0x1) IX[B]
	[12] -1	0	0x00001080 - 0x0000109f (0x20) IX[B]
	[13] -1	0	0x000010b0 - 0x000010bf (0x10) IX[B]
	[14] -1	0	0x000010a0 - 0x000010af (0x10) IX[B]
	[15] -1	0	0x00000374 - 0x00000374 (0x1) IX[B]
	[16] -1	0	0x000010c8 - 0x000010cf (0x8) IX[B]
	[17] -1	0	0x000003f4 - 0x000003f4 (0x1) IX[B]
	[18] -1	0	0x000010c0 - 0x000010c7 (0x8) IX[B]
	[19] -1	0	0x00001000 - 0x0000107f (0x80) IX[B]
	[20] -1	0	0x0000ff00 - 0x0000ff00 (0x1) IX[B]
	[21] 0	0	0x000003b0 - 0x000003bb (0xc) IS[B]
	[22] 0	0	0x000003c0 - 0x000003df (0x20) IS[B]
(II) Setting vga for screen 0.
(**) FBDEV(0): Depth 16, (--) framebuffer bpp 16
(==) FBDEV(0): RGB weight 565
(==) FBDEV(0): Default visual is TrueColor
(==) FBDEV(0): Using gamma correction (1.0, 1.0, 1.0)
(II) FBDEV(0): hardware: CyberPro2010 (video memory: 2048kB)
(II) FBDEV(0): checking modes against framebuffer device...
(II) FBDEV(0): 	mode "1024x768" ok
(II) FBDEV(0): 	mode "" not found
(II) FBDEV(0): 	mode "800x600" ok
(II) FBDEV(0): 	mode "" not found
(II) FBDEV(0): 	mode "640x480" ok
(II) FBDEV(0): checking modes against monitor...
(--) FBDEV(0): Virtual size is 1024x768 (pitch 1024)
(**) FBDEV(0):  Default mode "800x600": 36.0 MHz (scaled from 0.0 MHz), 35.2 kHz, 56.2 Hz
(II) FBDEV(0): Modeline "800x600"   36.00  800 824 896 1024  600 601 603 625 +hsync +vsync
(**) FBDEV(0):  Default mode "640x480": 25.2 MHz (scaled from 0.0 MHz), 31.5 kHz, 60.0 Hz
(II) FBDEV(0): Modeline "640x480"   25.20  640 656 752 800  480 490 492 525 -hsync -vsync
(++) FBDEV(0): DPI set to (100, 100)
(II) Loading sub module "fb"
(II) LoadModule: "fb"
(II) Loading /usr/X11R6/lib/modules/libfb.a
Skipping "/usr/X11R6/lib/modules/libfb.a:fbmmx.o":  No symbols found
(II) Module fb: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 1.0.0
	ABI class: X.Org ANSI C Emulation, version 0.2
(**) FBDEV(0): using shadow framebuffer
(II) Loading sub module "shadow"
(II) LoadModule: "shadow"
(II) Loading /usr/X11R6/lib/modules/libshadow.a
(II) Module shadow: vendor="X.Org Foundation"
	compiled for 6.8.2, module version = 1.0.0
	ABI class: X.Org ANSI C Emulation, version 0.2
(II) do I need RAC?  No, I don't.
(II) resource ranges after preInit:
	[0] 0	0	0x40000000 - 0x40ffffff (0x1000000) MX[B]
	[1] -1	0	0xffffffff - 0xffffffff (0x1) MX[B]
	[2] -1	0	0x00000000 - 0x00000000 (0x1) MX[B]
	[3] -1	0	0x41000000 - 0x410003ff (0x400) MX[B]
	[4] -1	0	0x00040000 - 0x0004ffff (0x10000) MX[B](B)
	[5] -1	0	0x40000000 - 0x40ffffff (0x1000000) MX[B](B)
	[6] -1	0	0xe0000000 - 0xe0000000 (0x1) MX[B]
	[7] -1	0	0xf4000000 - 0xf4000000 (0x1) MX[B]
	[8] 0	0	0x000a0000 - 0x000affff (0x10000) MS[B]
	[9] 0	0	0x000b0000 - 0x000b7fff (0x8000) MS[B]
	[10] 0	0	0x000b8000 - 0x000bffff (0x8000) MS[B]
	[11] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[12] -1	0	0x00000000 - 0x00000000 (0x1) IX[B]
	[13] -1	0	0x00001080 - 0x0000109f (0x20) IX[B]
	[14] -1	0	0x000010b0 - 0x000010bf (0x10) IX[B]
	[15] -1	0	0x000010a0 - 0x000010af (0x10) IX[B]
	[16] -1	0	0x00000374 - 0x00000374 (0x1) IX[B]
	[17] -1	0	0x000010c8 - 0x000010cf (0x8) IX[B]
	[18] -1	0	0x000003f4 - 0x000003f4 (0x1) IX[B]
	[19] -1	0	0x000010c0 - 0x000010c7 (0x8) IX[B]
	[20] -1	0	0x00001000 - 0x0000107f (0x80) IX[B]
	[21] -1	0	0x0000ff00 - 0x0000ff00 (0x1) IX[B]
	[22] 0	0	0x000003b0 - 0x000003bb (0xc) IS[B]
	[23] 0	0	0x000003c0 - 0x000003df (0x20) IS[B]
(==) FBDEV(0): Backing store disabled
(**) Option "dpms"
(**) FBDEV(0): DPMS enabled
(==) RandR enabled
(II) Setting vga for screen 0.
(II) Initializing built-in extension MIT-SHM
(II) Initializing built-in extension XInputExtension
(II) Initializing built-in extension XTEST
(II) Initializing built-in extension XKEYBOARD
(II) Initializing built-in extension LBX
(II) Initializing built-in extension XC-APPGROUP
(II) Initializing built-in extension SECURITY
(II) Initializing built-in extension XINERAMA
(II) Initializing built-in extension XFIXES
(II) Initializing built-in extension XFree86-Bigfont
(II) Initializing built-in extension RENDER
(II) Initializing built-in extension RANDR
(II) Initializing built-in extension COMPOSITE
(II) Initializing built-in extension DAMAGE
(II) Initializing built-in extension XEVIE
(**) Generic Keyboard: Core Keyboard
(**) Option "Protocol" "standard"
(**) Generic Keyboard: Protocol: standard
(**) Option "AutoRepeat" "500 30"
(**) Option "XkbRules" "xorg"
(**) Generic Keyboard: XkbRules: "xorg"
(**) Option "XkbModel" "pc105"
(**) Generic Keyboard: XkbModel: "pc105"
(**) Option "XkbLayout" "gb"
(**) Generic Keyboard: XkbLayout: "gb"
(**) Option "CustomKeycodes" "off"
(**) Generic Keyboard: CustomKeycodes disabled
(**) Option "Protocol" "ImPS/2"
(**) Configured Mouse: Device: "/dev/psaux"
(**) Configured Mouse: Protocol: "ImPS/2"
(**) Option "CorePointer"
(**) Configured Mouse: Core Pointer
(**) Option "Device" "/dev/psaux"
(**) Option "Emulate3Buttons" "true"
(**) Configured Mouse: Emulate3Buttons, Emulate3Timeout: 50
(**) Option "ZAxisMapping" "4 5"
(**) Configured Mouse: ZAxisMapping: buttons 4 and 5
(**) Configured Mouse: Buttons: 5
(II) XINPUT: Adding extended input device "Configured Mouse" (type: MOUSE)
(II) XINPUT: Adding extended input device "Generic Keyboard" (type: KEYBOARD)
(II) Configured Mouse: ps2EnableDataReporting: succeeded
Warning: font renderer for ".pcf" already registered at priority 0
Warning: font renderer for ".pcf.Z" already registered at priority 0
Warning: font renderer for ".pcf.gz" already registered at priority 0
Warning: font renderer for ".snf" already registered at priority 0
Warning: font renderer for ".snf.Z" already registered at priority 0
Warning: font renderer for ".snf.gz" already registered at priority 0
Warning: font renderer for ".bdf" already registered at priority 0
Warning: font renderer for ".bdf.Z" already registered at priority 0
Warning: font renderer for ".bdf.gz" already registered at priority 0
Warning: font renderer for ".pmf" already registered at priority 0

--9jxsPFA5p3P2qPhR--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
