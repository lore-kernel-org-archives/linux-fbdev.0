From: Joel Metelius <jome0008@hotmail.com>
Subject: neofb problem with console mode early in boot and after X is started
Date: 30 Mar 2003 23:53:44 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1049061225.2658.49.camel@joelm.2y.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-Y35iPvPezh3vqgXc/y0h"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from h221n1c1o871.bredband.skanova.com ([213.64.158.221] helo=joelm.2y.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18zkkT-0008M8-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 30 Mar 2003 13:53:53 -0800
Received: from joelm.2y.net (joelm.2y.net [127.0.0.1])
	by joelm.2y.net (8.12.8/8.12.5) with ESMTP id h2ULrjCR003114
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 30 Mar 2003 23:53:45 +0200
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: linux-fbdev-devel@lists.sourceforge.net


--=-Y35iPvPezh3vqgXc/y0h
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Problem appears both in 2.5.66 and when applying the patch fbdev.diff.gz
as of 31/3.

1. The penguin is only green lines.
2. After X is started the console font rendering is currupted and the
letters take up 2 times its width and 2 times its height by only setting
top left pixel in a 2x2 pixel square (the other 3 pixels are black).
This makes the console unusable since the letters and lines are drawn
50% on top of each other.
3. vga=0x305 that works in 2.4 kernel only makes the screen blank and
boot hangs.

More specific:

After GRUB splash only 25% of the screen is used (80x25).
The choose resolution question is displayed (vga=ask).
I press [SPACE] and boot continues.
After a while the resolution is switched to 100% (128x48) and before
entering runlevel 5 the console is OK.
After X (gdm) is started, switching to console mode makes the problem
described above appear.

Sometimes the boot hangs after:

nm256: Mapping port 1 from 0x3f09a0 - 0x3fec00

just before:

Mar 30 22:52:58 joelm kernel: ALSA device list:
Mar 30 22:52:58 joelm kernel:   #0: NeoMagic NM256ZX at 0xf9bf09a0 &
0xfda00000, irq 5

has not appeared with the patch (yet ;)

/joel

---------------
grub.conf

... vga=ask

--------------
HW: Dell latitude CSx 390MB laptop TFT monitor, neomagic NM256ZX

---------------
.config

#
# Graphics support
#
CONFIG_FB=y
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=y
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_HGA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I810 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SIS is not set
CONFIG_FB_NEOMAGIC=y
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_PCI_CONSOLE=y
CONFIG_FONTS=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
# CONFIG_FONT_6x11 is not set
CONFIG_FONT_PEARL_8x8=y
# CONFIG_FONT_ACORN_8x8 is not set
# CONFIG_FONT_MINI_4x6 is not set
# CONFIG_FONT_SUN8x16 is not set
# CONFIG_FONT_SUN12x22 is not set

#
# Logo configuration
#
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y

-----------------



--=-Y35iPvPezh3vqgXc/y0h
Content-Disposition: attachment; filename=messages_neofb.log
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=messages_neofb.log; charset=ISO-8859-1

Mar 30 22:52:56 joelm syslogd 1.4.1: restart.
Mar 30 22:52:56 joelm syslog: syslogd startup succeeded
Mar 30 22:52:57 joelm kernel: klogd 1.4.1, log source =3D /proc/kmsg starte=
d.
Mar 30 22:52:57 joelm kernel: Linux version 2.5.66 (xxx) (gcc version 3.2 2=
0020903 (Red Hat Linux 8.0 3.2-7)) #8 Sun Mar 30 22:44:50 CEST 2003
Mar 30 22:52:57 joelm kernel: Video mode to be used for restore is fffd
Mar 30 22:52:57 joelm kernel: BIOS-provided physical RAM map:
Mar 30 22:52:57 joelm kernel:  BIOS-e820: 0000000000000000 - 000000000009fc=
00 (usable)
Mar 30 22:52:57 joelm kernel:  BIOS-e820: 000000000009fc00 - 00000000000a00=
00 (reserved)
Mar 30 22:52:57 joelm kernel:  BIOS-e820: 00000000000c0000 - 00000000000cc0=
00 (reserved)
Mar 30 22:52:57 joelm kernel:  BIOS-e820: 0000000000100000 - 0000000017fec0=
00 (usable)
Mar 30 22:52:57 joelm kernel:  BIOS-e820: 0000000017fec000 - 0000000017ff00=
00 (reserved)
Mar 30 22:52:57 joelm kernel:  BIOS-e820: 00000000ffe00000 - 00000001000000=
00 (reserved)
Mar 30 22:52:57 joelm kernel: 383MB LOWMEM available.
Mar 30 22:52:57 joelm kernel: On node 0 totalpages: 98284
Mar 30 22:52:57 joelm syslog: klogd startup succeeded
Mar 30 22:52:57 joelm kernel:   DMA zone: 4096 pages, LIFO batch:1
Mar 30 22:52:57 joelm kernel:   Normal zone: 94188 pages, LIFO batch:16
Mar 30 22:52:57 joelm kernel:   HighMem zone: 0 pages, LIFO batch:1
Mar 30 22:52:57 joelm kernel: Dell Latitude with broken BIOS detected. Refu=
sing to enable the local APIC.
Mar 30 22:52:57 joelm kernel: Building zonelist for node : 0
Mar 30 22:52:57 joelm kernel: Kernel command line: ro vga=3Dask single
Mar 30 22:52:57 joelm kernel: Initializing CPU#0
Mar 30 22:52:57 joelm kernel: PID hash table entries: 2048 (order 11: 16384=
 bytes)
