From: Lucas Correia Villa Real <lucasvr@gobolinux.org>
Subject: Re: Bug on atyfb
Date: Sat, 11 Dec 2004 14:51:42 -0200
Message-ID: <200412111451.42845.lucasvr@gobolinux.org>
References: <200412101844.10577.lucasvr@gobolinux.org> <200412110519.19633.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_eWyuBUdhsLGRwxv"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CdAT6-0001IU-J8
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 11 Dec 2004 08:51:40 -0800
Received: from loncoche.terra.com.br ([200.154.55.229])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CdAT5-0002ns-8x
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 11 Dec 2004 08:51:40 -0800
Received: from pasto.terra.com.br (pasto.terra.com.br [200.154.55.137])
	by loncoche.terra.com.br (Postfix) with ESMTP id 79A36E78E04
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 11 Dec 2004 14:51:35 -0200 (BRST)
Received: from ummagumma.ozzmosis.net (200-102-085-101.nhoce7002.dsl.brasiltelecom.net.br [200.102.85.101])
	(authenticated user lucasvr)
	by pasto.terra.com.br (Postfix) with ESMTP id 2514279402F
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 11 Dec 2004 14:51:35 -0200 (BRST)
In-Reply-To: <200412110519.19633.adaplas@hotpop.com>
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


--Boundary-00=_eWyuBUdhsLGRwxv
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 10 December 2004 19:19, Antonino A. Daplas wrote:
> On Saturday 11 December 2004 04:44, Lucas Correia Villa Real wrote:
> > Hi,
> >
> > I'm trying to use atyfb on 2.6.10-rc3, but I'm getting a kernel oops just
> > at modprobe time. By tracking the problem, it seems that
> > 'pll_limits.xclk' is the heart of the problem, as seen in line 2210 from
> > atyfb_base.c:
> >
> > par->xclk_per = 1000000/par->pll_limits.xclk;
> >
> > It happens that pll_limits.xclk is zero, because of an attribution made
> > on line 3246:
> >
> > par->pll_limits.xclk = pll_block.XCLK_max_freq/100;
> >
> > pll_block.XCLK_max_freq, in this case, is read from BIOS a few lines
> > above (at line 3229, to be more precise), and the value being returned
> > from this copy here is 20. So we have a problem, since the result from
> > 20/100 = 0 will be used as denominator to set par->xclk_per's value.
>
> Buggy BIOS?  Why not skip the init_from_bios() step, since xclk will be
> initialized in the function correct_chipset(), just a few lines above?
>
> If that works, perhaps a boot option can be added such as no_bios?

Hi,

When trying to skip the initialization from bios the driver gets crazy:

atyfb: using auxiliary register aperture
atyfb: 3D RAGE II+ (Mach64 GTB) [0x4755 rev 0x9a]
atyfb: 512K RESV, 14.31818 MHz XTAL, 200 MHz PLL, 67 Mhz MCLK, 67 MHz XCLK
atyfb: Unsupported xclk source:  5.
atyfb: vclk out of range
atyfb: not enough video RAM
atyfb: not enough video RAM
atyfb: not enough video RAM
...
atyfb: vclk out of range
atyfb: can't set default video mode
...

After this broken initialization, if I try to rmmod atyfb, the kernel oops'es. 
So, I've decided to keep doing the initialization from bios, but if the bios 
is told to be buggy, correct_from_chipset() is called again to fix some stuff 
informed by the bios.

My card's behaviour isn't just the best yet: it looks like the monitor is out 
of sync, and I can't get any acceptable mode (I've tryied a lot of modes with 
fbset). Reading characters from the terminal is impossible.

However, I could successfully run 'dfbsee image.png', and the image was shown 
nicely on the display. Maybe DirectFB is performing another video mode 
switch..?

Anyway, I'm attaching the patch, which fixes the oops'es I was getting 
previously. I'll try to understand what's going wrong with video modes here, 
and if I came to a solution I'll post it. Any help is welcome, of course :-)

Thanks,
Lucas

--Boundary-00=_eWyuBUdhsLGRwxv
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="atyfb-2.6.10-rc3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="atyfb-2.6.10-rc3.patch"

diff -X dontdiff-2.6 -Nur linux-2.6.10-rc3-vanilla/drivers/video/aty/atyfb_base.c linux-2.6.10-rc3/drivers/video/aty/atyfb_base.c
--- linux-2.6.10-rc3-vanilla/drivers/video/aty/atyfb_base.c	2004-12-07 09:58:14.000000000 -0200
+++ linux-2.6.10-rc3/drivers/video/aty/atyfb_base.c	2004-12-11 14:23:56.000000000 -0200
@@ -299,6 +299,7 @@
 	.fb_sync	= atyfb_sync,
 };
 
+static int broken_bios;
 static int noaccel;
 #ifdef CONFIG_MTRR
 static int nomtrr;
@@ -3310,6 +3311,12 @@
 #ifdef __i386__
 	if((ret = init_from_bios(par)))
 		goto atyfb_setup_generic_fail;
+
+	if (broken_bios) {
+		/* Fix data configured by the BIOS */
+		if((ret = correct_chipset(par)))
+			goto atyfb_setup_generic_fail;
+	}
 #endif
 	if (!(aty_ld_le32(CRTC_GEN_CNTL, par) & CRTC_EXT_DISP_EN))
 		par->clk_wr_offset = (inb(R_GENMO) & 0x0CU) >> 2;
@@ -3600,6 +3607,8 @@
 			mclk = simple_strtoul(this_opt + 5, NULL, 0);
 		else if (!strncmp(this_opt, "xclk:", 5))
 			xclk = simple_strtoul(this_opt+5, NULL, 0);
+		else if (!strncmp(this_opt, "broken_bios:", 12))
+			broken_bios = simple_strtoul(this_opt+12, NULL, 0);
 #ifdef CONFIG_PPC
 		else if (!strncmp(this_opt, "vmode:", 6)) {
 			unsigned int vmode =
@@ -3692,6 +3701,8 @@
 MODULE_PARM_DESC(xclk, "int: override accelerated engine clock");
 module_param(mode, charp, 0);
 MODULE_PARM_DESC(mode, "Specify resolution as \"<xres>x<yres>[-<bpp>][@<refresh>]\" ");
+module_param(broken_bios, int, 0);
+MODULE_PARM_DESC(broken_bios, "bool: set to 1 if you have a broken video BIOS");
 #ifdef CONFIG_MTRR
 module_param(nomtrr, bool, 0);
 MODULE_PARM_DESC(nomtrr, "bool: disable use of MTRR registers");

--Boundary-00=_eWyuBUdhsLGRwxv--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
