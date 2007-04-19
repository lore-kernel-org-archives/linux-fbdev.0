From: =?iso-8859-1?q?Hans-J=FCrgen_Koch?= <hjk@linutronix.de>
Subject: Re: [Linux-fbdev-devel] Radeon X300, radeonfb, dual head
Date: Thu, 19 Apr 2007 09:00:50 +0200
Message-ID: <200704190900.51234.hjk@linutronix.de>
References: <200704181409.51475.hjk@linutronix.de>
	<200704182320.46917.hjk@linutronix.de>
	<a728f9f90704181445x95f493bj2ab639394bc22139@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <xorg-bounces@lists.freedesktop.org>
In-Reply-To: <a728f9f90704181445x95f493bj2ab639394bc22139@mail.gmail.com>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/xorg>
List-Post: <mailto:xorg@lists.freedesktop.org>
List-Help: <mailto:xorg-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=subscribe>
Sender: xorg-bounces@lists.freedesktop.org
Errors-To: xorg-bounces@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
To: xorg@lists.freedesktop.org
Cc: linux-fbdev-devel@lists.sourceforge.net

Am Mittwoch, 18. April 2007 23:45 schrieb Alex Deucher:

> 
> Can you post your full Xorg log and the config you are using?  

See below.

> Also 
> what release of the Xserver and radeon driver are you using?
>

Both are the latest Debian sid packages. More version information is
included in Xorg.0.log below.

Here's my xorg.conf:

=========================================================================

# /etc/X11/xorg.conf (xorg X Window System server configuration file)
#

Section "Files"
	FontPath	"unix/:7100"	# local font server
	FontPath	"unix/:7101"	# local ttf-font server
	# path to defoma fonts
	FontPath	"/var/lib/defoma/x-ttcidfont-conf.d/dirs/TrueType"
EndSection

Section "Module"
	Load	"i2c"
	Load	"bitmap"
	Load	"ddc"
	Load	"dri"
	Load	"extmod"
	Load	"freetype"
	Load	"glx"
	Load	"type1"
	Load	"vbe"
EndSection

Section "InputDevice"
	Identifier	"Generic Keyboard"
	Driver		"kbd"
	Option		"CoreKeyboard"
	Option		"XkbRules"	"xorg"
	Option		"XkbModel"	"pc105"
	Option		"XkbLayout"	"de"
	Option		"XkbVariant"	"nodeadkeys"
EndSection

Section "InputDevice"
	Identifier	"Configured Mouse"
	Driver		"mouse"
	Option		"CorePointer"
	Option		"Device"		"/dev/input/mice"
	Option		"Protocol"		"ExplorerPS/2"
	Option		"Emulate3Buttons"	"true"
EndSection

Section "Device"
	Identifier	"RadeonX300"
	Driver		"radeon"
	BusID		"PCI:1:0:0"
	Option		"MergedFB" "true"
	#Option		"MergedXinerama" "false"
	Option		"MergedXineramaCRT2IsScreen0" "true"
	Option		"MonitorLayout" "CRT,CRT"
	Option		"CRT2Position" "RightOf"
	Option		"CRT2HSync" "32-82"
	Option		"CRT2VRefresh" "56-75"
	Option		"MetaModes" "1680x1050-1680x1050"
EndSection

Section "Monitor"
	Identifier	"NECMonitor1"
	Option		"DPMS"
	HorizSync	32-82
	VertRefresh	56-75
	#Modeline "1680x1050@60" 154.20 1680 1712 2296 2328 1050 1071 1081 1103
EndSection

Section "Monitor"
	Identifier	"NECMonitor2"
	Option		"DPMS"
	HorizSync	32-82
	VertRefresh	56-75
	#Modeline "1680x1050@60" 154.20 1680 1712 2296 2328 1050 1071 1081 1103
EndSection

Section "Screen"
	Identifier	"Screen1"
	Device		"RadeonX300"
	Monitor		"NECMonitor1"
	DefaultDepth	24
	SubSection "Display"
		Depth		16
		Modes		"1680x1050" 
	EndSubSection
	SubSection "Display"
		Depth		24
		Modes		"1680x1050" 
	EndSubSection
EndSection

Section "ServerLayout"
	Identifier	"Default Layout"
	Screen		"Screen1" 0 0
	InputDevice	"Generic Keyboard"
	InputDevice	"Configured Mouse"
EndSection

Section "DRI"
	Group	0
	Mode	0666
EndSection

#Section "Extensions"
#	Option	"Composite"	"Enable"
#EndSection

=========================================================================
And this is the Xorg.0.log:
=========================================================================


X Window System Version 7.1.1
Release Date: 12 May 2006
X Protocol Version 11, Revision 0, Release 7.1.1
Build Operating System: UNKNOWN 
Current Operating System: Linux dilbert 2.6.21-rc7 #10 SMP PREEMPT Wed Apr 18 21:43:22 CEST 2007 i686
Build Date: 04 April 2007
	Before reporting problems, check http://wiki.x.org
	to make sure that you have the latest version.
Module Loader present
Markers: (--) probed, (**) from config file, (==) default setting,
	(++) from command line, (!!) notice, (II) informational,
	(WW) warning, (EE) error, (NI) not implemented, (??) unknown.
(==) Log file: "/var/log/Xorg.0.log", Time: Wed Apr 18 21:48:18 2007
(==) Using config file: "/etc/X11/xorg.conf"
(==) ServerLayout "Default Layout"
(**) |-->Screen "Screen1" (0)
(**) |   |-->Monitor "NECMonitor1"
(**) |   |-->Device "RadeonX300"
(**) |-->Input Device "Generic Keyboard"
(**) |-->Input Device "Configured Mouse"
(WW) The directory "/var/lib/defoma/x-ttcidfont-conf.d/dirs/TrueType" does not exist.
	Entry deleted from font path.
(**) FontPath set to:
	unix/:7100,
	unix/:7101
(==) RgbPath set to "/etc/X11/rgb"
(==) ModulePath set to "/usr/lib/xorg/modules"
(II) Open ACPI successful (/var/run/acpid.socket)
(II) Module ABI versions:
	X.Org ANSI C Emulation: 0.3
	X.Org Video Driver: 1.0
	X.Org XInput driver : 0.6
	X.Org Server Extension : 0.3
	X.Org Font Renderer : 0.5
(II) Loader running on linux
(II) LoadModule: "bitmap"
(II) Loading /usr/lib/xorg/modules/fonts/libbitmap.so
(II) Module bitmap: vendor="X.Org Foundation"
	compiled for 7.1.1, module version = 1.0.0
	Module class: X.Org Font Renderer
	ABI class: X.Org Font Renderer, version 0.5
(II) Loading font Bitmap
(II) LoadModule: "pcidata"
(II) Loading /usr/lib/xorg/modules/libpcidata.so
(II) Module pcidata: vendor="X.Org Foundation"
	compiled for 7.1.1, module version = 1.0.0
	ABI class: X.Org Video Driver, version 1.0
(++) using VT number 7

(II) PCI: PCI scan (all values are in hex)
(II) PCI: 00:00:0: chip 8086,29a0 card 8086,514d rev 02 class 06,00,00 hdr 00
(II) PCI: 00:01:0: chip 8086,29a1 card 0000,0000 rev 02 class 06,04,00 hdr 01
(II) PCI: 00:03:0: chip 8086,29a4 card 8086,514d rev 02 class 07,80,00 hdr 80
(II) PCI: 00:19:0: chip 8086,104b card 8086,0001 rev 02 class 02,00,00 hdr 00
(II) PCI: 00:1a:0: chip 8086,2834 card 8086,514d rev 02 class 0c,03,00 hdr 80
(II) PCI: 00:1a:1: chip 8086,2835 card 8086,514d rev 02 class 0c,03,00 hdr 00
(II) PCI: 00:1a:7: chip 8086,283a card 8086,514d rev 02 class 0c,03,20 hdr 00
(II) PCI: 00:1b:0: chip 8086,284b card 8086,2114 rev 02 class 04,03,00 hdr 00
(II) PCI: 00:1c:0: chip 8086,283f card 0000,0000 rev 02 class 06,04,00 hdr 81
(II) PCI: 00:1c:1: chip 8086,2841 card 0000,0000 rev 02 class 06,04,00 hdr 81
(II) PCI: 00:1c:2: chip 8086,2843 card 0000,0000 rev 02 class 06,04,00 hdr 81
(II) PCI: 00:1c:3: chip 8086,2845 card 0000,0000 rev 02 class 06,04,00 hdr 81
(II) PCI: 00:1c:4: chip 8086,2847 card 0000,0000 rev 02 class 06,04,00 hdr 81
(II) PCI: 00:1d:0: chip 8086,2830 card 8086,514d rev 02 class 0c,03,00 hdr 80
(II) PCI: 00:1d:1: chip 8086,2831 card 8086,514d rev 02 class 0c,03,00 hdr 00
(II) PCI: 00:1d:2: chip 8086,2832 card 8086,514d rev 02 class 0c,03,00 hdr 00
(II) PCI: 00:1d:7: chip 8086,2836 card 8086,514d rev 02 class 0c,03,20 hdr 00
(II) PCI: 00:1e:0: chip 8086,244e card 0000,0000 rev f2 class 06,04,01 hdr 01
(II) PCI: 00:1f:0: chip 8086,2810 card 8086,514d rev 02 class 06,01,00 hdr 80
(II) PCI: 00:1f:2: chip 8086,2824 card 8086,514d rev 02 class 01,06,01 hdr 00
(II) PCI: 00:1f:3: chip 8086,283e card 8086,514d rev 02 class 0c,05,00 hdr 00
(II) PCI: 01:00:0: chip 1002,5b60 card 1462,0320 rev 00 class 03,00,00 hdr 80
(II) PCI: 01:00:1: chip 1002,5b70 card 1462,0321 rev 00 class 03,80,00 hdr 00
(II) PCI: 03:00:0: chip 11ab,6101 card 11ab,6101 rev b1 class 01,01,8f hdr 00
(II) PCI: 07:00:0: chip 4444,0016 card 0070,8003 rev 01 class 04,00,00 hdr 00
(II) PCI: 07:03:0: chip 104c,8023 card 8086,514d rev 00 class 0c,00,10 hdr 00
(II) PCI: End of PCI scan
(II) Intel Bridge workaround enabled
(II) Host-to-PCI bridge:
(II) Bus 0: bridge is at (0:0:0), (0,0,7), BCTRL: 0x0008 (VGA_EN is set)
(II) Bus 0 I/O range:
	[0] -1	0	0x00000000 - 0x0000ffff (0x10000) IX[B]
(II) Bus 0 non-prefetchable memory range:
	[0] -1	0	0x00000000 - 0xffffffff (0x0) MX[B]
(II) Bus 0 prefetchable memory range:
	[0] -1	0	0x00000000 - 0xffffffff (0x0) MX[B]
(II) PCI-to-PCI bridge:
(II) Bus 1: bridge is at (0:1:0), (0,1,1), BCTRL: 0x0018 (VGA_EN is set)
(II) Bus 1 I/O range:
	[0] -1	0	0x00002000 - 0x00002fff (0x1000) IX[B]
(II) Bus 1 non-prefetchable memory range:
	[0] -1	0	0x4c200000 - 0x4c2fffff (0x100000) MX[B]
(II) Bus 1 prefetchable memory range:
	[0] -1	0	0x40000000 - 0x47ffffff (0x8000000) MX[B]
(II) PCI-to-PCI bridge:
(II) Bus 2: bridge is at (0:28:0), (0,2,2), BCTRL: 0x0004 (VGA_EN is cleared)
(II) Bus 2 non-prefetchable memory range:
	[0] -1	0	0x4c400000 - 0x4c4fffff (0x100000) MX[B]
(II) PCI-to-PCI bridge:
(II) Bus 3: bridge is at (0:28:1), (0,3,3), BCTRL: 0x0004 (VGA_EN is cleared)
(II) Bus 3 I/O range:
	[0] -1	0	0x00001000 - 0x000010ff (0x100) IX[B]
	[1] -1	0	0x00001400 - 0x000014ff (0x100) IX[B]
	[2] -1	0	0x00001800 - 0x000018ff (0x100) IX[B]
	[3] -1	0	0x00001c00 - 0x00001cff (0x100) IX[B]
(II) Bus 3 non-prefetchable memory range:
	[0] -1	0	0x4c100000 - 0x4c1fffff (0x100000) MX[B]
(II) PCI-to-PCI bridge:
(II) Bus 4: bridge is at (0:28:2), (0,4,4), BCTRL: 0x0004 (VGA_EN is cleared)
(II) Bus 4 non-prefetchable memory range:
	[0] -1	0	0x4c500000 - 0x4c5fffff (0x100000) MX[B]
(II) PCI-to-PCI bridge:
(II) Bus 5: bridge is at (0:28:3), (0,5,5), BCTRL: 0x0004 (VGA_EN is cleared)
(II) Bus 5 non-prefetchable memory range:
	[0] -1	0	0x4c600000 - 0x4c6fffff (0x100000) MX[B]
(II) PCI-to-PCI bridge:
(II) Bus 6: bridge is at (0:28:4), (0,6,6), BCTRL: 0x0004 (VGA_EN is cleared)
(II) Bus 6 non-prefetchable memory range:
	[0] -1	0	0x4c700000 - 0x4c7fffff (0x100000) MX[B]
(II) Subtractive PCI-to-PCI bridge:
(II) Bus 7: bridge is at (0:30:0), (0,7,7), BCTRL: 0x0004 (VGA_EN is cleared)
(II) Bus 7 non-prefetchable memory range:
	[0] -1	0	0x4c000000 - 0x4c0fffff (0x100000) MX[B]
(II) Bus 7 prefetchable memory range:
	[0] -1	0	0x48000000 - 0x4bffffff (0x4000000) MX[B]
(II) PCI-to-ISA bridge:
(II) Bus -1: bridge is at (0:31:0), (0,-1,-1), BCTRL: 0x0008 (VGA_EN is set)
(--) PCI:*(1:0:0) ATI Technologies Inc RV370 5B60 [Radeon X300 (PCIE)] rev 0, Mem @ 0x40000000/27, 0x4c210000/16, I/O @ 0x2000/8, BIOS @ 0x50000000/17
(--) PCI: (1:0:1) ATI Technologies Inc RV370 [Radeon X300SE] rev 0, Mem @ 0x4c200000/16
(--) PCI: (7:0:0) unknown vendor (0x4444) unknown chipset (0x0016) rev 1, Mem @ 0x48000000/26
(II) Addressable bus resource ranges are
	[0] -1	0	0x00000000 - 0xffffffff (0x0) MX[B]
	[1] -1	0	0x00000000 - 0x0000ffff (0x10000) IX[B]