Mar 30 22:52:57 joelm kernel: Detected 498.380 MHz processor.
Mar 30 22:52:57 joelm kernel: Console: colour VGA+ 80x25
Mar 30 22:52:57 joelm kernel: Calibrating delay loop... 985.08 BogoMIPS
Mar 30 22:52:57 joelm kernel: Memory: 385460k/393136k available (1886k kern=
el code, 6940k reserved, 632k data, 232k init, 0k highmem)
Mar 30 22:52:57 joelm kernel: Dentry cache hash table entries: 65536 (order=
: 6, 262144 bytes)
Mar 30 22:52:57 joelm kernel: Inode-cache hash table entries: 65536 (order:=
 6, 262144 bytes)
Mar 30 22:52:57 joelm kernel: Mount-cache hash table entries: 512 (order: 0=
, 4096 bytes)
Mar 30 22:52:57 joelm kernel: -> /dev
Mar 30 22:52:57 joelm kernel: -> /dev/console
Mar 30 22:52:57 joelm kernel: -> /root
Mar 30 22:52:57 joelm kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Mar 30 22:52:57 joelm kernel: CPU: L2 cache: 256K
Mar 30 22:52:57 joelm kernel: Intel machine check architecture supported.
Mar 30 22:52:57 joelm kernel: Intel machine check reporting enabled on CPU#=
0.
Mar 30 22:52:57 joelm kernel: CPU: Intel Pentium III (Coppermine) stepping =
01
Mar 30 22:52:57 joelm kernel: Enabling fast FPU save and restore... done.
Mar 30 22:52:57 joelm kernel: Enabling unmasked SIMD FPU exception support.=
.. done.
Mar 30 22:52:57 joelm kernel: Checking 'hlt' instruction... OK.
Mar 30 22:52:57 joelm kernel: POSIX conformance testing by UNIFIX
Mar 30 22:52:57 joelm portmap: portmap startup succeeded
Mar 30 22:52:57 joelm kernel: Linux NET4.0 for Linux 2.4
Mar 30 22:52:57 joelm kernel: Based upon Swansea University Computer Societ=
y NET3.039
Mar 30 22:52:57 joelm kernel: Initializing RT netlink socket
Mar 30 22:52:57 joelm kernel: mtrr: v2.0 (20020519)
Mar 30 22:52:57 joelm kernel: EISA bus registered
Mar 30 22:52:57 joelm kernel: PCI: PCI BIOS revision 2.10 entry at 0xfc0ce,=
 last bus=3D1
