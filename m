From: Andrew Walrond <andrew@walrond.org>
Subject: Re: Rivafb won't work with DVI connector
Date: Sat, 27 Nov 2004 12:40:13 +0000
Message-ID: <200411271240.13475.andrew@walrond.org>
References: <200411250807.32040.adaplas@hotpop.com> <200411251527.15141.andrew@walrond.org> <200411262209.17558.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_tWHqBrSBk3PbZcG"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CY1t9-0005KG-1N
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 27 Nov 2004 04:41:19 -0800
Received: from [62.24.231.113] (helo=cenedra.walrond.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CY1t4-0008PH-5s
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 27 Nov 2004 04:41:18 -0800
In-Reply-To: <200411262209.17558.adaplas@hotpop.com>
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
Cc: "Antonino A. Daplas" <adaplas@hotpop.com>

--Boundary-00=_tWHqBrSBk3PbZcG
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 26 Nov 2004 14:09, Antonino A. Daplas wrote:
> On Thursday 25 November 2004 23:27, Andrew Walrond wrote:
> > On Thursday 25 Nov 2004 00:07, Antonino A. Daplas wrote:
> > > That's assuming 0x31b is supported by your card.  Why not
> > > try:
> > >
> > > vga=ask
> > >
> > > Choose 'scan', choose the highest size, and check if the panel
> > > size changed again.
> >
> > vesafb 'scan' can only find 80xwhatever text modes with dvi connnection,
> > and upto 132xwhatever text modes with dsub. It does not display any
> > graphics modes at all, and rejects them if I try. (I also tried with
> > vesafb only, nvidafb removed - same result).
>
> You can also try this.  1600x1200 is not a standard VESA mode but is most
> probably supported by your card as an OEM mode.  However, we do not know
> the mode id of 1600x1200 since it's different from vendor to vendor.
>
> You can use X though to find out what modes are supported by your Video
> BIOS.
>
> 1. Boot with DVI attached
> 2. Change the X driver to 'vesa' (instead of probably 'nv')
> 3. Launch X
> 4. Check /var/log/XFree86.?.log
> 5. Find the mode id you want, add 0x200 and use it in your 'vga='
>    boot line
>

Hi Tony,

The X vesa driver finds lots of modes when connected with DSUB,including 145 
(1600x1200-8) and 146 (1600x1200-16)

However, when booting with DVI, it only finds these (from X log, full log 
attached)

 andrew@orac ~ $ grep Mode:  Xorg.dvi.vesa.log
 Mode: 100 (640x400)
 Mode: 101 (640x480)
 Mode: 102 (800x600)
 Mode: 103 (800x600)
 Mode: 10e (320x200)
 *Mode: 10f (320x200)
 Mode: 111 (640x480)
 *Mode: 112 (640x480)
 Mode: 114 (800x600)
 *Mode: 115 (800x600)
 Mode: 130 (320x200)
 Mode: 131 (320x400)
 Mode: 132 (320x400)
 *Mode: 133 (320x400)
 Mode: 134 (320x240)
 Mode: 135 (320x240)
 *Mode: 136 (320x240)
 Mode: 13d (640x400)
 *Mode: 13e (640x400)

none which are useful. Trying some of the modes from the DSUB log (ie 145 = 
vga=0x345 etc ) results always in (from memory) "Unsupported mode supplied; 
hit enter for list for wait 30s to continue" during boot. As I said, scan 
only finds text modes.

So, not only is this not going to work, but the vesa driver also seems broken 
when used with dvi.

Andrew

--Boundary-00=_tWHqBrSBk3PbZcG
Content-Type: text/x-log;
  charset="iso-8859-1";
  name="Xorg.dvi.vesa.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Xorg.dvi.vesa.log"


X Window System Version 6.8.0
Release Date: 8 September 2004
X Protocol Version 11, Revision 0, Release 6.8
Build Operating System: Linux 2.6.8.1 x86_64 [ELF] 
Current Operating System: Linux orac.walrond.org 2.6.10-rc2 #14 SMP Sat Nov 27 12:03:10 GMT 2004 x86_64
Build Date: 09 September 2004
	Before reporting problems, check http://wiki.X.Org
	to make sure that you have the latest version.
Module Loader present
Markers: (--) probed, (**) from config file, (==) default setting,
	(++) from command line, (!!) notice, (II) informational,
	(WW) warning, (EE) error, (NI) not implemented, (??) unknown.
(==) Log file: "/pkg/x11.2/state/log/Xorg.0.log", Time: Sat Nov 27 12:13:07 2004
(==) Using config file: "/pkg/x11.2/lib/X11/xorg.conf"
(==) ServerLayout "X.org Configured"
(**) |-->Screen "Screen0" (0)
(**) |   |-->Monitor "Monitor0"
(**) |   |-->Device "Card0"
(**) |-->Input Device "Mouse0"
(**) |-->Input Device "Keyboard0"
(==) FontPath set to "/pkg/x11.2/lib/X11/fonts/misc/,/pkg/x11.2/lib/X11/fonts/TTF/,/pkg/x11.2/lib/X11/fonts/Type1/,/pkg/x11.2/lib/X11/fonts/CID/,/pkg/x11.2/lib/X11/fonts/75dpi/,/pkg/x11.2/lib/X11/fonts/100dpi/"
(**) RgbPath set to "/pkg/x11.2/lib/X11/rgb"
(**) ModulePath set to "/pkg/x11.2/lib64/modules"
(WW) Open APM failed (/dev/apm_bios) (No such file or directory)
(II) Module ABI versions:
	X.Org ANSI C Emulation: 0.2
	X.Org Video Driver: 0.7
	X.Org XInput driver : 0.4
	X.Org Server Extension : 0.2
	X.Org Font Renderer : 0.4
(II) Loader running on linux
(II) LoadModule: "bitmap"
(II) Loading /pkg/x11.2/lib64/modules/fonts/libbitmap.a
(II) Module bitmap: vendor="X.Org Foundation"
	compiled for 6.8.0, module version = 1.0.0
	Module class: X.Org Font Renderer
	ABI class: X.Org Font Renderer, version 0.4
(II) Loading font Bitmap
(II) LoadModule: "pcidata"
(II) Loading /pkg/x11.2/lib64/modules/libpcidata.a
(II) Module pcidata: vendor="X.Org Foundation"
	compiled for 6.8.0, module version = 1.0.0
	ABI class: X.Org Video Driver, version 0.7
(--) using VT number 5

(II) PCI: Probing config type using method 1
(II) PCI: Config type is 1
(II) PCI: stages = 0x03, oldVal1 = 0x8000c29c, mode1Res1 = 0x80000000
(II) PCI: PCI scan (all values are in hex)
(II) PCI: 00:06:0: chip 1022,7460 card 0000,0000 rev 07 class 06,04,00 hdr 01
(II) PCI: 00:07:0: chip 1022,7468 card 1022,7468 rev 05 class 06,01,00 hdr 80
(II) PCI: 00:07:1: chip 1022,7469 card 1022,7469 rev 03 class 01,01,8a hdr 00
(II) PCI: 00:07:2: chip 1022,746a card 1022,746a rev 02 class 0c,05,00 hdr 00
(II) PCI: 00:07:3: chip 1022,746b card 1022,746b rev 05 class 06,80,00 hdr 00
(II) PCI: 00:07:5: chip 1022,746d card 10f1,2885 rev 03 class 04,01,00 hdr 00
(II) PCI: 00:0a:0: chip 1022,7450 card 0000,0000 rev 12 class 06,04,00 hdr 81
(II) PCI: 00:0a:1: chip 1022,7451 card 1022,36c0 rev 01 class 08,00,10 hdr 00
(II) PCI: 00:0b:0: chip 1022,7450 card 0000,0000 rev 12 class 06,04,00 hdr 81
(II) PCI: 00:0b:1: chip 1022,7451 card 1022,36c0 rev 01 class 08,00,10 hdr 00
(II) PCI: 00:18:0: chip 1022,1100 card 0000,0000 rev 00 class 06,00,00 hdr 80
(II) PCI: 00:18:1: chip 1022,1101 card 0000,0000 rev 00 class 06,00,00 hdr 80
(II) PCI: 00:18:2: chip 1022,1102 card 0000,0000 rev 00 class 06,00,00 hdr 80
(II) PCI: 00:18:3: chip 1022,1103 card 0000,0000 rev 00 class 06,00,00 hdr 80
(II) PCI: 00:19:0: chip 1022,1100 card 0000,0000 rev 00 class 06,00,00 hdr 80
(II) PCI: 00:19:1: chip 1022,1101 card 0000,0000 rev 00 class 06,00,00 hdr 80
(II) PCI: 00:19:2: chip 1022,1102 card 0000,0000 rev 00 class 06,00,00 hdr 80
(II) PCI: 00:19:3: chip 1022,1103 card 0000,0000 rev 00 class 06,00,00 hdr 80
(II) PCI: 02:09:0: chip 14e4,16a7 card 10f1,2885 rev 02 class 02,00,00 hdr 00
(II) PCI: 03:00:0: chip 1022,7464 card 1022,7464 rev 0b class 0c,03,10 hdr 80
(II) PCI: 03:00:1: chip 1022,7464 card 1022,7464 rev 0b class 0c,03,10 hdr 00
(II) PCI: 03:0a:0: chip 102b,0519 card 0000,0000 rev 01 class 03,80,00 hdr 00
(II) PCI: 03:0b:0: chip 1095,3114 card 1095,3114 rev 02 class 01,80,00 hdr 00
(II) PCI: 03:0c:0: chip 104c,8023 card 10f1,2885 rev 00 class 0c,00,10 hdr 00
(II) PCI: 04:00:0: chip 1022,7454 card 1022,7454 rev 14 class 06,00,00 hdr 00
(II) PCI: 04:01:0: chip 1022,7455 card 0000,0000 rev 14 class 06,04,00 hdr 01
(II) PCI: 05:00:0: chip 10de,0250 card 1462,8724 rev a2 class 03,00,00 hdr 00
(II) PCI: End of PCI scan
(II) PCI-to-PCI bridge:
(II) Bus 3: bridge is at (0:6:0), (0,3,3), BCTRL: 0x0406 (VGA_EN is cleared)
(II) Bus 3 I/O range:
	[0] -1	0	0x0000a000 - 0x0000a0ff (0x100) IX[B]
	[1] -1	0	0x0000a400 - 0x0000a4ff (0x100) IX[B]
	[2] -1	0	0x0000a800 - 0x0000a8ff (0x100) IX[B]
	[3] -1	0	0x0000ac00 - 0x0000acff (0x100) IX[B]
	[4] -1	0	0x0000b000 - 0x0000b0ff (0x100) IX[B]
	[5] -1	0	0x0000b400 - 0x0000b4ff (0x100) IX[B]
	[6] -1	0	0x0000b800 - 0x0000b8ff (0x100) IX[B]
	[7] -1	0	0x0000bc00 - 0x0000bcff (0x100) IX[B]
(II) Bus 3 non-prefetchable memory range:
	[0] -1	0	0xfc700000 - 0xfc8fffff (0x200000) MX[B]
(II) Bus 3 prefetchable memory range:
	[0] -1	0	0xdb300000 - 0xdc2fffff (0x1000000) MX[B]
(II) PCI-to-ISA bridge:
(II) Bus -1: bridge is at (0:7:0), (0,-1,-1), BCTRL: 0x0008 (VGA_EN is set)
(II) PCI-to-PCI bridge:
(II) Bus 2: bridge is at (0:10:0), (0,2,2), BCTRL: 0x0005 (VGA_EN is cleared)
(II) Bus 2 non-prefetchable memory range:
	[0] -1	0	0xfc600000 - 0xfc6fffff (0x100000) MX[B]
(II) Bus 2 prefetchable memory range:
	[0] -1	0	0xdb200000 - 0xdb2fffff (0x100000) MX[B]
(II) PCI-to-PCI bridge:
(II) Bus 1: bridge is at (0:11:0), (0,1,1), BCTRL: 0x0005 (VGA_EN is cleared)
(II) Host-to-PCI bridge:
(II) Bus 0: bridge is at (0:24:0), (0,0,5), BCTRL: 0x0008 (VGA_EN is set)
(II) Bus 0 I/O range:
	[0] -1	0	0x00000000 - 0x0000ffff (0x10000) IX[B]
(II) Bus 0 non-prefetchable memory range:
	[0] -1	0	0x00000000 - 0xffffffff (0x100000000) MX[B]
(II) Bus 0 prefetchable memory range:
	[0] -1	0	0x00000000 - 0xffffffff (0x100000000) MX[B]
(II) Host-to-PCI bridge:
(II) Bus -1: bridge is at (0:24:1), (-1,-1,5), BCTRL: 0x0008 (VGA_EN is set)
(II) Bus -1 I/O range:
	[0] -1	0	0x00000000 - 0x0000ffff (0x10000) IX[B]
(II) Bus -1 non-prefetchable memory range:
	[0] -1	0	0x00000000 - 0xffffffff (0x100000000) MX[B]
(II) Bus -1 prefetchable memory range:
	[0] -1	0	0x00000000 - 0xffffffff (0x100000000) MX[B]
(II) Host-to-PCI bridge:
(II) Bus -1: bridge is at (0:24:2), (-1,-1,5), BCTRL: 0x0008 (VGA_EN is set)
(II) Bus -1 I/O range:
	[0] -1	0	0x00000000 - 0x0000ffff (0x10000) IX[B]
(II) Bus -1 non-prefetchable memory range:
	[0] -1	0	0x00000000 - 0xffffffff (0x100000000) MX[B]
(II) Bus -1 prefetchable memory range:
	[0] -1	0	0x00000000 - 0xffffffff (0x100000000) MX[B]
(II) Host-to-PCI bridge:
(II) Bus -1: bridge is at (0:24:3), (-1,-1,5), BCTRL: 0x0008 (VGA_EN is set)
(II) Bus -1 I/O range:
	[0] -1	0	0x00000000 - 0x0000ffff (0x10000) IX[B]
(II) Bus -1 non-prefetchable memory range:
	[0] -1	0	0x00000000 - 0xffffffff (0x100000000) MX[B]
(II) Bus -1 prefetchable memory range:
	[0] -1	0	0x00000000 - 0xffffffff (0x100000000) MX[B]
(II) Host-to-PCI bridge:
(II) Bus -1: bridge is at (0:25:0), (-1,-1,5), BCTRL: 0x0008 (VGA_EN is set)
(II) Bus -1 I/O range:
	[0] -1	0	0x00000000 - 0x0000ffff (0x10000) IX[B]
(II) Bus -1 non-prefetchable memory range:
	[0] -1	0	0x00000000 - 0xffffffff (0x100000000) MX[B]
(II) Bus -1 prefetchable memory range:
	[0] -1	0	0x00000000 - 0xffffffff (0x100000000) MX[B]
(II) Host-to-PCI bridge:
(II) Bus -1: bridge is at (0:25:1), (-1,-1,5), BCTRL: 0x0008 (VGA_EN is set)
(II) Bus -1 I/O range:
	[0] -1	0	0x00000000 - 0x0000ffff (0x10000) IX[B]
(II) Bus -1 non-prefetchable memory range:
	[0] -1	0	0x00000000 - 0xffffffff (0x100000000) MX[B]
(II) Bus -1 prefetchable memory range:
	[0] -1	0	0x00000000 - 0xffffffff (0x100000000) MX[B]
(II) Host-to-PCI bridge:
(II) Bus -1: bridge is at (0:25:2), (-1,-1,5), BCTRL: 0x0008 (VGA_EN is set)
(II) Bus -1 I/O range:
	[0] -1	0	0x00000000 - 0x0000ffff (0x10000) IX[B]
(II) Bus -1 non-prefetchable memory range:
	[0] -1	0	0x00000000 - 0xffffffff (0x100000000) MX[B]
(II) Bus -1 prefetchable memory range:
	[0] -1	0	0x00000000 - 0xffffffff (0x100000000) MX[B]
(II) Host-to-PCI bridge:
(II) Bus -1: bridge is at (0:25:3), (-1,-1,5), BCTRL: 0x0008 (VGA_EN is set)
(II) Bus -1 I/O range:
	[0] -1	0	0x00000000 - 0x0000ffff (0x10000) IX[B]
(II) Bus -1 non-prefetchable memory range:
	[0] -1	0	0x00000000 - 0xffffffff (0x100000000) MX[B]
(II) Bus -1 prefetchable memory range:
	[0] -1	0	0x00000000 - 0xffffffff (0x100000000) MX[B]
(II) Host-to-PCI bridge:
(II) Bus 4: bridge is at (4:0:0), (4,4,5), BCTRL: 0x0008 (VGA_EN is set)
(II) Bus 4 I/O range:
	[0] -1	0	0x00000000 - 0x0000ffff (0x10000) IX[B]
(II) Bus 4 non-prefetchable memory range:
	[0] -1	0	0x00000000 - 0xffffffff (0x100000000) MX[B]
(II) Bus 4 prefetchable memory range:
	[0] -1	0	0x00000000 - 0xffffffff (0x100000000) MX[B]
(II) PCI-to-PCI bridge:
(II) Bus 5: bridge is at (4:1:0), (4,5,5), BCTRL: 0x0008 (VGA_EN is set)
(II) Bus 5 non-prefetchable memory range:
	[0] -1	0	0xfca00000 - 0xfeafffff (0x2100000) MX[B]
(II) Bus 5 prefetchable memory range:
	[0] -1	0	0xdc400000 - 0xec4fffff (0x10100000) MX[B]
(--) PCI: (3:10:0) Matrox Graphics, Inc. MGA 2064W [Millennium] rev 1, Mem @ 0xfc8f4000/14, 0xdb800000/23
(--) PCI:*(5:0:0) nVidia Corporation NV25 [GeForce4 Ti 4600] rev 162, Mem @ 0xfd000000/24, 0xe0000000/27, 0xec480000/19, BIOS @ 0xfeae0000/17
(II) Addressable bus resource ranges are
	[0] -1	0	0x00000000 - 0xffffffff (0x100000000) MX[B]
	[1] -1	0	0x00000000 - 0x0000ffff (0x10000) IX[B]
(II) OS-reported resource ranges:
	[0] -1	0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1	0	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[2] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1	0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[6] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
(II) PCI Memory resource overlap reduced 0xf0000000 from 0xf7ffffff to 0xefffffff
(II) Active PCI resource ranges:
	[0] -1	0	0xf0000000 - 0xefffffff (0x0) MX[B]O
	[1] -1	0	0xfc8f8000 - 0xfc8fbfff (0x4000) MX[B]
	[2] -1	0	0xfc8ff000 - 0xfc8ff7ff (0x800) MX[B]
	[3] -1	0	0xfc8ffc00 - 0xfc8fffff (0x400) MX[B]
	[4] -1	0	0xfc8fe000 - 0xfc8fefff (0x1000) MX[B]
	[5] -1	0	0xfc8fd000 - 0xfc8fdfff (0x1000) MX[B]
	[6] -1	0	0xfc6f0000 - 0xfc6fffff (0x10000) MX[B]
	[7] -1	0	0xfc9ff000 - 0xfc9fffff (0x1000) MX[B]
	[8] -1	0	0xfc9fe000 - 0xfc9fefff (0x1000) MX[B]
	[9] -1	0	0xfeae0000 - 0xfeafffff (0x20000) MX[B](B)
	[10] -1	0	0xec480000 - 0xec4fffff (0x80000) MX[B](B)
	[11] -1	0	0xe0000000 - 0xe7ffffff (0x8000000) MX[B](B)
	[12] -1	0	0xfd000000 - 0xfdffffff (0x1000000) MX[B](B)
	[13] -1	0	0xdb800000 - 0xdbffffff (0x800000) MX[B](B)
	[14] -1	0	0xfc8f4000 - 0xfc8f7fff (0x4000) MX[B](B)
	[15] -1	0	0x0000ac00 - 0x0000ac0f (0x10) IX[B]
	[16] -1	0	0x0000b000 - 0x0000b003 (0x4) IX[B]
	[17] -1	0	0x0000b400 - 0x0000b407 (0x8) IX[B]
	[18] -1	0	0x0000b800 - 0x0000b803 (0x4) IX[B]
	[19] -1	0	0x0000bc00 - 0x0000bc07 (0x8) IX[B]
	[20] -1	0	0x0000cc00 - 0x0000cc3f (0x40) IX[B]
	[21] -1	0	0x0000c800 - 0x0000c8ff (0x100) IX[B]
	[22] -1	0	0x0000c400 - 0x0000c41f (0x20) IX[B]
	[23] -1	0	0x0000ffa0 - 0x0000ffaf (0x10) IX[B]
(II) Active PCI resource ranges after removing overlaps:
	[0] -1	0	0xf0000000 - 0xefffffff (0x0) MX[B]O
	[1] -1	0	0xfc8f8000 - 0xfc8fbfff (0x4000) MX[B]
	[2] -1	0	0xfc8ff000 - 0xfc8ff7ff (0x800) MX[B]
	[3] -1	0	0xfc8ffc00 - 0xfc8fffff (0x400) MX[B]
	[4] -1	0	0xfc8fe000 - 0xfc8fefff (0x1000) MX[B]
	[5] -1	0	0xfc8fd000 - 0xfc8fdfff (0x1000) MX[B]
	[6] -1	0	0xfc6f0000 - 0xfc6fffff (0x10000) MX[B]
	[7] -1	0	0xfc9ff000 - 0xfc9fffff (0x1000) MX[B]
	[8] -1	0	0xfc9fe000 - 0xfc9fefff (0x1000) MX[B]
	[9] -1	0	0xfeae0000 - 0xfeafffff (0x20000) MX[B](B)
	[10] -1	0	0xec480000 - 0xec4fffff (0x80000) MX[B](B)
	[11] -1	0	0xe0000000 - 0xe7ffffff (0x8000000) MX[B](B)
	[12] -1	0	0xfd000000 - 0xfdffffff (0x1000000) MX[B](B)
	[13] -1	0	0xdb800000 - 0xdbffffff (0x800000) MX[B](B)
	[14] -1	0	0xfc8f4000 - 0xfc8f7fff (0x4000) MX[B](B)
	[15] -1	0	0x0000ac00 - 0x0000ac0f (0x10) IX[B]
	[16] -1	0	0x0000b000 - 0x0000b003 (0x4) IX[B]
	[17] -1	0	0x0000b400 - 0x0000b407 (0x8) IX[B]
	[18] -1	0	0x0000b800 - 0x0000b803 (0x4) IX[B]
	[19] -1	0	0x0000bc00 - 0x0000bc07 (0x8) IX[B]
	[20] -1	0	0x0000cc00 - 0x0000cc3f (0x40) IX[B]
	[21] -1	0	0x0000c800 - 0x0000c8ff (0x100) IX[B]
	[22] -1	0	0x0000c400 - 0x0000c41f (0x20) IX[B]
	[23] -1	0	0x0000ffa0 - 0x0000ffaf (0x10) IX[B]
(II) OS-reported resource ranges after removing overlaps with PCI:
	[0] -1	0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1	0	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[2] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1	0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[6] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
(II) All system resource ranges:
	[0] -1	0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1	0	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[2] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1	0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1	0	0xf0000000 - 0xefffffff (0x0) MX[B]O
	[6] -1	0	0xfc8f8000 - 0xfc8fbfff (0x4000) MX[B]
	[7] -1	0	0xfc8ff000 - 0xfc8ff7ff (0x800) MX[B]
	[8] -1	0	0xfc8ffc00 - 0xfc8fffff (0x400) MX[B]
	[9] -1	0	0xfc8fe000 - 0xfc8fefff (0x1000) MX[B]
	[10] -1	0	0xfc8fd000 - 0xfc8fdfff (0x1000) MX[B]
	[11] -1	0	0xfc6f0000 - 0xfc6fffff (0x10000) MX[B]
	[12] -1	0	0xfc9ff000 - 0xfc9fffff (0x1000) MX[B]
	[13] -1	0	0xfc9fe000 - 0xfc9fefff (0x1000) MX[B]
	[14] -1	0	0xfeae0000 - 0xfeafffff (0x20000) MX[B](B)
	[15] -1	0	0xec480000 - 0xec4fffff (0x80000) MX[B](B)
	[16] -1	0	0xe0000000 - 0xe7ffffff (0x8000000) MX[B](B)
	[17] -1	0	0xfd000000 - 0xfdffffff (0x1000000) MX[B](B)
	[18] -1	0	0xdb800000 - 0xdbffffff (0x800000) MX[B](B)
	[19] -1	0	0xfc8f4000 - 0xfc8f7fff (0x4000) MX[B](B)
	[20] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[21] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
	[22] -1	0	0x0000ac00 - 0x0000ac0f (0x10) IX[B]
	[23] -1	0	0x0000b000 - 0x0000b003 (0x4) IX[B]
	[24] -1	0	0x0000b400 - 0x0000b407 (0x8) IX[B]
	[25] -1	0	0x0000b800 - 0x0000b803 (0x4) IX[B]
	[26] -1	0	0x0000bc00 - 0x0000bc07 (0x8) IX[B]
	[27] -1	0	0x0000cc00 - 0x0000cc3f (0x40) IX[B]
	[28] -1	0	0x0000c800 - 0x0000c8ff (0x100) IX[B]
	[29] -1	0	0x0000c400 - 0x0000c41f (0x20) IX[B]
	[30] -1	0	0x0000ffa0 - 0x0000ffaf (0x10) IX[B]
(II) LoadModule: "extmod"
(II) Loading /pkg/x11.2/lib64/modules/extensions/libextmod.a
(II) Module extmod: vendor="X.Org Foundation"
	compiled for 6.8.0, module version = 1.0.0
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
(II) Loading extension TOG-CUP
(II) Loading extension Extended-Visual-Information
(II) Loading extension XVideo
(II) Loading extension XVideo-MotionCompensation
(II) Loading extension X-Resource
(II) LoadModule: "glx"
(II) Loading /pkg/x11.2/lib64/modules/extensions/libglx.a
(II) Module glx: vendor="X.Org Foundation"
	compiled for 6.8.0, module version = 1.0.0
	ABI class: X.Org Server Extension, version 0.2
(II) Loading sub module "GLcore"
(II) LoadModule: "GLcore"
(II) Loading /pkg/x11.2/lib64/modules/extensions/libGLcore.a
(II) Module GLcore: vendor="X.Org Foundation"
	compiled for 6.8.0, module version = 1.0.0
	ABI class: X.Org Server Extension, version 0.2
(II) Loading extension GLX
(II) LoadModule: "dri"
(II) Loading /pkg/x11.2/lib64/modules/extensions/libdri.a
(II) Module dri: vendor="X.Org Foundation"
	compiled for 6.8.0, module version = 1.0.0
	ABI class: X.Org Server Extension, version 0.2
(II) Loading sub module "drm"
(II) LoadModule: "drm"
(II) Loading /pkg/x11.2/lib64/modules/linux/libdrm.a
(II) Module drm: vendor="X.Org Foundation"
	compiled for 6.8.0, module version = 1.0.0
	ABI class: X.Org Server Extension, version 0.2
(II) Loading extension XFree86-DRI
(II) LoadModule: "dbe"
(II) Loading /pkg/x11.2/lib64/modules/extensions/libdbe.a
(II) Module dbe: vendor="X.Org Foundation"
	compiled for 6.8.0, module version = 1.0.0
	Module class: X.Org Server Extension
	ABI class: X.Org Server Extension, version 0.2
(II) Loading extension DOUBLE-BUFFER
(II) LoadModule: "record"
(II) Loading /pkg/x11.2/lib64/modules/extensions/librecord.a
(II) Module record: vendor="X.Org Foundation"
	compiled for 6.8.0, module version = 1.13.0
	Module class: X.Org Server Extension
	ABI class: X.Org Server Extension, version 0.2
(II) Loading extension RECORD
(II) LoadModule: "xtrap"
(II) Loading /pkg/x11.2/lib64/modules/extensions/libxtrap.a
(II) Module xtrap: vendor="X.Org Foundation"
	compiled for 6.8.0, module version = 1.0.0
	Module class: X.Org Server Extension
	ABI class: X.Org Server Extension, version 0.2
(II) Loading extension DEC-XTRAP
(II) LoadModule: "vesa"
(II) Loading /pkg/x11.2/lib64/modules/drivers/vesa_drv.o
(II) Module vesa: vendor="X.Org Foundation"
	compiled for 6.8.0, module version = 1.0.0
	Module class: X.Org Video Driver
	ABI class: X.Org Video Driver, version 0.7
(II) LoadModule: "mouse"
(II) Loading /pkg/x11.2/lib64/modules/input/mouse_drv.o
(II) Module mouse: vendor="X.Org Foundation"
	compiled for 6.8.0, module version = 1.0.0
	Module class: X.Org XInput Driver
	ABI class: X.Org XInput driver, version 0.4
(II) LoadModule: "kbd"
(II) Loading /pkg/x11.2/lib64/modules/input/kbd_drv.o
(II) Module kbd: vendor="X.Org Foundation"
	compiled for 6.8.0, module version = 1.0.0
	Module class: X.Org XInput Driver
	ABI class: X.Org XInput driver, version 0.4
(II) VESA: driver for VESA chipsets: vesa
(II) Primary Device is: PCI 05:00:0
(--) Chipset vesa found
(II) resource ranges after xf86ClaimFixedResources() call:
	[0] -1	0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1	0	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[2] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1	0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1	0	0xf0000000 - 0xefffffff (0x0) MX[B]O
	[6] -1	0	0xfc8f8000 - 0xfc8fbfff (0x4000) MX[B]
	[7] -1	0	0xfc8ff000 - 0xfc8ff7ff (0x800) MX[B]
	[8] -1	0	0xfc8ffc00 - 0xfc8fffff (0x400) MX[B]
	[9] -1	0	0xfc8fe000 - 0xfc8fefff (0x1000) MX[B]
	[10] -1	0	0xfc8fd000 - 0xfc8fdfff (0x1000) MX[B]
	[11] -1	0	0xfc6f0000 - 0xfc6fffff (0x10000) MX[B]
	[12] -1	0	0xfc9ff000 - 0xfc9fffff (0x1000) MX[B]
	[13] -1	0	0xfc9fe000 - 0xfc9fefff (0x1000) MX[B]
	[14] -1	0	0xfeae0000 - 0xfeafffff (0x20000) MX[B](B)
	[15] -1	0	0xec480000 - 0xec4fffff (0x80000) MX[B](B)
	[16] -1	0	0xe0000000 - 0xe7ffffff (0x8000000) MX[B](B)
	[17] -1	0	0xfd000000 - 0xfdffffff (0x1000000) MX[B](B)
	[18] -1	0	0xdb800000 - 0xdbffffff (0x800000) MX[B](B)
	[19] -1	0	0xfc8f4000 - 0xfc8f7fff (0x4000) MX[B](B)
	[20] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[21] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
	[22] -1	0	0x0000ac00 - 0x0000ac0f (0x10) IX[B]
	[23] -1	0	0x0000b000 - 0x0000b003 (0x4) IX[B]
	[24] -1	0	0x0000b400 - 0x0000b407 (0x8) IX[B]
	[25] -1	0	0x0000b800 - 0x0000b803 (0x4) IX[B]
	[26] -1	0	0x0000bc00 - 0x0000bc07 (0x8) IX[B]
	[27] -1	0	0x0000cc00 - 0x0000cc3f (0x40) IX[B]
	[28] -1	0	0x0000c800 - 0x0000c8ff (0x100) IX[B]
	[29] -1	0	0x0000c400 - 0x0000c41f (0x20) IX[B]
	[30] -1	0	0x0000ffa0 - 0x0000ffaf (0x10) IX[B]
(II) resource ranges after probing:
	[0] -1	0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1	0	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[2] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1	0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1	0	0xf0000000 - 0xefffffff (0x0) MX[B]O
	[6] -1	0	0xfc8f8000 - 0xfc8fbfff (0x4000) MX[B]
	[7] -1	0	0xfc8ff000 - 0xfc8ff7ff (0x800) MX[B]
	[8] -1	0	0xfc8ffc00 - 0xfc8fffff (0x400) MX[B]
	[9] -1	0	0xfc8fe000 - 0xfc8fefff (0x1000) MX[B]
	[10] -1	0	0xfc8fd000 - 0xfc8fdfff (0x1000) MX[B]
	[11] -1	0	0xfc6f0000 - 0xfc6fffff (0x10000) MX[B]
	[12] -1	0	0xfc9ff000 - 0xfc9fffff (0x1000) MX[B]
	[13] -1	0	0xfc9fe000 - 0xfc9fefff (0x1000) MX[B]
	[14] -1	0	0xfeae0000 - 0xfeafffff (0x20000) MX[B](B)
	[15] -1	0	0xec480000 - 0xec4fffff (0x80000) MX[B](B)
	[16] -1	0	0xe0000000 - 0xe7ffffff (0x8000000) MX[B](B)
	[17] -1	0	0xfd000000 - 0xfdffffff (0x1000000) MX[B](B)
	[18] -1	0	0xdb800000 - 0xdbffffff (0x800000) MX[B](B)
	[19] -1	0	0xfc8f4000 - 0xfc8f7fff (0x4000) MX[B](B)
	[20] 0	0	0x000a0000 - 0x000affff (0x10000) MS[B]
	[21] 0	0	0x000b0000 - 0x000b7fff (0x8000) MS[B]
	[22] 0	0	0x000b8000 - 0x000bffff (0x8000) MS[B]
	[23] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[24] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
	[25] -1	0	0x0000ac00 - 0x0000ac0f (0x10) IX[B]
	[26] -1	0	0x0000b000 - 0x0000b003 (0x4) IX[B]
	[27] -1	0	0x0000b400 - 0x0000b407 (0x8) IX[B]
	[28] -1	0	0x0000b800 - 0x0000b803 (0x4) IX[B]
	[29] -1	0	0x0000bc00 - 0x0000bc07 (0x8) IX[B]
	[30] -1	0	0x0000cc00 - 0x0000cc3f (0x40) IX[B]
	[31] -1	0	0x0000c800 - 0x0000c8ff (0x100) IX[B]
	[32] -1	0	0x0000c400 - 0x0000c41f (0x20) IX[B]
	[33] -1	0	0x0000ffa0 - 0x0000ffaf (0x10) IX[B]
	[34] 0	0	0x000003b0 - 0x000003bb (0xc) IS[B]
	[35] 0	0	0x000003c0 - 0x000003df (0x20) IS[B]
(II) Setting vga for screen 0.
(II) Loading sub module "vbe"
(II) LoadModule: "vbe"
(II) Loading /pkg/x11.2/lib64/modules/libvbe.a
(II) Module vbe: vendor="X.Org Foundation"
	compiled for 6.8.0, module version = 1.1.0
	ABI class: X.Org Video Driver, version 0.7
(II) Loading sub module "int10"
(II) LoadModule: "int10"
(II) Loading /pkg/x11.2/lib64/modules/linux/libint10.a
(II) Module int10: vendor="X.Org Foundation"
	compiled for 6.8.0, module version = 1.0.0
	ABI class: X.Org Video Driver, version 0.7
(II) VESA(0): initializing int10
(II) VESA(0): Primary V_BIOS segment is: 0xc000
(II) VESA(0): VESA BIOS detected
(II) VESA(0): VESA VBE Version 3.0
(II) VESA(0): VESA VBE Total Mem: 131072 kB
(II) VESA(0): VESA VBE OEM: NVidia
(II) VESA(0): VESA VBE OEM Software Rev: 4.37
(II) VESA(0): VESA VBE OEM Vendor: NVidia Corporation
(II) VESA(0): VESA VBE OEM Product: NV25 Board
(II) VESA(0): VESA VBE OEM Product Rev: Chip Rev   
(**) VESA(0): Depth 24, (--) framebuffer bpp 32
(==) VESA(0): RGB weight 888
(==) VESA(0): Default visual is TrueColor
(==) VESA(0): Using gamma correction (1.0, 1.0, 1.0)
(II) Loading sub module "ddc"
(II) LoadModule: "ddc"
(II) Loading /pkg/x11.2/lib64/modules/libddc.a
(II) Module ddc: vendor="X.Org Foundation"
	compiled for 6.8.0, module version = 1.0.0
	ABI class: X.Org Video Driver, version 0.7
(II) VESA(0): VESA VBE DDC supported
(II) VESA(0): VESA VBE DDC Level 2
(II) VESA(0): VESA VBE DDC transfer in appr. 1 sec.
(II) VESA(0): VESA VBE DDC read successfully
(II) VESA(0): Manufacturer: IVM  Model: 4800  Serial#: 1001
(II) VESA(0): Year: 2002  Week: 1
(II) VESA(0): EDID Version: 1.3
(II) VESA(0): Digital Display Input
(II) VESA(0): Max H-Image Size [cm]: horiz.: 39  vert.: 29
(II) VESA(0): Gamma: 2.20
(II) VESA(0): DPMS capabilities: StandBy Suspend Off; RGB/Color Display
(II) VESA(0): First detailed timing is preferred mode
(II) VESA(0): redX: 0.619 redY: 0.340   greenX: 0.279 greenY: 0.600
(II) VESA(0): blueX: 0.140 blueY: 0.090   whiteX: 0.289 whiteY: 0.300
(II) VESA(0): Supported VESA Video Modes:
(II) VESA(0): 720x400@70Hz
(II) VESA(0): 640x480@60Hz
(II) VESA(0): 640x480@67Hz
(II) VESA(0): 640x480@72Hz
(II) VESA(0): 640x480@75Hz
(II) VESA(0): 800x600@56Hz
(II) VESA(0): 800x600@60Hz
(II) VESA(0): 800x600@72Hz
(II) VESA(0): 800x600@75Hz
(II) VESA(0): 832x624@75Hz
(II) VESA(0): 1024x768@60Hz
(II) VESA(0): 1024x768@70Hz
(II) VESA(0): 1024x768@75Hz
(II) VESA(0): 1280x1024@75Hz
(II) VESA(0): 1152x870@75Hz
(II) VESA(0): Manufacturer's mask: 0
(II) VESA(0): Supported Future Video Modes:
(II) VESA(0): #0: hsize: 1280  vsize 1024  refresh: 60  vid: 32897
(II) VESA(0): #1: hsize: 1024  vsize 819  refresh: 85  vid: 39265
(II) VESA(0): #2: hsize: 800  vsize 640  refresh: 85  vid: 39237
(II) VESA(0): #3: hsize: 640  vsize 512  refresh: 85  vid: 39217
(II) VESA(0): Supported additional Video Mode:
(II) VESA(0): clock: 65.0 MHz   Image Size:  386 x 290 mm
(II) VESA(0): h_active: 1024  h_sync: 1040  h_sync_end 1104 h_blank_end 1344 h_border: 0
(II) VESA(0): v_active: 768  v_sync: 781  v_sync_end 783 v_blanking: 817 v_border: 0
(II) VESA(0): Supported additional Video Mode:
(II) VESA(0): clock: 162.0 MHz   Image Size:  386 x 290 mm
(II) VESA(0): h_active: 1600  h_sync: 1664  h_sync_end 1856 h_blank_end 2160 h_border: 0
(II) VESA(0): v_active: 1200  v_sync: 1201  v_sync_end 1204 v_blanking: 1250 v_border: 0
(II) VESA(0): Ranges: V min: 56  V max: 85 Hz, H min: 30  H max: 80 kHz, PixClock max 170 MHz
(II) VESA(0): Monitor name: iiyama
(II) VESA(0): Searching for matching VESA mode(s):
Mode: 100 (640x400)
	ModeAttributes: 0x39f
	WinAAttributes: 0x7
	WinBAttributes: 0x0
	WinGranularity: 64
	WinSize: 64
	WinASegment: 0xa000
	WinBSegment: 0x0
	WinFuncPtr: 0xc000a455
	BytesPerScanline: 640
	XResolution: 640
	YResolution: 400
	XCharSize: 8
	YCharSize: 16
	NumberOfPlanes: 1
	BitsPerPixel: 8
	NumberOfBanks: 1
	MemoryModel: 4
	BankSize: 0
	NumberOfImages: 14
	RedMaskSize: 0
	RedFieldPosition: 0
	GreenMaskSize: 0
	GreenFieldPosition: 0
	BlueMaskSize: 0
	BlueFieldPosition: 0
	RsvdMaskSize: 0
	RsvdFieldPosition: 0
	DirectColorModeInfo: 0
	PhysBasePtr: 0xe0000000
	LinBytesPerScanLine: 640
	BnkNumberOfImagePages: 14
	LinNumberOfImagePages: 14
	LinRedMaskSize: 0
	LinRedFieldPosition: 0
	LinGreenMaskSize: 0
	LinGreenFieldPosition: 0
	LinBlueMaskSize: 0
	LinBlueFieldPosition: 0
	LinRsvdMaskSize: 0
	LinRsvdFieldPosition: 0
	MaxPixelClock: 229500000
Mode: 101 (640x480)
	ModeAttributes: 0x39f
	WinAAttributes: 0x7
	WinBAttributes: 0x0
	WinGranularity: 64
	WinSize: 64
	WinASegment: 0xa000
	WinBSegment: 0x0
	WinFuncPtr: 0xc000a455
	BytesPerScanline: 640
	XResolution: 640
	YResolution: 480
	XCharSize: 8
	YCharSize: 16
	NumberOfPlanes: 1
	BitsPerPixel: 8
	NumberOfBanks: 1
	MemoryModel: 4
	BankSize: 0
	NumberOfImages: 10
	RedMaskSize: 0
	RedFieldPosition: 0
	GreenMaskSize: 0
	GreenFieldPosition: 0
	BlueMaskSize: 0
	BlueFieldPosition: 0
	RsvdMaskSize: 0
	RsvdFieldPosition: 0
	DirectColorModeInfo: 0
	PhysBasePtr: 0xe0000000
	LinBytesPerScanLine: 640
	BnkNumberOfImagePages: 10
	LinNumberOfImagePages: 10
	LinRedMaskSize: 0
	LinRedFieldPosition: 0
	LinGreenMaskSize: 0
	LinGreenFieldPosition: 0
	LinBlueMaskSize: 0
	LinBlueFieldPosition: 0
	LinRsvdMaskSize: 0
	LinRsvdFieldPosition: 0
	MaxPixelClock: 229500000
Mode: 102 (800x600)
	ModeAttributes: 0x31f
	WinAAttributes: 0x7
	WinBAttributes: 0x0
	WinGranularity: 64
	WinSize: 64
	WinASegment: 0xa000
	WinBSegment: 0x0
	WinFuncPtr: 0xc000a455
	BytesPerScanline: 100
	XResolution: 800
	YResolution: 600
	XCharSize: 8
	YCharSize: 16
	NumberOfPlanes: 4
	BitsPerPixel: 4
	NumberOfBanks: 1
	MemoryModel: 3
	BankSize: 0
	NumberOfImages: 14
	RedMaskSize: 0
	RedFieldPosition: 0
	GreenMaskSize: 0
	GreenFieldPosition: 0
	BlueMaskSize: 0
	BlueFieldPosition: 0
	RsvdMaskSize: 0
	RsvdFieldPosition: 0
	DirectColorModeInfo: 0
	PhysBasePtr: 0x0
	LinBytesPerScanLine: 100
	BnkNumberOfImagePages: 14
	LinNumberOfImagePages: 14
	LinRedMaskSize: 0
	LinRedFieldPosition: 0
	LinGreenMaskSize: 0
	LinGreenFieldPosition: 0
	LinBlueMaskSize: 0
	LinBlueFieldPosition: 0
	LinRsvdMaskSize: 0
	LinRsvdFieldPosition: 0
	MaxPixelClock: 108500000
Mode: 103 (800x600)
	ModeAttributes: 0x39f
	WinAAttributes: 0x7
	WinBAttributes: 0x0
	WinGranularity: 64
	WinSize: 64
	WinASegment: 0xa000
	WinBSegment: 0x0
	WinFuncPtr: 0xc000a455
	BytesPerScanline: 800
	XResolution: 800
	YResolution: 600
	XCharSize: 8
	YCharSize: 16
	NumberOfPlanes: 1
	BitsPerPixel: 8
	NumberOfBanks: 1
	MemoryModel: 4
	BankSize: 0
	NumberOfImages: 6
	RedMaskSize: 0
	RedFieldPosition: 0
	GreenMaskSize: 0
	GreenFieldPosition: 0
	BlueMaskSize: 0
	BlueFieldPosition: 0
	RsvdMaskSize: 0
	RsvdFieldPosition: 0
	DirectColorModeInfo: 0
	PhysBasePtr: 0xe0000000
	LinBytesPerScanLine: 800
	BnkNumberOfImagePages: 6
	LinNumberOfImagePages: 6
	LinRedMaskSize: 0
	LinRedFieldPosition: 0
	LinGreenMaskSize: 0
	LinGreenFieldPosition: 0
	LinBlueMaskSize: 0
	LinBlueFieldPosition: 0
	LinRsvdMaskSize: 0
	LinRsvdFieldPosition: 0
	MaxPixelClock: 229500000
Mode: 10e (320x200)
	ModeAttributes: 0x39f
	WinAAttributes: 0x7
	WinBAttributes: 0x0
	WinGranularity: 64
	WinSize: 64
	WinASegment: 0xa000
	WinBSegment: 0x0
	WinFuncPtr: 0xc000a455
	BytesPerScanline: 640
	XResolution: 320
	YResolution: 200
	XCharSize: 8
	YCharSize: 8
	NumberOfPlanes: 1
	BitsPerPixel: 16
	NumberOfBanks: 1
	MemoryModel: 6
	BankSize: 0
	NumberOfImages: 30
	RedMaskSize: 5
	RedFieldPosition: 11
	GreenMaskSize: 6
	GreenFieldPosition: 5
	BlueMaskSize: 5
	BlueFieldPosition: 0
	RsvdMaskSize: 0
	RsvdFieldPosition: 0
	DirectColorModeInfo: 0
	PhysBasePtr: 0xe0000000
	LinBytesPerScanLine: 640
	BnkNumberOfImagePages: 30
	LinNumberOfImagePages: 30
	LinRedMaskSize: 5
	LinRedFieldPosition: 11
	LinGreenMaskSize: 6
	LinGreenFieldPosition: 5
	LinBlueMaskSize: 5
	LinBlueFieldPosition: 0
	LinRsvdMaskSize: 0
	LinRsvdFieldPosition: 0
	MaxPixelClock: 229500000
*Mode: 10f (320x200)
	ModeAttributes: 0x39f
	WinAAttributes: 0x7
	WinBAttributes: 0x0
	WinGranularity: 64
	WinSize: 64
	WinASegment: 0xa000
	WinBSegment: 0x0
	WinFuncPtr: 0xc000a455
	BytesPerScanline: 1280
	XResolution: 320
	YResolution: 200
	XCharSize: 8
	YCharSize: 8
	NumberOfPlanes: 1
	BitsPerPixel: 32
	NumberOfBanks: 1
	MemoryModel: 6
	BankSize: 0
	NumberOfImages: 14
	RedMaskSize: 8
	RedFieldPosition: 16
	GreenMaskSize: 8
	GreenFieldPosition: 8
	BlueMaskSize: 8
	BlueFieldPosition: 0
	RsvdMaskSize: 8
	RsvdFieldPosition: 24
	DirectColorModeInfo: 0
	PhysBasePtr: 0xe0000000
	LinBytesPerScanLine: 1280
	BnkNumberOfImagePages: 14
	LinNumberOfImagePages: 14
	LinRedMaskSize: 8
	LinRedFieldPosition: 16
	LinGreenMaskSize: 8
	LinGreenFieldPosition: 8
	LinBlueMaskSize: 8
	LinBlueFieldPosition: 0
	LinRsvdMaskSize: 8
	LinRsvdFieldPosition: 24
	MaxPixelClock: 229500000
Mode: 111 (640x480)
	ModeAttributes: 0x39f
	WinAAttributes: 0x7
	WinBAttributes: 0x0
	WinGranularity: 64
	WinSize: 64
	WinASegment: 0xa000
	WinBSegment: 0x0
	WinFuncPtr: 0xc000a455
	BytesPerScanline: 1280
	XResolution: 640
	YResolution: 480
	XCharSize: 8
	YCharSize: 16
	NumberOfPlanes: 1
	BitsPerPixel: 16
	NumberOfBanks: 1
	MemoryModel: 6
	BankSize: 0
	NumberOfImages: 4
	RedMaskSize: 5
	RedFieldPosition: 11
	GreenMaskSize: 6
	GreenFieldPosition: 5
	BlueMaskSize: 5
	BlueFieldPosition: 0
	RsvdMaskSize: 0
	RsvdFieldPosition: 0
	DirectColorModeInfo: 0
	PhysBasePtr: 0xe0000000
	LinBytesPerScanLine: 1280
	BnkNumberOfImagePages: 4
	LinNumberOfImagePages: 4
	LinRedMaskSize: 5
	LinRedFieldPosition: 11
	LinGreenMaskSize: 6
	LinGreenFieldPosition: 5
	LinBlueMaskSize: 5
	LinBlueFieldPosition: 0
	LinRsvdMaskSize: 0
	LinRsvdFieldPosition: 0
	MaxPixelClock: 229500000
*Mode: 112 (640x480)
	ModeAttributes: 0x39f
	WinAAttributes: 0x7
	WinBAttributes: 0x0
	WinGranularity: 64
	WinSize: 64
	WinASegment: 0xa000
	WinBSegment: 0x0
	WinFuncPtr: 0xc000a455
	BytesPerScanline: 2560
	XResolution: 640
	YResolution: 480
	XCharSize: 8
	YCharSize: 16
	NumberOfPlanes: 1
	BitsPerPixel: 32
	NumberOfBanks: 1
	MemoryModel: 6
	BankSize: 0
	NumberOfImages: 1
	RedMaskSize: 8
	RedFieldPosition: 16
	GreenMaskSize: 8
	GreenFieldPosition: 8
	BlueMaskSize: 8
	BlueFieldPosition: 0
	RsvdMaskSize: 8
	RsvdFieldPosition: 24
	DirectColorModeInfo: 0
	PhysBasePtr: 0xe0000000
	LinBytesPerScanLine: 2560
	BnkNumberOfImagePages: 1
	LinNumberOfImagePages: 1
	LinRedMaskSize: 8
	LinRedFieldPosition: 16
	LinGreenMaskSize: 8
	LinGreenFieldPosition: 8
	LinBlueMaskSize: 8
	LinBlueFieldPosition: 0
	LinRsvdMaskSize: 8
	LinRsvdFieldPosition: 24
	MaxPixelClock: 229500000
Mode: 114 (800x600)
	ModeAttributes: 0x39f
	WinAAttributes: 0x7
	WinBAttributes: 0x0
	WinGranularity: 64
	WinSize: 64
	WinASegment: 0xa000
	WinBSegment: 0x0
	WinFuncPtr: 0xc000a455
	BytesPerScanline: 1600
	XResolution: 800
	YResolution: 600
	XCharSize: 8
	YCharSize: 16
	NumberOfPlanes: 1
	BitsPerPixel: 16
	NumberOfBanks: 1
	MemoryModel: 6
	BankSize: 0
	NumberOfImages: 2
	RedMaskSize: 5
	RedFieldPosition: 11
	GreenMaskSize: 6
	GreenFieldPosition: 5
	BlueMaskSize: 5
	BlueFieldPosition: 0
	RsvdMaskSize: 0
	RsvdFieldPosition: 0
	DirectColorModeInfo: 0
	PhysBasePtr: 0xe0000000
	LinBytesPerScanLine: 1600
	BnkNumberOfImagePages: 2
	LinNumberOfImagePages: 2
	LinRedMaskSize: 5
	LinRedFieldPosition: 11
	LinGreenMaskSize: 6
	LinGreenFieldPosition: 5
	LinBlueMaskSize: 5
	LinBlueFieldPosition: 0
	LinRsvdMaskSize: 0
	LinRsvdFieldPosition: 0
	MaxPixelClock: 229500000
*Mode: 115 (800x600)
	ModeAttributes: 0x39f
	WinAAttributes: 0x7
	WinBAttributes: 0x0
	WinGranularity: 64
	WinSize: 64
	WinASegment: 0xa000
	WinBSegment: 0x0
	WinFuncPtr: 0xc000a455
	BytesPerScanline: 3200
	XResolution: 800
	YResolution: 600
	XCharSize: 8
	YCharSize: 16
	NumberOfPlanes: 1
	BitsPerPixel: 32
	NumberOfBanks: 1
	MemoryModel: 6
	BankSize: 0
	NumberOfImages: 1
	RedMaskSize: 8
	RedFieldPosition: 16
	GreenMaskSize: 8
	GreenFieldPosition: 8
	BlueMaskSize: 8
	BlueFieldPosition: 0
	RsvdMaskSize: 8
	RsvdFieldPosition: 24
	DirectColorModeInfo: 0
	PhysBasePtr: 0xe0000000
	LinBytesPerScanLine: 3200
	BnkNumberOfImagePages: 1
	LinNumberOfImagePages: 1
	LinRedMaskSize: 8
	LinRedFieldPosition: 16
	LinGreenMaskSize: 8
	LinGreenFieldPosition: 8
	LinBlueMaskSize: 8
	LinBlueFieldPosition: 0
	LinRsvdMaskSize: 8
	LinRsvdFieldPosition: 24
	MaxPixelClock: 229500000
Mode: 130 (320x200)
	ModeAttributes: 0x39f
	WinAAttributes: 0x7
	WinBAttributes: 0x0
	WinGranularity: 64
	WinSize: 64
	WinASegment: 0xa000
	WinBSegment: 0x0
	WinFuncPtr: 0xc000a455
	BytesPerScanline: 320
	XResolution: 320
	YResolution: 200
	XCharSize: 8
	YCharSize: 8
	NumberOfPlanes: 1
	BitsPerPixel: 8
	NumberOfBanks: 1
	MemoryModel: 4
	BankSize: 0
	NumberOfImages: 62
	RedMaskSize: 0
	RedFieldPosition: 0
	GreenMaskSize: 0
	GreenFieldPosition: 0
	BlueMaskSize: 0
	BlueFieldPosition: 0
	RsvdMaskSize: 0
	RsvdFieldPosition: 0
	DirectColorModeInfo: 0
	PhysBasePtr: 0xe0000000
	LinBytesPerScanLine: 320
	BnkNumberOfImagePages: 62
	LinNumberOfImagePages: 62
	LinRedMaskSize: 0
	LinRedFieldPosition: 0
	LinGreenMaskSize: 0
	LinGreenFieldPosition: 0
	LinBlueMaskSize: 0
	LinBlueFieldPosition: 0
	LinRsvdMaskSize: 0
	LinRsvdFieldPosition: 0
	MaxPixelClock: 229500000
Mode: 131 (320x400)
	ModeAttributes: 0x39f
	WinAAttributes: 0x7
	WinBAttributes: 0x0
	WinGranularity: 64
	WinSize: 64
	WinASegment: 0xa000
	WinBSegment: 0x0
	WinFuncPtr: 0xc000a455
	BytesPerScanline: 320
	XResolution: 320
	YResolution: 400
	XCharSize: 8
	YCharSize: 16
	NumberOfPlanes: 1
	BitsPerPixel: 8
	NumberOfBanks: 1
	MemoryModel: 4
	BankSize: 0
	NumberOfImages: 30
	RedMaskSize: 0
	RedFieldPosition: 0
	GreenMaskSize: 0
	GreenFieldPosition: 0
	BlueMaskSize: 0
	BlueFieldPosition: 0
	RsvdMaskSize: 0
	RsvdFieldPosition: 0
	DirectColorModeInfo: 0
	PhysBasePtr: 0xe0000000
	LinBytesPerScanLine: 320
	BnkNumberOfImagePages: 30
	LinNumberOfImagePages: 30
	LinRedMaskSize: 0
	LinRedFieldPosition: 0
	LinGreenMaskSize: 0
	LinGreenFieldPosition: 0
	LinBlueMaskSize: 0
	LinBlueFieldPosition: 0
	LinRsvdMaskSize: 0
	LinRsvdFieldPosition: 0
	MaxPixelClock: 229500000
Mode: 132 (320x400)
	ModeAttributes: 0x39f
	WinAAttributes: 0x7
	WinBAttributes: 0x0
	WinGranularity: 64
	WinSize: 64
	WinASegment: 0xa000
	WinBSegment: 0x0
	WinFuncPtr: 0xc000a455
	BytesPerScanline: 640
	XResolution: 320
	YResolution: 400
	XCharSize: 8
	YCharSize: 16
	NumberOfPlanes: 1
	BitsPerPixel: 16
	NumberOfBanks: 1
	MemoryModel: 6
	BankSize: 0
	NumberOfImages: 14
	RedMaskSize: 5
	RedFieldPosition: 11
	GreenMaskSize: 6
	GreenFieldPosition: 5
	BlueMaskSize: 5
	BlueFieldPosition: 0
	RsvdMaskSize: 0
	RsvdFieldPosition: 0
	DirectColorModeInfo: 0
	PhysBasePtr: 0xe0000000
	LinBytesPerScanLine: 640
	BnkNumberOfImagePages: 14
	LinNumberOfImagePages: 14
	LinRedMaskSize: 5
	LinRedFieldPosition: 11
	LinGreenMaskSize: 6
	LinGreenFieldPosition: 5
	LinBlueMaskSize: 5
	LinBlueFieldPosition: 0
	LinRsvdMaskSize: 0
	LinRsvdFieldPosition: 0
	MaxPixelClock: 229500000
*Mode: 133 (320x400)
	ModeAttributes: 0x39f
	WinAAttributes: 0x7
	WinBAttributes: 0x0
	WinGranularity: 64
	WinSize: 64
	WinASegment: 0xa000
	WinBSegment: 0x0
	WinFuncPtr: 0xc000a455
	BytesPerScanline: 1280
	XResolution: 320
	YResolution: 400
	XCharSize: 8
	YCharSize: 16
	NumberOfPlanes: 1
	BitsPerPixel: 32
	NumberOfBanks: 1
	MemoryModel: 6
	BankSize: 0
	NumberOfImages: 6
	RedMaskSize: 8
	RedFieldPosition: 16
	GreenMaskSize: 8
	GreenFieldPosition: 8
	BlueMaskSize: 8
	BlueFieldPosition: 0
	RsvdMaskSize: 8
	RsvdFieldPosition: 24
	DirectColorModeInfo: 0
	PhysBasePtr: 0xe0000000
	LinBytesPerScanLine: 1280
	BnkNumberOfImagePages: 6
	LinNumberOfImagePages: 6
	LinRedMaskSize: 8
	LinRedFieldPosition: 16
	LinGreenMaskSize: 8
	LinGreenFieldPosition: 8
	LinBlueMaskSize: 8
	LinBlueFieldPosition: 0
	LinRsvdMaskSize: 8
	LinRsvdFieldPosition: 24
	MaxPixelClock: 229500000
Mode: 134 (320x240)
	ModeAttributes: 0x39f
	WinAAttributes: 0x7
	WinBAttributes: 0x0
	WinGranularity: 64
	WinSize: 64
	WinASegment: 0xa000
	WinBSegment: 0x0
	WinFuncPtr: 0xc000a455
	BytesPerScanline: 320
	XResolution: 320
	YResolution: 240
	XCharSize: 8
	YCharSize: 8
	NumberOfPlanes: 1
	BitsPerPixel: 8
	NumberOfBanks: 1
	MemoryModel: 4
	BankSize: 0
	NumberOfImages: 30
	RedMaskSize: 0
	RedFieldPosition: 0
	GreenMaskSize: 0
	GreenFieldPosition: 0
	BlueMaskSize: 0
	BlueFieldPosition: 0
	RsvdMaskSize: 0
	RsvdFieldPosition: 0
	DirectColorModeInfo: 0
	PhysBasePtr: 0xe0000000
	LinBytesPerScanLine: 320
	BnkNumberOfImagePages: 30
	LinNumberOfImagePages: 30
	LinRedMaskSize: 0
	LinRedFieldPosition: 0
	LinGreenMaskSize: 0
	LinGreenFieldPosition: 0
	LinBlueMaskSize: 0
	LinBlueFieldPosition: 0
	LinRsvdMaskSize: 0
	LinRsvdFieldPosition: 0
	MaxPixelClock: 229500000
Mode: 135 (320x240)
	ModeAttributes: 0x39f
	WinAAttributes: 0x7
	WinBAttributes: 0x0
	WinGranularity: 64
	WinSize: 64
	WinASegment: 0xa000
	WinBSegment: 0x0
	WinFuncPtr: 0xc000a455
	BytesPerScanline: 640
	XResolution: 320
	YResolution: 240
	XCharSize: 8
	YCharSize: 8
	NumberOfPlanes: 1
	BitsPerPixel: 16
	NumberOfBanks: 1
	MemoryModel: 6
	BankSize: 0
	NumberOfImages: 19
	RedMaskSize: 5
	RedFieldPosition: 11
	GreenMaskSize: 6
	GreenFieldPosition: 5
	BlueMaskSize: 5
	BlueFieldPosition: 0
	RsvdMaskSize: 0
	RsvdFieldPosition: 0
	DirectColorModeInfo: 0
	PhysBasePtr: 0xe0000000
	LinBytesPerScanLine: 640
	BnkNumberOfImagePages: 19
	LinNumberOfImagePages: 19
	LinRedMaskSize: 5
	LinRedFieldPosition: 11
	LinGreenMaskSize: 6
	LinGreenFieldPosition: 5
	LinBlueMaskSize: 5
	LinBlueFieldPosition: 0
	LinRsvdMaskSize: 0
	LinRsvdFieldPosition: 0
	MaxPixelClock: 229500000
*Mode: 136 (320x240)
	ModeAttributes: 0x39f
	WinAAttributes: 0x7
	WinBAttributes: 0x0
	WinGranularity: 64
	WinSize: 64
	WinASegment: 0xa000
	WinBSegment: 0x0
	WinFuncPtr: 0xc000a455
	BytesPerScanline: 1280
	XResolution: 320
	YResolution: 240
	XCharSize: 8
	YCharSize: 8
	NumberOfPlanes: 1
	BitsPerPixel: 32
	NumberOfBanks: 1
	MemoryModel: 6
	BankSize: 0
	NumberOfImages: 10
	RedMaskSize: 8
	RedFieldPosition: 16
	GreenMaskSize: 8
	GreenFieldPosition: 8
	BlueMaskSize: 8
	BlueFieldPosition: 0
	RsvdMaskSize: 8
	RsvdFieldPosition: 24
	DirectColorModeInfo: 0
	PhysBasePtr: 0xe0000000
	LinBytesPerScanLine: 1280
	BnkNumberOfImagePages: 10
	LinNumberOfImagePages: 10
	LinRedMaskSize: 8
	LinRedFieldPosition: 16
	LinGreenMaskSize: 8
	LinGreenFieldPosition: 8
	LinBlueMaskSize: 8
	LinBlueFieldPosition: 0
	LinRsvdMaskSize: 8
	LinRsvdFieldPosition: 24
	MaxPixelClock: 229500000
Mode: 13d (640x400)
	ModeAttributes: 0x39f
	WinAAttributes: 0x7
	WinBAttributes: 0x0
	WinGranularity: 64
	WinSize: 64
	WinASegment: 0xa000
	WinBSegment: 0x0
	WinFuncPtr: 0xc000a455
	BytesPerScanline: 1280
	XResolution: 640
	YResolution: 400
	XCharSize: 8
	YCharSize: 16
	NumberOfPlanes: 1
	BitsPerPixel: 16
	NumberOfBanks: 1
	MemoryModel: 6
	BankSize: 0
	NumberOfImages: 6
	RedMaskSize: 5
	RedFieldPosition: 11
	GreenMaskSize: 6
	GreenFieldPosition: 5
	BlueMaskSize: 5
	BlueFieldPosition: 0
	RsvdMaskSize: 0
	RsvdFieldPosition: 0
	DirectColorModeInfo: 0
	PhysBasePtr: 0xe0000000
	LinBytesPerScanLine: 1280
	BnkNumberOfImagePages: 6
	LinNumberOfImagePages: 6
	LinRedMaskSize: 5
	LinRedFieldPosition: 11
	LinGreenMaskSize: 6
	LinGreenFieldPosition: 5
	LinBlueMaskSize: 5
	LinBlueFieldPosition: 0
	LinRsvdMaskSize: 0
	LinRsvdFieldPosition: 0
	MaxPixelClock: 229500000
*Mode: 13e (640x400)
	ModeAttributes: 0x39f
	WinAAttributes: 0x7
	WinBAttributes: 0x0
	WinGranularity: 64
	WinSize: 64
	WinASegment: 0xa000
	WinBSegment: 0x0
	WinFuncPtr: 0xc000a455
	BytesPerScanline: 2560
	XResolution: 640
	YResolution: 400
	XCharSize: 8
	YCharSize: 16
	NumberOfPlanes: 1
	BitsPerPixel: 32
	NumberOfBanks: 1
	MemoryModel: 6
	BankSize: 0
	NumberOfImages: 2
	RedMaskSize: 8
	RedFieldPosition: 16
	GreenMaskSize: 8
	GreenFieldPosition: 8
	BlueMaskSize: 8
	BlueFieldPosition: 0
	RsvdMaskSize: 8
	RsvdFieldPosition: 24
	DirectColorModeInfo: 0
	PhysBasePtr: 0xe0000000
	LinBytesPerScanLine: 2560
	BnkNumberOfImagePages: 2
	LinNumberOfImagePages: 2
	LinRedMaskSize: 8
	LinRedFieldPosition: 16
	LinGreenMaskSize: 8
	LinGreenFieldPosition: 8
	LinBlueMaskSize: 8
	LinBlueFieldPosition: 0
	LinRsvdMaskSize: 8
	LinRsvdFieldPosition: 24
	MaxPixelClock: 229500000

(II) VESA(0): Total Memory: 2048 64KB banks (131072kB)
(II) VESA(0): Monitor0: Using default hsync range of 30.00-80.00 kHz
(II) VESA(0): Monitor0: Using default vrefresh range of 56.00-85.00 Hz
(--) VESA(0): Virtual size is 800x600 (pitch 800)
(**) VESA(0): *Built-in mode "800x600"
(**) VESA(0): *Built-in mode "640x480"
(**) VESA(0): *Built-in mode "640x400"
(--) VESA(0): Display dimensions: (390, 290) mm
(--) VESA(0): DPI set to (52, 52)
(II) VESA(0): Attempting to use 85Hz refresh for mode "800x600" (115)
(II) VESA(0): Attempting to use 85Hz refresh for mode "640x480" (112)
(II) VESA(0): Attempting to use 85Hz refresh for mode "640x400" (13e)
(**) VESA(0): Using "Shadow Framebuffer"
(II) Loading sub module "shadow"
(II) LoadModule: "shadow"
(II) Loading /pkg/x11.2/lib64/modules/libshadow.a
(II) Module shadow: vendor="X.Org Foundation"
	compiled for 6.8.0, module version = 1.0.0
	ABI class: X.Org ANSI C Emulation, version 0.2
(II) Loading sub module "fb"
(II) LoadModule: "fb"
(II) Loading /pkg/x11.2/lib64/modules/libfb.a
(II) Module fb: vendor="X.Org Foundation"
	compiled for 6.8.0, module version = 1.0.0
	ABI class: X.Org ANSI C Emulation, version 0.2
(--) Depth 24 pixmap format is 32 bpp
(II) do I need RAC?  No, I don't.
(II) resource ranges after preInit:
	[0] -1	0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1	0	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[2] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1	0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1	0	0xf0000000 - 0xefffffff (0x0) MX[B]O
	[6] -1	0	0xfc8f8000 - 0xfc8fbfff (0x4000) MX[B]
	[7] -1	0	0xfc8ff000 - 0xfc8ff7ff (0x800) MX[B]
	[8] -1	0	0xfc8ffc00 - 0xfc8fffff (0x400) MX[B]
	[9] -1	0	0xfc8fe000 - 0xfc8fefff (0x1000) MX[B]
	[10] -1	0	0xfc8fd000 - 0xfc8fdfff (0x1000) MX[B]
	[11] -1	0	0xfc6f0000 - 0xfc6fffff (0x10000) MX[B]
	[12] -1	0	0xfc9ff000 - 0xfc9fffff (0x1000) MX[B]
	[13] -1	0	0xfc9fe000 - 0xfc9fefff (0x1000) MX[B]
	[14] -1	0	0xfeae0000 - 0xfeafffff (0x20000) MX[B](B)
	[15] -1	0	0xec480000 - 0xec4fffff (0x80000) MX[B](B)
	[16] -1	0	0xe0000000 - 0xe7ffffff (0x8000000) MX[B](B)
	[17] -1	0	0xfd000000 - 0xfdffffff (0x1000000) MX[B](B)
	[18] -1	0	0xdb800000 - 0xdbffffff (0x800000) MX[B](B)
	[19] -1	0	0xfc8f4000 - 0xfc8f7fff (0x4000) MX[B](B)
	[20] 0	0	0x000a0000 - 0x000affff (0x10000) MS[B]
	[21] 0	0	0x000b0000 - 0x000b7fff (0x8000) MS[B]
	[22] 0	0	0x000b8000 - 0x000bffff (0x8000) MS[B]
	[23] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[24] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
	[25] -1	0	0x0000ac00 - 0x0000ac0f (0x10) IX[B]
	[26] -1	0	0x0000b000 - 0x0000b003 (0x4) IX[B]
	[27] -1	0	0x0000b400 - 0x0000b407 (0x8) IX[B]
	[28] -1	0	0x0000b800 - 0x0000b803 (0x4) IX[B]
	[29] -1	0	0x0000bc00 - 0x0000bc07 (0x8) IX[B]
	[30] -1	0	0x0000cc00 - 0x0000cc3f (0x40) IX[B]
	[31] -1	0	0x0000c800 - 0x0000c8ff (0x100) IX[B]
	[32] -1	0	0x0000c400 - 0x0000c41f (0x20) IX[B]
	[33] -1	0	0x0000ffa0 - 0x0000ffaf (0x10) IX[B]
	[34] 0	0	0x000003b0 - 0x000003bb (0xc) IS[B]
	[35] 0	0	0x000003c0 - 0x000003df (0x20) IS[B]
(II) Loading sub module "int10"
(II) LoadModule: "int10"
(II) Reloading /pkg/x11.2/lib64/modules/linux/libint10.a
(II) VESA(0): initializing int10
(II) VESA(0): Primary V_BIOS segment is: 0xc000
(II) VESA(0): VESA BIOS detected
(II) VESA(0): VESA VBE Version 3.0
(II) VESA(0): VESA VBE Total Mem: 131072 kB
(II) VESA(0): VESA VBE OEM: NVidia
(II) VESA(0): VESA VBE OEM Software Rev: 4.37
(II) VESA(0): VESA VBE OEM Vendor: NVidia Corporation
(II) VESA(0): VESA VBE OEM Product: NV25 Board
(II) VESA(0): VESA VBE OEM Product Rev: Chip Rev   
(==) VESA(0): Write-combining range (0xe0000000,0x8000000)
(II) VESA(0): virtual address = 0x2a95c7d000,
	physical address = 0xe0000000, size = 134217728
(==) VESA(0): Default visual is TrueColor
(==) VESA(0): Backing store disabled
(**) Option "dpms"
(**) VESA(0): DPMS enabled
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
(**) Option "Protocol" "auto"
(**) Mouse0: Device: "/dev/input/mouse0"
(**) Mouse0: Protocol: "auto"
(**) Option "CorePointer"
(**) Mouse0: Core Pointer
(**) Option "Device" "/dev/input/mouse0"
(==) Mouse0: Emulate3Buttons, Emulate3Timeout: 50
(==) Mouse0: Buttons: 3
(**) Option "CoreKeyboard"
(**) Keyboard0: Core Keyboard
(**) Option "Protocol" "standard"
(**) Keyboard0: Protocol: standard
(**) Option "AutoRepeat" "500 30"
(**) Option "XkbRules" "xorg"
(**) Keyboard0: XkbRules: "xorg"
(**) Option "XkbModel" "pc101"
(**) Keyboard0: XkbModel: "pc101"
(**) Option "XkbLayout" "gb"
(**) Keyboard0: XkbLayout: "gb"
(**) Option "CustomKeycodes" "off"
(**) Keyboard0: CustomKeycodes disabled
(II) XINPUT: Adding extended input device "Keyboard0" (type: KEYBOARD)
(II) XINPUT: Adding extended input device "Mouse0" (type: MOUSE)
(--) Mouse0: PnP-detected protocol: "ExplorerPS/2"
(II) Mouse0: ps2EnableDataReporting: succeeded
Could not init font path element /pkg/x11.2/lib/X11/fonts/TTF/, removing from list!
Could not init font path element /pkg/x11.2/lib/X11/fonts/Type1/, removing from list!
Could not init font path element /pkg/x11.2/lib/X11/fonts/CID/, removing from list!
SetClientVersion: 0 8

--Boundary-00=_tWHqBrSBk3PbZcG--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