(II) OS-reported resource ranges:
	[0] -1	0	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[1] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[2] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[3] -1	0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[4] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[5] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
(II) Active PCI resource ranges:
	[0] -1	0	0x4c000000 - 0x4c003fff (0x4000) MX[B]
	[1] -1	0	0x4c004000 - 0x4c0047ff (0x800) MX[B]
	[2] -1	0	0x4c100000 - 0x4c1001ff (0x200) MX[B]
	[3] -1	0	0x4c326000 - 0x4c3260ff (0x100) MX[B]
	[4] -1	0	0x4c325000 - 0x4c3257ff (0x800) MX[B]
	[5] -1	0	0x4c325800 - 0x4c325bff (0x400) MX[B]
	[6] -1	0	0x4c320000 - 0x4c323fff (0x4000) MX[B]
	[7] -1	0	0x4c325c00 - 0x4c325fff (0x400) MX[B]
	[8] -1	0	0x4c324000 - 0x4c324fff (0x1000) MX[B]
	[9] -1	0	0x4c300000 - 0x4c31ffff (0x20000) MX[B]
	[10] -1	0	0x4c326100 - 0x4c32610f (0x10) MX[B]
	[11] -1	0	0x48000000 - 0x4bffffff (0x4000000) MX[B](B)
	[12] -1	0	0x4c200000 - 0x4c20ffff (0x10000) MX[B](B)
	[13] -1	0	0x4c220000 - 0x4c23ffff (0x20000) MX[B](B)
	[14] -1	0	0x4c210000 - 0x4c21ffff (0x10000) MX[B](B)
	[15] -1	0	0x40000000 - 0x47ffffff (0x8000000) MX[B](B)
	[16] -1	0	0x00001000 - 0x0000100f (0x10) IX[B]
	[17] -1	0	0x00001020 - 0x00001023 (0x4) IX[B]
	[18] -1	0	0x00001010 - 0x00001017 (0x8) IX[B]
	[19] -1	0	0x00001024 - 0x00001027 (0x4) IX[B]
	[20] -1	0	0x00001018 - 0x0000101f (0x8) IX[B]
	[21] -1	0	0x00003000 - 0x0000301f (0x20) IX[B]
	[22] -1	0	0x00003020 - 0x0000303f (0x20) IX[B]
	[23] -1	0	0x00003110 - 0x00003113 (0x4) IX[B]
	[24] -1	0	0x00003100 - 0x00003107 (0x8) IX[B]
	[25] -1	0	0x00003114 - 0x00003117 (0x4) IX[B]
	[26] -1	0	0x00003108 - 0x0000310f (0x8) IX[B]
	[27] -1	0	0x00003040 - 0x0000305f (0x20) IX[B]
	[28] -1	0	0x00003060 - 0x0000307f (0x20) IX[B]
	[29] -1	0	0x00003080 - 0x0000309f (0x20) IX[B]
	[30] -1	0	0x000030a0 - 0x000030bf (0x20) IX[B]
	[31] -1	0	0x000030c0 - 0x000030df (0x20) IX[B]
	[32] -1	0	0x000030e0 - 0x000030ff (0x20) IX[B]
	[33] -1	0	0x00002000 - 0x000020ff (0x100) IX[B](B)
(II) Active PCI resource ranges after removing overlaps:
	[0] -1	0	0x4c000000 - 0x4c003fff (0x4000) MX[B]
	[1] -1	0	0x4c004000 - 0x4c0047ff (0x800) MX[B]
	[2] -1	0	0x4c100000 - 0x4c1001ff (0x200) MX[B]
	[3] -1	0	0x4c326000 - 0x4c3260ff (0x100) MX[B]
	[4] -1	0	0x4c325000 - 0x4c3257ff (0x800) MX[B]
	[5] -1	0	0x4c325800 - 0x4c325bff (0x400) MX[B]
	[6] -1	0	0x4c320000 - 0x4c323fff (0x4000) MX[B]
	[7] -1	0	0x4c325c00 - 0x4c325fff (0x400) MX[B]
	[8] -1	0	0x4c324000 - 0x4c324fff (0x1000) MX[B]
	[9] -1	0	0x4c300000 - 0x4c31ffff (0x20000) MX[B]
	[10] -1	0	0x4c326100 - 0x4c32610f (0x10) MX[B]
	[11] -1	0	0x48000000 - 0x4bffffff (0x4000000) MX[B](B)
	[12] -1	0	0x4c200000 - 0x4c20ffff (0x10000) MX[B](B)
	[13] -1	0	0x4c220000 - 0x4c23ffff (0x20000) MX[B](B)
	[14] -1	0	0x4c210000 - 0x4c21ffff (0x10000) MX[B](B)
	[15] -1	0	0x40000000 - 0x47ffffff (0x8000000) MX[B](B)
	[16] -1	0	0x00001000 - 0x0000100f (0x10) IX[B]
	[17] -1	0	0x00001020 - 0x00001023 (0x4) IX[B]
	[18] -1	0	0x00001010 - 0x00001017 (0x8) IX[B]
	[19] -1	0	0x00001024 - 0x00001027 (0x4) IX[B]
	[20] -1	0	0x00001018 - 0x0000101f (0x8) IX[B]
	[21] -1	0	0x00003000 - 0x0000301f (0x20) IX[B]
	[22] -1	0	0x00003020 - 0x0000303f (0x20) IX[B]
	[23] -1	0	0x00003110 - 0x00003113 (0x4) IX[B]
	[24] -1	0	0x00003100 - 0x00003107 (0x8) IX[B]
	[25] -1	0	0x00003114 - 0x00003117 (0x4) IX[B]
	[26] -1	0	0x00003108 - 0x0000310f (0x8) IX[B]
	[27] -1	0	0x00003040 - 0x0000305f (0x20) IX[B]
	[28] -1	0	0x00003060 - 0x0000307f (0x20) IX[B]
	[29] -1	0	0x00003080 - 0x0000309f (0x20) IX[B]
	[30] -1	0	0x000030a0 - 0x000030bf (0x20) IX[B]
	[31] -1	0	0x000030c0 - 0x000030df (0x20) IX[B]
	[32] -1	0	0x000030e0 - 0x000030ff (0x20) IX[B]
	[33] -1	0	0x00002000 - 0x000020ff (0x100) IX[B](B)
(II) OS-reported resource ranges after removing overlaps with PCI:
	[0] -1	0	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[1] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[2] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[3] -1	0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[4] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[5] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
(II) All system resource ranges:
	[0] -1	0	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[1] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[2] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[3] -1	0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[4] -1	0	0x4c000000 - 0x4c003fff (0x4000) MX[B]
	[5] -1	0	0x4c004000 - 0x4c0047ff (0x800) MX[B]
	[6] -1	0	0x4c100000 - 0x4c1001ff (0x200) MX[B]
	[7] -1	0	0x4c326000 - 0x4c3260ff (0x100) MX[B]
	[8] -1	0	0x4c325000 - 0x4c3257ff (0x800) MX[B]
	[9] -1	0	0x4c325800 - 0x4c325bff (0x400) MX[B]
	[10] -1	0	0x4c320000 - 0x4c323fff (0x4000) MX[B]
	[11] -1	0	0x4c325c00 - 0x4c325fff (0x400) MX[B]
	[12] -1	0	0x4c324000 - 0x4c324fff (0x1000) MX[B]
	[13] -1	0	0x4c300000 - 0x4c31ffff (0x20000) MX[B]
	[14] -1	0	0x4c326100 - 0x4c32610f (0x10) MX[B]
	[15] -1	0	0x48000000 - 0x4bffffff (0x4000000) MX[B](B)
	[16] -1	0	0x4c200000 - 0x4c20ffff (0x10000) MX[B](B)
	[17] -1	0	0x4c220000 - 0x4c23ffff (0x20000) MX[B](B)
	[18] -1	0	0x4c210000 - 0x4c21ffff (0x10000) MX[B](B)
	[19] -1	0	0x40000000 - 0x47ffffff (0x8000000) MX[B](B)
	[20] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[21] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
	[22] -1	0	0x00001000 - 0x0000100f (0x10) IX[B]
	[23] -1	0	0x00001020 - 0x00001023 (0x4) IX[B]
	[24] -1	0	0x00001010 - 0x00001017 (0x8) IX[B]
	[25] -1	0	0x00001024 - 0x00001027 (0x4) IX[B]
	[26] -1	0	0x00001018 - 0x0000101f (0x8) IX[B]
	[27] -1	0	0x00003000 - 0x0000301f (0x20) IX[B]
	[28] -1	0	0x00003020 - 0x0000303f (0x20) IX[B]
	[29] -1	0	0x00003110 - 0x00003113 (0x4) IX[B]
	[30] -1	0	0x00003100 - 0x00003107 (0x8) IX[B]
	[31] -1	0	0x00003114 - 0x00003117 (0x4) IX[B]
	[32] -1	0	0x00003108 - 0x0000310f (0x8) IX[B]
	[33] -1	0	0x00003040 - 0x0000305f (0x20) IX[B]
	[34] -1	0	0x00003060 - 0x0000307f (0x20) IX[B]
	[35] -1	0	0x00003080 - 0x0000309f (0x20) IX[B]
	[36] -1	0	0x000030a0 - 0x000030bf (0x20) IX[B]
	[37] -1	0	0x000030c0 - 0x000030df (0x20) IX[B]
	[38] -1	0	0x000030e0 - 0x000030ff (0x20) IX[B]
	[39] -1	0	0x00002000 - 0x000020ff (0x100) IX[B](B)
(II) LoadModule: "i2c"
(II) Loading /usr/lib/xorg/modules/libi2c.so
(II) Module i2c: vendor="X.Org Foundation"
	compiled for 7.1.1, module version = 1.2.0
	ABI class: X.Org Video Driver, version 1.0
(II) LoadModule: "bitmap"
(II) Reloading /usr/lib/xorg/modules/fonts/libbitmap.so
(II) Loading font Bitmap
(II) LoadModule: "ddc"
(II) Loading /usr/lib/xorg/modules/libddc.so
(II) Module ddc: vendor="X.Org Foundation"
	compiled for 7.1.1, module version = 1.0.0
	ABI class: X.Org Video Driver, version 1.0
(II) LoadModule: "dri"
(II) Loading /usr/lib/xorg/modules/extensions/libdri.so
(II) Module dri: vendor="X.Org Foundation"
	compiled for 7.1.1, module version = 1.0.0
	ABI class: X.Org Server Extension, version 0.3
(II) Loading sub module "drm"
(II) LoadModule: "drm"
(II) Loading /usr/lib/xorg/modules/linux/libdrm.so
(II) Module drm: vendor="X.Org Foundation"
	compiled for 7.1.1, module version = 1.0.0
	ABI class: X.Org Server Extension, version 0.3
(II) Loading extension XFree86-DRI
(II) LoadModule: "extmod"
(II) Loading /usr/lib/xorg/modules/extensions/libextmod.so
(II) Module extmod: vendor="X.Org Foundation"
	compiled for 7.1.1, module version = 1.0.0
	Module class: X.Org Server Extension
	ABI class: X.Org Server Extension, version 0.3
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
(II) Loading extension TOG-CUP
(II) Loading extension Extended-Visual-Information
(II) Loading extension XVideo
(II) Loading extension XVideo-MotionCompensation
(II) Loading extension X-Resource
(II) LoadModule: "freetype"
(II) Loading /usr/lib/xorg/modules/fonts/libfreetype.so
(II) Module freetype: vendor="X.Org Foundation & the After X-TT Project"
	compiled for 7.1.1, module version = 2.1.0
	Module class: X.Org Font Renderer
	ABI class: X.Org Font Renderer, version 0.5
(II) Loading font FreeType
(II) LoadModule: "glx"
(II) Loading /usr/lib/xorg/modules/extensions/libglx.so
(II) Module glx: vendor="X.Org Foundation"
	compiled for 7.1.1, module version = 1.0.0
	ABI class: X.Org Server Extension, version 0.3
(==) AIGLX enabled
(II) Loading extension GLX
(II) LoadModule: "type1"
(II) Loading /usr/lib/xorg/modules/fonts/libtype1.so
(II) Module type1: vendor="X.Org Foundation"
	compiled for 7.1.1, module version = 1.0.2
	Module class: X.Org Font Renderer
	ABI class: X.Org Font Renderer, version 0.5
(II) Loading font Type1
(II) LoadModule: "vbe"
(II) Loading /usr/lib/xorg/modules/libvbe.so
(II) Module vbe: vendor="X.Org Foundation"
	compiled for 7.1.1, module version = 1.1.0
	ABI class: X.Org Video Driver, version 1.0
(II) LoadModule: "radeon"
(II) Loading /usr/lib/xorg/modules/drivers/radeon_drv.so
(II) Module radeon: vendor="X.Org Foundation"
	compiled for 7.1.1, module version = 4.2.0
	Module class: X.Org Video Driver
	ABI class: X.Org Video Driver, version 1.0
(II) LoadModule: "ati"
(II) Loading /usr/lib/xorg/modules/drivers/ati_drv.so
(II) Module ati: vendor="X.Org Foundation"
	compiled for 7.1.1, module version = 6.6.3
	Module class: X.Org Video Driver
	ABI class: X.Org Video Driver, version 1.0
(II) LoadModule: "kbd"
(II) Loading /usr/lib/xorg/modules/input/kbd_drv.so
(II) Module kbd: vendor="X.Org Foundation"
	compiled for 7.1.1, module version = 1.1.0
	Module class: X.Org XInput Driver
	ABI class: X.Org XInput driver, version 0.6
(II) LoadModule: "mouse"
(II) Loading /usr/lib/xorg/modules/input/mouse_drv.so
(II) Module mouse: vendor="X.Org Foundation"
	compiled for 7.1.1, module version = 1.1.1
	Module class: X.Org XInput Driver
	ABI class: X.Org XInput driver, version 0.6
