From: Lucas Correia Villa Real <lucasvr@gobolinux.org>
Subject: Re: Bug on atyfb
Date: Mon, 13 Dec 2004 01:30:44 -0200
Message-ID: <200412130130.44962.lucasvr@gobolinux.org>
References: <200412101844.10577.lucasvr@gobolinux.org> <200412111451.42845.lucasvr@gobolinux.org> <20041211213754.GA14355@sci.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_kzQvBgpfigMtcnv"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cdgv4-0002m0-EW
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 12 Dec 2004 19:30:42 -0800
Received: from linares.terra.com.br ([200.154.55.228])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1Cdgv3-0000tj-5v
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 12 Dec 2004 19:30:42 -0800
Received: from talara.terra.com.br (talara.terra.com.br [200.154.55.136])
	by linares.terra.com.br (Postfix) with ESMTP id 1698EDDC3D9
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 13 Dec 2004 01:30:37 -0200 (BRST)
Received: from ummagumma.ozzmosis.net (200-203-050-104.nhoce7002.dsl.brasiltelecom.net.br [200.203.50.104])
	(authenticated user lucasvr)
	by talara.terra.com.br (Postfix) with ESMTP id A8D3D3C002
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 13 Dec 2004 01:30:36 -0200 (BRST)
In-Reply-To: <20041211213754.GA14355@sci.fi>
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


--Boundary-00=_kzQvBgpfigMtcnv
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 11 December 2004 19:37, Ville Syrj=E4l=E4 wrote:
> On Sat, Dec 11, 2004 at 02:51:42PM -0200, Lucas Correia Villa Real wrote:
> > On Friday 10 December 2004 19:19, Antonino A. Daplas wrote:
> > > On Saturday 11 December 2004 04:44, Lucas Correia Villa Real wrote:
> > > > Hi,
> > > >
> > > > I'm trying to use atyfb on 2.6.10-rc3, but I'm getting a kernel oops
> > > > just at modprobe time. By tracking the problem, it seems that
> > > > 'pll_limits.xclk' is the heart of the problem, as seen in line 2210
> > > > from atyfb_base.c:
> > > >
> > > > par->xclk_per =3D 1000000/par->pll_limits.xclk;
> > > >
> > > > It happens that pll_limits.xclk is zero, because of an attribution
> > > > made on line 3246:
> > > >
> > > > par->pll_limits.xclk =3D pll_block.XCLK_max_freq/100;
> > > >
> > > > pll_block.XCLK_max_freq, in this case, is read from BIOS a few lines
> > > > above (at line 3229, to be more precise), and the value being
> > > > returned from this copy here is 20. So we have a problem, since the
> > > > result from 20/100 =3D 0 will be used as denominator to set
> > > > par->xclk_per's value.
> > >
> > > Buggy BIOS?  Why not skip the init_from_bios() step, since xclk will =
be
> > > initialized in the function correct_chipset(), just a few lines above?
> > >
> > > If that works, perhaps a boot option can be added such as no_bios?
> >
> > Hi,
> >
> > When trying to skip the initialization from bios the driver gets crazy:
> >
> > atyfb: using auxiliary register aperture
> > atyfb: 3D RAGE II+ (Mach64 GTB) [0x4755 rev 0x9a]
> > atyfb: 512K RESV, 14.31818 MHz XTAL, 200 MHz PLL, 67 Mhz MCLK, 67 MHz
> > XCLK atyfb: Unsupported xclk source:  5.
> > atyfb: vclk out of range
> > atyfb: not enough video RAM
> > atyfb: not enough video RAM
> > atyfb: not enough video RAM
> > ...
> > atyfb: vclk out of range
> > atyfb: can't set default video mode
> > ...
> >
> > After this broken initialization, if I try to rmmod atyfb, the kernel
> > oops'es. So, I've decided to keep doing the initialization from bios, b=
ut
> > if the bios is told to be buggy, correct_from_chipset() is called again
> > to fix some stuff informed by the bios.
>
> Are you saying you don't get these warnings if you call init_from_bios()?
> That sounds really strange as the only thing init_from_bios() does is get
> the PLL limits. So if you call correct_chipset() after init_from_bios() it
> should behave exactly the same as if you didn't call init_from_bios() in
> the first place.

I've done some more tests, and I discovered that I was being fooled by X. W=
hen=20
I try to load the atyfb module after X has been started and finished, the=20
module is loaded successfully -- given that the init_from_bios() function i=
s=20
skipped.

So you were right, there's no need to call correct_chipset() again. I just=
=20
guess X is setting some hardware registers that atyfb is missing. I'll give=
 a=20
look on Xorg drivers tomorrow to see if something "appears" magically to my=
=20
eyes.

I've fixed the previous patch, sent in attach. It now also uses "use_bios"=
=20
instead of the "broken_bios" parameter.

By the way, are datasheets to ATI Rage II+ freely available? Maybe I can=20
provide some better feedback by trying to check things there first.

Thanks!
Lucas

--Boundary-00=_kzQvBgpfigMtcnv
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="atyfb-2.6.10-rc3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="atyfb-2.6.10-rc3.patch"

--- linux-2.6.10-rc3/drivers/video/aty/atyfb_base.c.orig	2004-12-13 01:07:26.000000000 -0200
+++ linux-2.6.10-rc3/drivers/video/aty/atyfb_base.c	2004-12-13 01:10:10.000000000 -0200
@@ -299,6 +299,7 @@
 	.fb_sync	= atyfb_sync,
 };
 
+static int use_bios;
 static int noaccel;
 #ifdef CONFIG_MTRR
 static int nomtrr;
@@ -3308,8 +3309,10 @@
 	if((ret = correct_chipset(par)))
 		goto atyfb_setup_generic_fail;
 #ifdef __i386__
-	if((ret = init_from_bios(par)))
-		goto atyfb_setup_generic_fail;
+	if (use_bios) {
+		if((ret = init_from_bios(par)))
+			goto atyfb_setup_generic_fail;
+	}
 #endif
 	if (!(aty_ld_le32(CRTC_GEN_CNTL, par) & CRTC_EXT_DISP_EN))
 		par->clk_wr_offset = (inb(R_GENMO) & 0x0CU) >> 2;
@@ -3600,6 +3603,8 @@
 			mclk = simple_strtoul(this_opt + 5, NULL, 0);
 		else if (!strncmp(this_opt, "xclk:", 5))
 			xclk = simple_strtoul(this_opt+5, NULL, 0);
+		else if (!strncmp(this_opt, "use_bios:", 12))
+			use_bios = simple_strtoul(this_opt+12, NULL, 0);
 #ifdef CONFIG_PPC
 		else if (!strncmp(this_opt, "vmode:", 6)) {
 			unsigned int vmode =
@@ -3692,6 +3697,8 @@
 MODULE_PARM_DESC(xclk, "int: override accelerated engine clock");
 module_param(mode, charp, 0);
 MODULE_PARM_DESC(mode, "Specify resolution as \"<xres>x<yres>[-<bpp>][@<refresh>]\" ");
+module_param(use_bios, int, 0);
+MODULE_PARM_DESC(use_bios, "bool: enable/disable the use of video bios");
 #ifdef CONFIG_MTRR
 module_param(nomtrr, bool, 0);
 MODULE_PARM_DESC(nomtrr, "bool: disable use of MTRR registers");

--Boundary-00=_kzQvBgpfigMtcnv--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
