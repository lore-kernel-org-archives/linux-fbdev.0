From: Alexander Kern <alex.kern@gmx.de>
Subject: Re: atyfb h/vsync polarity
Date: Thu, 23 Jun 2005 11:25:10 +0200
Message-ID: <200506231125.10848.alex.kern@gmx.de>
References: <20050622140842.GV20191@midgar.lan.raphnet.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DlNya-0003My-Hf
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Jun 2005 02:26:24 -0700
Received: from pop.gmx.de ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DlNyZ-0006ao-8r
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Jun 2005 02:26:24 -0700
In-Reply-To: <20050622140842.GV20191@midgar.lan.raphnet.net>
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
Content-Type: text/plain; charset="iso-8859-1"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Raphael Assenat <raph@raphnet.net>

Am Mittwoch, 22. Juni 2005 16:08 schrieb Raphael Assenat:
> Hi,
> I am a Linux Sparc64 user, and recently I decided to switch from 2.4
> kernel series to 2.6 series. Everything worked well, but I had trouble
> getting the framebuffer console to work.
>
> In openboot, my monitor worked perfectly. But as soon as Linux
> configured the framebuffer, my monitor would loose sync. I compared the
> output given by fbset on the working configuration (2.4 kernel) and the
> non-working configuration (2.6.12 kernel). Every setting was identical,
> except that the output on 2.4 had 'hsync high'. I tried 'fbset -hsync
> high', but the screen still did not sync, and fbset still did not report
> 'hsync high', as if the setting was ignored.
>
> After digging a little bit, I found this in
> drivers/video/aty/atyfb_base.c:
>
> if(vdisplay < 400) {
> 		h_sync_pol =3D 1;
> 		v_sync_pol =3D 0;
> } else if(vdisplay < 480) {
> 		h_sync_pol =3D 0;
> 		v_sync_pol =3D 1;
> } else if(vdisplay < 768) {
> 		h_sync_pol =3D 0;
> 		v_sync_pol =3D 0;
> } else {
> 		h_sync_pol =3D 1;
> 		v_sync_pol =3D 1;
> }
>
> So no mater what sync polarity we ask for, the driver overrides them. I
> commented the code above in my build, and the framebuffer console finally
> works.
>
> It seems strange to me that the driver ignores the sync polarity we
> request, but I'm sure the above code exists for a good reason so I would
> not suggest to simply remove it as a fix. Can anyone explain why this code
> is
> necessary?
this behaviour is from XFree code and more VGA like.
>
> The fact that this cause problems for me is probably due to my particular
> video setup: Ultra10 vga -> passive VGA csync on hsync pin to sync on gre=
en
> adapter -> passive VGA to 13W3 adapter -> GDM-17E11 SGI monitor (requires
> sync-on-green).
>
Anyway, SPARC has own rules, This error was always disputed on the list,=20
Here is a patch.

=46rom: "Antonino A. Daplas" <adaplas@hotpop.com>

Some SPARC-based displays need the composite sync set to high. =A0Since none
of the entries in the default db has the composite sync set to high, using
fb_find_mode() will produce a blank display.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
Acked-by: Alexander Kern <alex.kern@gmx.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
=2D--

=A025-akpm/drivers/video/aty/atyfb_base.c | =A0 13 +++++++++++++
=A01 files changed, 13 insertions(+)

diff -puN=20
drivers/video/aty/atyfb_base.c~atyfb-add-boot-module-option-to-override-com=
posite-sync=20
drivers/video/aty/atyfb_base.c
=2D--=20
25/drivers/video/aty/atyfb_base.c~atyfb-add-boot-module-option-to-override-=
composite-sync=A0=A0=A02005-03-31=20
03:06:50.000000000 -0800
+++ 25-akpm/drivers/video/aty/atyfb_base.c=A0=A0=A0=A0=A0=A02005-03-31 03:0=
9:07.000000000=20
=2D0800
@@ -307,6 +307,7 @@ static int vram;
=A0static int pll;
=A0static int mclk;
=A0static int xclk;
+static int comp_sync __initdata =3D -1;
=A0static char *mode;
=A0
=A0#ifdef CONFIG_PPC
@@ -2527,6 +2528,13 @@ static int __init aty_init(struct fb_inf
=A0=A0=A0=A0=A0=A0=A0=A0else
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0var.accel_flags |=3D FB_ACC=
ELF_TEXT;
=A0
+=A0=A0=A0=A0=A0=A0=A0if (comp_sync !=3D -1) {
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (!comp_sync)
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0var.s=
ync &=3D ~FB_SYNC_COMP_HIGH_ACT;
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0else
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0var.s=
ync |=3D FB_SYNC_COMP_HIGH_ACT;
+=A0=A0=A0=A0=A0=A0=A0}
+
=A0=A0=A0=A0=A0=A0=A0=A0if (var.yres =3D=3D var.yres_virtual) {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0u32 videoram =3D (info->fix=
=2Esmem_len - (PAGE_SIZE << 2));
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0var.yres_virtual =3D ((vide=
oram * 8) / var.bits_per_pixel) /=20
var.xres_virtual;
@@ -3612,6 +3620,8 @@ static int __init atyfb_setup(char *opti
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0mcl=
k =3D simple_strtoul(this_opt + 5, NULL, 0);
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0else if (!strncmp(this_opt,=
 "xclk:", 5))
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0xcl=
k =3D simple_strtoul(this_opt+5, NULL, 0);
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0else if (!strncmp(this_opt, "=
comp_sync:", 10))
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0comp_=
sync =3D simple_strtoul(this_opt+10, NULL, 0);
=A0#ifdef CONFIG_PPC
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0else if (!strncmp(this_opt,=
 "vmode:", 6)) {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0uns=
igned int vmode =3D
@@ -3701,6 +3711,9 @@ module_param(mclk, int, 0);
=A0MODULE_PARM_DESC(mclk, "int: override memory clock");
=A0module_param(xclk, int, 0);
=A0MODULE_PARM_DESC(xclk, "int: override accelerated engine clock");
+module_param(comp_sync, int, 0);
+MODULE_PARM_DESC(comp_sync,
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "Set composite sync signal t=
o low (0) or high (1)");
=A0module_param(mode, charp, 0);
=A0MODULE_PARM_DESC(mode, "Specify resolution as \"<xres>x<yres>[-<bpp>]
[@<refresh>]\" ");
=A0#ifdef CONFIG_MTRR
_

> IMHO, the driver should preserve the settings from openboot, not only the
> resoltion and sync frequencies, but also the sync polarities.
>
> Regards,
> Raphael Assenat

Best Wishes
Mit freundlichen Gr=FC=DFen

Alex Kern


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