(II) ATI: ATI driver (version 6.6.3) for chipsets: ati, ativga
(II) R128: Driver for ATI Rage 128 chipsets:
	ATI Rage 128 Mobility M3 LE (PCI), ATI Rage 128 Mobility M3 LF (AGP),
	ATI Rage 128 Mobility M4 MF (AGP), ATI Rage 128 Mobility M4 ML (AGP),
	ATI Rage 128 Pro GL PA (AGP?), ATI Rage 128 Pro GL PB (AGP?),
	ATI Rage 128 Pro GL PC (AGP?), ATI Rage 128 Pro GL PD (PCI),
	ATI Rage 128 Pro GL PE (AGP?), ATI Rage 128 Pro GL PF (AGP),
	ATI Rage 128 Pro VR PG (AGP?), ATI Rage 128 Pro VR PH (AGP?),
	ATI Rage 128 Pro VR PI (AGP?), ATI Rage 128 Pro VR PJ (AGP?),
	ATI Rage 128 Pro VR PK (AGP?), ATI Rage 128 Pro VR PL (AGP?),
	ATI Rage 128 Pro VR PM (AGP?), ATI Rage 128 Pro VR PN (AGP?),
	ATI Rage 128 Pro VR PO (AGP?), ATI Rage 128 Pro VR PP (PCI),
	ATI Rage 128 Pro VR PQ (AGP?), ATI Rage 128 Pro VR PR (PCI),
	ATI Rage 128 Pro VR PS (AGP?), ATI Rage 128 Pro VR PT (AGP?),
	ATI Rage 128 Pro VR PU (AGP?), ATI Rage 128 Pro VR PV (AGP?),
	ATI Rage 128 Pro VR PW (AGP?), ATI Rage 128 Pro VR PX (AGP?),
	ATI Rage 128 GL RE (PCI), ATI Rage 128 GL RF (AGP),
	ATI Rage 128 RG (AGP), ATI Rage 128 VR RK (PCI),
	ATI Rage 128 VR RL (AGP), ATI Rage 128 4X SE (AGP?),
	ATI Rage 128 4X SF (AGP?), ATI Rage 128 4X SG (AGP?),
	ATI Rage 128 4X SH (AGP?), ATI Rage 128 4X SK (AGP?),
	ATI Rage 128 4X SL (AGP?), ATI Rage 128 4X SM (AGP),
	ATI Rage 128 4X SN (AGP?), ATI Rage 128 Pro ULTRA TF (AGP),
	ATI Rage 128 Pro ULTRA TL (AGP), ATI Rage 128 Pro ULTRA TR (AGP),
	ATI Rage 128 Pro ULTRA TS (AGP?), ATI Rage 128 Pro ULTRA TT (AGP?),
	ATI Rage 128 Pro ULTRA TU (AGP?)
(II) RADEON: Driver for ATI Radeon chipsets: ATI Radeon QD (AGP),
	ATI Radeon QE (AGP), ATI Radeon QF (AGP), ATI Radeon QG (AGP),
	ATI Radeon VE/7000 QY (AGP/PCI), ATI Radeon VE/7000 QZ (AGP/PCI),
	ATI ES1000 515E (PCI), ATI ES1000 5969 (PCI),
	ATI Radeon Mobility M7 LW (AGP),
	ATI Mobility FireGL 7800 M7 LX (AGP),
	ATI Radeon Mobility M6 LY (AGP), ATI Radeon Mobility M6 LZ (AGP),
	ATI Radeon IGP320 (A3) 4136, ATI Radeon IGP320M (U1) 4336,
	ATI Radeon IGP330/340/350 (A4) 4137,
	ATI Radeon IGP330M/340M/350M (U2) 4337,
	ATI Radeon 7000 IGP (A4+) 4237, ATI Radeon Mobility 7000 IGP 4437,
	ATI FireGL 8700/8800 QH (AGP), ATI Radeon 8500 QL (AGP),
	ATI Radeon 9100 QM (AGP), ATI Radeon 8500 AIW BB (AGP),
	ATI Radeon 8500 AIW BC (AGP), ATI Radeon 7500 QW (AGP/PCI),
	ATI Radeon 7500 QX (AGP/PCI), ATI Radeon 9000/PRO If (AGP/PCI),
	ATI Radeon 9000 Ig (AGP/PCI), ATI FireGL Mobility 9000 (M9) Ld (AGP),
	ATI Radeon Mobility 9000 (M9) Lf (AGP),
	ATI Radeon Mobility 9000 (M9) Lg (AGP),
	ATI Radeon 9100 IGP (A5) 5834,
	ATI Radeon Mobility 9100 IGP (U3) 5835, ATI Radeon 9100 PRO IGP 7834,
	ATI Radeon Mobility 9200 IGP 7835, ATI Radeon 9250 5960 (AGP),
	ATI Radeon 9200 5961 (AGP), ATI Radeon 9200 5962 (AGP),
	ATI Radeon 9200SE 5964 (AGP), ATI FireMV 2200 (PCI),
	ATI Radeon Mobility 9200 (M9+) 5C61 (AGP),
	ATI Radeon Mobility 9200 (M9+) 5C63 (AGP), ATI Radeon 9500 AD (AGP),
	ATI Radeon 9500 AE (AGP), ATI Radeon 9600TX AF (AGP),
	ATI FireGL Z1 AG (AGP), ATI Radeon 9700 Pro ND (AGP),
	ATI Radeon 9700/9500Pro NE (AGP), ATI Radeon 9600TX NF (AGP),
	ATI FireGL X1 NG (AGP), ATI Radeon 9600 AP (AGP),
	ATI Radeon 9600SE AQ (AGP), ATI Radeon 9600XT AR (AGP),
	ATI Radeon 9600 AS (AGP), ATI FireGL T2 AT (AGP),
	ATI FireGL RV360 AV (AGP),
	ATI Radeon Mobility 9600/9700 (M10/M11) NP (AGP),
	ATI Radeon Mobility 9600 (M10) NQ (AGP),
	ATI Radeon Mobility 9600 (M11) NR (AGP),
	ATI Radeon Mobility 9600 (M10) NS (AGP),
	ATI FireGL Mobility T2 (M10) NT (AGP),
	ATI FireGL Mobility T2e (M11) NV (AGP), ATI Radeon 9650,
	ATI Radeon 9800SE AH (AGP), ATI Radeon 9800 AI (AGP),
	ATI Radeon 9800 AJ (AGP), ATI FireGL X2 AK (AGP),
	ATI Radeon 9800PRO NH (AGP), ATI Radeon 9800 NI (AGP),
	ATI FireGL X2 NK (AGP), ATI Radeon 9800XT NJ (AGP),
	ATI Radeon X600 (RV380) 3E50 (PCIE),
	ATI FireGL V3200 (RV380) 3E54 (PCIE),
	ATI Radeon Mobility X600 (M24) 3150 (PCIE),
	ATI Radeon Mobility X300 (M24) 3152 (PCIE),
	ATI FireGL M24 GL 3154 (PCIE), ATI Radeon X300 (RV370) 5B60 (PCIE),
	ATI Radeon X600 (RV370) 5B62 (PCIE),
	ATI Radeon X550 (RV370) 5B63 (PCIE),
	ATI FireGL V3100 (RV370) 5B64 (PCIE),
	ATI FireMV 2200 PCIE (RV370) 5B65 (PCIE),
	ATI Radeon Mobility X300 (M22) 5460 (PCIE),
	ATI Radeon Mobility X600 SE (M24C) 5462 (PCIE),
	ATI FireGL M22 GL 5464 (PCIE), ATI Radeon XPRESS 200 5A41 (PCIE),
	ATI Radeon XPRESS 200M 5A42 (PCIE),
	ATI Radeon XPRESS 200 5A61 (PCIE),
	ATI Radeon XPRESS 200M 5A62 (PCIE),
	ATI Radeon XPRESS 200 5954 (PCIE),
	ATI Radeon XPRESS 200M 5955 (PCIE),
	ATI Radeon XPRESS 200 5974 (PCIE),
	ATI Radeon XPRESS 200M 5975 (PCIE), ATI FireGL V5000 (RV410) (PCIE),
	ATI Mobility FireGL V5000 (M26) (PCIE),
	ATI Mobility FireGL V5000 (M26) (PCIE),
	ATI Mobility Radeon X700 XL (M26) (PCIE),
	ATI Mobility Radeon X700 (M26) (PCIE),
	ATI Mobility Radeon X700 (M26) (PCIE),
	ATI Radeon X700 PRO (RV410) (PCIE),
	ATI Radeon X700 XT (RV410) (PCIE), ATI Radeon X700 (RV410) (PCIE),
	ATI Radeon X700 SE (RV410) (PCIE), ATI Radeon X700 SE (RV410) (PCIE),
	ATI Radeon X800 (R420) JH (AGP), ATI Radeon X800PRO (R420) JI (AGP),
	ATI Radeon X800SE (R420) JJ (AGP), ATI Radeon X800 (R420) JK (AGP),
	ATI Radeon X800 (R420) JL (AGP), ATI FireGL X3 (R420) JM (AGP),
	ATI Radeon Mobility 9800 (M18) JN (AGP),
	ATI Radeon X800XT (R420) JP (AGP), ATI Radeon X800 SE (R420) (AGP),
	ATI Radeon AIW X800 VE (R420) JT (AGP),
	ATI Radeon X800 (R423) UH (PCIE),
	ATI Radeon X800PRO (R423) UI (PCIE),
	ATI Radeon X800LE (R423) UJ (PCIE),
	ATI Radeon X800SE (R423) UK (PCIE),
	ATI FireGL V5100 (R423) UQ (PCIE),
	ATI FireGL unknown (R423) UR (PCIE),
	ATI FireGL unknown (R423) UT (PCIE),
	ATI Radeon X800XT (R423) 5D57 (PCIE), ATI FireGL V7100 (R423) (PCIE),
	ATI Mobility FireGL V5100 (M28) (PCIE),
	ATI Mobility Radeon X800 (M28) (PCIE),
	ATI Mobility Radeon X800 XT (M28) (PCIE),
	ATI Radeon X800 (R430) (PCIE), ATI Radeon X800 XL (R430) (PCIE),
	ATI Radeon X800 SE (R430) (PCIE), ATI Radeon X800 XTP (R430) (PCIE),
	ATI Radeon X850 5D4C (PCIE),
	ATI unknown Radeon / FireGL (R480) 5D50 (PCIE),
	ATI Radeon X850 SE (R480) (PCIE), ATI Radeon X850 PRO (R480) (PCIE),
	ATI Radeon X850 XT (R480) (PCIE),
	ATI Radeon X850 XT PE (R480) (PCIE),
	ATI Radeon X850 PRO (R480) (AGP), ATI Radeon X850 SE (R480) (AGP),
	ATI Radeon X850 XT (R480) (AGP), ATI Radeon X850 XT PE (R480) (AGP)
(II) Primary Device is: PCI 01:00:0
(WW) RADEON: No matching Device section for instance (BusID PCI:1:0:1) found
(--) Chipset ATI Radeon X300 (RV370) 5B60 (PCIE) found
(II) resource ranges after xf86ClaimFixedResources() call:
	[0] -1	0	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[1] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[2] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[3] -1	0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[4] -1	0	0x4c000000 - 0x4c003fff (0x4000) MX[B]
	[5] -1	0	0x4c004000 - 0x4c0047ff (0x800) MX[B]
	[6] -1	0	0x4c100000 - 0x4c1001ff (0x200) MX[B]
	[7] -1	0	0x4c326000 - 0x4c3260ff (0x100) MX[B]
	[8] -1	0	0x4c325000 - 0x4c3257ff (0x800) MX[B]
	[9] -1	0	0x4c325800 - 0x4c325bff (0x400) MX[B]
	[10] -1	0	0x4c320000 - 0x4c323fff (0x4000) MX[B]
	[11] -1	0	0x4c325c00 - 0x4c325fff (0x400) MX[B]
	[12] -1	0	0x4c324000 - 0x4c324fff (0x1000) MX[B]
	[13] -1	0	0x4c300000 - 0x4c31ffff (0x20000) MX[B]
	[14] -1	0	0x4c326100 - 0x4c32610f (0x10) MX[B]
	[15] -1	0	0x48000000 - 0x4bffffff (0x4000000) MX[B](B)
	[16] -1	0	0x4c200000 - 0x4c20ffff (0x10000) MX[B](B)
	[17] -1	0	0x4c220000 - 0x4c23ffff (0x20000) MX[B](B)
	[18] -1	0	0x4c210000 - 0x4c21ffff (0x10000) MX[B](B)
	[19] -1	0	0x40000000 - 0x47ffffff (0x8000000) MX[B](B)
	[20] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[21] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
	[22] -1	0	0x00001000 - 0x0000100f (0x10) IX[B]
	[23] -1	0	0x00001020 - 0x00001023 (0x4) IX[B]
	[24] -1	0	0x00001010 - 0x00001017 (0x8) IX[B]
	[25] -1	0	0x00001024 - 0x00001027 (0x4) IX[B]
	[26] -1	0	0x00001018 - 0x0000101f (0x8) IX[B]
	[27] -1	0	0x00003000 - 0x0000301f (0x20) IX[B]
	[28] -1	0	0x00003020 - 0x0000303f (0x20) IX[B]
	[29] -1	0	0x00003110 - 0x00003113 (0x4) IX[B]
	[30] -1	0	0x00003100 - 0x00003107 (0x8) IX[B]
	[31] -1	0	0x00003114 - 0x00003117 (0x4) IX[B]
	[32] -1	0	0x00003108 - 0x0000310f (0x8) IX[B]
	[33] -1	0	0x00003040 - 0x0000305f (0x20) IX[B]
	[34] -1	0	0x00003060 - 0x0000307f (0x20) IX[B]
	[35] -1	0	0x00003080 - 0x0000309f (0x20) IX[B]
	[36] -1	0	0x000030a0 - 0x000030bf (0x20) IX[B]
	[37] -1	0	0x000030c0 - 0x000030df (0x20) IX[B]
	[38] -1	0	0x000030e0 - 0x000030ff (0x20) IX[B]
	[39] -1	0	0x00002000 - 0x000020ff (0x100) IX[B](B)
