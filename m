From: Clint Adams <schizo@debian.org>
Subject: Re: Bug#226973: xserver-xfree86: [glint] second card at wrong resolution
Date: Wed, 14 Jan 2004 16:06:35 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040114210635.GA31286@scowler.net>
References: <20040109163119.GA10151@scowler.net> <20040112121558.GA24511@iliana> <20040112215543.GB2150@scowler.net> <20040113074158.GF4863@iliana> <20040113154025.GA12817@scowler.net> <20040113160221.GA12752@iliana>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="qMm9M+Fa2AknHoGS"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AgsDp-0005oD-Bc
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 14 Jan 2004 13:06:41 -0800
Received: from acolyte.scowler.net ([216.254.112.142])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1AgsDn-0004rX-Fd
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 14 Jan 2004 13:06:39 -0800
Content-Disposition: inline
In-Reply-To: <20040113160221.GA12752@iliana>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: 226973@bugs.debian.org, linux-fbdev-devel@lists.sourceforge.net


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> Yep. It probably doesn't happen on x86, since the int10 stuff
> initializes the card with the onboard bios. Using a x86 emulator in X to
> run this bios might be a solution.

According to Tech-Source, this card has no VGA bios..

> Ho. definitively some registers who are bad. It has been a long time
> since i have looked at the pm2 specs (kind of 98ish i think) though.
> Maybe you could get hand of the free TI-pm2 specs and look for yourself ?

I've been looking and not finding anything.

> You would dump all the possible registers, and see which one is
> different. Enabling debugging in the glint driver would also do. You can
> safely run no-accel on these for the tests, as this is definitively not
> an accel issue, but a video out/ramdac one.

Attached is the XFree86.0.log from xserver-xfree86-dbg.  I'll start it
again with noaccel.  The only thing I notice is that it thinks the
second card only has 4 megs of video ram.

> Any color problem ?

No.

--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="XFree86.0.log"


