From: Ani Joshi <ajoshi@unixbox.com>
Subject: Re: [2.5.59] radeonfb not working
Date: Wed, 29 Jan 2003 10:20:55 -0800 (PST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.BSF.4.50.0301291018520.25671-100000@shell.unixbox.com>
References: <20030129152703.GA539@dreamland.darkstar.lan>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from shell.unixbox.com ([207.211.45.65] ident=root)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18dwqC-0003y7-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 29 Jan 2003 10:21:40 -0800
In-Reply-To: <20030129152703.GA539@dreamland.darkstar.lan>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kronos <kronos@kronoz.cjb.net>
Cc: linux-fbdev-devel@lists.sourceforge.net



> radeonfb: ref_clk=2700, ref_div=67, xclk=16600 defaults

This line here says that radeonfb didn't acquire the pll clock values from
your BIOS properly and is using defaults, which are for the 1st gen
Radeon.  Is anyone else with a 9500 (or 9700) using radeonfb and can get
values from their BIOS?  (radeonfb will say "from BIOS" if it got them
properly).  This will explain your "out of scan range" problem because it
is not setting the mode right.


ani



On Wed, 29 Jan 2003, Kronos wrote:

> Hi,
> I've a  Radeon 9500 Pro board  and framebuffer isn't working. If  I boot
> with "video=radeon" monitor complains about "Out of scan range". This is
> from the bootlog:
>
> radeonfb_pci_register BEGIN
> radeonfb: ref_clk=2700, ref_div=67, xclk=16600 defaults
> radeonfb: probed SDR SGRAM 131072k videoram
> radeon_get_moninfo: bios 4 scratch = 2000002
> radeonfb: ATI Radeon 9700 NE SDR SGRAM 128 MB
> radeonfb: DVI port no monitor connected
> radeonfb: CRT port CRT monitor connected
> radeonfb_pci_register END
> hStart = 664, hEnd = 760, hTotal = 800
> vStart = 491, vEnd = 493, vTotal = 525
> h_total_disp = 0x4f0063    hsync_strt_wid = 0x8c02a2
> v_total_disp = 0x1df020c           vsync_strt_wid = 0x8201ea
> post div = 0x8
> fb_div = 0x1f4
> ppll_div_3 = 0x301f4
> ron = 1024, roff = 23632
> vclk_freq = 2519, per = 844
> Console: switching to colour frame buffer device 80x30
>
> If   I  append   a  specific   video  mode   I'll  get   "out  of   scan
> range"   or  "no   signal"  depending   on  the   video  mode. This   is
> "video=radeon:640x480-16@85" (no signal):
>
> radeonfb_pci_register BEGIN
> radeonfb: ref_clk=2700, ref_div=67, xclk=16600 defaults
> radeonfb: probed SDR SGRAM 131072k videoram
> radeon_get_moninfo: bios 4 scratch = 2000002
> radeonfb: ATI Radeon 9700 NE SDR SGRAM 128 MB
> radeonfb: DVI port no monitor connected
> radeonfb: CRT port CRT monitor connected
> radeonfb_pci_register END
> hStart = 696, hEnd = 752, hTotal = 832
> vStart = 481, vEnd = 484, vTotal = 509
> h_total_disp = 0x4f0067    hsync_strt_wid = 0x8702b9
> v_total_disp = 0x1df01fc           vsync_strt_wid = 0x8301e0
> post div = 0x4
> fb_div = 0x165
> ppll_div_3 = 0x20165
> ron = 960, roff = 16548
> vclk_freq = 3597, per = 591
> Console: switching to colour frame buffer device 80x30
>
> ciao,
> Luca
> --
> Reply-To: kronos@kronoz.cjb.net
> Home: http://kronoz.cjb.net
> Il coraggio non mi manca.
> E` la paura che mi frega...
>
>
> -------------------------------------------------------
> This SF.NET email is sponsored by:
> SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
> http://www.vasoftware.com
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
>


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
