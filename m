From: James Simmons <jsimmons@www.infradead.org>
Subject: Re: PATCH: move soft_cursor into fbconsole
Date: Thu, 7 Jul 2005 00:28:06 +0100 (BST)
Message-ID: <Pine.LNX.4.56.0507070027460.10433@pentafluge.infradead.org>
References: <9e47339105061021571f479b10@mail.gmail.com> 
 <200506161111.27115.adaplas@hotpop.com>  <9e4733910506152037193300fa@mail.gmail.com>
  <Pine.LNX.4.56.0506210103540.18685@pentafluge.infradead.org> 
 <9e473391050620173132ea1ce6@mail.gmail.com> 
 <Pine.LNX.4.56.0506240015300.24330@pentafluge.infradead.org> 
 <9e473391050624052640aa5279@mail.gmail.com> 
 <Pine.LNX.4.56.0506241713210.14981@pentafluge.infradead.org> 
 <9e47339105062409276fcd5223@mail.gmail.com> 
 <Pine.LNX.4.56.0506241740220.15430@pentafluge.infradead.org>
 <9e473391050624102559929cd9@mail.gmail.com> <Pine.LNX.4.56.0507020030120.14405@pentafluge.infradead.org>
 <42C5D739.4050205@worldonline.fr>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DqJJL-0001RI-RS
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 06 Jul 2005 16:28:11 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx2-new.sourceforge.net with esmtp (Exim 4.44)
	id 1DqJJK-0004pJ-P5
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 06 Jul 2005 16:28:11 -0700
In-Reply-To: <42C5D739.4050205@worldonline.fr>
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
Content-Type: TEXT/PLAIN; charset="iso-8859-1"
To: Sylvain Meyer <sylvain.meyer@worldonline.fr>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


Yes please send me a proper patch.

On Sat, 2 Jul 2005, Sylvain Meyer wrote:

>         James,
>=20
>     In the intelfb driver, the hw cursor is decoupled from the graphic=20
> hw acceleration. So, this code is incorrect
>=20
> @@ -1328,9 +1317,10 @@
>  =09if (ACCEL(dinfo, info)) {
>  =09=09info->flags =3D FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN |
>  =09=09FBINFO_HWACCEL_COPYAREA | FBINFO_HWACCEL_FILLRECT |
> -=09=09FBINFO_HWACCEL_IMAGEBLIT;
> +=09=09FBINFO_HWACCEL_IMAGEBLIT | FBINFO_HWACCEL_CURSOR;
>  =09} else {
> -=09=09info->flags =3D FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN;
> +=09=09info->flags =3D FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN |=20
> +=09=09FBINFO_HWACCEL_CURSOR;
>  =09}
>  =09kfree(hw);
>  =09return 0;
>=20
> should be something like this. I can come with a good patch if you want=
=20
> (now it's just a mail hack)
>=20
>  =09if (ACCEL(dinfo, info)) {
>  =09=09info->flags =3D FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN |
>  =09=09FBINFO_HWACCEL_COPYAREA | FBINFO_HWACCEL_FILLRECT |
> =09=09FBINFO_HWACCEL_IMAGEBLIT;
>  =09} else {
> =09=09info->flags =3D FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN;
>  =09}
> +       if (dinfo->hwcursor)
> +               info->flags |=3D FBINFO_HWACCEL_CURSOR;
>=20
> Regards
> Sylvain
>=20
> James Simmons a =E9crit:
>=20
> >>Why are you trying to preserve all of the ".fb_cursor =3D soft_cursor,"
> >>assignments in the drivers? What purpose do they serve that can't be
> >>handled by a simple test like this:
> >>
> >>Then any in-kernel user does this:
> >>      /* First try the hardware cursor */
> >>      if (info->fbops->fb_cursor)
> >>              err =3D info->fbops->fb_cursor(info, &cursor);
> >>      /* if that doesn't exist or didn't work, use the software one */
> >>      if (err)
> >>              soft_cursor(info, &cursor);
> >>   =20
> >>
> >
> >I don't want to make a patch that touches all the drivers. Th epatch I=
=20
> >posted is a nice simple patch. If there are no other arguments against i=
t=20
> >I like to submit it to Andrew.
> >
> >diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/aty/mach64_=
cursor.c fbdev-2.6/drivers/video/aty/mach64_cursor.c
> >--- linus-2.6/drivers/video/aty/mach64_cursor.c=092005-05-10 08:39:33.00=
0000000 -0700
> >+++ fbdev-2.6/drivers/video/aty/mach64_cursor.c=092005-06-24 09:04:12.00=
0000000 -0700
> >@@ -219,8 +219,8 @@
> > =09info->sprite.buf_align =3D 16; =09/* and 64 lines tall. */
> > =09info->sprite.flags =3D FB_PIXMAP_IO;
> >=20
> >+=09info->flags |=3D FBINFO_HWACCEL_CURSOR;
> > =09info->fbops->fb_cursor =3D atyfb_cursor;
> >-
> > =09return 0;
> > }
> >=20
> >diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/fbsysfs.c f=
bdev-2.6/drivers/video/fbsysfs.c
> >--- linus-2.6/drivers/video/fbsysfs.c=092005-06-14 11:51:24.000000000 -0=
700
> >+++ fbdev-2.6/drivers/video/fbsysfs.c=092005-06-24 09:46:33.000000000 -0=
700
> >@@ -311,13 +311,19 @@
> > static ssize_t store_cursor(struct class_device *class_device,
> > =09=09=09    const char * buf, size_t count)
> > {
> >-//=09struct fb_info *fb_info =3D (struct fb_info *)class_get_devdata(cl=
ass_device);
> >+=09struct fb_info *fb_info =3D (struct fb_info *)class_get_devdata(clas=
s_device);
> >+
> >+=09if (!(fb_info->flags & FBINFO_HWACCEL_CURSOR))
> >+=09=09return -ENXIO;
> > =09return 0;
> > }
> >=20
> > static ssize_t show_cursor(struct class_device *class_device, char *buf=
)
> > {
> >-//=09struct fb_info *fb_info =3D (struct fb_info *)class_get_devdata(cl=
ass_device);
> >+=09struct fb_info *fb_info =3D (struct fb_info *)class_get_devdata(clas=
s_device);
> >+
> >+=09if (!(fb_info->flags & FBINFO_HWACCEL_CURSOR))
> >+=09=09return -ENXIO;
> > =09return 0;
> > }
> >=20
> >diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/i810/i810.h=
 fbdev-2.6/drivers/video/i810/i810.h