(II) Loading sub module "radeon"
(II) LoadModule: "radeon"
(II) Reloading /usr/lib/xorg/modules/drivers/radeon_drv.so
(II) resource ranges after probing:
	[0] -1	0	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[1] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[2] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[3] -1	0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[4] -1	0	0x4c000000 - 0x4c003fff (0x4000) MX[B]
	[5] -1	0	0x4c004000 - 0x4c0047ff (0x800) MX[B]
	[6] -1	0	0x4c100000 - 0x4c1001ff (0x200) MX[B]
	[7] -1	0	0x4c326000 - 0x4c3260ff (0x100) MX[B]
	[8] -1	0	0x4c325000 - 0x4c3257ff (0x800) MX[B]
	[9] -1	0	0x4c325800 - 0x4c325bff (0x400) MX[B]
	[10] -1	0	0x4c320000 - 0x4c323fff (0x4000) MX[B]
	[11] -1	0	0x4c325c00 - 0x4c325fff (0x400) MX[B]
	[12] -1	0	0x4c324000 - 0x4c324fff (0x1000) MX[B]
	[13] -1	0	0x4c300000 - 0x4c31ffff (0x20000) MX[B]
	[14] -1	0	0x4c326100 - 0x4c32610f (0x10) MX[B]
	[15] -1	0	0x48000000 - 0x4bffffff (0x4000000) MX[B](B)
	[16] -1	0	0x4c200000 - 0x4c20ffff (0x10000) MX[B](B)
	[17] -1	0	0x4c220000 - 0x4c23ffff (0x20000) MX[B](B)
	[18] -1	0	0x4c210000 - 0x4c21ffff (0x10000) MX[B](B)
	[19] -1	0	0x40000000 - 0x47ffffff (0x8000000) MX[B](B)
	[20] 0	0	0x000a0000 - 0x000affff (0x10000) MS[B]
	[21] 0	0	0x000b0000 - 0x000b7fff (0x8000) MS[B]
	[22] 0	0	0x000b8000 - 0x000bffff (0x8000) MS[B]
	[23] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[24] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
	[25] -1	0	0x00001000 - 0x0000100f (0x10) IX[B]
	[26] -1	0	0x00001020 - 0x00001023 (0x4) IX[B]
	[27] -1	0	0x00001010 - 0x00001017 (0x8) IX[B]
	[28] -1	0	0x00001024 - 0x00001027 (0x4) IX[B]
	[29] -1	0	0x00001018 - 0x0000101f (0x8) IX[B]
	[30] -1	0	0x00003000 - 0x0000301f (0x20) IX[B]
	[31] -1	0	0x00003020 - 0x0000303f (0x20) IX[B]
	[32] -1	0	0x00003110 - 0x00003113 (0x4) IX[B]
	[33] -1	0	0x00003100 - 0x00003107 (0x8) IX[B]
	[34] -1	0	0x00003114 - 0x00003117 (0x4) IX[B]
	[35] -1	0	0x00003108 - 0x0000310f (0x8) IX[B]
	[36] -1	0	0x00003040 - 0x0000305f (0x20) IX[B]
	[37] -1	0	0x00003060 - 0x0000307f (0x20) IX[B]
	[38] -1	0	0x00003080 - 0x0000309f (0x20) IX[B]
	[39] -1	0	0x000030a0 - 0x000030bf (0x20) IX[B]
	[40] -1	0	0x000030c0 - 0x000030df (0x20) IX[B]
	[41] -1	0	0x000030e0 - 0x000030ff (0x20) IX[B]
	[42] -1	0	0x00002000 - 0x000020ff (0x100) IX[B](B)
	[43] 0	0	0x000003b0 - 0x000003bb (0xc) IS[B]
	[44] 0	0	0x000003c0 - 0x000003df (0x20) IS[B]
(II) Setting vga for screen 0.
(**) RADEON(0): RADEONPreInit
(II) RADEON(0): MMIO registers at 0x4c210000: size 64KB
(II) RADEON(0): PCI bus 1 card 0 func 0
(**) RADEON(0): Depth 24, (--) framebuffer bpp 32
(II) RADEON(0): Pixel depth = 24 bits stored in 4 bytes (32 bpp pixmaps)
(==) RADEON(0): Default visual is TrueColor
(**) RADEON(0): Option "MonitorLayout" "CRT,CRT"
(**) RADEON(0): Option "MergedFB" "true"
(**) RADEON(0): Option "CRT2HSync" "32-82"
(**) RADEON(0): Option "CRT2VRefresh" "56-75"
(**) RADEON(0): Option "CRT2Position" "RightOf"
(**) RADEON(0): Option "MetaModes" "1680x1050-1680x1050"
(**) RADEON(0): Option "MergedXineramaCRT2IsScreen0" "true"
(II) Loading sub module "vgahw"
(II) LoadModule: "vgahw"
(II) Loading /usr/lib/xorg/modules/libvgahw.so
(II) Module vgahw: vendor="X.Org Foundation"
	compiled for 7.1.1, module version = 0.1.0
	ABI class: X.Org Video Driver, version 1.0
(II) RADEON(0): vgaHWGetIOBase: hwp->IOBase is 0x03d0, hwp->PIOOffset is 0x0000
(==) RADEON(0): RGB weight 888
(II) RADEON(0): Using 8 bits per RGB (8 bit DAC)
(==) RADEON(0): X server will not keep DPI constant for all screen sizes
(II) Loading sub module "int10"
(II) LoadModule: "int10"
(II) Loading /usr/lib/xorg/modules/libint10.so
(II) Module int10: vendor="X.Org Foundation"
	compiled for 7.1.1, module version = 1.0.0
	ABI class: X.Org Video Driver, version 1.0
(II) RADEON(0): initializing int10
(II) Loading sub module "vm86"
(II) LoadModule: "vm86"
(II) Loading /usr/lib/xorg/modules/libvm86.so
(II) Module vm86: vendor="X.Org Foundation"
	compiled for 7.1.1, module version = 1.0.0
	ABI class: X.Org Video Driver, version 1.0
(II) RADEON(0): Primary V_BIOS segment is: 0xc000
(--) RADEON(0): Chipset: "ATI Radeon X300 (RV370) 5B60 (PCIE)" (ChipID = 0x5b60)
(--) RADEON(0): Linear framebuffer at 0x40000000
(--) RADEON(0): BIOS at 0x50000000
(II) RADEON(0): PCIE card detected
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is -1, (No such device or address)
drmOpenDevice: open result is -1, (No such device or address)
drmOpenDevice: Open failed
drmOpenByBusid: Searching for BusID pci:0000:01:00.0
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is 8, (OK)
drmOpenByBusid: drmOpenMinor returns 8
drmOpenByBusid: drmGetBusid reports pci:0000:01:00.0
(II) RADEON(0): [dri] Found DRI library version 1.2.0 and kernel module version 1.25.0
(II) Loading sub module "shadowfb"
(II) LoadModule: "shadowfb"
(II) Loading /usr/lib/xorg/modules/libshadowfb.so
(II) Module shadowfb: vendor="X.Org Foundation"
	compiled for 7.1.1, module version = 1.0.0
	ABI class: X.Org ANSI C Emulation, version 0.3
(II) RADEON(0): Page flipping disabled
(II) RADEON(0): Will try to use DMA for Xv image transfers
(II) RADEON(0): Generation 2 PCI interface, using max accessible memory
(II) RADEON(0): Detected total video RAM=131072K, accessible=131072K (PCI BAR=131072K)
(--) RADEON(0): Mapped VideoRAM: 131072 kByte (64 bit DDR SDRAM)
(II) RADEON(0): Color tiling enabled by default
(II) Loading sub module "ddc"
(II) LoadModule: "ddc"
(II) Reloading /usr/lib/xorg/modules/libddc.so
(II) Loading sub module "i2c"
(II) LoadModule: "i2c"
(II) Reloading /usr/lib/xorg/modules/libi2c.so
(II) RADEON(0): I2C bus "DDC" initialized.
(II) RADEON(0): Legacy BIOS detected
(II) RADEON(0): Connector0: DDCType-2, DACType-1, TMDSType-0, ConnectorType-4
(II) RADEON(0): Connector1: DDCType-3, DACType-0, TMDSType--1, ConnectorType-2
(**) RADEON(0): MonitorLayout Option: 
	Monitor1--Type CRT, Monitor2--Type CRT

(II) RADEON(0): I2C device "DDC:ddc2" registered at address 0xA0.
(II) RADEON(0): I2C device "DDC:ddc2" removed.
(II) RADEON(0): DDC Type: 2, Detected Type: 1
(II) RADEON(0): I2C device "DDC:ddc2" registered at address 0xA0.
(II) RADEON(0): I2C device "DDC:ddc2" removed.
(II) RADEON(0): DDC Type: 3, Detected Type: 1
(II) RADEON(0): EDID data from the display on port 1 ----------------------
(II) RADEON(0): Manufacturer: NEC  Model: 66ba  Serial#: 16843009
(II) RADEON(0): Year: 2006  Week: 39
(II) RADEON(0): EDID Version: 1.3
(II) RADEON(0): Analog Display Input,  Input Voltage Level: 0.700/0.300 V
(II) RADEON(0): Sync:  Separate  Composite  SyncOnGreen
(II) RADEON(0): Max H-Image Size [cm]: horiz.: 43  vert.: 27
(II) RADEON(0): Gamma: 2.20
(II) RADEON(0): DPMS capabilities: StandBy Suspend Off; RGB/Color Display
(II) RADEON(0): First detailed timing is preferred mode
(II) RADEON(0): redX: 0.651 redY: 0.336   greenX: 0.289 greenY: 0.608
(II) RADEON(0): blueX: 0.141 blueY: 0.087   whiteX: 0.313 whiteY: 0.329
(II) RADEON(0): Supported VESA Video Modes:
(II) RADEON(0): 720x400@70Hz
(II) RADEON(0): 640x480@60Hz
(II) RADEON(0): 640x480@67Hz
(II) RADEON(0): 640x480@72Hz
(II) RADEON(0): 640x480@75Hz
(II) RADEON(0): 800x600@56Hz
(II) RADEON(0): 800x600@60Hz
(II) RADEON(0): 800x600@72Hz
(II) RADEON(0): 800x600@75Hz
(II) RADEON(0): 832x624@75Hz
(II) RADEON(0): 1024x768@60Hz
(II) RADEON(0): 1024x768@70Hz
(II) RADEON(0): 1024x768@75Hz
(II) RADEON(0): 1280x1024@75Hz
(II) RADEON(0): 1152x870@75Hz
(II) RADEON(0): Manufacturer's mask: 0
(II) RADEON(0): Supported Future Video Modes:
(II) RADEON(0): #0: hsize: 1280  vsize 720  refresh: 60  vid: 49281
(II) RADEON(0): #1: hsize: 1280  vsize 960  refresh: 60  vid: 16513
(II) RADEON(0): #2: hsize: 1280  vsize 1024  refresh: 60  vid: 32897
(II) RADEON(0): #3: hsize: 1440  vsize 900  refresh: 60  vid: 149
(II) RADEON(0): #4: hsize: 1400  vsize 1050  refresh: 60  vid: 16528
(II) RADEON(0): #5: hsize: 1680  vsize 1050  refresh: 60  vid: 179
(II) RADEON(0): #6: hsize: 1152  vsize 864  refresh: 75  vid: 20337
(II) RADEON(0): Supported additional Video Mode:
(II) RADEON(0): clock: 146.2 MHz   Image Size:  433 x 270 mm
(II) RADEON(0): h_active: 1680  h_sync: 1960  h_sync_end 2136 h_blank_end 2240 h_border: 0
(II) RADEON(0): v_active: 1050  v_sync: 1053  v_sync_end 1059 v_blanking: 1089 v_border: 0
(II) RADEON(0): Ranges: V min: 56  V max: 75 Hz, H min: 31  H max: 83 kHz, PixClock max 170 MHz
(II) RADEON(0): Monitor name: LCD2070WNX
(II) RADEON(0): Serial No: 69104679GB
(II) RADEON(0): EDID data from the display on port 2-----------------------
(II) RADEON(0): Manufacturer: NEC  Model: 66ba  Serial#: 16843009
(II) RADEON(0): Year: 2006  Week: 39
(II) RADEON(0): EDID Version: 1.3
(II) RADEON(0): Analog Display Input,  Input Voltage Level: 0.700/0.300 V
(II) RADEON(0): Sync:  Separate  Composite  SyncOnGreen
(II) RADEON(0): Max H-Image Size [cm]: horiz.: 43  vert.: 27
(II) RADEON(0): Gamma: 2.20
(II) RADEON(0): DPMS capabilities: StandBy Suspend Off; RGB/Color Display
(II) RADEON(0): First detailed timing is preferred mode
(II) RADEON(0): redX: 0.651 redY: 0.336   greenX: 0.289 greenY: 0.608
(II) RADEON(0): blueX: 0.141 blueY: 0.087   whiteX: 0.313 whiteY: 0.329
(II) RADEON(0): Supported VESA Video Modes:
(II) RADEON(0): 720x400@70Hz
(II) RADEON(0): 640x480@60Hz
(II) RADEON(0): 640x480@67Hz
(II) RADEON(0): 640x480@72Hz
(II) RADEON(0): 640x480@75Hz
(II) RADEON(0): 800x600@56Hz
(II) RADEON(0): 800x600@60Hz
(II) RADEON(0): 800x600@72Hz
(II) RADEON(0): 800x600@75Hz
(II) RADEON(0): 832x624@75Hz
(II) RADEON(0): 1024x768@60Hz
(II) RADEON(0): 1024x768@70Hz
(II) RADEON(0): 1024x768@75Hz
(II) RADEON(0): 1280x1024@75Hz
(II) RADEON(0): 1152x870@75Hz
(II) RADEON(0): Manufacturer's mask: 0
(II) RADEON(0): Supported Future Video Modes:
(II) RADEON(0): #0: hsize: 1280  vsize 720  refresh: 60  vid: 49281
(II) RADEON(0): #1: hsize: 1280  vsize 960  refresh: 60  vid: 16513
(II) RADEON(0): #2: hsize: 1280  vsize 1024  refresh: 60  vid: 32897
(II) RADEON(0): #3: hsize: 1440  vsize 900  refresh: 60  vid: 149
(II) RADEON(0): #4: hsize: 1400  vsize 1050  refresh: 60  vid: 16528
(II) RADEON(0): #5: hsize: 1680  vsize 1050  refresh: 60  vid: 179
(II) RADEON(0): #6: hsize: 1152  vsize 864  refresh: 75  vid: 20337
(II) RADEON(0): Supported additional Video Mode:
(II) RADEON(0): clock: 146.2 MHz   Image Size:  433 x 270 mm
(II) RADEON(0): h_active: 1680  h_sync: 1960  h_sync_end 2136 h_blank_end 2240 h_border: 0
(II) RADEON(0): v_active: 1050  v_sync: 1053  v_sync_end 1059 v_blanking: 1089 v_border: 0
(II) RADEON(0): Ranges: V min: 56  V max: 75 Hz, H min: 31  H max: 83 kHz, PixClock max 170 MHz
(II) RADEON(0): Monitor name: LCD2070WNX
(II) RADEON(0): Serial No: 69104928GB
(II) RADEON(0): 
(II) RADEON(0): Primary:
 Monitor   -- CRT
 Connector -- DVI-D
 DAC Type  -- TVDAC/ExtDAC
 TMDS Type -- Internal
 DDC Type  -- DVI_DDC
(II) RADEON(0): Secondary:
 Monitor   -- CRT
 Connector -- VGA
 DAC Type  -- Primary
 TMDS Type -- NONE
 DDC Type  -- VGA_DDC