Mar 30 22:52:57 joelm kernel: PCI: Using configuration type 1
Mar 30 22:52:57 joelm kernel: BIO: pool of 256 setup, 14Kb (56 bytes/bio)
Mar 30 22:52:57 joelm kernel: biovec pool[0]:   1 bvecs: 256 entries (12 by=
tes)
Mar 30 22:52:57 joelm kernel: biovec pool[1]:   4 bvecs: 256 entries (48 by=
tes)
Mar 30 22:52:57 joelm kernel: biovec pool[2]:  16 bvecs: 256 entries (192 b=
ytes)
Mar 30 22:52:57 joelm kernel: biovec pool[3]:  64 bvecs: 256 entries (768 b=
ytes)
Mar 30 22:52:57 joelm kernel: biovec pool[4]: 128 bvecs: 256 entries (1536 =
bytes)
Mar 30 22:52:57 joelm kernel: biovec pool[5]: 256 bvecs: 256 entries (3072 =
bytes)
Mar 30 22:52:57 joelm kernel: Linux Plug and Play Support v0.95 (c) Adam Be=
lay
Mar 30 22:52:57 joelm kernel: PnPBIOS: Found PnP BIOS installation structur=
e at 0xc00fe2d0
Mar 30 22:52:57 joelm kernel: PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:=
0xe2f4, dseg 0x40
Mar 30 22:52:57 joelm kernel: PnPBIOS: 15 nodes reported by PnP BIOS; 15 re=
corded by driver
Mar 30 22:52:57 joelm kernel: block request queues:
Mar 30 22:52:57 joelm kernel:  128 requests per read queue
Mar 30 22:52:57 joelm nfslock: rpc.statd startup succeeded
Mar 30 22:52:57 joelm kernel:  128 requests per write queue
Mar 30 22:52:57 joelm kernel:  8 requests per batch
Mar 30 22:52:57 joelm kernel:  enter congestion at 15
Mar 30 22:52:57 joelm kernel:  exit congestion at 17
Mar 30 22:52:57 joelm kernel: PCI: Probing PCI hardware
Mar 30 22:52:57 joelm kernel: PCI: Probing PCI hardware (bus 00)
Mar 30 22:52:57 joelm kernel: PCI: Using IRQ router PIIX [8086/7110] at 00:=
07.0
Mar 30 22:52:57 joelm kernel: cpufreq: Intel(R) SpeedStep(TM) for this chip=
set not (yet) available.
Mar 30 22:52:57 joelm kernel: apm: BIOS version 1.2 Flags 0x03 (Driver vers=
ion 1.16ac)
Mar 30 22:52:57 joelm kernel: Enabling SEP on CPU 0
Mar 30 22:52:57 joelm rpc.statd[786]: Version 1.0.1 Starting
Mar 30 22:52:57 joelm kernel: Journalled Block Device driver loaded
Mar 30 22:52:57 joelm keytable: Loading keymap:
Mar 30 22:52:57 joelm kernel: Limiting direct PCI/PCI transfers.
Mar 30 22:52:57 joelm kernel: isapnp: Scanning for PnP cards...
Mar 30 22:52:57 joelm kernel: isapnp: No Plug & Play device found
Mar 30 22:52:57 joelm keytable: ^[[60G
Mar 30 22:52:57 joelm kernel: PCI: Found IRQ 11 for device 01:00.0
Mar 30 22:52:57 joelm keytable:
Mar 30 22:52:57 joelm kernel: neofb: mapped io at d880d000
Mar 30 22:52:57 joelm keytable: Loading system font:
Mar 30 22:52:57 joelm kernel: Autodetected internal display
Mar 30 22:52:57 joelm kernel: Panel is a 1024x768 color TFT display
Mar 30 22:52:57 joelm kernel: neofb: mapped framebuffer at d8a0e000
Mar 30 22:52:57 joelm kernel: neofb v0.4.1: 4096kB VRAM, using 1024x768, 48=
.361kHz, 60Hz
Mar 30 22:52:57 joelm keytable: plus before aring ignored
Mar 30 22:52:58 joelm kernel: fb0: MagicGraph 256ZX frame buffer device
Mar 30 22:52:58 joelm keytable:
Mar 30 22:52:58 joelm kernel: Console: switching to colour frame buffer dev=
ice 128x48
Mar 30 22:52:58 joelm keytable: plus before Aring ignored
Mar 30 22:52:58 joelm kernel: pty: 2048 Unix98 ptys configured
Mar 30 22:52:58 joelm keytable: plus before odiaeresis ignored
Mar 30 22:52:58 joelm kernel: i8k: unable to get SMM BIOS version
Mar 30 22:52:58 joelm keytable: plus before Odiaeresis ignored
Mar 30 22:52:58 joelm kernel: Dell laptop SMM driver v1.13 14/05/2002 Massi=
mo Dal Zotto (dz@debian.org)
Mar 30 22:52:58 joelm keytable: plus before adiaeresis ignored
Mar 30 22:52:58 joelm kernel: Real Time Clock Driver v1.11
Mar 30 22:52:58 joelm keytable: plus before Adiaeresis ignored
Mar 30 22:52:58 joelm kernel: Linux agpgart interface v0.100 (c) Dave Jones
Mar 30 22:52:58 joelm kernel: agpgart: Detected Intel 440BX chipset
Mar 30 22:52:58 joelm rc: Starting keytable:  succeeded
Mar 30 22:52:58 joelm kernel: agpgart: Maximum main memory to use for agp m=
emory: 321M
Mar 30 22:52:58 joelm kernel: agpgart: AGP aperture is 64M @ 0xf4000000
Mar 30 22:52:58 joelm kernel: Floppy drive(s): fd0 is 1.44M
Mar 30 22:52:58 joelm kernel: FDC 0 is a post-1991 82077
Mar 30 22:52:58 joelm kernel: RAMDISK driver initialized: 16 RAM disks of 4=
096K size 1024 blocksize
Mar 30 22:52:58 joelm kernel: Uniform Multi-Platform E-IDE driver Revision:=
 7.00alpha2
Mar 30 22:52:58 joelm kernel: ide: Assuming 33MHz system bus speed for PIO =
modes; override with idebus=3Dxx
Mar 30 22:52:58 joelm kernel: PIIX4: IDE controller at PCI slot 00:07.1
Mar 30 22:52:58 joelm random: Initializing random number generator:  succee=
ded
Mar 30 22:52:58 joelm kernel: PIIX4: chipset revision 1
Mar 30 22:52:58 joelm kernel: PIIX4: not 100%% native mode: will probe irqs=
 later
Mar 30 22:52:58 joelm kernel:     ide0: BM-DMA at 0x0860-0x0867, BIOS setti=
ngs: hda:DMA, hdb:pio
Mar 30 22:52:58 joelm kernel: hda: IBM-DJSA-210, ATA DISK drive
Mar 30 22:52:58 joelm kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Mar 30 22:52:58 joelm kernel: hda: host protected area =3D> 1
Mar 30 22:52:58 joelm kernel: hda: 19640880 sectors (10056 MB) w/384KiB Cac=
he, CHS=3D19485/16/63, UDMA(33)
Mar 30 22:52:58 joelm kernel:  hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hd=
a8 >
Mar 30 22:52:58 joelm kernel: ide-floppy driver 0.99.newide
Mar 30 22:52:58 joelm kernel: Console: switching to colour frame buffer dev=
ice 128x48
Mar 30 22:52:58 joelm kernel: mice: PS/2 mouse device common for all mice
Mar 30 22:52:58 joelm kernel: input: ImExPS/2 Generic Explorer Mouse on isa=
0060/serio1
Mar 30 22:52:58 joelm kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Mar 30 22:52:58 joelm kernel: input: AT Set 2 keyboard on isa0060/serio0
Mar 30 22:52:58 joelm kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Mar 30 22:52:58 joelm kernel: EISA: Probing bus 0 at Virtual EISA Bridge
Mar 30 22:52:58 joelm kernel: EISA: Detected 0 cards.
Mar 30 22:52:58 joelm kernel: Advanced Linux Sound Architecture Driver Vers=
ion 0.9.2 (Thu Mar 20 13:31:57 2003 UTC).
Mar 30 22:52:58 joelm kernel: PCI: Found IRQ 5 for device 01:00.1
Mar 30 22:52:58 joelm kernel: nm256: found card signature in video RAM: 0x3=
fec00
Mar 30 22:52:58 joelm kernel: nm256: Mapping port 1 from 0x3f09a0 - 0x3fec0=
0
Mar 30 22:52:58 joelm kernel: ALSA device list:
Mar 30 22:52:58 joelm kernel:   #0: NeoMagic NM256ZX at 0xf9bf09a0 & 0xfda0=
0000, irq 5

--=-Y35iPvPezh3vqgXc/y0h
Content-Disposition: attachment; filename=XF86Config
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=XF86Config; charset=ISO-8859-1

# File generated by anaconda.

Section "ServerLayout"
#	InputDevice    "Mouse1" "SendCoreEvents"
#	InputDevice    "Mouse1" "CorePointer"
	Identifier     "Anaconda Configured"
	Screen      0  "Screen0" 0 0
	InputDevice    "A4tech" "CorePointer"
	InputDevice    "Keyboard0" "CoreKeyboard"
EndSection

Section "Files"
# The location of the RGB database.  Note, this is the name of the
# file minus the extension (like ".txt" or ".db").  There is normally
# no need to change the default.
# Multiple FontPath entries are allowed (they are concatenated together)
# By default, Red Hat 6.0 and later now use a font server independent of
# the X server to render fonts.
	RgbPath      "/usr/X11R6/lib/X11/rgb"
	FontPath     "unix/:7100"
EndSection

Section "Module"
	Load  "dbe"
	Load  "extmod"
	Load  "fbdevhw"
	Load  "dri"
	Load  "glx"
	Load  "record"
	Load  "freetype"
	Load  "type1"
EndSection

Section "InputDevice"
#	Option	"AutoRepeat"	"500 5"
# when using XQUEUE, comment out the above line, and uncomment the
# following line
#	Option	"Protocol"	"Xqueue"
# Specify which keyboard LEDs can be user-controlled (eg, with xset(1))
#	Option	"Xleds"		"1 2 3"
# To disable the XKEYBOARD extension, uncomment XkbDisable.
#	Option	"XkbDisable"
# To customise the XKB settings to suit your keyboard, modify the
# lines below (which are the defaults).  For example, for a non-U.S.
# keyboard, you will probably want to use:
#	Option	"XkbModel"	"pc102"
# If you have a US Microsoft Natural keyboard, you can use:
#	Option	"XkbModel"	"microsoft"
#
# Then to change the language, change the Layout setting.
# For example, a german layout can be obtained with:
#	Option	"XkbLayout"	"de"
# or:
#	Option	"XkbLayout"	"de"
#	Option	"XkbVariant"	"nodeadkeys"
#
# If you'd like to switch the positions of your capslock and
# control keys, use:
#	Option	"XkbOptions"	"ctrl:swapcaps"
	#Option	"XkbOptions"	""
	Identifier  "Keyboard0"
	Driver      "keyboard"
	Option	    "XkbRules" "xfree86"
	Option	    "XkbModel" "pc102"
	Option	    "XkbLayout" "se"	#Option	"XkbVariant"	""
EndSection

Section "InputDevice"
	# Modified by mouseconfig
	# Modified by mouseconfig
	Identifier  "A4tech"
	Driver      "mouse"
	Option	    "Device" "/dev/mouse"
	Option	    "Protocol" "IMPS/2"
	Option	    "Buttons" "8"
	Option	    "Emulate3Buttons" "no"
	Option	    "ZAxisMapping" "4 5 6 7"
EndSection

Section "InputDevice"
	Identifier  "Mouse1"
	Driver      "mouse"
	Option	    "Device" "/dev/input/mice"
	Option	    "Protocol" "IMPS/2"
	Option	    "Emulate3Buttons" "no"
	Option	    "ZAxisMapping" "4 5"
EndSection

Section "Monitor"
	Identifier   "Monitor0"
	VendorName   "Monitor Vendor"
	ModelName    "Sony CPD-200ES"
	HorizSync    30.0 - 70.0
	VertRefresh  50.0 - 120.0
	Option	    "dpms"
EndSection

Section "Device"
#   Option     "Rotate"
#   Option     "pciBurst"
#   Option     "ShadowFB"
#   Option     "NoStretch"
#   Option     "LcdCenter"
        #BusID
	Identifier  "NeoMagic 256 (laptop/notebook)"
	Driver      "neomagic"
	VendorName  "NeoMagic 256 (laptop/notebook)"
	BoardName   "NeoMagic 256 (laptop/notebook)"
        Option      "internDisp"
        Option      "XaaNoScanlineImageWriteRect"
        Option      "XaaNoScanlineCPUToScreenColorExpandFill"
	Option	    "externDisp"
	Option	    "SWcursor"
EndSection

Section "Screen"
	SubSection "Display"
		Depth     24
		Modes    "1024x768" "800x600" "640x480"
	EndSubSection
	Identifier "Screen0"
	Device     "NeoMagic 256 (laptop/notebook)"
	Monitor    "Monitor0"
	DefaultDepth     16
	SubSection "Display"
		Depth     16
		Modes     "1280x1024" "1152x864" "1024x768" "800x600"
	EndSubSection
EndSection

Section "DRI"
	Mode         0666
EndSection


--=-Y35iPvPezh3vqgXc/y0h--



-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
