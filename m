From: Sven Luther <sven.luther@wanadoo.fr>
Subject: Re: Bug#226973: xserver-xfree86: [glint] second card at wrong resolution
Date: Tue, 13 Jan 2004 08:41:58 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040113074158.GF4863@iliana>
References: <20040109163119.GA10151@scowler.net> <20040112121558.GA24511@iliana> <20040112215543.GB2150@scowler.net>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AgJBj-0003bB-16
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 12 Jan 2004 23:42:11 -0800
Received: from smtp4.wanadoo.fr ([193.252.22.27] helo=mwinf0402.wanadoo.fr)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1AgJBh-0001oR-67
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 12 Jan 2004 23:42:09 -0800
Content-Disposition: inline
In-Reply-To: <20040112215543.GB2150@scowler.net>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Clint Adams <schizo@debian.org>
Cc: Sven Luther <sven.luther@wanadoo.fr>, 226973@bugs.debian.org, linux-fbdev-devel@lists.sourceforge.net

On Mon, Jan 12, 2004 at 04:55:43PM -0500, Clint Adams wrote:
> > Could you also provide the /var/log/XFree86.0.log, and please CC me on
> > this bugreport.
> 
> Sure.    I don't know if this is relevant, but the first card is is
> picked up by the PM2 framebuffer driver (the second is not, because the
> driver doesn't support multiple cards--I'm trying to copy the multiple
> card support from pm3fb but I don't really know what I'm doing.

Ok, this may be the problem. The first one is initialized by the pm2fb,
while the second is not. This mean either some initialization problems,
or the fact that X doesn't initialize some values set by pm2fb.

What kernel are you using, maybe it would be best to work on a 2.6
kernel and try to adapt the pm2fb to the new framework or something.

Can you describe me the symptoms again ? what exactly did you see on the
second head ?

Also, i am CCing the linux-fbdev mailing list, as there are chance that
they would have an insight on this.

Friendly,

Sven Luther

> /var/log/XFree86.0.log:
> 
> This is a pre-release version of XFree86, and is not supported in any
> way.  Bugs may be reported to XFree86@XFree86.Org and patches submitted
> to fixes@XFree86.Org.  Before reporting bugs in pre-release versions,
> please check the latest version in the XFree86 CVS repository
> (http://www.XFree86.Org/cvs).
> 
> XFree86 Version 4.3.0.1 (Debian 4.3.0-0pre1v3 20030929061855 ilmari@ilmari.org)
> Release Date: 15 August 2003
> X Protocol Version 11, Revision 0, Release 6.6
> Build Operating System: Linux 2.4.18 sparc [ELF] 
> Build Date: 29 September 2003
> 	Before reporting problems, check http://www.XFree86.Org/
> 	to make sure that you have the latest version.
> Module Loader present
> OS Kernel: Linux version 2.4.24 (clint@rashudo) (gcc version 3.3.3 20031229 (prerelease) (Debian)) #1 Mon Jan 12 14:44:22 EST 2004 
> Markers: (--) probed, (**) from config file, (==) default setting,
>          (++) from command line, (!!) notice, (II) informational,
>          (WW) warning, (EE) error, (NI) not implemented, (??) unknown.
> (==) Log file: "/var/log/XFree86.0.log", Time: Mon Jan 12 15:30:54 2004
> (==) Using config file: "/etc/X11/XF86Config-4"
> (==) ServerLayout "Default Layout"
> (**) |-->Screen "Default Screen" (0)
> (**) |   |-->Monitor "Sun"
> (**) |   |-->Device "TSI Raptor GFX 8P"
> (**) |-->Screen "Screen Two" (1)
> (**) |   |-->Monitor "Sun2"
> (**) |   |-->Device "TSI Raptor GFX 8P 2"
> (**) |-->Input Device "Generic Keyboard"
> (**) Option "XkbRules" "xfree86"
> (**) XKB: rules: "xfree86"
> (**) Option "XkbModel" "pc104"
> (**) XKB: model: "pc104"
> (**) Option "XkbLayout" "us"
> (**) XKB: layout: "us"
> (==) Keyboard: CustomKeycode disabled
> (**) |-->Input Device "Configured Mouse"
> (WW) The directory "/usr/lib/X11/fonts/CID" does not exist.
> 	Entry deleted from font path.
> (WW) The directory "/usr/lib/X11/fonts/cyrillic" does not exist.
> 	Entry deleted from font path.
> (WW) `fonts.dir' not found (or not valid) in "/var/lib/defoma/x-ttcidfont-conf.d/dirs/CID".
> 	Entry deleted from font path.
> 	(Run 'mkfontdir' on "/var/lib/defoma/x-ttcidfont-conf.d/dirs/CID").
> (**) FontPath set to "unix/:7100,/usr/lib/X11/fonts/Type1,/usr/lib/X11/fonts/Speedo,/usr/lib/X11/fonts/misc,/usr/lib/X11/fonts/100dpi,/usr/lib/X11/fonts/75dpi,/var/lib/defoma/x-ttcidfont-conf.d/dirs/TrueType"
> (==) RgbPath set to "/usr/X11R6/lib/X11/rgb"
> (==) ModulePath set to "/usr/X11R6/lib/modules"
> (++) using VT number 7
> 
> (WW) Open APM failed (/dev/apm_bios) (No such file or directory)
> (II) Module ABI versions:
> 	XFree86 ANSI C Emulation: 0.2
> 	XFree86 Video Driver: 0.6
> 	XFree86 XInput driver : 0.4
> 	XFree86 Server Extension : 0.2
> 	XFree86 Font Renderer : 0.4
> (II) Loader running on linux
> (II) LoadModule: "bitmap"
> (II) Loading /usr/X11R6/lib/modules/fonts/libbitmap.a
> (II) Module bitmap: vendor="The XFree86 Project"
> 	compiled for 4.3.0.1, module version = 1.0.0
> 	Module class: XFree86 Font Renderer
> 	ABI class: XFree86 Font Renderer, version 0.4
> (II) Loading font Bitmap
> (II) LoadModule: "pcidata"
> (II) Loading /usr/X11R6/lib/modules/libpcidata.a
> (II) Module pcidata: vendor="The XFree86 Project"
> 	compiled for 4.3.0.1, module version = 1.0.0
> 	ABI class: XFree86 Video Driver, version 0.6
> (II) PCI: PCI scan (all values are in hex)
> (II) PCI: 00:00:0: chip 108e,a001 card 0000,0000 rev 00 class 06,00,00 hdr 00
> (II) PCI: 00:03:0: chip 10b9,7101 card 0000,0000 rev 00 class 00,00,00 hdr 00
> (II) PCI: 00:05:0: chip 1011,0024 card 0000,0000 rev 03 class 06,04,00 hdr 01
> (II) PCI: 00:07:0: chip 10b9,1533 card 10b9,1533 rev 00 class 06,01,00 hdr 00
> (II) PCI: 00:08:0: chip 10b9,5451 card 10b9,5451 rev 01 class 04,01,00 hdr 00
> (II) PCI: 00:0c:0: chip 108e,1100 card 0000,0000 rev 01 class 06,80,00 hdr 80
> (II) PCI: 00:0c:1: chip 108e,1101 card 0000,0000 rev 01 class 02,00,00 hdr 80
> (II) PCI: 00:0c:2: chip 108e,1102 card 0000,0000 rev 01 class 0c,00,10 hdr 80
> (II) PCI: 00:0c:3: chip 108e,1103 card 0000,0000 rev 01 class 0c,03,10 hdr 80
> (II) PCI: 00:0d:0: chip 10b9,5229 card 0000,0000 rev c3 class 01,01,ff hdr 00
> (II) PCI: 00:13:0: chip 1002,4752 card 0000,0000 rev 65 class 03,00,00 hdr 00
> (II) PCI: 01:00:0: chip 3d3d,0009 card 1227,0006 rev 01 class 03,80,00 hdr 00
> (II) PCI: 01:01:0: chip 3d3d,0009 card 1227,0006 rev 01 class 03,80,00 hdr 00
> (II) PCI: End of PCI scan
> (II) Host-to-PCI bridge:
> (II) Bus 0: bridge is at (0:0:0), (0,0,1), BCTRL: 0x0008 (VGA_EN is set)
> (II) Bus 0 I/O range:
> 	[0] -1	1	0x00000000 - 0x00ffffff (0x1000000) IX[B]
> (II) Bus 0 non-prefetchable memory range:
> 	[0] -1	1	0x00000000 - 0xffffffff (0x0) MX[B]
> (II) Bus 0 prefetchable memory range:
> 	[0] -1	1	0x00000000 - 0xffffffff (0x0) MX[B]
> (II) PCI-to-PCI bridge:
> (II) Bus 1: bridge is at (0:5:0), (0,1,1), BCTRL: 0x0000 (VGA_EN is cleared)
> (II) Bus 1 non-prefetchable memory range:
> 	[0] -1	1	0x03000000 - 0x057fffff (0x2800000) MX[B]
> (II) PCI-to-ISA bridge:
> (II) Bus -1: bridge is at (0:7:0), (0,-1,-1), BCTRL: 0x0008 (VGA_EN is set)
> (!!) More than one possible primary device found
> (--) PCI: (0:3:0) ALi Corporation M7101 PMU rev 0
> (--) PCI: (0:19:0) ATI Technologies Inc Rage XL rev 101, Mem @ 0x06000000/24, 0x00426000/12, I/O @ 0x0b00/8, BIOS @ 0x00440000/17
> (--) PCI: (1:0:0) 3DLabs Permedia II 2D+3D rev 1, Mem @ 0x03000000/17, 0x03800000/23, 0x04000000/23, BIOS @ 0x03020000/16
> (--) PCI: (1:1:0) 3DLabs Permedia II 2D+3D rev 1, Mem @ 0x03040000/17, 0x04800000/23, 0x05000000/23, BIOS @ 0x03030000/16
> (II) Addressable bus resource ranges are
> 	[0] -1	1	0x00000000 - 0xffffffff (0x0) MX[B]
> 	[1] -1	1	0x00000000 - 0x00ffffff (0x1000000) IX[B]
> (II) OS-reported resource ranges:
> 	[0] -1	1	0xffffffff - 0xffffffff (0x1) MX[B]
> 	[1] -1	1	0x000f0000 - 0x000fffff (0x10000) MX[B]
> 	[2] -1	1	0x000c0000 - 0x000effff (0x30000) MX[B]
> 	[3] -1	1	0x00000000 - 0x0009ffff (0xa0000) MX[B]
> 	[4] -1	1	0x00ffffff - 0x00ffffff (0x1) IX[B]
> 	[5] -1	1	0x00000000 - 0x00000000 (0x1) IX[B]
> (II) Active PCI resource ranges:
> 	[0] -1	1	0x02000000 - 0x02007fff (0x8000) MX[B]
> 	[1] -1	1	0x00422000 - 0x004227ff (0x800) MX[B]
> 	[2] -1	1	0x00420000 - 0x004207ff (0x800) MX[B]
> 	[3] -1	1	0x00400000 - 0x0041ffff (0x20000) MX[B]
> 	[4] -1	1	0x01800000 - 0x01ffffff (0x800000) MX[B]
> 	[5] -1	1	0x07000000 - 0x07ffffff (0x1000000) MX[B]
> 	[6] -1	1	0x00424000 - 0x00424fff (0x1000) MX[B]
> 	[7] -1	1	0x03030000 - 0x0303ffff (0x10000) MX[B](B)
> 	[8] -1	1	0x05000000 - 0x057fffff (0x800000) MX[B](B)
> 	[9] -1	1	0x04800000 - 0x04ffffff (0x800000) MX[B](B)
> 	[10] -1	1	0x03040000 - 0x0305ffff (0x20000) MX[B](B)
> 	[11] -1	1	0x03020000 - 0x0302ffff (0x10000) MX[B](B)
> 	[12] -1	1	0x04000000 - 0x047fffff (0x800000) MX[B](B)
> 	[13] -1	1	0x03800000 - 0x03ffffff (0x800000) MX[B](B)
> 	[14] -1	1	0x03000000 - 0x0301ffff (0x20000) MX[B](B)
> 	[15] -1	1	0x00440000 - 0x0045ffff (0x20000) MX[B](B)
> 	[16] -1	1	0x00426000 - 0x00426fff (0x1000) MX[B](B)
> 	[17] -1	1	0x06000000 - 0x06ffffff (0x1000000) MX[B](B)
> 	[18] -1	1	0x00000a20 - 0x00000a2f (0x10) IX[B]
> 	[19] -1	1	0x00000a08 - 0x00000a0b (0x4) IX[B]
> 	[20] -1	1	0x00000a10 - 0x00000a17 (0x8) IX[B]
> 	[21] -1	1	0x00000a18 - 0x00000a1b (0x4) IX[B]
> 	[22] -1	1	0x00000a00 - 0x00000a07 (0x8) IX[B]
> 	[23] -1	1	0x00000900 - 0x000009ff (0x100) IX[B]
> 	[24] -1	1	0x00000b00 - 0x00000bff (0x100) IX[B](B)
> (II) Active PCI resource ranges after removing overlaps:
> 	[0] -1	1	0x02000000 - 0x02007fff (0x8000) MX[B]
> 	[1] -1	1	0x00422000 - 0x004227ff (0x800) MX[B]
> 	[2] -1	1	0x00420000 - 0x004207ff (0x800) MX[B]
> 	[3] -1	1	0x00400000 - 0x0041ffff (0x20000) MX[B]
> 	[4] -1	1	0x01800000 - 0x01ffffff (0x800000) MX[B]
> 	[5] -1	1	0x07000000 - 0x07ffffff (0x1000000) MX[B]
> 	[6] -1	1	0x00424000 - 0x00424fff (0x1000) MX[B]
> 	[7] -1	1	0x03030000 - 0x0303ffff (0x10000) MX[B](B)
> 	[8] -1	1	0x05000000 - 0x057fffff (0x800000) MX[B](B)
> 	[9] -1	1	0x04800000 - 0x04ffffff (0x800000) MX[B](B)
> 	[10] -1	1	0x03040000 - 0x0305ffff (0x20000) MX[B](B)
> 	[11] -1	1	0x03020000 - 0x0302ffff (0x10000) MX[B](B)
> 	[12] -1	1	0x04000000 - 0x047fffff (0x800000) MX[B](B)
> 	[13] -1	1	0x03800000 - 0x03ffffff (0x800000) MX[B](B)
> 	[14] -1	1	0x03000000 - 0x0301ffff (0x20000) MX[B](B)
> 	[15] -1	1	0x00440000 - 0x0045ffff (0x20000) MX[B](B)
> 	[16] -1	1	0x00426000 - 0x00426fff (0x1000) MX[B](B)
> 	[17] -1	1	0x06000000 - 0x06ffffff (0x1000000) MX[B](B)
> 	[18] -1	1	0x00000a20 - 0x00000a2f (0x10) IX[B]
> 	[19] -1	1	0x00000a08 - 0x00000a0b (0x4) IX[B]
> 	[20] -1	1	0x00000a10 - 0x00000a17 (0x8) IX[B]
> 	[21] -1	1	0x00000a18 - 0x00000a1b (0x4) IX[B]
> 	[22] -1	1	0x00000a00 - 0x00000a07 (0x8) IX[B]
> 	[23] -1	1	0x00000900 - 0x000009ff (0x100) IX[B]
> 	[24] -1	1	0x00000b00 - 0x00000bff (0x100) IX[B](B)
> (II) OS-reported resource ranges after removing overlaps with PCI:
> 	[0] -1	1	0xffffffff - 0xffffffff (0x1) MX[B]
> 	[1] -1	1	0x000f0000 - 0x000fffff (0x10000) MX[B]
> 	[2] -1	1	0x000c0000 - 0x000effff (0x30000) MX[B]
> 	[3] -1	1	0x00000000 - 0x0009ffff (0xa0000) MX[B]
> 	[4] -1	1	0x00ffffff - 0x00ffffff (0x1) IX[B]
> 	[5] -1	1	0x00000000 - 0x00000000 (0x1) IX[B]
> (II) All system resource ranges:
> 	[0] -1	1	0xffffffff - 0xffffffff (0x1) MX[B]
> 	[1] -1	1	0x000f0000 - 0x000fffff (0x10000) MX[B]
> 	[2] -1	1	0x000c0000 - 0x000effff (0x30000) MX[B]
> 	[3] -1	1	0x00000000 - 0x0009ffff (0xa0000) MX[B]
> 	[4] -1	1	0x02000000 - 0x02007fff (0x8000) MX[B]
> 	[5] -1	1	0x00422000 - 0x004227ff (0x800) MX[B]
> 	[6] -1	1	0x00420000 - 0x004207ff (0x800) MX[B]
> 	[7] -1	1	0x00400000 - 0x0041ffff (0x20000) MX[B]
> 	[8] -1	1	0x01800000 - 0x01ffffff (0x800000) MX[B]
> 	[9] -1	1	0x07000000 - 0x07ffffff (0x1000000) MX[B]
> 	[10] -1	1	0x00424000 - 0x00424fff (0x1000) MX[B]
> 	[11] -1	1	0x03030000 - 0x0303ffff (0x10000) MX[B](B)
> 	[12] -1	1	0x05000000 - 0x057fffff (0x800000) MX[B](B)
> 	[13] -1	1	0x04800000 - 0x04ffffff (0x800000) MX[B](B)
> 	[14] -1	1	0x03040000 - 0x0305ffff (0x20000) MX[B](B)
> 	[15] -1	1	0x03020000 - 0x0302ffff (0x10000) MX[B](B)
> 	[16] -1	1	0x04000000 - 0x047fffff (0x800000) MX[B](B)
> 	[17] -1	1	0x03800000 - 0x03ffffff (0x800000) MX[B](B)
> 	[18] -1	1	0x03000000 - 0x0301ffff (0x20000) MX[B](B)
> 	[19] -1	1	0x00440000 - 0x0045ffff (0x20000) MX[B](B)
> 	[20] -1	1	0x00426000 - 0x00426fff (0x1000) MX[B](B)
> 	[21] -1	1	0x06000000 - 0x06ffffff (0x1000000) MX[B](B)
> 	[22] -1	1	0x00ffffff - 0x00ffffff (0x1) IX[B]
> 	[23] -1	1	0x00000000 - 0x00000000 (0x1) IX[B]
> 	[24] -1	1	0x00000a20 - 0x00000a2f (0x10) IX[B]
> 	[25] -1	1	0x00000a08 - 0x00000a0b (0x4) IX[B]
> 	[26] -1	1	0x00000a10 - 0x00000a17 (0x8) IX[B]
> 	[27] -1	1	0x00000a18 - 0x00000a1b (0x4) IX[B]
> 	[28] -1	1	0x00000a00 - 0x00000a07 (0x8) IX[B]
> 	[29] -1	1	0x00000900 - 0x000009ff (0x100) IX[B]
> 	[30] -1	1	0x00000b00 - 0x00000bff (0x100) IX[B](B)
> (II) LoadModule: "GLcore"
> (II) Loading /usr/X11R6/lib/modules/extensions/libGLcore.a
> Skipping "/usr/X11R6/lib/modules/extensions/libGLcore.a:m_debug_clip.o":  No symbols found
> Skipping "/usr/X11R6/lib/modules/extensions/libGLcore.a:m_debug_norm.o":  No symbols found
> Skipping "/usr/X11R6/lib/modules/extensions/libGLcore.a:m_debug_xform.o":  No symbols found
> Skipping "/usr/X11R6/lib/modules/extensions/libGLcore.a:m_debug_vertex.o":  No symbols found
> (II) Module GLcore: vendor="The XFree86 Project"
> 	compiled for 4.3.0.1, module version = 1.0.0
> 	ABI class: XFree86 Server Extension, version 0.2
> (II) LoadModule: "bitmap"
> (II) Reloading /usr/X11R6/lib/modules/fonts/libbitmap.a
> (II) Loading font Bitmap
> (II) LoadModule: "dbe"
> (II) Loading /usr/X11R6/lib/modules/extensions/libdbe.a
> (II) Module dbe: vendor="The XFree86 Project"
> 	compiled for 4.3.0.1, module version = 1.0.0
> 	Module class: XFree86 Server Extension
> 	ABI class: XFree86 Server Extension, version 0.2
> (II) Loading extension DOUBLE-BUFFER
> (II) LoadModule: "ddc"
> (II) Loading /usr/X11R6/lib/modules/libddc.a
> (II) Module ddc: vendor="The XFree86 Project"
> 	compiled for 4.3.0.1, module version = 1.0.0
> 	ABI class: XFree86 Video Driver, version 0.6
> (II) LoadModule: "dri"
> (II) Loading /usr/X11R6/lib/modules/extensions/libdri.a
> (II) Module dri: vendor="The XFree86 Project"
> 	compiled for 4.3.0.1, module version = 1.0.0
> 	ABI class: XFree86 Server Extension, version 0.2
> (II) Loading sub module "drm"
> (II) LoadModule: "drm"
> (II) Loading /usr/X11R6/lib/modules/linux/libdrm.a
> (II) Module drm: vendor="The XFree86 Project"
> 	compiled for 4.3.0.1, module version = 1.0.0
> 	ABI class: XFree86 Server Extension, version 0.2
> (II) Loading extension XFree86-DRI
> (II) LoadModule: "extmod"
> (II) Loading /usr/X11R6/lib/modules/extensions/libextmod.a
> (II) Module extmod: vendor="The XFree86 Project"
> 	compiled for 4.3.0.1, module version = 1.0.0
> 	Module class: XFree86 Server Extension
> 	ABI class: XFree86 Server Extension, version 0.2
> (II) Loading extension SHAPE
> (II) Loading extension MIT-SUNDRY-NONSTANDARD
> (II) Loading extension BIG-REQUESTS
> (II) Loading extension SYNC
> (II) Loading extension MIT-SCREEN-SAVER
> (II) Loading extension XC-MISC
> (II) Loading extension XFree86-VidModeExtension
> (II) Loading extension XFree86-Misc
> (II) Loading extension XFree86-DGA
> (II) Loading extension DPMS
> (II) Loading extension FontCache
> (II) Loading extension TOG-CUP
> (II) Loading extension Extended-Visual-Information
> (II) Loading extension XVideo
> (II) Loading extension XVideo-MotionCompensation
> (II) Loading extension X-Resource
> (II) LoadModule: "freetype"
> (II) Loading /usr/X11R6/lib/modules/fonts/libfreetype.a
> (II) Module freetype: vendor="The XFree86 Project"
> 	compiled for 4.3.0.1, module version = 2.0.2
> 	Module class: XFree86 Font Renderer
> 	ABI class: XFree86 Font Renderer, version 0.4
> (II) Loading font FreeType
> (II) LoadModule: "glx"
> (II) Loading /usr/X11R6/lib/modules/extensions/libglx.a
> (II) Module glx: vendor="The XFree86 Project"
> 	compiled for 4.3.0.1, module version = 1.0.0
> 	ABI class: XFree86 Server Extension, version 0.2
> (II) Loading sub module "GLcore"
> (II) LoadModule: "GLcore"
> (II) Reloading /usr/X11R6/lib/modules/extensions/libGLcore.a
> (II) Loading extension GLX
> (II) LoadModule: "int10"
> (II) Loading /usr/X11R6/lib/modules/libint10.a
> (II) Module int10: vendor="The XFree86 Project"
> 	compiled for 4.3.0.1, module version = 1.0.0
> 	ABI class: XFree86 Video Driver, version 0.6
> (II) LoadModule: "record"
> (II) Loading /usr/X11R6/lib/modules/extensions/librecord.a
> (II) Module record: vendor="The XFree86 Project"
> 	compiled for 4.3.0.1, module version = 1.13.0
> 	Module class: XFree86 Server Extension
> 	ABI class: XFree86 Server Extension, version 0.2
> (II) Loading extension RECORD
> (II) LoadModule: "speedo"
> (II) Loading /usr/X11R6/lib/modules/fonts/libspeedo.a
> Skipping "/usr/X11R6/lib/modules/fonts/libspeedo.a:spencode.o":  No symbols found
> (II) Module speedo: vendor="The XFree86 Project"
> 	compiled for 4.3.0.1, module version = 1.0.1
> 	Module class: XFree86 Font Renderer
> 	ABI class: XFree86 Font Renderer, version 0.4
> (II) Loading font Speedo
> (II) LoadModule: "type1"
> (II) Loading /usr/X11R6/lib/modules/fonts/libtype1.a
> (II) Module type1: vendor="The XFree86 Project"
> 	compiled for 4.3.0.1, module version = 1.0.2
> 	Module class: XFree86 Font Renderer
> 	ABI class: XFree86 Font Renderer, version 0.4
> (II) Loading font Type1
> (II) Loading font CID
> (II) LoadModule: "vbe"
> (II) Loading /usr/X11R6/lib/modules/libvbe.a
> (II) Module vbe: vendor="The XFree86 Project"
> 	compiled for 4.3.0.1, module version = 1.1.0
> 	ABI class: XFree86 Video Driver, version 0.6
> (II) LoadModule: "glint"
> (II) Loading /usr/X11R6/lib/modules/drivers/glint_drv.o
> (II) Module glint: vendor="The XFree86 Project"
> 	compiled for 4.3.0.1, module version = 1.0.0
> 	Module class: XFree86 Video Driver
> 	ABI class: XFree86 Video Driver, version 0.6
> (II) LoadModule: "mouse"
> (II) Loading /usr/X11R6/lib/modules/input/mouse_drv.o
> (II) Module mouse: vendor="The XFree86 Project"
> 	compiled for 4.3.0.1, module version = 1.0.0
> 	Module class: XFree86 XInput Driver
> 	ABI class: XFree86 XInput driver, version 0.4
> (II) GLINT: driver for 3Dlabs chipsets: gamma, gamma2, ti_pm2, ti_pm, r4,
> 	pm4, pm3, pm2v, pm2, pm, 300sx, 500tx, mx, delta
> (II) Primary Device is: 
> (--) Chipset pm2v found
> (--) Chipset pm2v found
> (II) resource ranges after xf86ClaimFixedResources() call:
> 	[0] -1	1	0xffffffff - 0xffffffff (0x1) MX[B]
> 	[1] -1	1	0x000f0000 - 0x000fffff (0x10000) MX[B]
> 	[2] -1	1	0x000c0000 - 0x000effff (0x30000) MX[B]
> 	[3] -1	1	0x00000000 - 0x0009ffff (0xa0000) MX[B]
> 	[4] -1	1	0x02000000 - 0x02007fff (0x8000) MX[B]
> 	[5] -1	1	0x00422000 - 0x004227ff (0x800) MX[B]
> 	[6] -1	1	0x00420000 - 0x004207ff (0x800) MX[B]
> 	[7] -1	1	0x00400000 - 0x0041ffff (0x20000) MX[B]
> 	[8] -1	1	0x01800000 - 0x01ffffff (0x800000) MX[B]
> 	[9] -1	1	0x07000000 - 0x07ffffff (0x1000000) MX[B]
> 	[10] -1	1	0x00424000 - 0x00424fff (0x1000) MX[B]
> 	[11] -1	1	0x03030000 - 0x0303ffff (0x10000) MX[B](B)
> 	[12] -1	1	0x05000000 - 0x057fffff (0x800000) MX[B](B)
> 	[13] -1	1	0x04800000 - 0x04ffffff (0x800000) MX[B](B)
> 	[14] -1	1	0x03040000 - 0x0305ffff (0x20000) MX[B](B)
> 	[15] -1	1	0x03020000 - 0x0302ffff (0x10000) MX[B](B)
> 	[16] -1	1	0x04000000 - 0x047fffff (0x800000) MX[B](B)
> 	[17] -1	1	0x03800000 - 0x03ffffff (0x800000) MX[B](B)
> 	[18] -1	1	0x03000000 - 0x0301ffff (0x20000) MX[B](B)
> 	[19] -1	1	0x00440000 - 0x0045ffff (0x20000) MX[B](B)
> 	[20] -1	1	0x00426000 - 0x00426fff (0x1000) MX[B](B)
> 	[21] -1	1	0x06000000 - 0x06ffffff (0x1000000) MX[B](B)
> 	[22] -1	1	0x00ffffff - 0x00ffffff (0x1) IX[B]
> 	[23] -1	1	0x00000000 - 0x00000000 (0x1) IX[B]
> 	[24] -1	1	0x00000a20 - 0x00000a2f (0x10) IX[B]
> 	[25] -1	1	0x00000a08 - 0x00000a0b (0x4) IX[B]
> 	[26] -1	1	0x00000a10 - 0x00000a17 (0x8) IX[B]
> 	[27] -1	1	0x00000a18 - 0x00000a1b (0x4) IX[B]
> 	[28] -1	1	0x00000a00 - 0x00000a07 (0x8) IX[B]
> 	[29] -1	1	0x00000900 - 0x000009ff (0x100) IX[B]
> 	[30] -1	1	0x00000b00 - 0x00000bff (0x100) IX[B](B)
> (II) resource ranges after xf86ClaimFixedResources() call:
> 	[0] -1	1	0xffffffff - 0xffffffff (0x1) MX[B]
> 	[1] -1	1	0x000f0000 - 0x000fffff (0x10000) MX[B]
> 	[2] -1	1	0x000c0000 - 0x000effff (0x30000) MX[B]
> 	[3] -1	1	0x00000000 - 0x0009ffff (0xa0000) MX[B]
> 	[4] -1	1	0x02000000 - 0x02007fff (0x8000) MX[B]
> 	[5] -1	1	0x00422000 - 0x004227ff (0x800) MX[B]
> 	[6] -1	1	0x00420000 - 0x004207ff (0x800) MX[B]
> 	[7] -1	1	0x00400000 - 0x0041ffff (0x20000) MX[B]
> 	[8] -1	1	0x01800000 - 0x01ffffff (0x800000) MX[B]
> 	[9] -1	1	0x07000000 - 0x07ffffff (0x1000000) MX[B]
> 	[10] -1	1	0x00424000 - 0x00424fff (0x1000) MX[B]
> 	[11] -1	1	0x03030000 - 0x0303ffff (0x10000) MX[B](B)
> 	[12] -1	1	0x05000000 - 0x057fffff (0x800000) MX[B](B)
> 	[13] -1	1	0x04800000 - 0x04ffffff (0x800000) MX[B](B)
> 	[14] -1	1	0x03040000 - 0x0305ffff (0x20000) MX[B](B)
> 	[15] -1	1	0x03020000 - 0x0302ffff (0x10000) MX[B](B)
> 	[16] -1	1	0x04000000 - 0x047fffff (0x800000) MX[B](B)
> 	[17] -1	1	0x03800000 - 0x03ffffff (0x800000) MX[B](B)
> 	[18] -1	1	0x03000000 - 0x0301ffff (0x20000) MX[B](B)
> 	[19] -1	1	0x00440000 - 0x0045ffff (0x20000) MX[B](B)
> 	[20] -1	1	0x00426000 - 0x00426fff (0x1000) MX[B](B)
> 	[21] -1	1	0x06000000 - 0x06ffffff (0x1000000) MX[B](B)
> 	[22] -1	1	0x00ffffff - 0x00ffffff (0x1) IX[B]
> 	[23] -1	1	0x00000000 - 0x00000000 (0x1) IX[B]
> 	[24] -1	1	0x00000a20 - 0x00000a2f (0x10) IX[B]
> 	[25] -1	1	0x00000a08 - 0x00000a0b (0x4) IX[B]
> 	[26] -1	1	0x00000a10 - 0x00000a17 (0x8) IX[B]
> 	[27] -1	1	0x00000a18 - 0x00000a1b (0x4) IX[B]
> 	[28] -1	1	0x00000a00 - 0x00000a07 (0x8) IX[B]
> 	[29] -1	1	0x00000900 - 0x000009ff (0x100) IX[B]
> 	[30] -1	1	0x00000b00 - 0x00000bff (0x100) IX[B](B)
> (II) resource ranges after probing:
> 	[0] -1	1	0xffffffff - 0xffffffff (0x1) MX[B]
> 	[1] -1	1	0x000f0000 - 0x000fffff (0x10000) MX[B]
> 	[2] -1	1	0x000c0000 - 0x000effff (0x30000) MX[B]
> 	[3] -1	1	0x00000000 - 0x0009ffff (0xa0000) MX[B]
> 	[4] -1	1	0x02000000 - 0x02007fff (0x8000) MX[B]
> 	[5] -1	1	0x00422000 - 0x004227ff (0x800) MX[B]
> 	[6] -1	1	0x00420000 - 0x004207ff (0x800) MX[B]
> 	[7] -1	1	0x00400000 - 0x0041ffff (0x20000) MX[B]
> 	[8] -1	1	0x01800000 - 0x01ffffff (0x800000) MX[B]
> 	[9] -1	1	0x07000000 - 0x07ffffff (0x1000000) MX[B]
> 	[10] -1	1	0x00424000 - 0x00424fff (0x1000) MX[B]
> 	[11] -1	1	0x03030000 - 0x0303ffff (0x10000) MX[B](B)
> 	[12] -1	1	0x05000000 - 0x057fffff (0x800000) MX[B](B)
> 	[13] -1	1	0x04800000 - 0x04ffffff (0x800000) MX[B](B)
> 	[14] -1	1	0x03040000 - 0x0305ffff (0x20000) MX[B](B)
> 	[15] -1	1	0x03020000 - 0x0302ffff (0x10000) MX[B](B)
> 	[16] -1	1	0x04000000 - 0x047fffff (0x800000) MX[B](B)
> 	[17] -1	1	0x03800000 - 0x03ffffff (0x800000) MX[B](B)
> 	[18] -1	1	0x03000000 - 0x0301ffff (0x20000) MX[B](B)
> 	[19] -1	1	0x00440000 - 0x0045ffff (0x20000) MX[B](B)
> 	[20] -1	1	0x00426000 - 0x00426fff (0x1000) MX[B](B)
> 	[21] -1	1	0x06000000 - 0x06ffffff (0x1000000) MX[B](B)
> 	[22] 0	1	0x000a0000 - 0x000affff (0x10000) MS[B]
> 	[23] 0	1	0x000b0000 - 0x000b7fff (0x8000) MS[B]
> 	[24] 0	1	0x000b8000 - 0x000bffff (0x8000) MS[B]
> 	[25] 1	1	0x000a0000 - 0x000affff (0x10000) MS[B]
> 	[26] 1	1	0x000b0000 - 0x000b7fff (0x8000) MS[B]
> 	[27] 1	1	0x000b8000 - 0x000bffff (0x8000) MS[B]
> 	[28] -1	1	0x00ffffff - 0x00ffffff (0x1) IX[B]
> 	[29] -1	1	0x00000000 - 0x00000000 (0x1) IX[B]
> 	[30] -1	1	0x00000a20 - 0x00000a2f (0x10) IX[B]
> 	[31] -1	1	0x00000a08 - 0x00000a0b (0x4) IX[B]
> 	[32] -1	1	0x00000a10 - 0x00000a17 (0x8) IX[B]
> 	[33] -1	1	0x00000a18 - 0x00000a1b (0x4) IX[B]
> 	[34] -1	1	0x00000a00 - 0x00000a07 (0x8) IX[B]
> 	[35] -1	1	0x00000900 - 0x000009ff (0x100) IX[B]
> 	[36] -1	1	0x00000b00 - 0x00000bff (0x100) IX[B](B)
> 	[37] 0	1	0x000003b0 - 0x000003bb (0xc) IS[B]
> 	[38] 0	1	0x000003c0 - 0x000003df (0x20) IS[B]
> 	[39] 1	1	0x000003b0 - 0x000003bb (0xc) IS[B]
> 	[40] 1	1	0x000003c0 - 0x000003df (0x20) IS[B]
> (II) Setting vga for screen 0.
> (II) Setting vga for screen 1.
> (**) GLINT(0): Depth 24, (--) framebuffer bpp 32
> (==) GLINT(0): RGB weight 888
> (==) GLINT(0): Default visual is TrueColor
> (==) GLINT(0): Using gamma correction (1.0, 1.0, 1.0)
> (==) GLINT(0): Using HW cursor
> (--) GLINT(0): Not using Linux framebuffer device
> (--) GLINT(0): Chipset: "pm2v"
> (--) GLINT(0): Linear framebuffer at 0x4000000
> (--) GLINT(0): MMIO registers at 0x3010000
> (II) Loading sub module "int10"
> (II) LoadModule: "int10"
> (II) Reloading /usr/X11R6/lib/modules/libint10.a
> (II) GLINT(0): Initializing int10
> (II) Multi Device Card detected: [1:0:0][1:1:0]
> (EE) GLINT(0): Cannot read V_BIOS (5)
> (--) GLINT(0): VideoRAM: 8192 kByte
> (II) Loading sub module "ramdac"
> (II) LoadModule: "ramdac"
> (II) Loading /usr/X11R6/lib/modules/libramdac.a
> (II) Module ramdac: vendor="The XFree86 Project"
> 	compiled for 4.3.0.1, module version = 0.1.0
> 	ABI class: XFree86 Video Driver, version 0.6
> (--) GLINT(0): FIFO Size is 256 DWORDS
> (==) GLINT(0): Min pixel clock is 16 MHz
> (--) GLINT(0): Max pixel clock is 110 MHz
> (II) GLINT(0): Sun: Using hsync range of 30.00-82.00 kHz
> (II) GLINT(0): Sun: Using vrefresh range of 50.00-120.00 Hz
> (II) GLINT(0): Clock range:  16.25 to 110.00 MHz
> (II) GLINT(0): Not using default mode "320x175" (bad mode clock/interlace/doublescan)
> (II) GLINT(0): Not using default mode "320x200" (bad mode clock/interlace/doublescan)
> (II) GLINT(0): Not using default mode "360x200" (bad mode clock/interlace/doublescan)
> (II) GLINT(0): Not using default mode "320x240" (bad mode clock/interlace/doublescan)
> (II) GLINT(0): Not using default mode "320x240" (bad mode clock/interlace/doublescan)
> (II) GLINT(0): Not using default mode "320x240" (bad mode clock/interlace/doublescan)
> (II) GLINT(0): Not using default mode "320x240" (bad mode clock/interlace/doublescan)
> (II) GLINT(0): Not using default mode "400x300" (bad mode clock/interlace/doublescan)
> (II) GLINT(0): Not using default mode "400x300" (bad mode clock/interlace/doublescan)
> (II) GLINT(0): Not using default mode "400x300" (bad mode clock/interlace/doublescan)
> (II) GLINT(0): Not using default mode "400x300" (bad mode clock/interlace/doublescan)
> (II) GLINT(0): Not using default mode "400x300" (bad mode clock/interlace/doublescan)
> (II) GLINT(0): Not using default mode "1024x768" (bad mode clock/interlace/doublescan)
> (II) GLINT(0): Not using default mode "512x384" (bad mode clock/interlace/doublescan)
> (II) GLINT(0): Not using default mode "512x384" (bad mode clock/interlace/doublescan)
> (II) GLINT(0): Not using default mode "512x384" (bad mode clock/interlace/doublescan)
> (II) GLINT(0): Not using default mode "512x384" (bad mode clock/interlace/doublescan)
> (II) GLINT(0): Not using default mode "512x384" (bad mode clock/interlace/doublescan)
> (II) GLINT(0): Not using default mode "576x432" (bad mode clock/interlace/doublescan)
> (II) GLINT(0): Not using default mode "640x480" (bad mode clock/interlace/doublescan)
> (II) GLINT(0): Not using default mode "1280x960" (bad mode clock/interlace/doublescan)
> (II) GLINT(0): Not using default mode "640x480" (bad mode clock/interlace/doublescan)
> (II) GLINT(0): Not using default mode "640x512" (bad mode clock/interlace/doublescan)
> (II) GLINT(0): Not using default mode "1280x1024" (bad mode clock/interlace/doublescan)
> (II) GLINT(0): Not using default mode "640x512" (bad mode clock/interlace/doublescan)
> (II) GLINT(0): Not using default mode "1280x1024" (bad mode clock/interlace/doublescan)
> (II) GLINT(0): Not using default mode "640x512" (bad mode clock/interlace/doublescan)
> (II) GLINT(0): Not using default mode "1600x1200" (bad mode clock/interlace/doublescan)
> (II) GLINT(0): Not using default mode "800x600" (bad mode clock/interlace/doublescan)
> (II) GLINT(0): Not using default mode "1600x1200" (bad mode clock/interlace/doublescan)
> (II) GLINT(0): Not using default mode "800x600" (bad mode clock/interlace/doublescan)
> (II) GLINT(0): Not using default mode "1600x1200" (bad mode clock/interlace/doublescan)
> (II) GLINT(0): Not using default mode "800x600" (bad mode clock/interlace/doublescan)
> (II) GLINT(0): Not using default mode "1600x1200" (bad mode clock/interlace/doublescan)
> (II) GLINT(0): Not using default mode "800x600" (bad mode clock/interlace/doublescan)
> (II) GLINT(0): Not using default mode "1600x1200" (bad mode clock/interlace/doublescan)
> (II) GLINT(0): Not using default mode "800x600" (bad mode clock/interlace/doublescan)
> (II) GLINT(0): Not using default mode "1792x1344" (insufficient memory for mode)
> (II) GLINT(0): Not using default mode "896x672" (bad mode clock/interlace/doublescan)
> (II) GLINT(0): Not using default mode "1792x1344" (insufficient memory for mode)
> (II) GLINT(0): Not using default mode "896x672" (bad mode clock/interlace/doublescan)
> (II) GLINT(0): Not using default mode "1856x1392" (insufficient memory for mode)
> (II) GLINT(0): Not using default mode "928x696" (bad mode clock/interlace/doublescan)
> (II) GLINT(0): Not using default mode "1856x1392" (insufficient memory for mode)
> (II) GLINT(0): Not using default mode "928x696" (bad mode clock/interlace/doublescan)
> (II) GLINT(0): Not using default mode "1920x1440" (insufficient memory for mode)
> (II) GLINT(0): Not using default mode "960x720" (bad mode clock/interlace/doublescan)
> (II) GLINT(0): Not using default mode "1920x1440" (insufficient memory for mode)
> (II) GLINT(0): Not using default mode "960x720" (bad mode clock/interlace/doublescan)
> (II) GLINT(0): Not using default mode "416x312" (bad mode clock/interlace/doublescan)
> (II) GLINT(0): Not using default mode "576x384" (bad mode clock/interlace/doublescan)
> (II) GLINT(0): Not using default mode "1400x1050" (bad mode clock/interlace/doublescan)
> (II) GLINT(0): Not using default mode "700x525" (bad mode clock/interlace/doublescan)
> (II) GLINT(0): Not using default mode "1400x1050" (bad mode clock/interlace/doublescan)
> (II) GLINT(0): Not using default mode "700x525" (bad mode clock/interlace/doublescan)
> (II) GLINT(0): Not using default mode "800x512" (bad mode clock/interlace/doublescan)
> (II) GLINT(0): Not using default mode "1920x1440" (insufficient memory for mode)
> (II) GLINT(0): Not using default mode "960x720" (bad mode clock/interlace/doublescan)
> (II) GLINT(0): Not using default mode "2048x1536" (insufficient memory for mode)
> (II) GLINT(0): Not using default mode "1024x768" (bad mode clock/interlace/doublescan)
> (II) GLINT(0): Not using default mode "2048x1536" (insufficient memory for mode)
> (II) GLINT(0): Not using default mode "1024x768" (bad mode clock/interlace/doublescan)
> (II) GLINT(0): Not using default mode "2048x1536" (insufficient memory for mode)
> (II) GLINT(0): Not using default mode "1024x768" (bad mode clock/interlace/doublescan)
> (--) GLINT(0): Virtual size is 1280x1024 (pitch 1280)
> (**) GLINT(0): *Default mode "1280x1024": 108.0 MHz, 64.0 kHz, 60.0 Hz
> (II) GLINT(0): Modeline "1280x1024"  108.00  1280 1328 1440 1688  1024 1025 1028 1066 +hsync +vsync
> (**) GLINT(0):  Default mode "1280x960": 108.0 MHz, 60.0 kHz, 60.0 Hz
> (II) GLINT(0): Modeline "1280x960"  108.00  1280 1376 1488 1800  960 961 964 1000 +hsync +vsync
> (**) GLINT(0):  Default mode "1152x864": 108.0 MHz, 67.5 kHz, 75.0 Hz
> (II) GLINT(0): Modeline "1152x864"  108.00  1152 1216 1344 1600  864 865 868 900 +hsync +vsync
> (**) GLINT(0):  Default mode "1152x768": 65.0 MHz, 44.2 kHz, 54.8 Hz
> (II) GLINT(0): Modeline "1152x768"   65.00  1152 1178 1314 1472  768 771 777 806 +hsync +vsync
> (**) GLINT(0):  Default mode "1024x768": 94.5 MHz, 68.7 kHz, 85.0 Hz
> (II) GLINT(0): Modeline "1024x768"   94.50  1024 1072 1168 1376  768 769 772 808 +hsync +vsync
> (**) GLINT(0):  Default mode "1024x768": 78.8 MHz, 60.1 kHz, 75.1 Hz
> (II) GLINT(0): Modeline "1024x768"   78.80  1024 1040 1136 1312  768 769 772 800 +hsync +vsync
> (**) GLINT(0):  Default mode "1024x768": 75.0 MHz, 56.5 kHz, 70.1 Hz
> (II) GLINT(0): Modeline "1024x768"   75.00  1024 1048 1184 1328  768 771 777 806 -hsync -vsync
> (**) GLINT(0):  Default mode "1024x768": 65.0 MHz, 48.4 kHz, 60.0 Hz
> (II) GLINT(0): Modeline "1024x768"   65.00  1024 1048 1184 1344  768 771 777 806 -hsync -vsync
> (**) GLINT(0):  Default mode "832x624": 57.3 MHz, 49.7 kHz, 74.6 Hz
> (II) GLINT(0): Modeline "832x624"   57.28  832 864 928 1152  624 625 628 667 -hsync -vsync
> (**) GLINT(0):  Default mode "800x600": 56.3 MHz, 53.7 kHz, 85.1 Hz
> (II) GLINT(0): Modeline "800x600"   56.30  800 832 896 1048  600 601 604 631 +hsync +vsync
> (**) GLINT(0):  Default mode "800x600": 49.5 MHz, 46.9 kHz, 75.0 Hz
> (II) GLINT(0): Modeline "800x600"   49.50  800 816 896 1056  600 601 604 625 +hsync +vsync
> (**) GLINT(0):  Default mode "800x600": 50.0 MHz, 48.1 kHz, 72.2 Hz
> (II) GLINT(0): Modeline "800x600"   50.00  800 856 976 1040  600 637 643 666 +hsync +vsync
> (**) GLINT(0):  Default mode "800x600": 40.0 MHz, 37.9 kHz, 60.3 Hz
> (II) GLINT(0): Modeline "800x600"   40.00  800 840 968 1056  600 601 605 628 +hsync +vsync
> (**) GLINT(0):  Default mode "800x600": 36.0 MHz, 35.2 kHz, 56.2 Hz
> (II) GLINT(0): Modeline "800x600"   36.00  800 824 896 1024  600 601 603 625 +hsync +vsync
> (**) GLINT(0):  Default mode "640x480": 36.0 MHz, 43.3 kHz, 85.0 Hz
> (II) GLINT(0): Modeline "640x480"   36.00  640 696 752 832  480 481 484 509 -hsync -vsync
> (**) GLINT(0):  Default mode "640x480": 31.5 MHz, 37.5 kHz, 75.0 Hz
> (II) GLINT(0): Modeline "640x480"   31.50  640 656 720 840  480 481 484 500 -hsync -vsync
> (**) GLINT(0):  Default mode "640x480": 31.5 MHz, 37.9 kHz, 72.8 Hz
> (II) GLINT(0): Modeline "640x480"   31.50  640 664 704 832  480 489 491 520 -hsync -vsync
> (**) GLINT(0):  Default mode "640x480": 25.2 MHz, 31.5 kHz, 60.0 Hz
> (II) GLINT(0): Modeline "640x480"   25.20  640 656 752 800  480 490 492 525 -hsync -vsync
> (**) GLINT(0):  Default mode "720x400": 35.5 MHz, 37.9 kHz, 85.0 Hz
> (II) GLINT(0): Modeline "720x400"   35.50  720 756 828 936  400 401 404 446 -hsync +vsync
> (**) GLINT(0):  Default mode "640x400": 31.5 MHz, 37.9 kHz, 85.1 Hz
> (II) GLINT(0): Modeline "640x400"   31.50  640 672 736 832  400 401 404 445 -hsync +vsync
> (**) GLINT(0):  Default mode "640x350": 31.5 MHz, 37.9 kHz, 85.1 Hz
> (II) GLINT(0): Modeline "640x350"   31.50  640 672 736 832  350 382 385 445 +hsync -vsync
> (++) GLINT(0): DPI set to (100, 100)
> (II) Loading sub module "fb"
> (II) LoadModule: "fb"
> (II) Loading /usr/X11R6/lib/modules/libfb.a
> (II) Module fb: vendor="The XFree86 Project"
> 	compiled for 4.3.0.1, module version = 1.0.0
> 	ABI class: XFree86 ANSI C Emulation, version 0.2
> (II) Loading sub module "xaa"
> (II) LoadModule: "xaa"
> (II) Loading /usr/X11R6/lib/modules/libxaa.a
> (II) Module xaa: vendor="The XFree86 Project"
> 	compiled for 4.3.0.1, module version = 1.1.0
> 	ABI class: XFree86 Video Driver, version 0.6
> (II) Loading sub module "ddc"
> (II) LoadModule: "ddc"
> (II) Reloading /usr/X11R6/lib/modules/libddc.a
> (II) Loading sub module "i2c"
> (II) LoadModule: "i2c"
> (II) Loading /usr/X11R6/lib/modules/libi2c.a
> (II) Module i2c: vendor="The XFree86 Project"
> 	compiled for 4.3.0.1, module version = 1.2.0
> 	ABI class: XFree86 Video Driver, version 0.6
> (II) GLINT(0): I2C bus "DDC" initialized.
> (II) GLINT(0): I2C bus "Video" initialized.
> (**) GLINT(1): Depth 24, (--) framebuffer bpp 32
> (==) GLINT(1): RGB weight 888
> (==) GLINT(1): Default visual is TrueColor
> (==) GLINT(1): Using gamma correction (1.0, 1.0, 1.0)
> (==) GLINT(1): Using HW cursor
> (--) GLINT(1): Not using Linux framebuffer device
> (--) GLINT(1): Chipset: "pm2v"
> (--) GLINT(1): Linear framebuffer at 0x5000000
> (--) GLINT(1): MMIO registers at 0x3050000
> (II) Loading sub module "int10"
> (II) LoadModule: "int10"
> (II) Reloading /usr/X11R6/lib/modules/libint10.a
> (II) GLINT(1): Initializing int10
> (II) Multi Device Card detected: [1:0:0][1:1:0]
> (EE) GLINT(1): Cannot read V_BIOS (5)
> (--) GLINT(1): VideoRAM: 4096 kByte
> (II) Loading sub module "ramdac"
> (II) LoadModule: "ramdac"
> (II) Reloading /usr/X11R6/lib/modules/libramdac.a
> (--) GLINT(1): FIFO Size is 256 DWORDS
> (==) GLINT(1): Min pixel clock is 16 MHz
> (--) GLINT(1): Max pixel clock is 110 MHz
> (II) GLINT(1): Sun2: Using hsync range of 30.00-82.00 kHz
> (II) GLINT(1): Sun2: Using vrefresh range of 50.00-120.00 Hz
> (II) GLINT(1): Clock range:  16.25 to 110.00 MHz
> (II) GLINT(1): Not using default mode "320x175" (bad mode clock/interlace/doublescan)
> (II) GLINT(1): Not using default mode "320x200" (bad mode clock/interlace/doublescan)
> (II) GLINT(1): Not using default mode "360x200" (bad mode clock/interlace/doublescan)
> (II) GLINT(1): Not using default mode "320x240" (bad mode clock/interlace/doublescan)
> (II) GLINT(1): Not using default mode "320x240" (bad mode clock/interlace/doublescan)
> (II) GLINT(1): Not using default mode "320x240" (bad mode clock/interlace/doublescan)
> (II) GLINT(1): Not using default mode "320x240" (bad mode clock/interlace/doublescan)
> (II) GLINT(1): Not using default mode "400x300" (bad mode clock/interlace/doublescan)
> (II) GLINT(1): Not using default mode "400x300" (bad mode clock/interlace/doublescan)
> (II) GLINT(1): Not using default mode "400x300" (bad mode clock/interlace/doublescan)
> (II) GLINT(1): Not using default mode "400x300" (bad mode clock/interlace/doublescan)
> (II) GLINT(1): Not using default mode "400x300" (bad mode clock/interlace/doublescan)
> (II) GLINT(1): Not using default mode "1024x768" (bad mode clock/interlace/doublescan)
> (II) GLINT(1): Not using default mode "512x384" (bad mode clock/interlace/doublescan)
> (II) GLINT(1): Not using default mode "512x384" (bad mode clock/interlace/doublescan)
> (II) GLINT(1): Not using default mode "512x384" (bad mode clock/interlace/doublescan)
> (II) GLINT(1): Not using default mode "512x384" (bad mode clock/interlace/doublescan)
> (II) GLINT(1): Not using default mode "512x384" (bad mode clock/interlace/doublescan)
> (II) GLINT(1): Not using default mode "576x432" (bad mode clock/interlace/doublescan)
> (II) GLINT(1): Not using default mode "1280x960" (insufficient memory for mode)
> (II) GLINT(1): Not using default mode "640x480" (bad mode clock/interlace/doublescan)
> (II) GLINT(1): Not using default mode "1280x960" (insufficient memory for mode)
> (II) GLINT(1): Not using default mode "640x480" (bad mode clock/interlace/doublescan)
> (II) GLINT(1): Not using default mode "1280x1024" (insufficient memory for mode)
> (II) GLINT(1): Not using default mode "640x512" (bad mode clock/interlace/doublescan)
> (II) GLINT(1): Not using default mode "1280x1024" (insufficient memory for mode)
> (II) GLINT(1): Not using default mode "640x512" (bad mode clock/interlace/doublescan)
> (II) GLINT(1): Not using default mode "1280x1024" (insufficient memory for mode)
> (II) GLINT(1): Not using default mode "640x512" (bad mode clock/interlace/doublescan)
> (II) GLINT(1): Not using default mode "1600x1200" (insufficient memory for mode)
> (II) GLINT(1): Not using default mode "800x600" (bad mode clock/interlace/doublescan)
> (II) GLINT(1): Not using default mode "1600x1200" (insufficient memory for mode)
> (II) GLINT(1): Not using default mode "800x600" (bad mode clock/interlace/doublescan)
> (II) GLINT(1): Not using default mode "1600x1200" (insufficient memory for mode)
> (II) GLINT(1): Not using default mode "800x600" (bad mode clock/interlace/doublescan)
> (II) GLINT(1): Not using default mode "1600x1200" (insufficient memory for mode)
> (II) GLINT(1): Not using default mode "800x600" (bad mode clock/interlace/doublescan)
> (II) GLINT(1): Not using default mode "1600x1200" (insufficient memory for mode)
> (II) GLINT(1): Not using default mode "800x600" (bad mode clock/interlace/doublescan)
> (II) GLINT(1): Not using default mode "1792x1344" (insufficient memory for mode)
> (II) GLINT(1): Not using default mode "896x672" (bad mode clock/interlace/doublescan)
> (II) GLINT(1): Not using default mode "1792x1344" (insufficient memory for mode)
> (II) GLINT(1): Not using default mode "896x672" (bad mode clock/interlace/doublescan)
> (II) GLINT(1): Not using default mode "1856x1392" (insufficient memory for mode)
> (II) GLINT(1): Not using default mode "928x696" (bad mode clock/interlace/doublescan)
> (II) GLINT(1): Not using default mode "1856x1392" (insufficient memory for mode)
> (II) GLINT(1): Not using default mode "928x696" (bad mode clock/interlace/doublescan)
> (II) GLINT(1): Not using default mode "1920x1440" (insufficient memory for mode)
> (II) GLINT(1): Not using default mode "960x720" (bad mode clock/interlace/doublescan)
> (II) GLINT(1): Not using default mode "1920x1440" (insufficient memory for mode)
> (II) GLINT(1): Not using default mode "960x720" (bad mode clock/interlace/doublescan)
> (II) GLINT(1): Not using default mode "416x312" (bad mode clock/interlace/doublescan)
> (II) GLINT(1): Not using default mode "576x384" (bad mode clock/interlace/doublescan)
> (II) GLINT(1): Not using default mode "1400x1050" (insufficient memory for mode)
> (II) GLINT(1): Not using default mode "700x525" (bad mode clock/interlace/doublescan)
> (II) GLINT(1): Not using default mode "1400x1050" (insufficient memory for mode)
> (II) GLINT(1): Not using default mode "700x525" (bad mode clock/interlace/doublescan)
> (II) GLINT(1): Not using default mode "1600x1024" (insufficient memory for mode)
> (II) GLINT(1): Not using default mode "800x512" (bad mode clock/interlace/doublescan)
> (II) GLINT(1): Not using default mode "1920x1440" (insufficient memory for mode)
> (II) GLINT(1): Not using default mode "960x720" (bad mode clock/interlace/doublescan)
> (II) GLINT(1): Not using default mode "2048x1536" (insufficient memory for mode)
> (II) GLINT(1): Not using default mode "1024x768" (bad mode clock/interlace/doublescan)
> (II) GLINT(1): Not using default mode "2048x1536" (insufficient memory for mode)
> (II) GLINT(1): Not using default mode "1024x768" (bad mode clock/interlace/doublescan)
> (II) GLINT(1): Not using default mode "2048x1536" (insufficient memory for mode)
> (II) GLINT(1): Not using default mode "1024x768" (bad mode clock/interlace/doublescan)
> (II) GLINT(1): Not using mode "1280x1024" (no mode of this name)
> (--) GLINT(1): Virtual size is 1152x864 (pitch 1152)
> (**) GLINT(1):  Default mode "1152x864": 108.0 MHz, 67.5 kHz, 75.0 Hz
> (II) GLINT(1): Modeline "1152x864"  108.00  1152 1216 1344 1600  864 865 868 900 +hsync +vsync
> (**) GLINT(1):  Default mode "1152x768": 65.0 MHz, 44.2 kHz, 54.8 Hz
> (II) GLINT(1): Modeline "1152x768"   65.00  1152 1178 1314 1472  768 771 777 806 +hsync +vsync
> (**) GLINT(1):  Default mode "1024x768": 94.5 MHz, 68.7 kHz, 85.0 Hz
> (II) GLINT(1): Modeline "1024x768"   94.50  1024 1072 1168 1376  768 769 772 808 +hsync +vsync
> (**) GLINT(1):  Default mode "1024x768": 78.8 MHz, 60.1 kHz, 75.1 Hz
> (II) GLINT(1): Modeline "1024x768"   78.80  1024 1040 1136 1312  768 769 772 800 +hsync +vsync
> (**) GLINT(1):  Default mode "1024x768": 75.0 MHz, 56.5 kHz, 70.1 Hz
> (II) GLINT(1): Modeline "1024x768"   75.00  1024 1048 1184 1328  768 771 777 806 -hsync -vsync
> (**) GLINT(1):  Default mode "1024x768": 65.0 MHz, 48.4 kHz, 60.0 Hz
> (II) GLINT(1): Modeline "1024x768"   65.00  1024 1048 1184 1344  768 771 777 806 -hsync -vsync
> (**) GLINT(1):  Default mode "832x624": 57.3 MHz, 49.7 kHz, 74.6 Hz
> (II) GLINT(1): Modeline "832x624"   57.28  832 864 928 1152  624 625 628 667 -hsync -vsync
> (**) GLINT(1):  Default mode "800x600": 56.3 MHz, 53.7 kHz, 85.1 Hz
> (II) GLINT(1): Modeline "800x600"   56.30  800 832 896 1048  600 601 604 631 +hsync +vsync
> (**) GLINT(1):  Default mode "800x600": 49.5 MHz, 46.9 kHz, 75.0 Hz
> (II) GLINT(1): Modeline "800x600"   49.50  800 816 896 1056  600 601 604 625 +hsync +vsync
> (**) GLINT(1):  Default mode "800x600": 50.0 MHz, 48.1 kHz, 72.2 Hz
> (II) GLINT(1): Modeline "800x600"   50.00  800 856 976 1040  600 637 643 666 +hsync +vsync
> (**) GLINT(1):  Default mode "800x600": 40.0 MHz, 37.9 kHz, 60.3 Hz
> (II) GLINT(1): Modeline "800x600"   40.00  800 840 968 1056  600 601 605 628 +hsync +vsync
> (**) GLINT(1):  Default mode "800x600": 36.0 MHz, 35.2 kHz, 56.2 Hz
> (II) GLINT(1): Modeline "800x600"   36.00  800 824 896 1024  600 601 603 625 +hsync +vsync
> (**) GLINT(1):  Default mode "640x480": 36.0 MHz, 43.3 kHz, 85.0 Hz
> (II) GLINT(1): Modeline "640x480"   36.00  640 696 752 832  480 481 484 509 -hsync -vsync
> (**) GLINT(1):  Default mode "640x480": 31.5 MHz, 37.5 kHz, 75.0 Hz
> (II) GLINT(1): Modeline "640x480"   31.50  640 656 720 840  480 481 484 500 -hsync -vsync
> (**) GLINT(1):  Default mode "640x480": 31.5 MHz, 37.9 kHz, 72.8 Hz
> (II) GLINT(1): Modeline "640x480"   31.50  640 664 704 832  480 489 491 520 -hsync -vsync
> (**) GLINT(1):  Default mode "640x480": 25.2 MHz, 31.5 kHz, 60.0 Hz
> (II) GLINT(1): Modeline "640x480"   25.20  640 656 752 800  480 490 492 525 -hsync -vsync
> (**) GLINT(1):  Default mode "720x400": 35.5 MHz, 37.9 kHz, 85.0 Hz
> (II) GLINT(1): Modeline "720x400"   35.50  720 756 828 936  400 401 404 446 -hsync +vsync
> (**) GLINT(1):  Default mode "640x400": 31.5 MHz, 37.9 kHz, 85.1 Hz
> (II) GLINT(1): Modeline "640x400"   31.50  640 672 736 832  400 401 404 445 -hsync +vsync
> (**) GLINT(1):  Default mode "640x350": 31.5 MHz, 37.9 kHz, 85.1 Hz
> (II) GLINT(1): Modeline "640x350"   31.50  640 672 736 832  350 382 385 445 +hsync -vsync
> (++) GLINT(1): DPI set to (100, 100)
> (II) Loading sub module "fb"
> (II) LoadModule: "fb"
> (II) Reloading /usr/X11R6/lib/modules/libfb.a
> (II) Loading sub module "xaa"
> (II) LoadModule: "xaa"
> (II) Reloading /usr/X11R6/lib/modules/libxaa.a
> (II) Loading sub module "ddc"
> (II) LoadModule: "ddc"
> (II) Reloading /usr/X11R6/lib/modules/libddc.a
> (II) Loading sub module "i2c"
> (II) LoadModule: "i2c"
> (II) Reloading /usr/X11R6/lib/modules/libi2c.a
> (II) GLINT(1): I2C bus "DDC" initialized.
> (II) GLINT(1): I2C bus "Video" initialized.
> (--) Depth 24 pixmap format is 32 bpp
> (II) do I need RAC?  Yes, I do.
> (II) LoadModule: "rac"
> (II) Loading /usr/X11R6/lib/modules/librac.a
> (II) Module rac: vendor="The XFree86 Project"
> 	compiled for 4.3.0.1, module version = 1.0.0
> 	ABI class: XFree86 Video Driver, version 0.6
> (II) resource ranges after preInit:
> 	[0] 1	1	0x05000000 - 0x057fffff (0x800000) MX[B]
> 	[1] 1	1	0x04800000 - 0x04ffffff (0x800000) MX[B]
> 	[2] 1	1	0x03040000 - 0x0305ffff (0x20000) MX[B]
> 	[3] 0	1	0x04000000 - 0x047fffff (0x800000) MX[B]
> 	[4] 0	1	0x03800000 - 0x03ffffff (0x800000) MX[B]
> 	[5] 0	1	0x03000000 - 0x0301ffff (0x20000) MX[B]
> 	[6] -1	1	0xffffffff - 0xffffffff (0x1) MX[B]
> 	[7] -1	1	0x000f0000 - 0x000fffff (0x10000) MX[B]
> 	[8] -1	1	0x000c0000 - 0x000effff (0x30000) MX[B]
> 	[9] -1	1	0x00000000 - 0x0009ffff (0xa0000) MX[B]
> 	[10] -1	1	0x02000000 - 0x02007fff (0x8000) MX[B]
> 	[11] -1	1	0x00422000 - 0x004227ff (0x800) MX[B]
> 	[12] -1	1	0x00420000 - 0x004207ff (0x800) MX[B]
> 	[13] -1	1	0x00400000 - 0x0041ffff (0x20000) MX[B]
> 	[14] -1	1	0x01800000 - 0x01ffffff (0x800000) MX[B]
> 	[15] -1	1	0x07000000 - 0x07ffffff (0x1000000) MX[B]
> 	[16] -1	1	0x00424000 - 0x00424fff (0x1000) MX[B]
> 	[17] -1	1	0x03030000 - 0x0303ffff (0x10000) MX[B](B)
> 	[18] -1	1	0x05000000 - 0x057fffff (0x800000) MX[B](B)
> 	[19] -1	1	0x04800000 - 0x04ffffff (0x800000) MX[B](B)
> 	[20] -1	1	0x03040000 - 0x0305ffff (0x20000) MX[B](B)
> 	[21] -1	1	0x03020000 - 0x0302ffff (0x10000) MX[B](B)
> 	[22] -1	1	0x04000000 - 0x047fffff (0x800000) MX[B](B)
> 	[23] -1	1	0x03800000 - 0x03ffffff (0x800000) MX[B](B)
> 	[24] -1	1	0x03000000 - 0x0301ffff (0x20000) MX[B](B)
> 	[25] -1	1	0x00440000 - 0x0045ffff (0x20000) MX[B](B)
> 	[26] -1	1	0x00426000 - 0x00426fff (0x1000) MX[B](B)
> 	[27] -1	1	0x06000000 - 0x06ffffff (0x1000000) MX[B](B)
> 	[28] 0	1	0x000a0000 - 0x000affff (0x10000) MS[B](OprD)
> 	[29] 0	1	0x000b0000 - 0x000b7fff (0x8000) MS[B](OprD)
> 	[30] 0	1	0x000b8000 - 0x000bffff (0x8000) MS[B](OprD)
> 	[31] 1	1	0x000a0000 - 0x000affff (0x10000) MS[B](OprD)
> 	[32] 1	1	0x000b0000 - 0x000b7fff (0x8000) MS[B](OprD)
> 	[33] 1	1	0x000b8000 - 0x000bffff (0x8000) MS[B](OprD)
> 	[34] -1	1	0x00ffffff - 0x00ffffff (0x1) IX[B]
> 	[35] -1	1	0x00000000 - 0x00000000 (0x1) IX[B]
> 	[36] -1	1	0x00000a20 - 0x00000a2f (0x10) IX[B]
> 	[37] -1	1	0x00000a08 - 0x00000a0b (0x4) IX[B]
> 	[38] -1	1	0x00000a10 - 0x00000a17 (0x8) IX[B]
> 	[39] -1	1	0x00000a18 - 0x00000a1b (0x4) IX[B]
> 	[40] -1	1	0x00000a00 - 0x00000a07 (0x8) IX[B]
> 	[41] -1	1	0x00000900 - 0x000009ff (0x100) IX[B]
> 	[42] -1	1	0x00000b00 - 0x00000bff (0x100) IX[B](B)
> 	[43] 0	1	0x000003b0 - 0x000003bb (0xc) IS[B](OprD)
> 	[44] 0	1	0x000003c0 - 0x000003df (0x20) IS[B](OprD)
> 	[45] 1	1	0x000003b0 - 0x000003bb (0xc) IS[B](OprD)
> 	[46] 1	1	0x000003c0 - 0x000003df (0x20) IS[B](OprD)
> (II) GLINT(0): I2C device "DDC:ddc2" registered at address 0xA0.
> (II) GLINT(0): I2C device "DDC:ddc2" removed.
> (II) GLINT(0): Using XFree86 Acceleration Architecture (XAA)
> 	Screen to screen bit blits
> 	Solid filled rectangles
> 	8x8 mono pattern filled rectangles
> 	Indirect CPU to Screen color expansion
> 	Solid Lines
> 	Offscreen Pixmaps
> 	Driver provided WriteBitmap replacement
> 	Driver provided WritePixmap replacement
> 	Setting up tile and stipple cache:
> 		20 128x128 slots
> 		5 256x256 slots
> (==) GLINT(0): Backing store disabled
> (==) GLINT(0): Silken mouse enabled
> (**) Option "dpms"
> (**) GLINT(0): DPMS enabled
> (II) GLINT(0): direct rendering disabled
> (II) GLINT(0): Initializing Xv driver rev. 4
> (II) GLINT(0): Xv frontend scaler enabled
> (==) RandR enabled
> (II) GLINT(1): I2C device "DDC:ddc2" registered at address 0xA0.
> (II) GLINT(1): I2C device "DDC:ddc2" removed.
> (II) GLINT(1): I2C device "DDC:ddc2" registered at address 0xA0.
> (II) GLINT(1): I2C device "DDC:ddc2" removed.
> (II) GLINT(1): Manufacturer: SUN  Model: 577  Serial#: 206324300
> (II) GLINT(1): Year: 2000  Week: 37
> (II) GLINT(1): EDID Version: 1.2
> (II) GLINT(1): Analog Display Input,  Input Voltage Level: 0.700/0.300 V
> (II) GLINT(1): Sync:  Separate  Composite  SyncOnGreen
> (II) GLINT(1): Max H-Image Size [cm]: horiz.: 40  vert.: 30
> (II) GLINT(1): Gamma: 2.50
> (II) GLINT(1): DPMS capabilities: StandBy Suspend Off; RGB/Color Display
> (II) GLINT(1): redX: 0.625 redY: 0.340   greenX: 0.280 greenY: 0.605
> (II) GLINT(1): blueX: 0.155 blueY: 0.070   whiteX: 0.283 whiteY: 0.298
> (II) GLINT(1): Supported VESA Video Modes:
> (II) GLINT(1): 720x400@70Hz
> (II) GLINT(1): 720x400@88Hz
> (II) GLINT(1): 640x480@60Hz
> (II) GLINT(1): 640x480@67Hz
> (II) GLINT(1): 640x480@72Hz
> (II) GLINT(1): 640x480@75Hz
> (II) GLINT(1): 800x600@56Hz
> (II) GLINT(1): 800x600@60Hz
> (II) GLINT(1): 800x600@72Hz
> (II) GLINT(1): 800x600@75Hz
> (II) GLINT(1): 832x624@75Hz
> (II) GLINT(1): 1024x768@87Hz (interlaced)
> (II) GLINT(1): 1024x768@60Hz
> (II) GLINT(1): 1024x768@70Hz
> (II) GLINT(1): 1024x768@75Hz
> (II) GLINT(1): 1280x1024@75Hz
> (II) GLINT(1): 1152x870@75Hz
> (II) GLINT(1): Manufacturer's mask: 0
> (II) GLINT(1): Supported Future Video Modes:
> (II) GLINT(1): #0: hsize: 1280  vsize 1024  refresh: 76  vid: 36993
> (II) GLINT(1): #1: hsize: 1152  vsize 921  refresh: 76  vid: 36977
> (II) GLINT(1): #2: hsize: 1280  vsize 1024  refresh: 75  vid: 36737
> (II) GLINT(1): #3: hsize: 1280  vsize 1024  refresh: 67  vid: 34689
> (II) GLINT(1): #4: hsize: 1152  vsize 921  refresh: 66  vid: 34417
> (II) GLINT(1): #5: hsize: 1024  vsize 768  refresh: 75  vid: 20321
> (II) GLINT(1): #6: hsize: 1600  vsize 1200  refresh: 75  vid: 20393
> (II) GLINT(1): #7: hsize: 1280  vsize 1024  refresh: 112  vid: 46209
> (II) GLINT(1): Ranges: V min: 48  V max: 160 Hz, H min: 30  H max: 121 kHz, PixClock max 210 MHz
> (II) GLINT(1): Monitor name: GDM-5410
> (II) GLINT(1): Serial No: 0037LB3148
> (II) GLINT(1): Supported additional Video Mode:
> (II) GLINT(1): clock: 135.0 MHz   Image Size:  364 x 291 mm
> (II) GLINT(1): h_active: 1280  h_sync: 1312  h_sync_end 1376 h_blank_end 1664 h_border: 0
> (II) GLINT(1): v_active: 1024  v_sync: 1026  v_sync_end 1034 v_blanking: 1066 v_border: 0
> (II) GLINT(1): Using XFree86 Acceleration Architecture (XAA)
> 	Screen to screen bit blits
> 	Solid filled rectangles
> 	8x8 mono pattern filled rectangles
> 	Indirect CPU to Screen color expansion
> 	Solid Lines
> 	Offscreen Pixmaps
> 	Driver provided WriteBitmap replacement
> 	Driver provided WritePixmap replacement
> 	Setting up tile and stipple cache:
> 		9 128x46 slots
> (==) GLINT(1): Backing store disabled
> (==) GLINT(1): Silken mouse enabled
> (**) Option "dpms"
> (**) GLINT(1): DPMS enabled
> (II) GLINT(1): direct rendering disabled
> (II) GLINT(1): Initializing Xv driver rev. 4
> (II) GLINT(1): Xv frontend scaler enabled
> (==) RandR enabled
> (II) Entity 0 shares no resources
> (II) Entity 1 shares no resources
> (II) Initializing built-in extension MIT-SHM
> (II) Initializing built-in extension XInputExtension
> (II) Initializing built-in extension XTEST
> (II) Initializing built-in extension XKEYBOARD
> (II) Initializing built-in extension LBX
> (II) Initializing built-in extension XC-APPGROUP
> (II) Initializing built-in extension SECURITY
> (II) Initializing built-in extension XINERAMA
> (II) Initializing built-in extension XFree86-Bigfont
> (II) Initializing built-in extension RENDER
> (II) Initializing built-in extension RANDR
> (II) Keyboard "Generic Keyboard" handled by legacy driver
> (**) Option "Protocol" "ImPS/2"
> (**) Configured Mouse: Protocol: "ImPS/2"
> (**) Configured Mouse: Core Pointer
> (**) Option "Device" "/dev/input/mice"
> (**) Configured Mouse: Emulate3Buttons, Emulate3Timeout: 50
> (==) Configured Mouse: Buttons: 3
> (II) XINPUT: Adding extended input device "Configured Mouse" (type: MOUSE)
> (II) Server_Terminate keybinding not found
> (II) Configured Mouse: ps2EnableDataReporting: succeeded
> Warning: font renderer for ".pcf" already registered at priority 0
> Warning: font renderer for ".pcf.Z" already registered at priority 0
> Warning: font renderer for ".pcf.gz" already registered at priority 0
> Warning: font renderer for ".snf" already registered at priority 0
> Warning: font renderer for ".snf.Z" already registered at priority 0
> Warning: font renderer for ".snf.gz" already registered at priority 0
> Warning: font renderer for ".bdf" already registered at priority 0
> Warning: font renderer for ".bdf.Z" already registered at priority 0
> Warning: font renderer for ".bdf.gz" already registered at priority 0
> Warning: font renderer for ".pmf" already registered at priority 0
> Could not init font path element unix/:7100, removing from list!
> (II) 3rd Button detected: disabling emulate3Button
> (II) Screen 0 shares mem & io resources
> (II) Screen 1 shares mem & io resources
> (WW) Open APM failed (/dev/apm_bios) (No such file or directory)
> (II) Screen 0 shares mem & io resources
> (II) Screen 1 shares mem & io resources
> (II) Screen 0 shares mem & io resources
> (II) Screen 1 shares mem & io resources
> (II) Entity 0 shares no resources
> (II) Entity 1 shares no resources
> (II) Configured Mouse: ps2EnableDataReporting: succeeded


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