(II) RADEON(0): PLL parameters: rf=2700 rd=12 min=20000 max=40000; xclk=29000
(II) RADEON(0): MergedFB mode forced on.
(==) RADEON(0): Using gamma correction (1.0, 1.0, 1.0)
(II) RADEON(0): Validating modes on Primary head ---------
(II) RADEON(0): NECMonitor1: Using hsync range of 32.00-82.00 kHz
(II) RADEON(0): NECMonitor1: Using vrefresh range of 56.00-75.00 Hz
(II) RADEON(0): Clock range:  20.00 to 400.00 MHz
(II) RADEON(0): Not using default mode "640x350" (vrefresh out of range)
(II) RADEON(0): Not using default mode "320x175" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "640x400" (vrefresh out of range)
(II) RADEON(0): Not using default mode "320x200" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "720x400" (vrefresh out of range)
(II) RADEON(0): Not using default mode "360x200" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "640x480" (hsync out of range)
(II) RADEON(0): Not using default mode "320x240" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "320x240" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "320x240" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "640x480" (vrefresh out of range)
(II) RADEON(0): Not using default mode "320x240" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "400x300" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "800x600" (vrefresh out of range)
(II) RADEON(0): Not using default mode "400x300" (vrefresh out of range)
(II) RADEON(0): Not using default mode "1024x768" (vrefresh out of range)
(II) RADEON(0): Not using default mode "512x384" (vrefresh out of range)
(II) RADEON(0): Not using default mode "512x384" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "512x384" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "512x384" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "1024x768" (vrefresh out of range)
(II) RADEON(0): Not using default mode "512x384" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "576x432" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "640x480" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "1280x960" (hsync out of range)
(II) RADEON(0): Not using default mode "640x480" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "640x512" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "640x512" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "1280x1024" (hsync out of range)
(II) RADEON(0): Not using default mode "640x512" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "800x600" (bad mode clock/interlace/doublescan)
(WW) (1600x1200,NECMonitor1) mode clock 175.5MHz exceeds DDC maximum 170MHz
(II) RADEON(0): Not using default mode "800x600" (bad mode clock/interlace/doublescan)
(WW) (1600x1200,NECMonitor1) mode clock 189MHz exceeds DDC maximum 170MHz
(II) RADEON(0): Not using default mode "1600x1200" (hsync out of range)
(II) RADEON(0): Not using default mode "800x600" (bad mode clock/interlace/doublescan)
(WW) (1600x1200,NECMonitor1) mode clock 202.5MHz exceeds DDC maximum 170MHz
(II) RADEON(0): Not using default mode "1600x1200" (hsync out of range)
(II) RADEON(0): Not using default mode "800x600" (bad mode clock/interlace/doublescan)
(WW) (1600x1200,NECMonitor1) mode clock 229.5MHz exceeds DDC maximum 170MHz
(II) RADEON(0): Not using default mode "1600x1200" (hsync out of range)
(II) RADEON(0): Not using default mode "800x600" (bad mode clock/interlace/doublescan)
(WW) (1792x1344,NECMonitor1) mode clock 204.8MHz exceeds DDC maximum 170MHz
(II) RADEON(0): Not using default mode "1792x1344" (hsync out of range)
(II) RADEON(0): Not using default mode "896x672" (bad mode clock/interlace/doublescan)
(WW) (1792x1344,NECMonitor1) mode clock 261MHz exceeds DDC maximum 170MHz
(II) RADEON(0): Not using default mode "1792x1344" (hsync out of range)
(II) RADEON(0): Not using default mode "896x672" (bad mode clock/interlace/doublescan)
(WW) (1856x1392,NECMonitor1) mode clock 218.3MHz exceeds DDC maximum 170MHz
(II) RADEON(0): Not using default mode "1856x1392" (hsync out of range)
(II) RADEON(0): Not using default mode "928x696" (bad mode clock/interlace/doublescan)
(WW) (1856x1392,NECMonitor1) mode clock 288MHz exceeds DDC maximum 170MHz
(II) RADEON(0): Not using default mode "1856x1392" (hsync out of range)
(II) RADEON(0): Not using default mode "928x696" (bad mode clock/interlace/doublescan)
(WW) (1920x1440,NECMonitor1) mode clock 234MHz exceeds DDC maximum 170MHz
(II) RADEON(0): Not using default mode "1920x1440" (hsync out of range)
(II) RADEON(0): Not using default mode "960x720" (bad mode clock/interlace/doublescan)
(WW) (1920x1440,NECMonitor1) mode clock 297MHz exceeds DDC maximum 170MHz
(II) RADEON(0): Not using default mode "1920x1440" (hsync out of range)
(II) RADEON(0): Not using default mode "960x720" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "640x384" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "640x400" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "1152x768" (vrefresh out of range)
(II) RADEON(0): Not using default mode "576x384" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "1152x864" (vrefresh out of range)
(II) RADEON(0): Not using default mode "576x432" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "700x525" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "700x525" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "700x525" (bad mode clock/interlace/doublescan)
(WW) (1400x1050,NECMonitor1) mode clock 184MHz exceeds DDC maximum 170MHz
(II) RADEON(0): Not using default mode "1400x1050" (hsync out of range)
(II) RADEON(0): Not using default mode "700x525" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "720x450" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "800x512" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "840x525" (bad mode clock/interlace/doublescan)
(WW) (1920x1200,NECMonitor1) mode clock 193.16MHz exceeds DDC maximum 170MHz
(II) RADEON(0): Not using default mode "960x600" (bad mode clock/interlace/doublescan)
(WW) (1920x1200,NECMonitor1) mode clock 230MHz exceeds DDC maximum 170MHz
(II) RADEON(0): Not using default mode "1920x1200" (hsync out of range)
(II) RADEON(0): Not using default mode "960x600" (bad mode clock/interlace/doublescan)
(WW) (1920x1440,NECMonitor1) mode clock 341.35MHz exceeds DDC maximum 170MHz
(II) RADEON(0): Not using default mode "1920x1440" (hsync out of range)
(II) RADEON(0): Not using default mode "960x720" (bad mode clock/interlace/doublescan)
(WW) (2048x1536,NECMonitor1) mode clock 266.95MHz exceeds DDC maximum 170MHz
(II) RADEON(0): Not using default mode "2048x1536" (hsync out of range)
(II) RADEON(0): Not using default mode "1024x768" (bad mode clock/interlace/doublescan)
(WW) (2048x1536,NECMonitor1) mode clock 340.48MHz exceeds DDC maximum 170MHz
(II) RADEON(0): Not using default mode "2048x1536" (hsync out of range)
(II) RADEON(0): Not using default mode "1024x768" (bad mode clock/interlace/doublescan)
(WW) (2048x1536,NECMonitor1) mode clock 388.04MHz exceeds DDC maximum 170MHz
(II) RADEON(0): Not using default mode "2048x1536" (hsync out of range)
(II) RADEON(0): Not using default mode "1024x768" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "1920x1200" (width too large for virtual size)
(II) RADEON(0): Not using default mode "1600x1200" (height too large for virtual size)
(II) RADEON(0): Not using default mode "1600x1200" (height too large for virtual size)
(II) RADEON(0): Validating CRTC2 modes for MergedFB ------------ 
(II) RADEON(0): CRT2 Monitor: Using hsync range of 32.00-82.00 kHz
(II) RADEON(0): CRT2 Monitor: Using vrefresh range of 56.00-75.00 Hz
(II) RADEON(0): Clock range:  20.00 to 400.00 MHz
(II) RADEON(0): Not using default mode "640x350" (vrefresh out of range)
(II) RADEON(0): Not using default mode "320x175" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "640x400" (vrefresh out of range)
(II) RADEON(0): Not using default mode "320x200" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "720x400" (vrefresh out of range)
(II) RADEON(0): Not using default mode "360x200" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "640x480" (hsync out of range)
(II) RADEON(0): Not using default mode "320x240" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "320x240" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "320x240" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "640x480" (vrefresh out of range)
(II) RADEON(0): Not using default mode "320x240" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "400x300" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "800x600" (vrefresh out of range)
(II) RADEON(0): Not using default mode "400x300" (vrefresh out of range)
(II) RADEON(0): Not using default mode "1024x768" (vrefresh out of range)
(II) RADEON(0): Not using default mode "512x384" (vrefresh out of range)
(II) RADEON(0): Not using default mode "512x384" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "512x384" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "512x384" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "1024x768" (vrefresh out of range)
(II) RADEON(0): Not using default mode "512x384" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "576x432" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "640x480" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "1280x960" (hsync out of range)
(II) RADEON(0): Not using default mode "640x480" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "640x512" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "640x512" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "1280x1024" (hsync out of range)
(II) RADEON(0): Not using default mode "640x512" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "800x600" (bad mode clock/interlace/doublescan)
(WW) (1600x1200,CRT2 Monitor) mode clock 175.5MHz exceeds DDC maximum 170MHz
(II) RADEON(0): Not using default mode "800x600" (bad mode clock/interlace/doublescan)
(WW) (1600x1200,CRT2 Monitor) mode clock 189MHz exceeds DDC maximum 170MHz
(II) RADEON(0): Not using default mode "1600x1200" (hsync out of range)
(II) RADEON(0): Not using default mode "800x600" (bad mode clock/interlace/doublescan)
(WW) (1600x1200,CRT2 Monitor) mode clock 202.5MHz exceeds DDC maximum 170MHz
(II) RADEON(0): Not using default mode "1600x1200" (hsync out of range)
(II) RADEON(0): Not using default mode "800x600" (bad mode clock/interlace/doublescan)
(WW) (1600x1200,CRT2 Monitor) mode clock 229.5MHz exceeds DDC maximum 170MHz
(II) RADEON(0): Not using default mode "1600x1200" (hsync out of range)
(II) RADEON(0): Not using default mode "800x600" (bad mode clock/interlace/doublescan)
(WW) (1792x1344,CRT2 Monitor) mode clock 204.8MHz exceeds DDC maximum 170MHz
(II) RADEON(0): Not using default mode "1792x1344" (hsync out of range)
(II) RADEON(0): Not using default mode "896x672" (bad mode clock/interlace/doublescan)
(WW) (1792x1344,CRT2 Monitor) mode clock 261MHz exceeds DDC maximum 170MHz
(II) RADEON(0): Not using default mode "1792x1344" (hsync out of range)
(II) RADEON(0): Not using default mode "896x672" (bad mode clock/interlace/doublescan)
(WW) (1856x1392,CRT2 Monitor) mode clock 218.3MHz exceeds DDC maximum 170MHz
(II) RADEON(0): Not using default mode "1856x1392" (hsync out of range)
(II) RADEON(0): Not using default mode "928x696" (bad mode clock/interlace/doublescan)
(WW) (1856x1392,CRT2 Monitor) mode clock 288MHz exceeds DDC maximum 170MHz
(II) RADEON(0): Not using default mode "1856x1392" (hsync out of range)
(II) RADEON(0): Not using default mode "928x696" (bad mode clock/interlace/doublescan)
(WW) (1920x1440,CRT2 Monitor) mode clock 234MHz exceeds DDC maximum 170MHz
(II) RADEON(0): Not using default mode "1920x1440" (hsync out of range)
(II) RADEON(0): Not using default mode "960x720" (bad mode clock/interlace/doublescan)
(WW) (1920x1440,CRT2 Monitor) mode clock 297MHz exceeds DDC maximum 170MHz
(II) RADEON(0): Not using default mode "1920x1440" (hsync out of range)
(II) RADEON(0): Not using default mode "960x720" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "640x384" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "640x400" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "1152x768" (vrefresh out of range)
(II) RADEON(0): Not using default mode "576x384" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "1152x864" (vrefresh out of range)
(II) RADEON(0): Not using default mode "576x432" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "700x525" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "700x525" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "700x525" (bad mode clock/interlace/doublescan)
(WW) (1400x1050,CRT2 Monitor) mode clock 184MHz exceeds DDC maximum 170MHz
(II) RADEON(0): Not using default mode "1400x1050" (hsync out of range)
(II) RADEON(0): Not using default mode "700x525" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "720x450" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "800x512" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "840x525" (bad mode clock/interlace/doublescan)
(WW) (1920x1200,CRT2 Monitor) mode clock 193.16MHz exceeds DDC maximum 170MHz
(II) RADEON(0): Not using default mode "960x600" (bad mode clock/interlace/doublescan)
(WW) (1920x1200,CRT2 Monitor) mode clock 230MHz exceeds DDC maximum 170MHz
(II) RADEON(0): Not using default mode "1920x1200" (hsync out of range)
(II) RADEON(0): Not using default mode "960x600" (bad mode clock/interlace/doublescan)
(WW) (1920x1440,CRT2 Monitor) mode clock 341.35MHz exceeds DDC maximum 170MHz
(II) RADEON(0): Not using default mode "1920x1440" (hsync out of range)
(II) RADEON(0): Not using default mode "960x720" (bad mode clock/interlace/doublescan)
(WW) (2048x1536,CRT2 Monitor) mode clock 266.95MHz exceeds DDC maximum 170MHz
(II) RADEON(0): Not using default mode "2048x1536" (hsync out of range)
(II) RADEON(0): Not using default mode "1024x768" (bad mode clock/interlace/doublescan)
(WW) (2048x1536,CRT2 Monitor) mode clock 340.48MHz exceeds DDC maximum 170MHz
(II) RADEON(0): Not using default mode "2048x1536" (hsync out of range)
(II) RADEON(0): Not using default mode "1024x768" (bad mode clock/interlace/doublescan)
(WW) (2048x1536,CRT2 Monitor) mode clock 388.04MHz exceeds DDC maximum 170MHz
(II) RADEON(0): Not using default mode "2048x1536" (hsync out of range)
(II) RADEON(0): Not using default mode "1024x768" (bad mode clock/interlace/doublescan)
(II) RADEON(0): Not using default mode "1920x1200" (width too large for virtual size)
(II) RADEON(0): Not using default mode "1600x1200" (height too large for virtual size)
(II) RADEON(0): Not using default mode "1600x1200" (height too large for virtual size)
(II) RADEON(0): Total of 25 CRTC2 modes found for MergedFB------------ 
(II) RADEON(0): Modes for CRT1: ********************
(--) RADEON(0): Virtual size is 1680x1050 (pitch 1728)
(**) RADEON(0): *Default mode "1680x1050": 147.1 MHz, 65.2 kHz, 60.0 Hz
(II) RADEON(0): Modeline "1680x1050"  147.14  1680 1784 1968 2256  1050 1051 1054 1087
(**) RADEON(0):  Default mode "1400x1050": 155.8 MHz, 81.5 kHz, 74.8 Hz
(II) RADEON(0): Modeline "1400x1050"  155.80  1400 1464 1784 1912  1050 1052 1064 1090 +hsync +vsync
(**) RADEON(0):  Default mode "1400x1050": 151.0 MHz, 77.0 kHz, 70.0 Hz
(II) RADEON(0): Modeline "1400x1050"  151.00  1400 1464 1656 1960  1050 1051 1054 1100 +hsync +vsync
(**) RADEON(0):  Default mode "1400x1050": 122.0 MHz, 64.9 kHz, 60.0 Hz
(II) RADEON(0): Modeline "1400x1050"  122.00  1400 1488 1640 1880  1050 1052 1064 1082 +hsync +vsync
(**) RADEON(0):  Default mode "1280x1024": 135.0 MHz, 80.0 kHz, 75.0 Hz
(II) RADEON(0): Modeline "1280x1024"  135.00  1280 1296 1440 1688  1024 1025 1028 1066 +hsync +vsync
(**) RADEON(0):  Default mode "1280x1024": 108.0 MHz, 64.0 kHz, 60.0 Hz
(II) RADEON(0): Modeline "1280x1024"  108.00  1280 1328 1440 1688  1024 1025 1028 1066 +hsync +vsync
(**) RADEON(0):  Default mode "1440x900": 108.8 MHz, 56.9 kHz, 60.2 Hz
(II) RADEON(0): Modeline "1440x900"  108.84  1440 1472 1880 1912  900 918 927 946 +hsync +vsync
(**) RADEON(0):  Default mode "1280x960": 108.0 MHz, 60.0 kHz, 60.0 Hz
(II) RADEON(0): Modeline "1280x960"  108.00  1280 1376 1488 1800  960 961 964 1000 +hsync +vsync
(**) RADEON(0):  Default mode "1280x800": 83.5 MHz, 49.7 kHz, 60.0 Hz
(II) RADEON(0): Modeline "1280x800"   83.46  1280 1344 1480 1680  800 801 804 828
(**) RADEON(0):  Default mode "1152x864": 108.0 MHz, 67.5 kHz, 75.0 Hz
(II) RADEON(0): Modeline "1152x864"  108.00  1152 1216 1344 1600  864 865 868 900 +hsync +vsync
(**) RADEON(0):  Default mode "1280x768": 80.1 MHz, 47.7 kHz, 60.0 Hz
(II) RADEON(0): Modeline "1280x768"   80.14  1280 1344 1480 1680  768 769 772 795
(**) RADEON(0):  Default mode "1024x768": 78.8 MHz, 60.1 kHz, 75.1 Hz
(II) RADEON(0): Modeline "1024x768"   78.80  1024 1040 1136 1312  768 769 772 800 +hsync +vsync
(**) RADEON(0):  Default mode "1024x768": 75.0 MHz, 56.5 kHz, 70.1 Hz
(II) RADEON(0): Modeline "1024x768"   75.00  1024 1048 1184 1328  768 771 777 806 -hsync -vsync
(**) RADEON(0):  Default mode "1024x768": 65.0 MHz, 48.4 kHz, 60.0 Hz
(II) RADEON(0): Modeline "1024x768"   65.00  1024 1048 1184 1344  768 771 777 806 -hsync -vsync
(**) RADEON(0):  Default mode "832x624": 57.3 MHz, 49.7 kHz, 74.6 Hz
(II) RADEON(0): Modeline "832x624"   57.28  832 864 928 1152  624 625 628 667 -hsync -vsync
(**) RADEON(0):  Default mode "800x600": 49.5 MHz, 46.9 kHz, 75.0 Hz
(II) RADEON(0): Modeline "800x600"   49.50  800 816 896 1056  600 601 604 625 +hsync +vsync
(**) RADEON(0):  Default mode "800x600": 50.0 MHz, 48.1 kHz, 72.2 Hz
(II) RADEON(0): Modeline "800x600"   50.00  800 856 976 1040  600 637 643 666 +hsync +vsync
(**) RADEON(0):  Default mode "800x600": 40.0 MHz, 37.9 kHz, 60.3 Hz
(II) RADEON(0): Modeline "800x600"   40.00  800 840 968 1056  600 601 605 628 +hsync +vsync
(**) RADEON(0):  Default mode "800x600": 36.0 MHz, 35.2 kHz, 56.2 Hz
(II) RADEON(0): Modeline "800x600"   36.00  800 824 896 1024  600 601 603 625 +hsync +vsync
(**) RADEON(0):  Default mode "640x480": 31.5 MHz, 37.5 kHz, 75.0 Hz
(II) RADEON(0): Modeline "640x480"   31.50  640 656 720 840  480 481 484 500 -hsync -vsync
(**) RADEON(0):  Default mode "640x480": 31.5 MHz, 37.9 kHz, 72.8 Hz
(II) RADEON(0): Modeline "640x480"   31.50  640 664 704 832  480 489 491 520 -hsync -vsync
(**) RADEON(0):  Default mode "416x312": 28.6 MHz, 49.7 kHz, 74.7 Hz (D)
(II) RADEON(0): Modeline "416x312"   28.64  416 432 464 576  312 312 314 333 doublescan -hsync -vsync
(**) RADEON(0):  Default mode "400x300": 24.8 MHz, 46.9 kHz, 75.1 Hz (D)
(II) RADEON(0): Modeline "400x300"   24.75  400 408 448 528  300 300 302 312 doublescan +hsync +vsync
(**) RADEON(0):  Default mode "400x300": 25.0 MHz, 48.1 kHz, 72.2 Hz (D)
(II) RADEON(0): Modeline "400x300"   25.00  400 428 488 520  300 318 321 333 doublescan +hsync +vsync
(**) RADEON(0):  Default mode "400x300": 20.0 MHz, 37.9 kHz, 60.3 Hz (D)
(II) RADEON(0): Modeline "400x300"   20.00  400 420 484 528  300 300 302 314 doublescan +hsync +vsync
(II) RADEON(0): Modes for CRT2: ********************
(--) RADEON(0): Virtual size is 1680x1050 (pitch 1728)
(**) RADEON(0): *Default mode "1680x1050": 147.1 MHz, 65.2 kHz, 60.0 Hz
(II) RADEON(0): Modeline "1680x1050"  147.14  1680 1784 1968 2256  1050 1051 1054 1087
(**) RADEON(0):  Default mode "1400x1050": 155.8 MHz, 81.5 kHz, 74.8 Hz
(II) RADEON(0): Modeline "1400x1050"  155.80  1400 1464 1784 1912  1050 1052 1064 1090 +hsync +vsync
(**) RADEON(0):  Default mode "1400x1050": 151.0 MHz, 77.0 kHz, 70.0 Hz
(II) RADEON(0): Modeline "1400x1050"  151.00  1400 1464 1656 1960  1050 1051 1054 1100 +hsync +vsync
(**) RADEON(0):  Default mode "1400x1050": 122.0 MHz, 64.9 kHz, 60.0 Hz
(II) RADEON(0): Modeline "1400x1050"  122.00  1400 1488 1640 1880  1050 1052 1064 1082 +hsync +vsync
(**) RADEON(0):  Default mode "1280x1024": 135.0 MHz, 80.0 kHz, 75.0 Hz
(II) RADEON(0): Modeline "1280x1024"  135.00  1280 1296 1440 1688  1024 1025 1028 1066 +hsync +vsync
(**) RADEON(0):  Default mode "1280x1024": 108.0 MHz, 64.0 kHz, 60.0 Hz
(II) RADEON(0): Modeline "1280x1024"  108.00  1280 1328 1440 1688  1024 1025 1028 1066 +hsync +vsync
(**) RADEON(0):  Default mode "1440x900": 108.8 MHz, 56.9 kHz, 60.2 Hz
(II) RADEON(0): Modeline "1440x900"  108.84  1440 1472 1880 1912  900 918 927 946 +hsync +vsync
(**) RADEON(0):  Default mode "1280x960": 108.0 MHz, 60.0 kHz, 60.0 Hz
(II) RADEON(0): Modeline "1280x960"  108.00  1280 1376 1488 1800  960 961 964 1000 +hsync +vsync
(**) RADEON(0):  Default mode "1280x800": 83.5 MHz, 49.7 kHz, 60.0 Hz
(II) RADEON(0): Modeline "1280x800"   83.46  1280 1344 1480 1680  800 801 804 828
(**) RADEON(0):  Default mode "1152x864": 108.0 MHz, 67.5 kHz, 75.0 Hz
(II) RADEON(0): Modeline "1152x864"  108.00  1152 1216 1344 1600  864 865 868 900 +hsync +vsync
(**) RADEON(0):  Default mode "1280x768": 80.1 MHz, 47.7 kHz, 60.0 Hz
(II) RADEON(0): Modeline "1280x768"   80.14  1280 1344 1480 1680  768 769 772 795
(**) RADEON(0):  Default mode "1024x768": 78.8 MHz, 60.1 kHz, 75.1 Hz
(II) RADEON(0): Modeline "1024x768"   78.80  1024 1040 1136 1312  768 769 772 800 +hsync +vsync
(**) RADEON(0):  Default mode "1024x768": 75.0 MHz, 56.5 kHz, 70.1 Hz
(II) RADEON(0): Modeline "1024x768"   75.00  1024 1048 1184 1328  768 771 777 806 -hsync -vsync
(**) RADEON(0):  Default mode "1024x768": 65.0 MHz, 48.4 kHz, 60.0 Hz
(II) RADEON(0): Modeline "1024x768"   65.00  1024 1048 1184 1344  768 771 777 806 -hsync -vsync
(**) RADEON(0):  Default mode "832x624": 57.3 MHz, 49.7 kHz, 74.6 Hz
(II) RADEON(0): Modeline "832x624"   57.28  832 864 928 1152  624 625 628 667 -hsync -vsync
(**) RADEON(0):  Default mode "800x600": 49.5 MHz, 46.9 kHz, 75.0 Hz
(II) RADEON(0): Modeline "800x600"   49.50  800 816 896 1056  600 601 604 625 +hsync +vsync
(**) RADEON(0):  Default mode "800x600": 50.0 MHz, 48.1 kHz, 72.2 Hz
(II) RADEON(0): Modeline "800x600"   50.00  800 856 976 1040  600 637 643 666 +hsync +vsync
(**) RADEON(0):  Default mode "800x600": 40.0 MHz, 37.9 kHz, 60.3 Hz
(II) RADEON(0): Modeline "800x600"   40.00  800 840 968 1056  600 601 605 628 +hsync +vsync
(**) RADEON(0):  Default mode "800x600": 36.0 MHz, 35.2 kHz, 56.2 Hz
(II) RADEON(0): Modeline "800x600"   36.00  800 824 896 1024  600 601 603 625 +hsync +vsync
(**) RADEON(0):  Default mode "640x480": 31.5 MHz, 37.5 kHz, 75.0 Hz
(II) RADEON(0): Modeline "640x480"   31.50  640 656 720 840  480 481 484 500 -hsync -vsync
(**) RADEON(0):  Default mode "640x480": 31.5 MHz, 37.9 kHz, 72.8 Hz
(II) RADEON(0): Modeline "640x480"   31.50  640 664 704 832  480 489 491 520 -hsync -vsync
(**) RADEON(0):  Default mode "416x312": 28.6 MHz, 49.7 kHz, 74.7 Hz (D)
(II) RADEON(0): Modeline "416x312"   28.64  416 432 464 576  312 312 314 333 doublescan -hsync -vsync
(**) RADEON(0):  Default mode "400x300": 24.8 MHz, 46.9 kHz, 75.1 Hz (D)
(II) RADEON(0): Modeline "400x300"   24.75  400 408 448 528  300 300 302 312 doublescan +hsync +vsync
(**) RADEON(0):  Default mode "400x300": 25.0 MHz, 48.1 kHz, 72.2 Hz (D)
(II) RADEON(0): Modeline "400x300"   25.00  400 428 488 520  300 318 321 333 doublescan +hsync +vsync
(**) RADEON(0):  Default mode "400x300": 20.0 MHz, 37.9 kHz, 60.3 Hz (D)
(II) RADEON(0): Modeline "400x300"   20.00  400 420 484 528  300 300 302 314 doublescan +hsync +vsync
(II) RADEON(0): Generating MergedFB mode list
(II) RADEON(0): Merged "1680x1050" (1680x1050) and "1680x1050" (1680x1050) to 3360x1050
(--) RADEON(0): MergedFB: Virtual width 3360
(--) RADEON(0): MergedFB: Virtual height 1050
(==) RADEON(0): MergedFB: DPI set to (75, 75)
(II) Loading sub module "fb"
(II) LoadModule: "fb"
(II) Loading /usr/lib/xorg/modules/libfb.so
(II) Module fb: vendor="X.Org Foundation"
	compiled for 7.1.1, module version = 1.0.0
	ABI class: X.Org ANSI C Emulation, version 0.3