This is a pre-release version of XFree86, and is not supported in any
way.  Bugs may be reported to XFree86@XFree86.Org and patches submitted
to fixes@XFree86.Org.  Before reporting bugs in pre-release versions,
please check the latest version in the XFree86 CVS repository
(http://www.XFree86.Org/cvs).

XFree86 Version 4.3.0.1 (Debian (static) 4.3.0-0pre1v3 20030929061855 ilmari@ilmari.org)
Release Date: 15 August 2003
X Protocol Version 11, Revision 0, Release 6.6
Build Operating System: Linux 2.4.18 sparc [ELF] 
Build Date: 29 September 2003
	Before reporting problems, check http://www.XFree86.Org/
	to make sure that you have the latest version.
OS Kernel: Linux version 2.4.24 (clint@rashudo) (gcc version 3.3.3 20031229 (prerelease) (Debian)) #1 Mon Jan 12 14:44:22 EST 2004 
Markers: (--) probed, (**) from config file, (==) default setting,
         (++) from command line, (!!) notice, (II) informational,
         (WW) warning, (EE) error, (NI) not implemented, (??) unknown.
(==) Log file: "/var/log/XFree86.0.log", Time: Wed Jan 14 15:47:31 2004
(==) Using config file: "/etc/X11/XF86Config-4"
(==) ServerLayout "Default Layout"
(**) |-->Screen "Default Screen" (0)
(**) |   |-->Monitor "Sun"
(**) |   |-->Device "TSI Raptor GFX 8P"
(**) |-->Screen "Screen Two" (1)
(**) |   |-->Monitor "Sun2"
(**) |   |-->Device "TSI Raptor GFX 8P 2"
(**) |-->Input Device "Generic Keyboard"
(**) Option "XkbRules" "xfree86"
(**) XKB: rules: "xfree86"
(**) Option "XkbModel" "pc104"
(**) XKB: model: "pc104"
(**) Option "XkbLayout" "us"
(**) XKB: layout: "us"
(==) Keyboard: CustomKeycode disabled
(**) |-->Input Device "Configured Mouse"
(WW) The directory "/usr/lib/X11/fonts/CID" does not exist.
	Entry deleted from font path.
(WW) The directory "/usr/lib/X11/fonts/cyrillic" does not exist.
	Entry deleted from font path.
(WW) `fonts.dir' not found (or not valid) in "/var/lib/defoma/x-ttcidfont-conf.d/dirs/CID".
	Entry deleted from font path.
	(Run 'mkfontdir' on "/var/lib/defoma/x-ttcidfont-conf.d/dirs/CID").
(**) FontPath set to "unix/:7100,/usr/lib/X11/fonts/Type1,/usr/lib/X11/fonts/Speedo,/usr/lib/X11/fonts/misc,/usr/lib/X11/fonts/100dpi,/usr/lib/X11/fonts/75dpi,/var/lib/defoma/x-ttcidfont-conf.d/dirs/TrueType"
(==) RgbPath set to "/usr/X11R6/lib/X11/rgb"
(++) using VT number 7

(WW) Open APM failed (/dev/apm_bios) (No such file or directory)
(II) PCI: PCI scan (all values are in hex)
(II) PCI: 00:00:0: chip 108e,a001 card 0000,0000 rev 00 class 06,00,00 hdr 00
(II) PCI: 00:03:0: chip 10b9,7101 card 0000,0000 rev 00 class 00,00,00 hdr 00
(II) PCI: 00:05:0: chip 1011,0024 card 0000,0000 rev 03 class 06,04,00 hdr 01
(II) PCI: 00:07:0: chip 10b9,1533 card 10b9,1533 rev 00 class 06,01,00 hdr 00
(II) PCI: 00:08:0: chip 10b9,5451 card 10b9,5451 rev 01 class 04,01,00 hdr 00
(II) PCI: 00:0c:0: chip 108e,1100 card 0000,0000 rev 01 class 06,80,00 hdr 80
(II) PCI: 00:0c:1: chip 108e,1101 card 0000,0000 rev 01 class 02,00,00 hdr 80
(II) PCI: 00:0c:2: chip 108e,1102 card 0000,0000 rev 01 class 0c,00,10 hdr 80
(II) PCI: 00:0c:3: chip 108e,1103 card 0000,0000 rev 01 class 0c,03,10 hdr 80
(II) PCI: 00:0d:0: chip 10b9,5229 card 0000,0000 rev c3 class 01,01,ff hdr 00
(II) PCI: 00:13:0: chip 1002,4752 card 0000,0000 rev 65 class 03,00,00 hdr 00
(II) PCI: 01:00:0: chip 3d3d,0009 card 1227,0006 rev 01 class 03,80,00 hdr 00
(II) PCI: 01:01:0: chip 3d3d,0009 card 1227,0006 rev 01 class 03,80,00 hdr 00
(II) PCI: End of PCI scan
(II) Host-to-PCI bridge:
(II) Bus 0: bridge is at (0:0:0), (0,0,1), BCTRL: 0x0008 (VGA_EN is set)
(II) Bus 0 I/O range:
	[0] -1	1	0x00000000 - 0x00ffffff (0x1000000) IX[B]
(II) Bus 0 non-prefetchable memory range:
	[0] -1	1	0x00000000 - 0xffffffff (0x0) MX[B]
(II) Bus 0 prefetchable memory range:
	[0] -1	1	0x00000000 - 0xffffffff (0x0) MX[B]
(II) PCI-to-PCI bridge:
(II) Bus 1: bridge is at (0:5:0), (0,1,1), BCTRL: 0x0000 (VGA_EN is cleared)
(II) Bus 1 non-prefetchable memory range:
	[0] -1	1	0x03000000 - 0x057fffff (0x2800000) MX[B]
(II) PCI-to-ISA bridge:
(II) Bus -1: bridge is at (0:7:0), (0,-1,-1), BCTRL: 0x0008 (VGA_EN is set)
(!!) More than one possible primary device found
(--) PCI: (0:3:0) ALi Corporation M7101 PMU rev 0
(--) PCI: (0:19:0) ATI Technologies Inc Rage XL rev 101, Mem @ 0x06000000/24, 0x00426000/12, I/O @ 0x0b00/8, BIOS @ 0x00440000/17
(--) PCI: (1:0:0) 3DLabs Permedia II 2D+3D rev 1, Mem @ 0x03000000/17, 0x03800000/23, 0x04000000/23, BIOS @ 0x03020000/16
(--) PCI: (1:1:0) 3DLabs Permedia II 2D+3D rev 1, Mem @ 0x03040000/17, 0x04800000/23, 0x05000000/23, BIOS @ 0x03030000/16
(II) Addressable bus resource ranges are
	[0] -1	1	0x00000000 - 0xffffffff (0x0) MX[B]
	[1] -1	1	0x00000000 - 0x00ffffff (0x1000000) IX[B]
(II) OS-reported resource ranges:
	[0] -1	1	0xffffffff - 0xffffffff (0x1) MX[B]
	[1] -1	1	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[2] -1	1	0x000c0000 - 0x000effff (0x30000) MX[B]
	[3] -1	1	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[4] -1	1	0x00ffffff - 0x00ffffff (0x1) IX[B]
	[5] -1	1	0x00000000 - 0x00000000 (0x1) IX[B]
(II) Active PCI resource ranges:
	[0] -1	1	0x02000000 - 0x02007fff (0x8000) MX[B]
	[1] -1	1	0x00422000 - 0x004227ff (0x800) MX[B]
	[2] -1	1	0x00420000 - 0x004207ff (0x800) MX[B]
	[3] -1	1	0x00400000 - 0x0041ffff (0x20000) MX[B]
	[4] -1	1	0x01800000 - 0x01ffffff (0x800000) MX[B]
	[5] -1	1	0x07000000 - 0x07ffffff (0x1000000) MX[B]
	[6] -1	1	0x00424000 - 0x00424fff (0x1000) MX[B]
	[7] -1	1	0x03030000 - 0x0303ffff (0x10000) MX[B](B)
	[8] -1	1	0x05000000 - 0x057fffff (0x800000) MX[B](B)
	[9] -1	1	0x04800000 - 0x04ffffff (0x800000) MX[B](B)
	[10] -1	1	0x03040000 - 0x0305ffff (0x20000) MX[B](B)
	[11] -1	1	0x03020000 - 0x0302ffff (0x10000) MX[B](B)
	[12] -1	1	0x04000000 - 0x047fffff (0x800000) MX[B](B)
	[13] -1	1	0x03800000 - 0x03ffffff (0x800000) MX[B](B)
	[14] -1	1	0x03000000 - 0x0301ffff (0x20000) MX[B](B)
	[15] -1	1	0x00440000 - 0x0045ffff (0x20000) MX[B](B)
	[16] -1	1	0x00426000 - 0x00426fff (0x1000) MX[B](B)
	[17] -1	1	0x06000000 - 0x06ffffff (0x1000000) MX[B](B)
	[18] -1	1	0x00000a20 - 0x00000a2f (0x10) IX[B]
	[19] -1	1	0x00000a08 - 0x00000a0b (0x4) IX[B]
	[20] -1	1	0x00000a10 - 0x00000a17 (0x8) IX[B]
	[21] -1	1	0x00000a18 - 0x00000a1b (0x4) IX[B]
	[22] -1	1	0x00000a00 - 0x00000a07 (0x8) IX[B]
	[23] -1	1	0x00000900 - 0x000009ff (0x100) IX[B]
	[24] -1	1	0x00000b00 - 0x00000bff (0x100) IX[B](B)
(II) Active PCI resource ranges after removing overlaps:
	[0] -1	1	0x02000000 - 0x02007fff (0x8000) MX[B]
	[1] -1	1	0x00422000 - 0x004227ff (0x800) MX[B]
	[2] -1	1	0x00420000 - 0x004207ff (0x800) MX[B]
	[3] -1	1	0x00400000 - 0x0041ffff (0x20000) MX[B]
	[4] -1	1	0x01800000 - 0x01ffffff (0x800000) MX[B]
	[5] -1	1	0x07000000 - 0x07ffffff (0x1000000) MX[B]
	[6] -1	1	0x00424000 - 0x00424fff (0x1000) MX[B]
	[7] -1	1	0x03030000 - 0x0303ffff (0x10000) MX[B](B)
	[8] -1	1	0x05000000 - 0x057fffff (0x800000) MX[B](B)
	[9] -1	1	0x04800000 - 0x04ffffff (0x800000) MX[B](B)
	[10] -1	1	0x03040000 - 0x0305ffff (0x20000) MX[B](B)
	[11] -1	1	0x03020000 - 0x0302ffff (0x10000) MX[B](B)
	[12] -1	1	0x04000000 - 0x047fffff (0x800000) MX[B](B)
	[13] -1	1	0x03800000 - 0x03ffffff (0x800000) MX[B](B)
	[14] -1	1	0x03000000 - 0x0301ffff (0x20000) MX[B](B)
	[15] -1	1	0x00440000 - 0x0045ffff (0x20000) MX[B](B)
	[16] -1	1	0x00426000 - 0x00426fff (0x1000) MX[B](B)
	[17] -1	1	0x06000000 - 0x06ffffff (0x1000000) MX[B](B)
	[18] -1	1	0x00000a20 - 0x00000a2f (0x10) IX[B]
	[19] -1	1	0x00000a08 - 0x00000a0b (0x4) IX[B]
	[20] -1	1	0x00000a10 - 0x00000a17 (0x8) IX[B]
	[21] -1	1	0x00000a18 - 0x00000a1b (0x4) IX[B]
	[22] -1	1	0x00000a00 - 0x00000a07 (0x8) IX[B]
	[23] -1	1	0x00000900 - 0x000009ff (0x100) IX[B]
	[24] -1	1	0x00000b00 - 0x00000bff (0x100) IX[B](B)
(II) OS-reported resource ranges after removing overlaps with PCI:
	[0] -1	1	0xffffffff - 0xffffffff (0x1) MX[B]
	[1] -1	1	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[2] -1	1	0x000c0000 - 0x000effff (0x30000) MX[B]
	[3] -1	1	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[4] -1	1	0x00ffffff - 0x00ffffff (0x1) IX[B]
	[5] -1	1	0x00000000 - 0x00000000 (0x1) IX[B]
(II) All system resource ranges:
	[0] -1	1	0xffffffff - 0xffffffff (0x1) MX[B]
	[1] -1	1	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[2] -1	1	0x000c0000 - 0x000effff (0x30000) MX[B]
	[3] -1	1	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[4] -1	1	0x02000000 - 0x02007fff (0x8000) MX[B]
	[5] -1	1	0x00422000 - 0x004227ff (0x800) MX[B]
	[6] -1	1	0x00420000 - 0x004207ff (0x800) MX[B]
	[7] -1	1	0x00400000 - 0x0041ffff (0x20000) MX[B]
	[8] -1	1	0x01800000 - 0x01ffffff (0x800000) MX[B]
	[9] -1	1	0x07000000 - 0x07ffffff (0x1000000) MX[B]
	[10] -1	1	0x00424000 - 0x00424fff (0x1000) MX[B]
	[11] -1	1	0x03030000 - 0x0303ffff (0x10000) MX[B](B)
	[12] -1	1	0x05000000 - 0x057fffff (0x800000) MX[B](B)
	[13] -1	1	0x04800000 - 0x04ffffff (0x800000) MX[B](B)
	[14] -1	1	0x03040000 - 0x0305ffff (0x20000) MX[B](B)
	[15] -1	1	0x03020000 - 0x0302ffff (0x10000) MX[B](B)
	[16] -1	1	0x04000000 - 0x047fffff (0x800000) MX[B](B)
	[17] -1	1	0x03800000 - 0x03ffffff (0x800000) MX[B](B)
	[18] -1	1	0x03000000 - 0x0301ffff (0x20000) MX[B](B)
	[19] -1	1	0x00440000 - 0x0045ffff (0x20000) MX[B](B)
	[20] -1	1	0x00426000 - 0x00426fff (0x1000) MX[B](B)
	[21] -1	1	0x06000000 - 0x06ffffff (0x1000000) MX[B](B)
	[22] -1	1	0x00ffffff - 0x00ffffff (0x1) IX[B]
	[23] -1	1	0x00000000 - 0x00000000 (0x1) IX[B]
	[24] -1	1	0x00000a20 - 0x00000a2f (0x10) IX[B]
	[25] -1	1	0x00000a08 - 0x00000a0b (0x4) IX[B]
	[26] -1	1	0x00000a10 - 0x00000a17 (0x8) IX[B]
	[27] -1	1	0x00000a18 - 0x00000a1b (0x4) IX[B]
	[28] -1	1	0x00000a00 - 0x00000a07 (0x8) IX[B]
	[29] -1	1	0x00000900 - 0x000009ff (0x100) IX[B]
	[30] -1	1	0x00000b00 - 0x00000bff (0x100) IX[B](B)
(II) SUNFFB: driver for Creator, Creator 3D and Elite 3D
(II) SUNLEO: driver for Leo (ZX)
(II) SUNCG6: driver for CGsix (GX and Turbo GX)
(II) SUNCG3: driver for CGthree
(II) SUNCG14: driver for CG14
(II) SUNTCX: driver for TCX
(II) SUNBW2: driver for BWtwo
(II) GLINT: driver for 3Dlabs chipsets: gamma, gamma2, ti_pm2, ti_pm, r4,
	pm4, pm3, pm2v, pm2, pm, 300sx, 500tx, mx, delta
(II) MGA: driver for Matrox chipsets: mga2064w, mga1064sg, mga2164w,
	mga2164w AGP, mgag100, mgag100 PCI, mgag200, mgag200 PCI, mgag400,
	mgag550
(II) TDFX: Driver for 3dfx Banshee/Voodoo3 chipsets: 3dfx Banshee,
	3dfx Voodoo3, 3dfx Voodoo5
(II) ATI: ATI driver (version 6.4.18) for chipset: ati
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
	ATI Radeon VE/7000 QY (AGP), ATI Radeon VE/7000 QZ (AGP),
	ATI Radeon Mobility M7 LW (AGP),
	ATI Mobility FireGL 7800 M7 LX (AGP),
	ATI Radeon Mobility M6 LY (AGP), ATI Radeon Mobility M6 LZ (AGP),
	ATI Radeon IGP320 (A3) 4136, ATI Radeon IGP320M (U1) 4336,
	ATI Radeon IGP330/340/350 (A4) 4137,
	ATI Radeon IGP330M/340M/350M (U2) 4337,
	ATI FireGL 8700/8800 QH (AGP), ATI Radeon 8500 QI (AGP),
	ATI Radeon 8500 QJ (AGP), ATI Radeon 8500 QK (AGP),
	ATI Radeon 8500 QL (AGP), ATI Radeon 9100 QM (AGP),
	ATI Radeon 8500 QN (AGP), ATI Radeon 8500 QO (AGP),
	ATI Radeon 8500 Qh (AGP), ATI Radeon 8500 Qi (AGP),
	ATI Radeon 8500 Qj (AGP), ATI Radeon 8500 Qk (AGP),
	ATI Radeon 8500 Ql (AGP), ATI Radeon 8500 BB (AGP),
	ATI Radeon 7500 QW (AGP), ATI Radeon 7500 QX (AGP),
	ATI Radeon 9000 Id (AGP), ATI Radeon 9000 Ie (AGP),
	ATI Radeon 9000 If (AGP), ATI Radeon 9000 Ig (AGP),
	ATI Radeon Mobility M9 Ld (AGP), ATI Radeon Mobility M9 Le (AGP),
	ATI Radeon Mobility M9 Lf (AGP), ATI Radeon Mobility M9 Lg (AGP),
	ATI Radeon 9200 5960 (AGP), ATI Radeon 9200 5961 (AGP),
	ATI Radeon 9200 5962 (AGP), ATI Radeon 9200 5963 (AGP),
	ATI Radeon M9+ 5968 (AGP), ATI Radeon M9+ 5969 (AGP),
	ATI Radeon M9+ 596A (AGP), ATI Radeon M9+ 596B (AGP),
	ATI Radeon 9500 AD (AGP), ATI Radeon 9500 AE (AGP),
	ATI Radeon 9500 AF (AGP), ATI FireGL Z1/X1 AG (AGP),
	ATI Radeon 9700 Pro ND (AGP), ATI Radeon 9700/9500Pro NE (AGP),
	ATI Radeon 9700 NF (AGP), ATI FireGL X1 NG (AGP)
(II) VESA: driver for VESA chipsets: vesa
(II) VGA: Generic VGA driver (version 4.0) for chipsets: generic
(II) FBDEV: driver for framebuffer: fbdev
(II) v4l driver for Video4Linux
(II) APM: driver for the Alliance chipsets: AP6422, AT24, AT3D
(II) ARK: driver (version 0.5.0 for ARK Logic chipset: ark1000pv,
	ark2000pv, ark2000mt
(II) CHIPS: Driver for Chips and Technologies chipsets: ct65520, ct65525,
	ct65530, ct65535, ct65540, ct65545, ct65546, ct65548, ct65550,
	ct65554, ct65555, ct68554, ct69000, ct69030, ct64200, ct64300
(II) CIRRUS: driver for Cirrus chipsets: CLGD5430, CLGD5434-4, CLGD5434-8,
	CLGD5436, CLGD5446, CLGD5480, CL-GD5462, CL-GD5464, CL-GD5464BD,
	CL-GD5465, CL-GD7548
(II) I128: driver for Number Nine I128 chipsets: i128, i128v2, i128t2r,
	i128t2r4
(II) I740: Driver for Intel i740 chipset: i740 (agp), i740 (pci)
(II) IMSTT: driver (version 1.0.0) for IMS TwinTurbo chipsets : imstt128,
	imstt3d
(II) NEOMAGIC: Driver for Neomagic chipsets: neo2070, neo2090, neo2093,
	neo2097, neo2160, neo2200, neo2230, neo2360, neo2380
(II) NV: driver for NVIDIA chipsets: RIVA 128, RIVA TNT, RIVA TNT2, Vanta,
	RIVA TNT2 Ultra, RIVA TNT2 Model 64, Aladdin TNT2, GeForce 256,
	GeForce DDR, Quadro, GeForce2 MX/MX 400, GeForce2 MX 100/200,
	GeForce2 Go, Quadro2 MXR/EX/Go, GeForce2 Integrated GPU,
	GeForce2 GTS, GeForce2 Ti, GeForce2 Ultra, Quadro2 Pro,
	GeForce4 MX 460, GeForce4 MX 440, GeForce4 MX 420,
	GeForce4 MX 440-SE, GeForce4 440 Go, GeForce4 420 Go,
	GeForce4 420 Go 32M, GeForce4 460 Go, GeForce4 440 Go 64M,
	GeForce4 410 Go 16M, Quadro4 500 GoGL, Quadro4 550 XGL, Quadro4 NVS,
	GeForce4 MX 440 with AGP8X, GeForce4 MX 440SE with AGP8X,
	GeForce4 MX 420 with AGP8X, GeForce4 448 Go, GeForce4 488 Go,
	Quadro4 580 XGL, Quadro4 280 NVS, Quadro4 380 XGL,
	GeForce4 MX Integrated GPU, GeForce3, GeForce3 Ti 200,
	GeForce3 Ti 500, Quadro DCC, GeForce4 Ti 4600, GeForce4 Ti 4400,
	0x0252, GeForce4 Ti 4200, Quadro4 900 XGL, Quadro4 750 XGL,
	Quadro4 700 XGL, GeForce4 Ti 4800, GeForce4 Ti 4200 with AGP8X,
	GeForce4 Ti 4800 SE, GeForce4 4200 Go, Quadro4 700 GoGL,
	Quadro4 980 XGL, Quadro4 780 XGL, 0x0300, GeForce FX 5800 Ultra,
	GeForce FX 5800, Quadro FX 2000, Quadro FX 1000,
	GeForce FX 5600 Ultra, GeForce FX 5600, 0x0316, 0x0317, 0x0318,
	0x0319, 0x031A, 0x031B, 0x031C, 0x031D, 0x031E, 0x031F,
	GeForce FX 5200 Ultra, GeForce FX 5200, 0x0323, GeForce FX Go5200,
	GeForce FX Go5250, 0x032A, Quadro FX 500, 0x032C, 0x032D, 0x032F
(II) RENDITION: rendition driver (version 4.0) for chipsets: V1000,
	V2100/V2200
(II) S3VIRGE: driver (version 1.8.6) for S3 ViRGE chipsets: virge, 86C325,
	virge vx, 86C988, virge dx, virge gx, 86C375, 86C385, virge gx2,
	86C357, virge mx, 86C260, virge mx+, 86C280, trio 3d, 86C365,
	trio 3d/2x, 86C362, 86C368
(II) SAVAGE: driver (version 1.1.27t) for S3 Savage chipsets: Savage4,
	Savage3D, Savage3D-MV, Savage2000, Savage/MX-MV, Savage/MX,
	Savage/IX-MV, Savage/IX, ProSavage PM133, ProSavage KM133,
	ProSavage PN133, ProSavage KN133, SuperSavage/MX 128,
	SuperSavage/MX 64, SuperSavage/MX 64C, SuperSavage/IX 128,
	SuperSavage/IX 128, SuperSavage/IX 64, SuperSavage/IX 64,
	SuperSavage/IXC 64, SuperSavage/IXC 64, ProSavage DDR,
	ProSavage DDR-K
(II) Silicon Motion: driver (version 1.3.1) for Silicon Motion Lynx chipsets:
	Lynx, LynxE, Lynx3D, LynxEM, LynxEM+, Lynx3DM
(II) TRIDENT: driver for Trident chipsets: tvga9000, tvga9000i, tvga8900c,
	tvga8900d, tvga9200cxr, tgui9400cxi, cyber9320, cyber9388, cyber9397,
	cyber9397dvd, cyber9520, cyber9525dvd, cyberblade/e4, tgui9420dgi,
	tgui9440agi, tgui9660, tgui9680, providia9682, providia9685,
	cyber9382, cyber9385, 3dimage975, 3dimage985, blade3d, cyberbladei7,
	cyberbladei7d, cyberbladei1, cyberbladei1d, cyberbladeAi1,
	cyberbladeAi1d, bladeXP, cyberbladeXPAi1
(II) DUMMY: Driver for Dummy chipsets: dummy
(II) Primary Device is: 
(--) Chipset pm2v found
(--) Chipset pm2v found
(II) resource ranges after xf86ClaimFixedResources() call:
	[0] -1	1	0xffffffff - 0xffffffff (0x1) MX[B]
	[1] -1	1	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[2] -1	1	0x000c0000 - 0x000effff (0x30000) MX[B]
	[3] -1	1	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[4] -1	1	0x02000000 - 0x02007fff (0x8000) MX[B]
	[5] -1	1	0x00422000 - 0x004227ff (0x800) MX[B]
	[6] -1	1	0x00420000 - 0x004207ff (0x800) MX[B]
	[7] -1	1	0x00400000 - 0x0041ffff (0x20000) MX[B]
	[8] -1	1	0x01800000 - 0x01ffffff (0x800000) MX[B]
	[9] -1	1	0x07000000 - 0x07ffffff (0x1000000) MX[B]
	[10] -1	1	0x00424000 - 0x00424fff (0x1000) MX[B]
	[11] -1	1	0x03030000 - 0x0303ffff (0x10000) MX[B](B)
	[12] -1	1	0x05000000 - 0x057fffff (0x800000) MX[B](B)
	[13] -1	1	0x04800000 - 0x04ffffff (0x800000) MX[B](B)
	[14] -1	1	0x03040000 - 0x0305ffff (0x20000) MX[B](B)
	[15] -1	1	0x03020000 - 0x0302ffff (0x10000) MX[B](B)
	[16] -1	1	0x04000000 - 0x047fffff (0x800000) MX[B](B)
	[17] -1	1	0x03800000 - 0x03ffffff (0x800000) MX[B](B)
	[18] -1	1	0x03000000 - 0x0301ffff (0x20000) MX[B](B)
	[19] -1	1	0x00440000 - 0x0045ffff (0x20000) MX[B](B)
	[20] -1	1	0x00426000 - 0x00426fff (0x1000) MX[B](B)
	[21] -1	1	0x06000000 - 0x06ffffff (0x1000000) MX[B](B)
	[22] -1	1	0x00ffffff - 0x00ffffff (0x1) IX[B]
	[23] -1	1	0x00000000 - 0x00000000 (0x1) IX[B]
	[24] -1	1	0x00000a20 - 0x00000a2f (0x10) IX[B]
	[25] -1	1	0x00000a08 - 0x00000a0b (0x4) IX[B]
	[26] -1	1	0x00000a10 - 0x00000a17 (0x8) IX[B]
	[27] -1	1	0x00000a18 - 0x00000a1b (0x4) IX[B]
	[28] -1	1	0x00000a00 - 0x00000a07 (0x8) IX[B]
	[29] -1	1	0x00000900 - 0x000009ff (0x100) IX[B]
	[30] -1	1	0x00000b00 - 0x00000bff (0x100) IX[B](B)
(II) resource ranges after xf86ClaimFixedResources() call:
	[0] -1	1	0xffffffff - 0xffffffff (0x1) MX[B]
	[1] -1	1	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[2] -1	1	0x000c0000 - 0x000effff (0x30000) MX[B]
	[3] -1	1	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[4] -1	1	0x02000000 - 0x02007fff (0x8000) MX[B]
	[5] -1	1	0x00422000 - 0x004227ff (0x800) MX[B]
	[6] -1	1	0x00420000 - 0x004207ff (0x800) MX[B]
	[7] -1	1	0x00400000 - 0x0041ffff (0x20000) MX[B]
	[8] -1	1	0x01800000 - 0x01ffffff (0x800000) MX[B]
	[9] -1	1	0x07000000 - 0x07ffffff (0x1000000) MX[B]
	[10] -1	1	0x00424000 - 0x00424fff (0x1000) MX[B]
	[11] -1	1	0x03030000 - 0x0303ffff (0x10000) MX[B](B)
	[12] -1	1	0x05000000 - 0x057fffff (0x800000) MX[B](B)
	[13] -1	1	0x04800000 - 0x04ffffff (0x800000) MX[B](B)
	[14] -1	1	0x03040000 - 0x0305ffff (0x20000) MX[B](B)
	[15] -1	1	0x03020000 - 0x0302ffff (0x10000) MX[B](B)
	[16] -1	1	0x04000000 - 0x047fffff (0x800000) MX[B](B)
	[17] -1	1	0x03800000 - 0x03ffffff (0x800000) MX[B](B)
	[18] -1	1	0x03000000 - 0x0301ffff (0x20000) MX[B](B)
	[19] -1	1	0x00440000 - 0x0045ffff (0x20000) MX[B](B)
	[20] -1	1	0x00426000 - 0x00426fff (0x1000) MX[B](B)
	[21] -1	1	0x06000000 - 0x06ffffff (0x1000000) MX[B](B)
	[22] -1	1	0x00ffffff - 0x00ffffff (0x1) IX[B]
	[23] -1	1	0x00000000 - 0x00000000 (0x1) IX[B]
	[24] -1	1	0x00000a20 - 0x00000a2f (0x10) IX[B]
	[25] -1	1	0x00000a08 - 0x00000a0b (0x4) IX[B]
	[26] -1	1	0x00000a10 - 0x00000a17 (0x8) IX[B]
	[27] -1	1	0x00000a18 - 0x00000a1b (0x4) IX[B]
	[28] -1	1	0x00000a00 - 0x00000a07 (0x8) IX[B]
	[29] -1	1	0x00000900 - 0x000009ff (0x100) IX[B]
	[30] -1	1	0x00000b00 - 0x00000bff (0x100) IX[B](B)
(II) resource ranges after probing:
	[0] -1	1	0xffffffff - 0xffffffff (0x1) MX[B]
	[1] -1	1	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[2] -1	1	0x000c0000 - 0x000effff (0x30000) MX[B]
	[3] -1	1	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[4] -1	1	0x02000000 - 0x02007fff (0x8000) MX[B]
	[5] -1	1	0x00422000 - 0x004227ff (0x800) MX[B]
	[6] -1	1	0x00420000 - 0x004207ff (0x800) MX[B]
	[7] -1	1	0x00400000 - 0x0041ffff (0x20000) MX[B]
	[8] -1	1	0x01800000 - 0x01ffffff (0x800000) MX[B]
	[9] -1	1	0x07000000 - 0x07ffffff (0x1000000) MX[B]
	[10] -1	1	0x00424000 - 0x00424fff (0x1000) MX[B]
	[11] -1	1	0x03030000 - 0x0303ffff (0x10000) MX[B](B)
	[12] -1	1	0x05000000 - 0x057fffff (0x800000) MX[B](B)
	[13] -1	1	0x04800000 - 0x04ffffff (0x800000) MX[B](B)
	[14] -1	1	0x03040000 - 0x0305ffff (0x20000) MX[B](B)
	[15] -1	1	0x03020000 - 0x0302ffff (0x10000) MX[B](B)
	[16] -1	1	0x04000000 - 0x047fffff (0x800000) MX[B](B)
	[17] -1	1	0x03800000 - 0x03ffffff (0x800000) MX[B](B)
	[18] -1	1	0x03000000 - 0x0301ffff (0x20000) MX[B](B)
	[19] -1	1	0x00440000 - 0x0045ffff (0x20000) MX[B](B)
	[20] -1	1	0x00426000 - 0x00426fff (0x1000) MX[B](B)
	[21] -1	1	0x06000000 - 0x06ffffff (0x1000000) MX[B](B)
	[22] 0	1	0x000a0000 - 0x000affff (0x10000) MS[B]
	[23] 0	1	0x000b0000 - 0x000b7fff (0x8000) MS[B]
	[24] 0	1	0x000b8000 - 0x000bffff (0x8000) MS[B]
	[25] 1	1	0x000a0000 - 0x000affff (0x10000) MS[B]
	[26] 1	1	0x000b0000 - 0x000b7fff (0x8000) MS[B]
	[27] 1	1	0x000b8000 - 0x000bffff (0x8000) MS[B]
	[28] -1	1	0x00ffffff - 0x00ffffff (0x1) IX[B]
	[29] -1	1	0x00000000 - 0x00000000 (0x1) IX[B]
	[30] -1	1	0x00000a20 - 0x00000a2f (0x10) IX[B]
	[31] -1	1	0x00000a08 - 0x00000a0b (0x4) IX[B]
	[32] -1	1	0x00000a10 - 0x00000a17 (0x8) IX[B]
	[33] -1	1	0x00000a18 - 0x00000a1b (0x4) IX[B]
	[34] -1	1	0x00000a00 - 0x00000a07 (0x8) IX[B]
	[35] -1	1	0x00000900 - 0x000009ff (0x100) IX[B]
	[36] -1	1	0x00000b00 - 0x00000bff (0x100) IX[B](B)
	[37] 0	1	0x000003b0 - 0x000003bb (0xc) IS[B]
	[38] 0	1	0x000003c0 - 0x000003df (0x20) IS[B]
	[39] 1	1	0x000003b0 - 0x000003bb (0xc) IS[B]
	[40] 1	1	0x000003c0 - 0x000003df (0x20) IS[B]
(II) Setting vga for screen 0.
(II) Setting vga for screen 1.
(**) GLINT(0): Depth 24, (--) framebuffer bpp 32
(==) GLINT(0): RGB weight 888
(==) GLINT(0): Default visual is TrueColor
(==) GLINT(0): Using gamma correction (1.0, 1.0, 1.0)
(==) GLINT(0): Using HW cursor
(--) GLINT(0): Not using Linux framebuffer device
(--) GLINT(0): Chipset: "pm2v"
(--) GLINT(0): Linear framebuffer at 0x4000000
(--) GLINT(0): MMIO registers at 0x3010000
(II) GLINT(0): Initializing int10
(II) Multi Device Card detected: [1:0:0][1:1:0]
(EE) GLINT(0): Cannot read V_BIOS (5)
(--) GLINT(0): VideoRAM: 8192 kByte
(--) GLINT(0): FIFO Size is 256 DWORDS
(==) GLINT(0): Min pixel clock is 16 MHz
(--) GLINT(0): Max pixel clock is 110 MHz
(II) GLINT(0): Sun: Using hsync range of 30.00-82.00 kHz
(II) GLINT(0): Sun: Using vrefresh range of 50.00-120.00 Hz
(II) GLINT(0): Clock range:  16.25 to 110.00 MHz
(II) GLINT(0): Not using default mode "320x175" (bad mode clock/interlace/doublescan)
(II) GLINT(0): Not using default mode "320x200" (bad mode clock/interlace/doublescan)
(II) GLINT(0): Not using default mode "360x200" (bad mode clock/interlace/doublescan)
(II) GLINT(0): Not using default mode "320x240" (bad mode clock/interlace/doublescan)
(II) GLINT(0): Not using default mode "320x240" (bad mode clock/interlace/doublescan)
(II) GLINT(0): Not using default mode "320x240" (bad mode clock/interlace/doublescan)
(II) GLINT(0): Not using default mode "320x240" (bad mode clock/interlace/doublescan)
(II) GLINT(0): Not using default mode "400x300" (bad mode clock/interlace/doublescan)
(II) GLINT(0): Not using default mode "400x300" (bad mode clock/interlace/doublescan)
(II) GLINT(0): Not using default mode "400x300" (bad mode clock/interlace/doublescan)
(II) GLINT(0): Not using default mode "400x300" (bad mode clock/interlace/doublescan)
(II) GLINT(0): Not using default mode "400x300" (bad mode clock/interlace/doublescan)
(II) GLINT(0): Not using default mode "1024x768" (bad mode clock/interlace/doublescan)
(II) GLINT(0): Not using default mode "512x384" (bad mode clock/interlace/doublescan)
(II) GLINT(0): Not using default mode "512x384" (bad mode clock/interlace/doublescan)
(II) GLINT(0): Not using default mode "512x384" (bad mode clock/interlace/doublescan)
(II) GLINT(0): Not using default mode "512x384" (bad mode clock/interlace/doublescan)
(II) GLINT(0): Not using default mode "512x384" (bad mode clock/interlace/doublescan)
(II) GLINT(0): Not using default mode "576x432" (bad mode clock/interlace/doublescan)
(II) GLINT(0): Not using default mode "640x480" (bad mode clock/interlace/doublescan)
(II) GLINT(0): Not using default mode "1280x960" (bad mode clock/interlace/doublescan)
(II) GLINT(0): Not using default mode "640x480" (bad mode clock/interlace/doublescan)
(II) GLINT(0): Not using default mode "640x512" (bad mode clock/interlace/doublescan)
(II) GLINT(0): Not using default mode "1280x1024" (bad mode clock/interlace/doublescan)
(II) GLINT(0): Not using default mode "640x512" (bad mode clock/interlace/doublescan)
(II) GLINT(0): Not using default mode "1280x1024" (bad mode clock/interlace/doublescan)
(II) GLINT(0): Not using default mode "640x512" (bad mode clock/interlace/doublescan)
(II) GLINT(0): Not using default mode "1600x1200" (bad mode clock/interlace/doublescan)
(II) GLINT(0): Not using default mode "800x600" (bad mode clock/interlace/doublescan)
(II) GLINT(0): Not using default mode "1600x1200" (bad mode clock/interlace/doublescan)
(II) GLINT(0): Not using default mode "800x600" (bad mode clock/interlace/doublescan)
(II) GLINT(0): Not using default mode "1600x1200" (bad mode clock/interlace/doublescan)
(II) GLINT(0): Not using default mode "800x600" (bad mode clock/interlace/doublescan)
(II) GLINT(0): Not using default mode "1600x1200" (bad mode clock/interlace/doublescan)
(II) GLINT(0): Not using default mode "800x600" (bad mode clock/interlace/doublescan)
(II) GLINT(0): Not using default mode "1600x1200" (bad mode clock/interlace/doublescan)
(II) GLINT(0): Not using default mode "800x600" (bad mode clock/interlace/doublescan)
(II) GLINT(0): Not using default mode "1792x1344" (insufficient memory for mode)
(II) GLINT(0): Not using default mode "896x672" (bad mode clock/interlace/doublescan)
(II) GLINT(0): Not using default mode "1792x1344" (insufficient memory for mode)
(II) GLINT(0): Not using default mode "896x672" (bad mode clock/interlace/doublescan)
(II) GLINT(0): Not using default mode "1856x1392" (insufficient memory for mode)
(II) GLINT(0): Not using default mode "928x696" (bad mode clock/interlace/doublescan)
(II) GLINT(0): Not using default mode "1856x1392" (insufficient memory for mode)
(II) GLINT(0): Not using default mode "928x696" (bad mode clock/interlace/doublescan)
(II) GLINT(0): Not using default mode "1920x1440" (insufficient memory for mode)
(II) GLINT(0): Not using default mode "960x720" (bad mode clock/interlace/doublescan)
(II) GLINT(0): Not using default mode "1920x1440" (insufficient memory for mode)
(II) GLINT(0): Not using default mode "960x720" (bad mode clock/interlace/doublescan)
(II) GLINT(0): Not using default mode "416x312" (bad mode clock/interlace/doublescan)
(II) GLINT(0): Not using default mode "576x384" (bad mode clock/interlace/doublescan)
(II) GLINT(0): Not using default mode "1400x1050" (bad mode clock/interlace/doublescan)
(II) GLINT(0): Not using default mode "700x525" (bad mode clock/interlace/doublescan)
(II) GLINT(0): Not using default mode "1400x1050" (bad mode clock/interlace/doublescan)
(II) GLINT(0): Not using default mode "700x525" (bad mode clock/interlace/doublescan)
(II) GLINT(0): Not using default mode "800x512" (bad mode clock/interlace/doublescan)
(II) GLINT(0): Not using default mode "1920x1440" (insufficient memory for mode)
(II) GLINT(0): Not using default mode "960x720" (bad mode clock/interlace/doublescan)
(II) GLINT(0): Not using default mode "2048x1536" (insufficient memory for mode)
(II) GLINT(0): Not using default mode "1024x768" (bad mode clock/interlace/doublescan)
(II) GLINT(0): Not using default mode "2048x1536" (insufficient memory for mode)
(II) GLINT(0): Not using default mode "1024x768" (bad mode clock/interlace/doublescan)
(II) GLINT(0): Not using default mode "2048x1536" (insufficient memory for mode)
(II) GLINT(0): Not using default mode "1024x768" (bad mode clock/interlace/doublescan)
(--) GLINT(0): Virtual size is 1280x1024 (pitch 1280)
(**) GLINT(0): *Default mode "1280x1024": 108.0 MHz, 64.0 kHz, 60.0 Hz
(II) GLINT(0): Modeline "1280x1024"  108.00  1280 1328 1440 1688  1024 1025 1028 1066 +hsync +vsync
(**) GLINT(0):  Default mode "1280x960": 108.0 MHz, 60.0 kHz, 60.0 Hz
(II) GLINT(0): Modeline "1280x960"  108.00  1280 1376 1488 1800  960 961 964 1000 +hsync +vsync
(**) GLINT(0):  Default mode "1152x864": 108.0 MHz, 67.5 kHz, 75.0 Hz
(II) GLINT(0): Modeline "1152x864"  108.00  1152 1216 1344 1600  864 865 868 900 +hsync +vsync
(**) GLINT(0):  Default mode "1152x768": 65.0 MHz, 44.2 kHz, 54.8 Hz
(II) GLINT(0): Modeline "1152x768"   65.00  1152 1178 1314 1472  768 771 777 806 +hsync +vsync
(**) GLINT(0):  Default mode "1024x768": 94.5 MHz, 68.7 kHz, 85.0 Hz
(II) GLINT(0): Modeline "1024x768"   94.50  1024 1072 1168 1376  768 769 772 808 +hsync +vsync
(**) GLINT(0):  Default mode "1024x768": 78.8 MHz, 60.1 kHz, 75.1 Hz
(II) GLINT(0): Modeline "1024x768"   78.80  1024 1040 1136 1312  768 769 772 800 +hsync +vsync
(**) GLINT(0):  Default mode "1024x768": 75.0 MHz, 56.5 kHz, 70.1 Hz
(II) GLINT(0): Modeline "1024x768"   75.00  1024 1048 1184 1328  768 771 777 806 -hsync -vsync
(**) GLINT(0):  Default mode "1024x768": 65.0 MHz, 48.4 kHz, 60.0 Hz
(II) GLINT(0): Modeline "1024x768"   65.00  1024 1048 1184 1344  768 771 777 806 -hsync -vsync
(**) GLINT(0):  Default mode "832x624": 57.3 MHz, 49.7 kHz, 74.6 Hz
(II) GLINT(0): Modeline "832x624"   57.28  832 864 928 1152  624 625 628 667 -hsync -vsync
(**) GLINT(0):  Default mode "800x600": 56.3 MHz, 53.7 kHz, 85.1 Hz
(II) GLINT(0): Modeline "800x600"   56.30  800 832 896 1048  600 601 604 631 +hsync +vsync
(**) GLINT(0):  Default mode "800x600": 49.5 MHz, 46.9 kHz, 75.0 Hz
(II) GLINT(0): Modeline "800x600"   49.50  800 816 896 1056  600 601 604 625 +hsync +vsync
(**) GLINT(0):  Default mode "800x600": 50.0 MHz, 48.1 kHz, 72.2 Hz
(II) GLINT(0): Modeline "800x600"   50.00  800 856 976 1040  600 637 643 666 +hsync +vsync
(**) GLINT(0):  Default mode "800x600": 40.0 MHz, 37.9 kHz, 60.3 Hz
(II) GLINT(0): Modeline "800x600"   40.00  800 840 968 1056  600 601 605 628 +hsync +vsync
(**) GLINT(0):  Default mode "800x600": 36.0 MHz, 35.2 kHz, 56.2 Hz
(II) GLINT(0): Modeline "800x600"   36.00  800 824 896 1024  600 601 603 625 +hsync +vsync
(**) GLINT(0):  Default mode "640x480": 36.0 MHz, 43.3 kHz, 85.0 Hz
(II) GLINT(0): Modeline "640x480"   36.00  640 696 752 832  480 481 484 509 -hsync -vsync
(**) GLINT(0):  Default mode "640x480": 31.5 MHz, 37.5 kHz, 75.0 Hz
(II) GLINT(0): Modeline "640x480"   31.50  640 656 720 840  480 481 484 500 -hsync -vsync
(**) GLINT(0):  Default mode "640x480": 31.5 MHz, 37.9 kHz, 72.8 Hz
(II) GLINT(0): Modeline "640x480"   31.50  640 664 704 832  480 489 491 520 -hsync -vsync
(**) GLINT(0):  Default mode "640x480": 25.2 MHz, 31.5 kHz, 60.0 Hz
(II) GLINT(0): Modeline "640x480"   25.20  640 656 752 800  480 490 492 525 -hsync -vsync
(**) GLINT(0):  Default mode "720x400": 35.5 MHz, 37.9 kHz, 85.0 Hz
(II) GLINT(0): Modeline "720x400"   35.50  720 756 828 936  400 401 404 446 -hsync +vsync
(**) GLINT(0):  Default mode "640x400": 31.5 MHz, 37.9 kHz, 85.1 Hz
(II) GLINT(0): Modeline "640x400"   31.50  640 672 736 832  400 401 404 445 -hsync +vsync
(**) GLINT(0):  Default mode "640x350": 31.5 MHz, 37.9 kHz, 85.1 Hz
(II) GLINT(0): Modeline "640x350"   31.50  640 672 736 832  350 382 385 445 +hsync -vsync
(++) GLINT(0): DPI set to (100, 100)
(II) GLINT(0): I2C bus "DDC" initialized.
(II) GLINT(0): I2C bus "Video" initialized.
(**) GLINT(1): Depth 24, (--) framebuffer bpp 32
(==) GLINT(1): RGB weight 888
(==) GLINT(1): Default visual is TrueColor
(==) GLINT(1): Using gamma correction (1.0, 1.0, 1.0)
(==) GLINT(1): Using HW cursor
(--) GLINT(1): Not using Linux framebuffer device
(--) GLINT(1): Chipset: "pm2v"
(--) GLINT(1): Linear framebuffer at 0x5000000
(--) GLINT(1): MMIO registers at 0x3050000
(II) GLINT(1): Initializing int10
(II) Multi Device Card detected: [1:0:0][1:1:0]
(EE) GLINT(1): Cannot read V_BIOS (5)
(--) GLINT(1): VideoRAM: 4096 kByte
(--) GLINT(1): FIFO Size is 256 DWORDS
(==) GLINT(1): Min pixel clock is 16 MHz
(--) GLINT(1): Max pixel clock is 110 MHz
(II) GLINT(1): Sun2: Using hsync range of 30.00-82.00 kHz
(II) GLINT(1): Sun2: Using vrefresh range of 50.00-120.00 Hz
(II) GLINT(1): Clock range:  16.25 to 110.00 MHz
(II) GLINT(1): Not using default mode "320x175" (bad mode clock/interlace/doublescan)
(II) GLINT(1): Not using default mode "320x200" (bad mode clock/interlace/doublescan)
(II) GLINT(1): Not using default mode "360x200" (bad mode clock/interlace/doublescan)
(II) GLINT(1): Not using default mode "320x240" (bad mode clock/interlace/doublescan)
(II) GLINT(1): Not using default mode "320x240" (bad mode clock/interlace/doublescan)
(II) GLINT(1): Not using default mode "320x240" (bad mode clock/interlace/doublescan)
(II) GLINT(1): Not using default mode "320x240" (bad mode clock/interlace/doublescan)
(II) GLINT(1): Not using default mode "400x300" (bad mode clock/interlace/doublescan)
(II) GLINT(1): Not using default mode "400x300" (bad mode clock/interlace/doublescan)
(II) GLINT(1): Not using default mode "400x300" (bad mode clock/interlace/doublescan)
(II) GLINT(1): Not using default mode "400x300" (bad mode clock/interlace/doublescan)
(II) GLINT(1): Not using default mode "400x300" (bad mode clock/interlace/doublescan)
(II) GLINT(1): Not using default mode "1024x768" (bad mode clock/interlace/doublescan)
(II) GLINT(1): Not using default mode "512x384" (bad mode clock/interlace/doublescan)
(II) GLINT(1): Not using default mode "512x384" (bad mode clock/interlace/doublescan)
(II) GLINT(1): Not using default mode "512x384" (bad mode clock/interlace/doublescan)
(II) GLINT(1): Not using default mode "512x384" (bad mode clock/interlace/doublescan)
(II) GLINT(1): Not using default mode "512x384" (bad mode clock/interlace/doublescan)
(II) GLINT(1): Not using default mode "576x432" (bad mode clock/interlace/doublescan)
(II) GLINT(1): Not using default mode "1280x960" (insufficient memory for mode)
(II) GLINT(1): Not using default mode "640x480" (bad mode clock/interlace/doublescan)
(II) GLINT(1): Not using default mode "1280x960" (insufficient memory for mode)
(II) GLINT(1): Not using default mode "640x480" (bad mode clock/interlace/doublescan)
(II) GLINT(1): Not using default mode "1280x1024" (insufficient memory for mode)
(II) GLINT(1): Not using default mode "640x512" (bad mode clock/interlace/doublescan)
(II) GLINT(1): Not using default mode "1280x1024" (insufficient memory for mode)
(II) GLINT(1): Not using default mode "640x512" (bad mode clock/interlace/doublescan)
(II) GLINT(1): Not using default mode "1280x1024" (insufficient memory for mode)
(II) GLINT(1): Not using default mode "640x512" (bad mode clock/interlace/doublescan)
(II) GLINT(1): Not using default mode "1600x1200" (insufficient memory for mode)
(II) GLINT(1): Not using default mode "800x600" (bad mode clock/interlace/doublescan)
(II) GLINT(1): Not using default mode "1600x1200" (insufficient memory for mode)
(II) GLINT(1): Not using default mode "800x600" (bad mode clock/interlace/doublescan)
(II) GLINT(1): Not using default mode "1600x1200" (insufficient memory for mode)
(II) GLINT(1): Not using default mode "800x600" (bad mode clock/interlace/doublescan)
(II) GLINT(1): Not using default mode "1600x1200" (insufficient memory for mode)
(II) GLINT(1): Not using default mode "800x600" (bad mode clock/interlace/doublescan)
(II) GLINT(1): Not using default mode "1600x1200" (insufficient memory for mode)
(II) GLINT(1): Not using default mode "800x600" (bad mode clock/interlace/doublescan)
(II) GLINT(1): Not using default mode "1792x1344" (insufficient memory for mode)
(II) GLINT(1): Not using default mode "896x672" (bad mode clock/interlace/doublescan)
(II) GLINT(1): Not using default mode "1792x1344" (insufficient memory for mode)
(II) GLINT(1): Not using default mode "896x672" (bad mode clock/interlace/doublescan)
(II) GLINT(1): Not using default mode "1856x1392" (insufficient memory for mode)
(II) GLINT(1): Not using default mode "928x696" (bad mode clock/interlace/doublescan)
(II) GLINT(1): Not using default mode "1856x1392" (insufficient memory for mode)
(II) GLINT(1): Not using default mode "928x696" (bad mode clock/interlace/doublescan)
(II) GLINT(1): Not using default mode "1920x1440" (insufficient memory for mode)
(II) GLINT(1): Not using default mode "960x720" (bad mode clock/interlace/doublescan)
(II) GLINT(1): Not using default mode "1920x1440" (insufficient memory for mode)
(II) GLINT(1): Not using default mode "960x720" (bad mode clock/interlace/doublescan)
(II) GLINT(1): Not using default mode "416x312" (bad mode clock/interlace/doublescan)
(II) GLINT(1): Not using default mode "576x384" (bad mode clock/interlace/doublescan)
(II) GLINT(1): Not using default mode "1400x1050" (insufficient memory for mode)
(II) GLINT(1): Not using default mode "700x525" (bad mode clock/interlace/doublescan)
(II) GLINT(1): Not using default mode "1400x1050" (insufficient memory for mode)
(II) GLINT(1): Not using default mode "700x525" (bad mode clock/interlace/doublescan)
(II) GLINT(1): Not using default mode "1600x1024" (insufficient memory for mode)
(II) GLINT(1): Not using default mode "800x512" (bad mode clock/interlace/doublescan)
(II) GLINT(1): Not using default mode "1920x1440" (insufficient memory for mode)
(II) GLINT(1): Not using default mode "960x720" (bad mode clock/interlace/doublescan)
(II) GLINT(1): Not using default mode "2048x1536" (insufficient memory for mode)
(II) GLINT(1): Not using default mode "1024x768" (bad mode clock/interlace/doublescan)
(II) GLINT(1): Not using default mode "2048x1536" (insufficient memory for mode)
(II) GLINT(1): Not using default mode "1024x768" (bad mode clock/interlace/doublescan)
(II) GLINT(1): Not using default mode "2048x1536" (insufficient memory for mode)
(II) GLINT(1): Not using default mode "1024x768" (bad mode clock/interlace/doublescan)
(II) GLINT(1): Not using mode "1280x1024" (no mode of this name)
(--) GLINT(1): Virtual size is 1152x864 (pitch 1152)
(**) GLINT(1):  Default mode "1152x864": 108.0 MHz, 67.5 kHz, 75.0 Hz
(II) GLINT(1): Modeline "1152x864"  108.00  1152 1216 1344 1600  864 865 868 900 +hsync +vsync
(**) GLINT(1):  Default mode "1152x768": 65.0 MHz, 44.2 kHz, 54.8 Hz
(II) GLINT(1): Modeline "1152x768"   65.00  1152 1178 1314 1472  768 771 777 806 +hsync +vsync
(**) GLINT(1):  Default mode "1024x768": 94.5 MHz, 68.7 kHz, 85.0 Hz
(II) GLINT(1): Modeline "1024x768"   94.50  1024 1072 1168 1376  768 769 772 808 +hsync +vsync
(**) GLINT(1):  Default mode "1024x768": 78.8 MHz, 60.1 kHz, 75.1 Hz
(II) GLINT(1): Modeline "1024x768"   78.80  1024 1040 1136 1312  768 769 772 800 +hsync +vsync
(**) GLINT(1):  Default mode "1024x768": 75.0 MHz, 56.5 kHz, 70.1 Hz
(II) GLINT(1): Modeline "1024x768"   75.00  1024 1048 1184 1328  768 771 777 806 -hsync -vsync
(**) GLINT(1):  Default mode "1024x768": 65.0 MHz, 48.4 kHz, 60.0 Hz
(II) GLINT(1): Modeline "1024x768"   65.00  1024 1048 1184 1344  768 771 777 806 -hsync -vsync
(**) GLINT(1):  Default mode "832x624": 57.3 MHz, 49.7 kHz, 74.6 Hz
(II) GLINT(1): Modeline "832x624"   57.28  832 864 928 1152  624 625 628 667 -hsync -vsync
(**) GLINT(1):  Default mode "800x600": 56.3 MHz, 53.7 kHz, 85.1 Hz
(II) GLINT(1): Modeline "800x600"   56.30  800 832 896 1048  600 601 604 631 +hsync +vsync
(**) GLINT(1):  Default mode "800x600": 49.5 MHz, 46.9 kHz, 75.0 Hz
(II) GLINT(1): Modeline "800x600"   49.50  800 816 896 1056  600 601 604 625 +hsync +vsync
(**) GLINT(1):  Default mode "800x600": 50.0 MHz, 48.1 kHz, 72.2 Hz
(II) GLINT(1): Modeline "800x600"   50.00  800 856 976 1040  600 637 643 666 +hsync +vsync
(**) GLINT(1):  Default mode "800x600": 40.0 MHz, 37.9 kHz, 60.3 Hz
(II) GLINT(1): Modeline "800x600"   40.00  800 840 968 1056  600 601 605 628 +hsync +vsync
(**) GLINT(1):  Default mode "800x600": 36.0 MHz, 35.2 kHz, 56.2 Hz
(II) GLINT(1): Modeline "800x600"   36.00  800 824 896 1024  600 601 603 625 +hsync +vsync
(**) GLINT(1):  Default mode "640x480": 36.0 MHz, 43.3 kHz, 85.0 Hz
(II) GLINT(1): Modeline "640x480"   36.00  640 696 752 832  480 481 484 509 -hsync -vsync
(**) GLINT(1):  Default mode "640x480": 31.5 MHz, 37.5 kHz, 75.0 Hz
(II) GLINT(1): Modeline "640x480"   31.50  640 656 720 840  480 481 484 500 -hsync -vsync
(**) GLINT(1):  Default mode "640x480": 31.5 MHz, 37.9 kHz, 72.8 Hz
(II) GLINT(1): Modeline "640x480"   31.50  640 664 704 832  480 489 491 520 -hsync -vsync
(**) GLINT(1):  Default mode "640x480": 25.2 MHz, 31.5 kHz, 60.0 Hz
(II) GLINT(1): Modeline "640x480"   25.20  640 656 752 800  480 490 492 525 -hsync -vsync
(**) GLINT(1):  Default mode "720x400": 35.5 MHz, 37.9 kHz, 85.0 Hz
(II) GLINT(1): Modeline "720x400"   35.50  720 756 828 936  400 401 404 446 -hsync +vsync
(**) GLINT(1):  Default mode "640x400": 31.5 MHz, 37.9 kHz, 85.1 Hz
(II) GLINT(1): Modeline "640x400"   31.50  640 672 736 832  400 401 404 445 -hsync +vsync
(**) GLINT(1):  Default mode "640x350": 31.5 MHz, 37.9 kHz, 85.1 Hz
(II) GLINT(1): Modeline "640x350"   31.50  640 672 736 832  350 382 385 445 +hsync -vsync
(++) GLINT(1): DPI set to (100, 100)
(II) GLINT(1): I2C bus "DDC" initialized.
(II) GLINT(1): I2C bus "Video" initialized.
(--) Depth 24 pixmap format is 32 bpp
(II) resource ranges after preInit:
	[0] 1	1	0x05000000 - 0x057fffff (0x800000) MX[B]
	[1] 1	1	0x04800000 - 0x04ffffff (0x800000) MX[B]
	[2] 1	1	0x03040000 - 0x0305ffff (0x20000) MX[B]
	[3] 0	1	0x04000000 - 0x047fffff (0x800000) MX[B]
	[4] 0	1	0x03800000 - 0x03ffffff (0x800000) MX[B]
	[5] 0	1	0x03000000 - 0x0301ffff (0x20000) MX[B]
	[6] -1	1	0xffffffff - 0xffffffff (0x1) MX[B]
	[7] -1	1	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[8] -1	1	0x000c0000 - 0x000effff (0x30000) MX[B]
	[9] -1	1	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[10] -1	1	0x02000000 - 0x02007fff (0x8000) MX[B]
	[11] -1	1	0x00422000 - 0x004227ff (0x800) MX[B]
	[12] -1	1	0x00420000 - 0x004207ff (0x800) MX[B]
	[13] -1	1	0x00400000 - 0x0041ffff (0x20000) MX[B]
	[14] -1	1	0x01800000 - 0x01ffffff (0x800000) MX[B]
	[15] -1	1	0x07000000 - 0x07ffffff (0x1000000) MX[B]
	[16] -1	1	0x00424000 - 0x00424fff (0x1000) MX[B]
	[17] -1	1	0x03030000 - 0x0303ffff (0x10000) MX[B](B)
	[18] -1	1	0x05000000 - 0x057fffff (0x800000) MX[B](B)
	[19] -1	1	0x04800000 - 0x04ffffff (0x800000) MX[B](B)
	[20] -1	1	0x03040000 - 0x0305ffff (0x20000) MX[B](B)
	[21] -1	1	0x03020000 - 0x0302ffff (0x10000) MX[B](B)
	[22] -1	1	0x04000000 - 0x047fffff (0x800000) MX[B](B)
	[23] -1	1	0x03800000 - 0x03ffffff (0x800000) MX[B](B)
	[24] -1	1	0x03000000 - 0x0301ffff (0x20000) MX[B](B)
	[25] -1	1	0x00440000 - 0x0045ffff (0x20000) MX[B](B)
	[26] -1	1	0x00426000 - 0x00426fff (0x1000) MX[B](B)
	[27] -1	1	0x06000000 - 0x06ffffff (0x1000000) MX[B](B)
	[28] 0	1	0x000a0000 - 0x000affff (0x10000) MS[B](OprD)
	[29] 0	1	0x000b0000 - 0x000b7fff (0x8000) MS[B](OprD)
	[30] 0	1	0x000b8000 - 0x000bffff (0x8000) MS[B](OprD)
	[31] 1	1	0x000a0000 - 0x000affff (0x10000) MS[B](OprD)
	[32] 1	1	0x000b0000 - 0x000b7fff (0x8000) MS[B](OprD)
	[33] 1	1	0x000b8000 - 0x000bffff (0x8000) MS[B](OprD)
	[34] -1	1	0x00ffffff - 0x00ffffff (0x1) IX[B]
	[35] -1	1	0x00000000 - 0x00000000 (0x1) IX[B]
	[36] -1	1	0x00000a20 - 0x00000a2f (0x10) IX[B]
	[37] -1	1	0x00000a08 - 0x00000a0b (0x4) IX[B]
	[38] -1	1	0x00000a10 - 0x00000a17 (0x8) IX[B]
	[39] -1	1	0x00000a18 - 0x00000a1b (0x4) IX[B]
	[40] -1	1	0x00000a00 - 0x00000a07 (0x8) IX[B]
	[41] -1	1	0x00000900 - 0x000009ff (0x100) IX[B]
	[42] -1	1	0x00000b00 - 0x00000bff (0x100) IX[B](B)
	[43] 0	1	0x000003b0 - 0x000003bb (0xc) IS[B](OprD)
	[44] 0	1	0x000003c0 - 0x000003df (0x20) IS[B](OprD)
	[45] 1	1	0x000003b0 - 0x000003bb (0xc) IS[B](OprD)
	[46] 1	1	0x000003c0 - 0x000003df (0x20) IS[B](OprD)
(II) GLINT(0): I2C device "DDC:ddc2" registered at address 0xA0.
(II) GLINT(0): I2C device "DDC:ddc2" removed.
(II) GLINT(0): Using XFree86 Acceleration Architecture (XAA)
	Screen to screen bit blits
	Solid filled rectangles
	8x8 mono pattern filled rectangles
	Indirect CPU to Screen color expansion
	Solid Lines
	Offscreen Pixmaps
	Driver provided WriteBitmap replacement
	Driver provided WritePixmap replacement
	Setting up tile and stipple cache:
		20 128x128 slots
		5 256x256 slots
(==) GLINT(0): Backing store disabled
(==) GLINT(0): Silken mouse enabled
(**) Option "dpms"
(**) GLINT(0): DPMS enabled
(II) GLINT(0): direct rendering disabled
(II) GLINT(0): Initializing Xv driver rev. 4
(II) GLINT(0): Xv frontend scaler enabled
(==) RandR enabled
(II) GLINT(1): I2C device "DDC:ddc2" registered at address 0xA0.
(II) GLINT(1): I2C device "DDC:ddc2" removed.
(II) GLINT(1): Using XFree86 Acceleration Architecture (XAA)
	Screen to screen bit blits
	Solid filled rectangles
	8x8 mono pattern filled rectangles
	Indirect CPU to Screen color expansion
	Solid Lines
	Offscreen Pixmaps
	Driver provided WriteBitmap replacement
	Driver provided WritePixmap replacement
	Setting up tile and stipple cache:
		9 128x46 slots
(==) GLINT(1): Backing store disabled
(==) GLINT(1): Silken mouse enabled
(**) Option "dpms"
(**) GLINT(1): DPMS enabled
(II) GLINT(1): direct rendering disabled
(II) GLINT(1): Initializing Xv driver rev. 4
(II) GLINT(1): Xv frontend scaler enabled
(==) RandR enabled
(II) Entity 0 shares no resources
(II) Entity 1 shares no resources
(II) Keyboard "Generic Keyboard" handled by legacy driver
(**) Option "Protocol" "ImPS/2"
(**) Configured Mouse: Protocol: "ImPS/2"
(**) Configured Mouse: Core Pointer
(**) Option "Device" "/dev/input/mice"
(**) Configured Mouse: Emulate3Buttons, Emulate3Timeout: 50
(==) Configured Mouse: Buttons: 3
(II) XINPUT: Adding extended input device "Configured Mouse" (type: MOUSE)
(II) Server_Terminate keybinding not found
(II) Configured Mouse: ps2EnableDataReporting: succeeded
Could not init font path element unix/:7100, removing from list!
(II) Screen 0 shares mem & io resources
(II) Screen 1 shares mem & io resources
(WW) Open APM failed (/dev/apm_bios) (No such file or directory)
(II) Screen 0 shares mem & io resources
(II) Screen 1 shares mem & io resources
(II) Screen 0 shares mem & io resources
(II) Screen 1 shares mem & io resources
(II) Entity 0 shares no resources
(II) Entity 1 shares no resources
(II) Configured Mouse: ps2EnableDataReporting: succeeded

--qMm9M+Fa2AknHoGS--


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