> >--- linus-2.6/drivers/video/i810/i810.h=092005-05-10 08:39:33.000000000 =
-0700
> >+++ fbdev-2.6/drivers/video/i810/i810.h=092005-06-24 09:04:12.000000000 =
-0700
> >@@ -201,7 +201,6 @@
> > #define HAS_ACCELERATION            2
> > #define ALWAYS_SYNC                 4
> > #define LOCKUP                      8
> >-#define USE_HWCUR                  16
> >=20
> > struct gtt_data {
> > =09struct agp_memory *i810_fb_memory;
> >diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/i810/i810_m=
ain.c fbdev-2.6/drivers/video/i810/i810_main.c
> >--- linus-2.6/drivers/video/i810/i810_main.c=092005-06-22 17:09:52.00000=
0000 -0700
> >+++ fbdev-2.6/drivers/video/i810/i810_main.c=092005-06-24 09:04:12.00000=
0000 -0700
> >@@ -1375,7 +1375,6 @@
> > =09decode_var(&info->var, par);
> > =09i810_load_regs(par);
> > =09i810_init_cursor(par);
> >-
> > =09encode_fix(&info->fix, info);
> >=20
> > =09if (info->var.accel_flags && !(par->dev_flags & LOCKUP)) {
> >@@ -1387,6 +1386,7 @@
> > =09=09info->pixmap.scan_align =3D 1;
> > =09=09info->flags =3D FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN;
> > =09}
> >+=09info->flags |=3D FBINFO_HWACCEL_CURSOR;
> > =09return 0;
> > }
> >=20
> >@@ -1418,9 +1418,8 @@
> > =09struct i810fb_par *par =3D (struct i810fb_par *)info->par;
> > =09u8 __iomem *mmio =3D par->mmio_start_virtual;
> >=20
> >-=09if (!(par->dev_flags & USE_HWCUR) || !info->var.accel_flags ||
> >-=09    par->dev_flags & LOCKUP)
> >-=09=09return soft_cursor(info, cursor);
> >+=09if (!par->dev_flags & LOCKUP)
> >+=09=09return -ENXIO;
> >=20
> > =09if (cursor->image.width > 64 || cursor->image.height > 64)
> > =09=09return -ENXIO;
> >diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/intelfb/int=
elfbdrv.c fbdev-2.6/drivers/video/intelfb/intelfbdrv.c
> >--- linus-2.6/drivers/video/intelfb/intelfbdrv.c=092005-06-22 17:09:52.0=
00000000 -0700
> >+++ fbdev-2.6/drivers/video/intelfb/intelfbdrv.c=092005-06-24 09:04:12.0=
00000000 -0700
> >@@ -117,14 +117,10 @@
> > #include <linux/slab.h>
> > #include <linux/delay.h>
> > #include <linux/fb.h>
> >-#include <linux/console.h>
> >-#include <linux/selection.h>
> > #include <linux/ioport.h>
> > #include <linux/init.h>
> > #include <linux/pci.h>
> > #include <linux/vmalloc.h>
> >-#include <linux/kd.h>
> >-#include <linux/vt_kern.h>
> > #include <linux/pagemap.h>
> > #include <linux/version.h>
> >=20
> >@@ -242,7 +238,7 @@
> > static char *mode       =3D NULL;
> >=20
> > module_param(accel, bool, S_IRUGO);
> >-MODULE_PARM_DESC(accel, "Enable console acceleration");
> >+MODULE_PARM_DESC(accel, "Enable hardware acceleration");
> > module_param(vram, int, S_IRUGO);
> > MODULE_PARM_DESC(vram, "System RAM to allocate to framebuffer in MiB");
> > module_param(voffset, int, S_IRUGO);
> >@@ -498,7 +494,7 @@
> > {
> > =09struct fb_info *info;
> > =09struct intelfb_info *dinfo;
> >-=09int i, j, err, dvo;
> >+=09int i, err, dvo;
> > =09int aperture_size, stolen_size;
> > =09struct agp_kern_info gtt_info;
> > =09int agp_memtype;
> >@@ -841,13 +837,6 @@
> > =09if (bailearly =3D=3D 5)
> > =09=09bailout(dinfo);
> >=20
> >-=09for (i =3D 0; i < 16; i++) {
> >-=09=09j =3D color_table[i];
> >-=09=09dinfo->palette[i].red =3D default_red[j];
> >-=09=09dinfo->palette[i].green =3D default_grn[j];
> >-=09=09dinfo->palette[i].blue =3D default_blu[j];
> >-=09}
> >-
> > =09if (bailearly =3D=3D 6)
> > =09=09bailout(dinfo);
> >=20
> >@@ -1328,9 +1317,10 @@
> > =09if (ACCEL(dinfo, info)) {
> > =09=09info->flags =3D FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN |
> > =09=09FBINFO_HWACCEL_COPYAREA | FBINFO_HWACCEL_FILLRECT |
> >-=09=09FBINFO_HWACCEL_IMAGEBLIT;
> >+=09=09FBINFO_HWACCEL_IMAGEBLIT | FBINFO_HWACCEL_CURSOR;
> > =09} else {
> >-=09=09info->flags =3D FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN;
> >+=09=09info->flags =3D FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN |=20
> >+=09=09FBINFO_HWACCEL_CURSOR;
> > =09}
> > =09kfree(hw);
> > =09return 0;
> >@@ -1359,10 +1349,6 @@
> > =09=09=09green >>=3D 8;
> > =09=09=09blue >>=3D 8;
> >=20
> >-=09=09=09dinfo->palette[regno].red =3D red;
> >-=09=09=09dinfo->palette[regno].green =3D green;
> >-=09=09=09dinfo->palette[regno].blue =3D blue;
> >-
> > =09=09=09intelfbhw_setcolreg(dinfo, regno, red, green, blue,
> > =09=09=09=09=09    transp);
> > =09=09}
> >diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/intelfb/int=
elfb.h fbdev-2.6/drivers/video/intelfb/intelfb.h
> >--- linus-2.6/drivers/video/intelfb/intelfb.h=092005-05-10 08:39:33.0000=
00000 -0700
> >+++ fbdev-2.6/drivers/video/intelfb/intelfb.h=092005-06-24 09:04:12.0000=
00000 -0700
> >@@ -234,7 +234,6 @@
> >=20
> > =09/* palette */
> > =09u32 pseudo_palette[17];
> >-=09struct { u8 red, green, blue, pad; } palette[256];
> >=20
> > =09/* chip info */
> > =09int pci_chipset;
> >diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/intelfb/int=
elfbhw.c fbdev-2.6/drivers/video/intelfb/intelfbhw.c
> >--- linus-2.6/drivers/video/intelfb/intelfbhw.c=092005-05-10 08:39:33.00=
0000000 -0700
> >+++ fbdev-2.6/drivers/video/intelfb/intelfbhw.c=092005-06-24 09:04:13.00=
0000000 -0700
> >@@ -29,14 +29,10 @@
> > #include <linux/slab.h>
> > #include <linux/delay.h>
> > #include <linux/fb.h>
> >-#include <linux/console.h>
> >-#include <linux/selection.h>
> > #include <linux/ioport.h>
> > #include <linux/init.h>
> > #include <linux/pci.h>
> > #include <linux/vmalloc.h>
> >-#include <linux/kd.h>
> >-#include <linux/vt_kern.h>
> > #include <linux/pagemap.h>
> > #include <linux/version.h>
> >=20
> >diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/nvidia/nvid=
ia.c fbdev-2.6/drivers/video/nvidia/nvidia.c
> >--- linus-2.6/drivers/video/nvidia/nvidia.c=092005-06-22 17:09:52.000000=
000 -0700
> >+++ fbdev-2.6/drivers/video/nvidia/nvidia.c=092005-06-24 09:04:13.000000=
000 -0700
> >@@ -1300,6 +1300,7 @@
> > =09    | FBINFO_HWACCEL_IMAGEBLIT
> > =09    | FBINFO_HWACCEL_FILLRECT
> > =09    | FBINFO_HWACCEL_COPYAREA
> >+=09    | FBINFO_HWACCEL_CURSOR
> > =09    | FBINFO_HWACCEL_YPAN;
> >=20
> > =09fb_videomode_to_modelist(info->monspecs.modedb,
> >diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/riva/fbdev.=
c fbdev-2.6/drivers/video/riva/fbdev.c
> >--- linus-2.6/drivers/video/riva/fbdev.c=092005-06-22 17:09:52.000000000=
 -0700
> >+++ fbdev-2.6/drivers/video/riva/fbdev.c=092005-06-24 09:04:13.000000000=
 -0700
> >@@ -1704,7 +1704,8 @@
> > =09=09    | FBINFO_HWACCEL_YPAN
> > =09=09    | FBINFO_HWACCEL_COPYAREA
> > =09=09    | FBINFO_HWACCEL_FILLRECT
> >-=09            | FBINFO_HWACCEL_IMAGEBLIT;
> >+=09            | FBINFO_HWACCEL_IMAGEBLIT
> >+=09=09    | FBINFO_HWACCEL_CURSOR;
> >=20
> > =09/* Accel seems to not work properly on NV30 yet...*/
> > =09if ((par->riva.Architecture =3D=3D NV_ARCH_30) || noaccel) {
> >diff -urN -X /home/jsimmons/dontdiff linus-2.6/include/linux/fb.h fbdev-=
2.6/include/linux/fb.h
> >--- linus-2.6/include/linux/fb.h=092005-06-22 17:09:52.000000000 -0700
> >+++ fbdev-2.6/include/linux/fb.h=092005-06-24 09:04:13.000000000 -0700
> >@@ -702,6 +702,7 @@
> > #define FBINFO_HWACCEL_XPAN=09=090x1000 /* optional */
> > #define FBINFO_HWACCEL_YPAN=09=090x2000 /* optional */
> > #define FBINFO_HWACCEL_YWRAP=09=090x4000 /* optional */
> >+#define FBINFO_HWACCEL_CURSOR=09=090x8000 /* required */
> >=20
> > #define FBINFO_MISC_USEREVENT          0x10000 /* event request
> > =09=09=09=09=09=09  from userspace */
> >
> >
> >-------------------------------------------------------
> >SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
> >from IBM. Find simple to follow Roadmaps, straightforward articles,
> >informative Webcasts and more! Get everything you need to get up to
> >speed, fast. http://ads.osdn.com/?ad_id=3D7477&alloc_id=3D16492&op=3Dcli=
ck
> >_______________________________________________
> >Linux-fbdev-devel mailing list
> >Linux-fbdev-devel@lists.sourceforge.net
> >https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
> >
> > =20
> >
>=20
>=20
>=20
>=20


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