(II) Loading sub module "ramdac"
(II) LoadModule: "ramdac"
(II) Loading /usr/lib/xorg/modules/libramdac.so
(II) Module ramdac: vendor="X.Org Foundation"
	compiled for 7.1.1, module version = 0.1.0
	ABI class: X.Org Video Driver, version 1.0
(==) RADEON(0): Using XAA acceleration architecture
(II) Loading sub module "xaa"
(II) LoadModule: "xaa"
(II) Loading /usr/lib/xorg/modules/libxaa.so
(II) Module xaa: vendor="X.Org Foundation"
	compiled for 7.1.1, module version = 1.2.0
	ABI class: X.Org Video Driver, version 1.0
(II) RADEON(0): No MM_TABLE found - assuming CARD is not TV-in capable.
(!!) RADEON(0): For information on using the multimedia capabilities
	of this adapter, please see http://gatos.sf.net.
(--) Depth 24 pixmap format is 32 bpp
(II) do I need RAC?  No, I don't.
(II) resource ranges after preInit:
	[0] 0	0	0x4c210000 - 0x4c21ffff (0x10000) MX[B]
	[1] 0	0	0x40000000 - 0x47ffffff (0x8000000) MX[B]
	[2] -1	0	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[3] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[4] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[5] -1	0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[6] -1	0	0x4c000000 - 0x4c003fff (0x4000) MX[B]
	[7] -1	0	0x4c004000 - 0x4c0047ff (0x800) MX[B]
	[8] -1	0	0x4c100000 - 0x4c1001ff (0x200) MX[B]
	[9] -1	0	0x4c326000 - 0x4c3260ff (0x100) MX[B]
	[10] -1	0	0x4c325000 - 0x4c3257ff (0x800) MX[B]
	[11] -1	0	0x4c325800 - 0x4c325bff (0x400) MX[B]
	[12] -1	0	0x4c320000 - 0x4c323fff (0x4000) MX[B]
	[13] -1	0	0x4c325c00 - 0x4c325fff (0x400) MX[B]
	[14] -1	0	0x4c324000 - 0x4c324fff (0x1000) MX[B]
	[15] -1	0	0x4c300000 - 0x4c31ffff (0x20000) MX[B]
	[16] -1	0	0x4c326100 - 0x4c32610f (0x10) MX[B]
	[17] -1	0	0x48000000 - 0x4bffffff (0x4000000) MX[B](B)
	[18] -1	0	0x4c200000 - 0x4c20ffff (0x10000) MX[B](B)
	[19] -1	0	0x4c220000 - 0x4c23ffff (0x20000) MX[B](B)
	[20] -1	0	0x4c210000 - 0x4c21ffff (0x10000) MX[B](B)
	[21] -1	0	0x40000000 - 0x47ffffff (0x8000000) MX[B](B)
	[22] 0	0	0x000a0000 - 0x000affff (0x10000) MS[B](OprU)
	[23] 0	0	0x000b0000 - 0x000b7fff (0x8000) MS[B](OprU)
	[24] 0	0	0x000b8000 - 0x000bffff (0x8000) MS[B](OprU)
	[25] 0	0	0x00002000 - 0x000020ff (0x100) IX[B]
	[26] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[27] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
	[28] -1	0	0x00001000 - 0x0000100f (0x10) IX[B]
	[29] -1	0	0x00001020 - 0x00001023 (0x4) IX[B]
	[30] -1	0	0x00001010 - 0x00001017 (0x8) IX[B]
	[31] -1	0	0x00001024 - 0x00001027 (0x4) IX[B]
	[32] -1	0	0x00001018 - 0x0000101f (0x8) IX[B]
	[33] -1	0	0x00003000 - 0x0000301f (0x20) IX[B]
	[34] -1	0	0x00003020 - 0x0000303f (0x20) IX[B]
	[35] -1	0	0x00003110 - 0x00003113 (0x4) IX[B]
	[36] -1	0	0x00003100 - 0x00003107 (0x8) IX[B]
	[37] -1	0	0x00003114 - 0x00003117 (0x4) IX[B]
	[38] -1	0	0x00003108 - 0x0000310f (0x8) IX[B]
	[39] -1	0	0x00003040 - 0x0000305f (0x20) IX[B]
	[40] -1	0	0x00003060 - 0x0000307f (0x20) IX[B]
	[41] -1	0	0x00003080 - 0x0000309f (0x20) IX[B]
	[42] -1	0	0x000030a0 - 0x000030bf (0x20) IX[B]
	[43] -1	0	0x000030c0 - 0x000030df (0x20) IX[B]
	[44] -1	0	0x000030e0 - 0x000030ff (0x20) IX[B]
	[45] -1	0	0x00002000 - 0x000020ff (0x100) IX[B](B)
	[46] 0	0	0x000003b0 - 0x000003bb (0xc) IS[B](OprU)
	[47] 0	0	0x000003c0 - 0x000003df (0x20) IS[B](OprU)
