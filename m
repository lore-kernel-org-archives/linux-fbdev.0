From: Jurriaan <thunder7@xs4all.nl>
Subject: Re: Re: FBdev updates.
Date: Tue, 4 Mar 2003 22:29:06 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030304212906.GA1115@middle.of.nowhere>
References: <Pine.LNX.4.44.0302200108090.20350-100000@phoenix.infradead.org> <20030220150201.GD13507@codemonkey.org.uk> <20030220182941.GK14445@vana.vc.cvut.cz> <1045787031.2051.9.camel@localhost.localdomain> <20030303203500.GA2916@vana.vc.cvut.cz>
Reply-To: thunder7@xs4all.nl
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from smtpzilla1.xs4all.nl ([194.109.127.137])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qJyr-0003jm-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 04 Mar 2003 13:29:45 -0800
Received: from zeeotter.xs4all.nl (zeeotter.xs4all.nl [80.126.31.149])
	by smtpzilla1.xs4all.nl (8.12.0/8.12.0) with ESMTP id h24LTf59031397
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 4 Mar 2003 22:29:42 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20030303203500.GA2916@vana.vc.cvut.cz>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Antonino Daplas <adaplas@pol.net>, James Simmons <jsimmons@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Petr Vandrovec <vandrove@vc.cvut.cz>
Date: Mon, Mar 03, 2003 at 09:35:00PM +0100
> On Fri, Feb 21, 2003 at 08:24:17AM +0800, Antonino Daplas wrote:
> > On Fri, 2003-02-21 at 02:29, Petr Vandrovec wrote:
> > > 
> > > I was for five weeks in U.S., so I did not do anything with
> > > matroxfb during that time. I plan to use fillrect and copyrect
> > > from generic code (although it means unnecessary multiply on
> > > generic side, and division in matroxfb, but well, if we gave
> > > up on reasonable speed for fbdev long ago...). But I simply
> > > want loadfont and putcs hooks for character painting. And if 
> > > fbdev maintainer does not want to give me them, well, then 
> > > matroxfb and fbdev are not compatible.
> > 
> > Petr,
> > 
> > I submitted the Tile Blitting patch to James some time ago, it has
> > tilefill, tilecopy and tileblit hooks.  These hooks should eliminate the
> > "multiply in fbcon, divide in driver" bottleneck.
> >
> > It should result in the same behavior as you would expect in the the 2.4
> > API, so you can use text mode with your matroxfb driver.  These same
> > hooks will also help optimize drawing if we need to use fonts like
> > 12x22.
> 
> Hi,
>   while waiting on these updates I updated matroxfb a bit
> (ftp://platan.vc.cvut.cz/pub/linux/matrox-latest/matroxfb-2.5.63.gz),
> so that it now uses fb_* for cfb modes, and putcs/... hooks for
> text mode.

There is a regression here: I boot my kernel like this:

kernel /boot/vmlinuz-2563matrox root=/dev/hda7 video=matrox:vesa:0x11E,fv:80,sgram hdc=scsi apm=smp apm=power-off nosmp=1

and have the following .config:

CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_AGP=y
CONFIG_AGP_VIA=y
CONFIG_DRM=y
CONFIG_DRM_MGA=y
CONFIG_RAW_DRIVER=y
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_PCI_CONSOLE=y
CONFIG_FBCON_ADVANCED=y
CONFIG_FONT_SUN12x22=y
CONFIG_FONTS=y
CONFIG_FB_MATROX=y
CONFIG_FB_MATROX_G450=y
CONFIG_FB_MATROX_G100=y
CONFIG_FB_MATROX_I2C=y
CONFIG_FB_MATROX_MAVEN=y
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_CFB16=y
CONFIG_FBCON_CFB24=y
CONFIG_FBCON_CFB32=y
CONFIG_FBCON_ACCEL=y

matroxfb: Matrox G400 (AGP) detected
matroxfb: MTRR's turned on
matroxfb: 1600x1200x16bpp (virtual: 1600x5241)
matroxfb: framebuffer at 0xD4000000, mapped to 0xe0805000, size 33554432
Console: switching to colour frame buffer device 133x54
fb0: MATROX VGA frame buffer device
pty: 256 Unix98 ptys configured
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA Apollo Pro 266T chipset
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 64M @ 0xd0000000
[drm] Initialized mga 3.1.0 20021029 on minor 0

I see a continuous strip of alternating blocks, of sub-character size,
at the extreme right end of my screen. The colors seem linked to the
color of the line with the cursor in some way.

After leaving XFRee, a piece of chbg's background picture is shown for a
short while, then the blocks return.

Kind regards,
Jurriaan


-- 
But the threat of disapproval had terrified me
No more my soul will I reveal
	Wargasm - Chameleon
GNU/Linux 2.5.63 SMP/ReiserFS 1x2793 bogomips load av: 1.18 0.46 0.17


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