(**) RADEON(0): RADEONScreenInit 40000000 0
(**) RADEON(0): Map: 0x40000000, 0x08000000
(==) RADEON(0): Write-combining range (0x40000000,0x8000000)
(**) RADEON(0): RADEONSave
(**) RADEON(0): RADEONSaveMode(0x81fdce0)
(**) RADEON(0): Read: 0x00080002 0x0004001e 0x00000000
(**) RADEON(0): Read: rd=2, fd=30, pd=4
(**) RADEON(0): Read: 0x00000000 0x00000000 0x00000000
(**) RADEON(0): Read: rd=0, fd=0, pd=0
(**) RADEON(0): RADEONSaveMode returns 0x81fdce0
(==) RADEON(0): Using 24 bit depth buffer
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is 8, (OK)
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is 8, (OK)
drmOpenByBusid: Searching for BusID pci:0000:01:00.0
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is 8, (OK)
drmOpenByBusid: drmOpenMinor returns 8
drmOpenByBusid: drmGetBusid reports pci:0000:01:00.0
(II) RADEON(0): [drm] DRM interface version 1.3
(II) RADEON(0): [drm] created "radeon" driver at busid "pci:0000:01:00.0"
(II) RADEON(0): [drm] added 8192 byte SAREA at 0xf8bdc000
(II) RADEON(0): [drm] mapped SAREA 0xf8bdc000 to 0xb7af7000
(II) RADEON(0): [drm] framebuffer handle = 0x40000000
(II) RADEON(0): [drm] added 1 reserved context for kernel
(II) RADEON(0): [pci] 8192 kB allocated with handle 0xf8ca0000
(II) RADEON(0): [pci] ring handle = 0xf8ca0000
(II) RADEON(0): [pci] Ring mapped at 0xaf8c1000
(II) RADEON(0): [pci] Ring contents 0x00000000
(II) RADEON(0): [pci] ring read ptr handle = 0xf8da1000
(II) RADEON(0): [pci] Ring read ptr mapped at 0xb7af6000
(II) RADEON(0): [pci] Ring read ptr contents 0x00000000
(II) RADEON(0): [pci] vertex/indirect buffers handle = 0xf8da2000
(II) RADEON(0): [pci] Vertex/indirect buffers mapped at 0xaf6c1000
(II) RADEON(0): [pci] Vertex/indirect buffers contents 0x00000000
(II) RADEON(0): [pci] GART texture map handle = 0xf8fa2000
(II) RADEON(0): [pci] GART Texture map mapped at 0xaf1e1000
(II) RADEON(0): [drm] register handle = 0x4c210000
(II) RADEON(0): [dri] Visual configs initialized
(**) RADEON(0): DRI New memory map param
(**) RADEON(0): RADEONInitMemoryMap() : 
(**) RADEON(0):   mem_size         : 0x08000000
(**) RADEON(0):   MC_FB_LOCATION   : 0x47ff4000
(**) RADEON(0):   MC_AGP_LOCATION  : 0xffffffc0
(**) RADEON(0): RADEONModeInit()
1680x1050    1901115.77  3360 3464 3648 3936  1050 1051 1054 1087 (24,32)
1680x1050    1901115.77  1680 1784 1968 2256  1050 1051 1054 1087 (24,32)
(**) RADEON(0): Pitch = 27787688 bytes (virtualX = 3360, displayWidth = 3392)
(**) RADEON(0): dc=14713, of=29426, fd=131, pd=2
(**) RADEON(0): Pitch = 27787688 bytes (virtualX = 3360, displayWidth = 3392)
(**) RADEON(0): dc=14713, of=29426, fd=131, pd=2
(**) RADEON(0): RADEONInit returns 0x81fe690
(**) RADEON(0): RADEONRestoreMode()
(**) RADEON(0): RADEONRestoreMode(0x81fe690)
(**) RADEON(0): RADEONRestoreMemMapRegisters() : 
(**) RADEON(0):   MC_FB_LOCATION   : 0x47ff4000
(**) RADEON(0):   MC_AGP_LOCATION  : 0xffffffc0
(**) RADEON(0):   Map Changed ! Applying ...
(**) RADEON(0):   Map applied, resetting engine ...
(**) RADEON(0): Updating display base addresses...
(**) RADEON(0): Memory map updated.
(**) RADEON(0): Programming CRTC2, offset: 0x00000000
(**) RADEON(0): Wrote: 0x0000000c 0x00010083 0x00000000 (0x0000a400)
(**) RADEON(0): Wrote: rd=12, fd=131, pd=1
(**) RADEON(0): Programming CRTC1, offset: 0x00000000
(**) RADEON(0): Wrote: 0x0000000c 0x00010083 0x00000000 (0x0000bf00)
(**) RADEON(0): Wrote: rd=12, fd=131, pd=1
(**) RADEON(0): GRPH_BUFFER_CNTL from 30004c4c to 20257c7c
(**) RADEON(0): GRPH2_BUFFER_CNTL from 30004c4c to 204f7c7c
(**) RADEON(0): RADEONSaveScreen(0)
(II) RADEON(0): Depth moves disabled by default
(**) RADEON(0): Setting up initial surfaces
(**) RADEON(0): Initializing fb layer
(**) RADEON(0): Setting up accel memmap
(II) RADEON(0): CP in BM mode
(II) RADEON(0): Using 8 MB GART aperture
(II) RADEON(0): Using 1 MB for the ring buffer
(II) RADEON(0): Using 2 MB for vertex/indirect buffers
(II) RADEON(0): Using 5 MB for GART textures
(II) RADEON(0): Memory manager initialized to (0,0) (3392,8191)
(II) RADEON(0): Reserved area from (0,1050) to (3392,1058)
(II) RADEON(0): Largest offscreen area available: 3392 x 7133
(II) RADEON(0): Will use back buffer at offset 0x1c92000
(II) RADEON(0): Will use depth buffer at offset 0x2a3c000
(II) RADEON(0): Will use 32 kb for PCI GART table at offset 0x7ff8000
(II) RADEON(0): Will use 73728 kb for textures at offset 0x37e6000
(**) RADEON(0): Initializing backing store
(==) RADEON(0): Backing store disabled
(**) RADEON(0): DRI PCIGART param
(**) RADEON(0): DRI Finishing init !
(II) RADEON(0): X context handle = 0x1
(II) RADEON(0): [drm] installed DRM signal handler
(II) RADEON(0): [DRI] installation complete
(**) RADEON(0): EngineRestore (32/32)
(II) RADEON(0): [drm] Added 32 65536 byte vertex/indirect buffers
(II) RADEON(0): [drm] Mapped 32 vertex/indirect buffers
(II) RADEON(0): [drm] dma control initialized, using IRQ 16
(II) RADEON(0): [drm] Initialized kernel GART heap manager, 5111808
(II) RADEON(0): Direct rendering enabled
(**) RADEON(0): Setting up final surfaces
(**) RADEON(0): Initializing Acceleration
(II) RADEON(0): Render acceleration unsupported on Radeon 9500/9700 and newer.
(II) RADEON(0): Render acceleration disabled
(**) RADEON(0): EngineInit (32/32)
(**) RADEON(0): Pitch for acceleration = 424
(**) RADEON(0): EngineRestore (32/32)
(II) RADEON(0): Using XFree86 Acceleration Architecture (XAA)
	Screen to screen bit blits
	Solid filled rectangles
	8x8 mono pattern filled rectangles
	Indirect CPU to Screen color expansion
	Solid Lines
	Scanline Image Writes
	Offscreen Pixmaps
	Setting up tile and stipple cache:
		32 128x128 slots
		32 256x256 slots
		16 512x512 slots
(II) RADEON(0): Acceleration enabled
(**) RADEON(0): Initializing DPMS
(**) Option "dpms"
(**) RADEON(0): DPMS enabled
(**) RADEON(0): Initializing Cursor
(==) RADEON(0): Silken mouse enabled
(II) RADEON(0): Using hardware cursor (scanline 1058)
(II) RADEON(0): Largest offscreen area available: 3392 x 7131
(**) RADEON(0): Initializing color map
(**) RADEON(0): Initializing DGA
(II) RADEON(0): Initialized Radeon Pseudo-Xinerama extension
(II) RADEON(0): Pseudo-Xinerama: CRT1 (Screen 1) (0,0)-(1679,1049)
(II) RADEON(0): Pseudo-Xinerama: CRT2 (Screen 0) (1680,0)-(3359,1049)
(**) RADEON(0): Initializing Xv
(II) RADEON(0): No video input capabilities detected and no information is provided - disabling multimedia i2c
(II) Loading sub module "theatre_detect"
(II) LoadModule: "theatre_detect"
(II) Loading /usr/lib/xorg/modules/multimedia/theatre_detect_drv.so
(II) Module theatre_detect: vendor="X.Org Foundation"
	compiled for 7.1.1, module version = 1.0.0
	ABI class: X.Org Video Driver, version 1.0
(II) RADEON(0): no multimedia table present, disabling Rage Theatre.
(**) RADEON(0): RADEONScreenInit finished
(==) RandR enabled
(II) Initializing built-in extension MIT-SHM
(II) Initializing built-in extension XInputExtension
(II) Initializing built-in extension XTEST
(II) Initializing built-in extension XKEYBOARD
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
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is 9, (OK)
drmOpenByBusid: Searching for BusID pci:0000:01:00.0
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is 9, (OK)
drmOpenByBusid: drmOpenMinor returns 9
drmOpenByBusid: drmGetBusid reports pci:0000:01:00.0
(WW) AIGLX: 3D driver claims to not support visual 0x23
(WW) AIGLX: 3D driver claims to not support visual 0x24
(WW) AIGLX: 3D driver claims to not support visual 0x25
(WW) AIGLX: 3D driver claims to not support visual 0x26
(WW) AIGLX: 3D driver claims to not support visual 0x27
(WW) AIGLX: 3D driver claims to not support visual 0x28
(WW) AIGLX: 3D driver claims to not support visual 0x29
(WW) AIGLX: 3D driver claims to not support visual 0x2a
(WW) AIGLX: 3D driver claims to not support visual 0x2b
(WW) AIGLX: 3D driver claims to not support visual 0x2c
(WW) AIGLX: 3D driver claims to not support visual 0x2d
(WW) AIGLX: 3D driver claims to not support visual 0x2e
(WW) AIGLX: 3D driver claims to not support visual 0x2f
(WW) AIGLX: 3D driver claims to not support visual 0x30
(WW) AIGLX: 3D driver claims to not support visual 0x31
(WW) AIGLX: 3D driver claims to not support visual 0x32
(II) AIGLX: Loaded and initialized /usr/lib/dri/r300_dri.so
(II) GLX: Initialized DRI GL provider for screen 0
(**) Option "CoreKeyboard"
(**) Generic Keyboard: Core Keyboard
(**) Option "Protocol" "standard"
(**) Generic Keyboard: Protocol: standard
(**) Option "AutoRepeat" "500 30"
(**) Option "XkbRules" "xorg"
(**) Generic Keyboard: XkbRules: "xorg"
(**) Option "XkbModel" "pc105"
(**) Generic Keyboard: XkbModel: "pc105"
(**) Option "XkbLayout" "de"
(**) Generic Keyboard: XkbLayout: "de"
(**) Option "XkbVariant" "nodeadkeys"
(**) Generic Keyboard: XkbVariant: "nodeadkeys"
(**) Option "CustomKeycodes" "off"
(**) Generic Keyboard: CustomKeycodes disabled
(**) Option "Protocol" "ExplorerPS/2"
(**) Configured Mouse: Device: "/dev/input/mice"
(**) Configured Mouse: Protocol: "ExplorerPS/2"
(**) Option "CorePointer"
(**) Configured Mouse: Core Pointer
(**) Option "Device" "/dev/input/mice"
(**) Option "Emulate3Buttons" "true"
(**) Configured Mouse: Emulate3Buttons, Emulate3Timeout: 50
(**) Configured Mouse: ZAxisMapping: buttons 4 and 5
(**) Configured Mouse: Buttons: 9
(II) XINPUT: Adding extended input device "Configured Mouse" (type: MOUSE)
(II) XINPUT: Adding extended input device "Generic Keyboard" (type: KEYBOARD)
    xkb_keycodes             { include "xfree86+aliases(qwertz)" };
    xkb_types                { include "complete" };
    xkb_compatibility        { include "complete" };
    xkb_symbols              { include "pc(pc105)+de(nodeadkeys)" };
    xkb_geometry             { include "pc(pc105)" };
(II) Configured Mouse: ps2EnableDataReporting: succeeded
(**) RADEON(0): RADEONSaveScreen(2)
AUDIT: Wed Apr 18 22:02:41 2007: 2116 X: client 7 rejected from local host
(**) RADEON(0): RADEONSaveScreen(2)
(**) RADEON(0): RADEONDisplayPowerManagementSet(1,0x0)
(**) RADEON(0): RADEONDisplayPowerManagementSet(0,0x0)
(**) RADEON(0): RADEONCloseScreen
(**) RADEON(0): RADEONDRIStop
(**) RADEON(0): EngineRestore (32/32)
(**) RADEON(0): RADEONDisplayPowerManagementSet(0,0x0)
(**) RADEON(0): RADEONRestore
(**) RADEON(0): RADEONRestoreMode()
(**) RADEON(0): RADEONRestoreMode(0x81fdce0)
(**) RADEON(0): RADEONRestoreMemMapRegisters() : 
(**) RADEON(0):   MC_FB_LOCATION   : 0x1fff0000
(**) RADEON(0):   MC_AGP_LOCATION  : 0x27ff2000
(**) RADEON(0):   Map Changed ! Applying ...
(**) RADEON(0):   Map applied, resetting engine ...
(**) RADEON(0): Updating display base addresses...
(**) RADEON(0): Memory map updated.
(**) RADEON(0): Programming CRTC2, offset: 0x00000000
(**) RADEON(0): Wrote: 0x00000000 0x00000000 0x00000000 (0x0000a400)
(**) RADEON(0): Wrote: rd=0, fd=0, pd=0
(**) RADEON(0): Programming CRTC1, offset: 0x00000000
(**) RADEON(0): Wrote: 0x00080002 0x0004001e 0x00000000 (0x0000bf00)
(**) RADEON(0): Wrote: rd=2, fd=30, pd=4
(**) RADEON(0): Disposing accel...
(**) RADEON(0): Disposing cusor info
(**) RADEON(0): Disposing DGA
(**) RADEON(0): Unmapping memory
(**) RADEON(0): RADEONDRICloseScreen
(II) RADEON(0): [drm] removed 1 reserved context for kernel
(II) RADEON(0): [drm] unmapping 8192 bytes of SAREA 0xf8bdc000 at 0xb7af7000
FreeFontPath: FPE "unix/:7100" refcount is 2, should be 1; fixing.
(II) Open ACPI successful (/var/run/acpid.socket)
(II) APM registered successfully
(**) RADEON(0): RADEONScreenInit 40000000 0
(**) RADEON(0): Map: 0x40000000, 0x08000000
(==) RADEON(0): Write-combining range (0x40000000,0x8000000)
(**) RADEON(0): RADEONSave
(**) RADEON(0): RADEONSaveMode(0x81fdce0)
(**) RADEON(0): Read: 0x00080002 0x0004001e 0x00000000
(**) RADEON(0): Read: rd=2, fd=30, pd=4
(**) RADEON(0): Read: 0x00000000 0x00000000 0x00000000
(**) RADEON(0): Read: rd=0, fd=0, pd=0
(**) RADEON(0): RADEONSaveMode returns 0x81fdce0
(==) RADEON(0): Using 24 bit depth buffer
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is 8, (OK)
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is 8, (OK)
drmOpenByBusid: Searching for BusID pci:0000:01:00.0
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is 8, (OK)
drmOpenByBusid: drmOpenMinor returns 8
drmOpenByBusid: drmGetBusid reports pci:0000:01:00.0
(II) RADEON(0): [drm] DRM interface version 1.3
(II) RADEON(0): [drm] created "radeon" driver at busid "pci:0000:01:00.0"
(II) RADEON(0): [drm] added 8192 byte SAREA at 0xf8bdc000
(II) RADEON(0): [drm] mapped SAREA 0xf8bdc000 to 0xb7af7000
(II) RADEON(0): [drm] framebuffer handle = 0x40000000
(II) RADEON(0): [drm] added 1 reserved context for kernel
(II) RADEON(0): [pci] 8192 kB allocated with handle 0xf8ca0000
(II) RADEON(0): [pci] ring handle = 0xf8ca0000
(II) RADEON(0): [pci] Ring mapped at 0xaf8c1000
(II) RADEON(0): [pci] Ring contents 0x00000000
(II) RADEON(0): [pci] ring read ptr handle = 0xf8da1000
(II) RADEON(0): [pci] Ring read ptr mapped at 0xb7af6000
(II) RADEON(0): [pci] Ring read ptr contents 0x00000000
(II) RADEON(0): [pci] vertex/indirect buffers handle = 0xf8da2000
(II) RADEON(0): [pci] Vertex/indirect buffers mapped at 0xaf6c1000
(II) RADEON(0): [pci] Vertex/indirect buffers contents 0x00000000
(II) RADEON(0): [pci] GART texture map handle = 0xf8fa2000
(II) RADEON(0): [pci] GART Texture map mapped at 0xaf1e1000
(II) RADEON(0): [drm] register handle = 0x4c210000
(II) RADEON(0): [dri] Visual configs initialized
(**) RADEON(0): DRI New memory map param
(**) RADEON(0): RADEONInitMemoryMap() : 
(**) RADEON(0):   mem_size         : 0x08000000
(**) RADEON(0):   MC_FB_LOCATION   : 0x47ff4000
(**) RADEON(0):   MC_AGP_LOCATION  : 0xffffffc0
(**) RADEON(0): RADEONModeInit()
1680x1050    1901115.77  3360 3464 3648 3936  1050 1051 1054 1087 (24,32)
1680x1050    1901115.77  1680 1784 1968 2256  1050 1051 1054 1087 (24,32)
(**) RADEON(0): Pitch = 27787688 bytes (virtualX = 3360, displayWidth = 3392)
(**) RADEON(0): dc=14713, of=29426, fd=131, pd=2
(**) RADEON(0): Pitch = 27787688 bytes (virtualX = 3360, displayWidth = 3392)
(**) RADEON(0): dc=14713, of=29426, fd=131, pd=2
(**) RADEON(0): RADEONInit returns 0x81fe690
(**) RADEON(0): RADEONRestoreMode()
(**) RADEON(0): RADEONRestoreMode(0x81fe690)
(**) RADEON(0): RADEONRestoreMemMapRegisters() : 
(**) RADEON(0):   MC_FB_LOCATION   : 0x47ff4000
(**) RADEON(0):   MC_AGP_LOCATION  : 0xffffffc0
(**) RADEON(0):   Map Changed ! Applying ...
(**) RADEON(0):   Map applied, resetting engine ...
(**) RADEON(0): Updating display base addresses...
(**) RADEON(0): Memory map updated.
(**) RADEON(0): Programming CRTC2, offset: 0x00000000
(**) RADEON(0): Wrote: 0x0000000c 0x00010083 0x00000000 (0x0000a400)
(**) RADEON(0): Wrote: rd=12, fd=131, pd=1
(**) RADEON(0): Programming CRTC1, offset: 0x00000000
(**) RADEON(0): Wrote: 0x0000000c 0x00010083 0x00000000 (0x0000bf00)
(**) RADEON(0): Wrote: rd=12, fd=131, pd=1
(**) RADEON(0): GRPH_BUFFER_CNTL from 30004c4c to 20257c7c
(**) RADEON(0): GRPH2_BUFFER_CNTL from 30004c4c to 204f7c7c
(**) RADEON(0): RADEONSaveScreen(0)
(II) RADEON(0): Depth moves disabled by default
(**) RADEON(0): Setting up initial surfaces
(**) RADEON(0): Initializing fb layer
(**) RADEON(0): Setting up accel memmap
(II) RADEON(0): CP in BM mode
(II) RADEON(0): Using 8 MB GART aperture
(II) RADEON(0): Using 1 MB for the ring buffer
(II) RADEON(0): Using 2 MB for vertex/indirect buffers
(II) RADEON(0): Using 5 MB for GART textures
(II) RADEON(0): Memory manager initialized to (0,0) (3392,8191)
(II) RADEON(0): Reserved area from (0,1050) to (3392,1058)
(II) RADEON(0): Largest offscreen area available: 3392 x 7133
(II) RADEON(0): Will use back buffer at offset 0x1c92000
(II) RADEON(0): Will use depth buffer at offset 0x2a3c000
(II) RADEON(0): Will use 32 kb for PCI GART table at offset 0x7ff8000
(II) RADEON(0): Will use 73728 kb for textures at offset 0x37e6000
(**) RADEON(0): Initializing backing store
(**) RADEON(0): DRI PCIGART param
(**) RADEON(0): DRI Finishing init !
(II) RADEON(0): X context handle = 0x1
(II) RADEON(0): [drm] installed DRM signal handler
(II) RADEON(0): [DRI] installation complete
(**) RADEON(0): EngineRestore (32/32)
(II) RADEON(0): [drm] Added 32 65536 byte vertex/indirect buffers
(II) RADEON(0): [drm] Mapped 32 vertex/indirect buffers
(II) RADEON(0): [drm] dma control initialized, using IRQ 16
(II) RADEON(0): [drm] Initialized kernel GART heap manager, 5111808
(II) RADEON(0): Direct rendering enabled
(**) RADEON(0): Setting up final surfaces
(**) RADEON(0): Initializing Acceleration
(II) RADEON(0): Render acceleration disabled
(**) RADEON(0): EngineInit (32/32)
(**) RADEON(0): Pitch for acceleration = 424
(**) RADEON(0): EngineRestore (32/32)
(II) RADEON(0): Acceleration enabled
(**) RADEON(0): Initializing DPMS
(**) RADEON(0): DPMS enabled
(**) RADEON(0): Initializing Cursor
(II) RADEON(0): Using hardware cursor (scanline 1058)
(II) RADEON(0): Largest offscreen area available: 3392 x 7131
(**) RADEON(0): Initializing color map
(**) RADEON(0): Initializing DGA
(II) RADEON(0): Initialized Radeon Pseudo-Xinerama extension
(II) RADEON(0): Pseudo-Xinerama: CRT1 (Screen 1) (0,0)-(1679,1049)
(II) RADEON(0): Pseudo-Xinerama: CRT2 (Screen 0) (1680,0)-(3359,1049)
(**) RADEON(0): Initializing Xv
(II) RADEON(0): No video input capabilities detected and no information is provided - disabling multimedia i2c
(II) Loading sub module "theatre_detect"
(II) LoadModule: "theatre_detect"
(II) Reloading /usr/lib/xorg/modules/multimedia/theatre_detect_drv.so
(II) RADEON(0): no multimedia table present, disabling Rage Theatre.
(**) RADEON(0): RADEONScreenInit finished
(==) RandR enabled
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is 9, (OK)
drmOpenByBusid: Searching for BusID pci:0000:01:00.0
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is 9, (OK)
drmOpenByBusid: drmOpenMinor returns 9
drmOpenByBusid: drmGetBusid reports pci:0000:01:00.0
(WW) AIGLX: 3D driver claims to not support visual 0x23
(WW) AIGLX: 3D driver claims to not support visual 0x24
(WW) AIGLX: 3D driver claims to not support visual 0x25
(WW) AIGLX: 3D driver claims to not support visual 0x26
(WW) AIGLX: 3D driver claims to not support visual 0x27
(WW) AIGLX: 3D driver claims to not support visual 0x28
(WW) AIGLX: 3D driver claims to not support visual 0x29
(WW) AIGLX: 3D driver claims to not support visual 0x2a
(WW) AIGLX: 3D driver claims to not support visual 0x2b
(WW) AIGLX: 3D driver claims to not support visual 0x2c
(WW) AIGLX: 3D driver claims to not support visual 0x2d
(WW) AIGLX: 3D driver claims to not support visual 0x2e
(WW) AIGLX: 3D driver claims to not support visual 0x2f
(WW) AIGLX: 3D driver claims to not support visual 0x30
(WW) AIGLX: 3D driver claims to not support visual 0x31
(WW) AIGLX: 3D driver claims to not support visual 0x32
(II) AIGLX: Loaded and initialized /usr/lib/dri/r300_dri.so
(II) GLX: Initialized DRI GL provider for screen 0
    xkb_keycodes             { include "xfree86+aliases(qwertz)" };
    xkb_types                { include "complete" };
    xkb_compatibility        { include "complete" };
    xkb_symbols              { include "pc(pc105)+de(nodeadkeys)" };
    xkb_geometry             { include "pc(pc105)" };
(II) Configured Mouse: ps2EnableDataReporting: succeeded
(**) RADEON(0): RADEONSaveScreen(2)
(**) RADEON(0): RADEONSaveScreen(0)
(**) RADEON(0): RADEONSaveScreen(2)
(**) RADEON(0): RADEONDisplayPowerManagementSet(1,0x0)
(WW) Open ACPI failed (/var/run/acpid.socket) (Connection refused)
(**) RADEON(0): RADEONSaveScreen(1)
(**) RADEON(0): RADEONCloseScreen
(**) RADEON(0): RADEONDRIStop
(**) RADEON(0): EngineRestore (32/32)
(**) RADEON(0): RADEONDisplayPowerManagementSet(0,0x0)
(**) RADEON(0): RADEONRestore
(**) RADEON(0): RADEONRestoreMode()
(**) RADEON(0): RADEONRestoreMode(0x81fdce0)
(**) RADEON(0): RADEONRestoreMemMapRegisters() : 
(**) RADEON(0):   MC_FB_LOCATION   : 0x1fff0000
(**) RADEON(0):   MC_AGP_LOCATION  : 0x27ff2000
(**) RADEON(0):   Map Changed ! Applying ...
(**) RADEON(0):   Map applied, resetting engine ...
(**) RADEON(0): Updating display base addresses...
(**) RADEON(0): Memory map updated.
(**) RADEON(0): Programming CRTC2, offset: 0x00000000
(**) RADEON(0): Wrote: 0x00000000 0x00000000 0x00000000 (0x0000a400)
(**) RADEON(0): Wrote: rd=0, fd=0, pd=0
(**) RADEON(0): Programming CRTC1, offset: 0x00000000
(**) RADEON(0): Wrote: 0x00080002 0x0004001e 0x00000000 (0x0000bf00)
(**) RADEON(0): Wrote: rd=2, fd=30, pd=4
(**) RADEON(0): Disposing accel...
(**) RADEON(0): Disposing cusor info
(**) RADEON(0): Disposing DGA
(**) RADEON(0): Unmapping memory
(**) RADEON(0): RADEONDRICloseScreen
(II) RADEON(0): [drm] removed 1 reserved context for kernel
(II) RADEON(0): [drm] unmapping 8192 bytes of SAREA 0xf8bdc000 at 0xb7af7000
FreeFontPath: FPE "unix/:7100" refcount is 2, should be 1; fixing.

=========================================================================

Thanks for your help,

Hans
