From: Sylvain Meyer <sylvain.meyer@worldonline.fr>
Subject: Re: PATCH: move soft_cursor into fbconsole
Date: Sat, 02 Jul 2005 01:52:25 +0200
Message-ID: <42C5D739.4050205@worldonline.fr>
References: <9e47339105061021571f479b10@mail.gmail.com>  <200506161111.27115.adaplas@hotpop.com>  <9e4733910506152037193300fa@mail.gmail.com>  <Pine.LNX.4.56.0506210103540.18685@pentafluge.infradead.org>  <9e473391050620173132ea1ce6@mail.gmail.com>  <Pine.LNX.4.56.0506240015300.24330@pentafluge.infradead.org>  <9e473391050624052640aa5279@mail.gmail.com>  <Pine.LNX.4.56.0506241713210.14981@pentafluge.infradead.org>  <9e47339105062409276fcd5223@mail.gmail.com>  <Pine.LNX.4.56.0506241740220.15430@pentafluge.infradead.org> <9e473391050624102559929cd9@mail.gmail.com> <Pine.LNX.4.56.0507020030120.14405@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DoVLB-00008I-27
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 01 Jul 2005 16:54:37 -0700
Received: from smtp4.wanadoo.fr ([193.252.22.27])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DoVL9-00072c-J9
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 01 Jul 2005 16:54:36 -0700
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf0401.wanadoo.fr (SMTP Server) with ESMTP id C3EBD1C002FB
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat,  2 Jul 2005 01:54:28 +0200 (CEST)
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
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Jon Smirl <jonsmirl@gmail.com>, James Simmons <jsimmons@pentafluge.infradead.org>, adaplas@pol.net

        James,

    In the intelfb driver, the hw cursor is decoupled from the graphic=20
hw acceleration. So, this code is incorrect

@@ -1328,9 +1317,10 @@
 	if (ACCEL(dinfo, info)) {
 		info->flags =3D FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN |
 		FBINFO_HWACCEL_COPYAREA | FBINFO_HWACCEL_FILLRECT |
-		FBINFO_HWACCEL_IMAGEBLIT;
+		FBINFO_HWACCEL_IMAGEBLIT | FBINFO_HWACCEL_CURSOR;
 	} else {
-		info->flags =3D FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN;
+		info->flags =3D FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN |=20
+		FBINFO_HWACCEL_CURSOR;
 	}
 	kfree(hw);
 	return 0;

should be something like this. I can come with a good patch if you want=20
(now it's just a mail hack)

 	if (ACCEL(dinfo, info)) {
 		info->flags =3D FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN |
 		FBINFO_HWACCEL_COPYAREA | FBINFO_HWACCEL_FILLRECT |
		FBINFO_HWACCEL_IMAGEBLIT;
 	} else {
		info->flags =3D FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN;
 	}
+       if (dinfo->hwcursor)
+               info->flags |=3D FBINFO_HWACCEL_CURSOR;

Regards
Sylvain

James Simmons a =E9crit:

>>Why are you trying to preserve all of the ".fb_cursor =3D soft_cursor,"
>>assignments in the drivers? What purpose do they serve that can't be
>>handled by a simple test like this:
>>
>>Then any in-kernel user does this:
>>      /* First try the hardware cursor */
>>      if (info->fbops->fb_cursor)
>>              err =3D info->fbops->fb_cursor(info, &cursor);
>>      /* if that doesn't exist or didn't work, use the software one */
>>      if (err)
>>              soft_cursor(info, &cursor);
>>   =20
>>
>
>I don't want to make a patch that touches all the drivers. Th epatch I=20
>posted is a nice simple patch. If there are no other arguments against i=
t=20
>I like to submit it to Andrew.
>
>diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/aty/mach64_=
cursor.c fbdev-2.6/drivers/video/aty/mach64_cursor.c
>--- linus-2.6/drivers/video/aty/mach64_cursor.c	2005-05-10 08:39:33.0000=
00000 -0700
>+++ fbdev-2.6/drivers/video/aty/mach64_cursor.c	2005-06-24 09:04:12.0000=
00000 -0700
>@@ -219,8 +219,8 @@
> 	info->sprite.buf_align =3D 16; 	/* and 64 lines tall. */
> 	info->sprite.flags =3D FB_PIXMAP_IO;
>=20
>+	info->flags |=3D FBINFO_HWACCEL_CURSOR;
> 	info->fbops->fb_cursor =3D atyfb_cursor;
>-
> 	return 0;
> }
>=20
>diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/fbsysfs.c f=
bdev-2.6/drivers/video/fbsysfs.c
>--- linus-2.6/drivers/video/fbsysfs.c	2005-06-14 11:51:24.000000000 -070=
0
>+++ fbdev-2.6/drivers/video/fbsysfs.c	2005-06-24 09:46:33.000000000 -070=
0
>@@ -311,13 +311,19 @@
> static ssize_t store_cursor(struct class_device *class_device,
> 			    const char * buf, size_t count)
> {
>-//	struct fb_info *fb_info =3D (struct fb_info *)class_get_devdata(clas=
s_device);
>+	struct fb_info *fb_info =3D (struct fb_info *)class_get_devdata(class_=
device);
>+
>+	if (!(fb_info->flags & FBINFO_HWACCEL_CURSOR))
>+		return -ENXIO;
> 	return 0;
> }
>=20
> static ssize_t show_cursor(struct class_device *class_device, char *buf=
)
> {
>-//	struct fb_info *fb_info =3D (struct fb_info *)class_get_devdata(clas=
s_device);
>+	struct fb_info *fb_info =3D (struct fb_info *)class_get_devdata(class_=
device);
>+
>+	if (!(fb_info->flags & FBINFO_HWACCEL_CURSOR))
>+		return -ENXIO;
> 	return 0;
> }
>=20
>diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/i810/i810.h=
 fbdev-2.6/drivers/video/i810/i810.h
>--- linus-2.6/drivers/video/i810/i810.h	2005-05-10 08:39:33.000000000 -0=
700
>+++ fbdev-2.6/drivers/video/i810/i810.h	2005-06-24 09:04:12.000000000 -0=
700
>@@ -201,7 +201,6 @@
> #define HAS_ACCELERATION            2
> #define ALWAYS_SYNC                 4
> #define LOCKUP                      8
>-#define USE_HWCUR                  16
>=20
> struct gtt_data {
> 	struct agp_memory *i810_fb_memory;
>diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/i810/i810_m=
ain.c fbdev-2.6/drivers/video/i810/i810_main.c
>--- linus-2.6/drivers/video/i810/i810_main.c	2005-06-22 17:09:52.0000000=
00 -0700
>+++ fbdev-2.6/drivers/video/i810/i810_main.c	2005-06-24 09:04:12.0000000=
00 -0700
>@@ -1375,7 +1375,6 @@
> 	decode_var(&info->var, par);
> 	i810_load_regs(par);
> 	i810_init_cursor(par);
>-
> 	encode_fix(&info->fix, info);
>=20
> 	if (info->var.accel_flags && !(par->dev_flags & LOCKUP)) {
>@@ -1387,6 +1386,7 @@
> 		info->pixmap.scan_align =3D 1;
> 		info->flags =3D FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN;
> 	}
>+	info->flags |=3D FBINFO_HWACCEL_CURSOR;
> 	return 0;
> }
>=20
>@@ -1418,9 +1418,8 @@
> 	struct i810fb_par *par =3D (struct i810fb_par *)info->par;
> 	u8 __iomem *mmio =3D par->mmio_start_virtual;
>=20
>-	if (!(par->dev_flags & USE_HWCUR) || !info->var.accel_flags ||
>-	    par->dev_flags & LOCKUP)
>-		return soft_cursor(info, cursor);
>+	if (!par->dev_flags & LOCKUP)
>+		return -ENXIO;
>=20
> 	if (cursor->image.width > 64 || cursor->image.height > 64)
> 		return -ENXIO;
>diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/intelfb/int=
elfbdrv.c fbdev-2.6/drivers/video/intelfb/intelfbdrv.c
>--- linus-2.6/drivers/video/intelfb/intelfbdrv.c	2005-06-22 17:09:52.000=
000000 -0700
>+++ fbdev-2.6/drivers/video/intelfb/intelfbdrv.c	2005-06-24 09:04:12.000=
000000 -0700
>@@ -117,14 +117,10 @@
> #include <linux/slab.h>
> #include <linux/delay.h>
> #include <linux/fb.h>
>-#include <linux/console.h>
>-#include <linux/selection.h>
> #include <linux/ioport.h>
> #include <linux/init.h>
> #include <linux/pci.h>
> #include <linux/vmalloc.h>
>-#include <linux/kd.h>
>-#include <linux/vt_kern.h>
> #include <linux/pagemap.h>
> #include <linux/version.h>
>=20
>@@ -242,7 +238,7 @@
> static char *mode       =3D NULL;
>=20
> module_param(accel, bool, S_IRUGO);
>-MODULE_PARM_DESC(accel, "Enable console acceleration");
>+MODULE_PARM_DESC(accel, "Enable hardware acceleration");
> module_param(vram, int, S_IRUGO);
> MODULE_PARM_DESC(vram, "System RAM to allocate to framebuffer in MiB");
> module_param(voffset, int, S_IRUGO);
>@@ -498,7 +494,7 @@
> {
> 	struct fb_info *info;
> 	struct intelfb_info *dinfo;
>-	int i, j, err, dvo;
>+	int i, err, dvo;
> 	int aperture_size, stolen_size;
> 	struct agp_kern_info gtt_info;
> 	int agp_memtype;
>@@ -841,13 +837,6 @@
> 	if (bailearly =3D=3D 5)
> 		bailout(dinfo);
>=20
>-	for (i =3D 0; i < 16; i++) {
>-		j =3D color_table[i];
>-		dinfo->palette[i].red =3D default_red[j];
>-		dinfo->palette[i].green =3D default_grn[j];
>-		dinfo->palette[i].blue =3D default_blu[j];
>-	}
>-
> 	if (bailearly =3D=3D 6)
> 		bailout(dinfo);
>=20
>@@ -1328,9 +1317,10 @@
> 	if (ACCEL(dinfo, info)) {
> 		info->flags =3D FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN |
> 		FBINFO_HWACCEL_COPYAREA | FBINFO_HWACCEL_FILLRECT |
>-		FBINFO_HWACCEL_IMAGEBLIT;
>+		FBINFO_HWACCEL_IMAGEBLIT | FBINFO_HWACCEL_CURSOR;
> 	} else {
>-		info->flags =3D FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN;
>+		info->flags =3D FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN |=20
>+		FBINFO_HWACCEL_CURSOR;
> 	}
> 	kfree(hw);
> 	return 0;
>@@ -1359,10 +1349,6 @@
> 			green >>=3D 8;
> 			blue >>=3D 8;
>=20
>-			dinfo->palette[regno].red =3D red;
>-			dinfo->palette[regno].green =3D green;
>-			dinfo->palette[regno].blue =3D blue;
>-
> 			intelfbhw_setcolreg(dinfo, regno, red, green, blue,
> 					    transp);
> 		}
>diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/intelfb/int=
elfb.h fbdev-2.6/drivers/video/intelfb/intelfb.h
>--- linus-2.6/drivers/video/intelfb/intelfb.h	2005-05-10 08:39:33.000000=
000 -0700
>+++ fbdev-2.6/drivers/video/intelfb/intelfb.h	2005-06-24 09:04:12.000000=
000 -0700
>@@ -234,7 +234,6 @@
>=20
> 	/* palette */
> 	u32 pseudo_palette[17];
>-	struct { u8 red, green, blue, pad; } palette[256];
>=20
> 	/* chip info */
> 	int pci_chipset;
>diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/intelfb/int=
elfbhw.c fbdev-2.6/drivers/video/intelfb/intelfbhw.c
>--- linus-2.6/drivers/video/intelfb/intelfbhw.c	2005-05-10 08:39:33.0000=
00000 -0700
>+++ fbdev-2.6/drivers/video/intelfb/intelfbhw.c	2005-06-24 09:04:13.0000=
00000 -0700
>@@ -29,14 +29,10 @@
> #include <linux/slab.h>
> #include <linux/delay.h>
> #include <linux/fb.h>
>-#include <linux/console.h>
>-#include <linux/selection.h>
> #include <linux/ioport.h>
> #include <linux/init.h>
> #include <linux/pci.h>
> #include <linux/vmalloc.h>
>-#include <linux/kd.h>
>-#include <linux/vt_kern.h>
> #include <linux/pagemap.h>
> #include <linux/version.h>
>=20
>diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/nvidia/nvid=
ia.c fbdev-2.6/drivers/video/nvidia/nvidia.c
>--- linus-2.6/drivers/video/nvidia/nvidia.c	2005-06-22 17:09:52.00000000=
0 -0700
>+++ fbdev-2.6/drivers/video/nvidia/nvidia.c	2005-06-24 09:04:13.00000000=
0 -0700
>@@ -1300,6 +1300,7 @@
> 	    | FBINFO_HWACCEL_IMAGEBLIT
> 	    | FBINFO_HWACCEL_FILLRECT
> 	    | FBINFO_HWACCEL_COPYAREA
>+	    | FBINFO_HWACCEL_CURSOR
> 	    | FBINFO_HWACCEL_YPAN;
>=20
> 	fb_videomode_to_modelist(info->monspecs.modedb,
>diff -urN -X /home/jsimmons/dontdiff linus-2.6/drivers/video/riva/fbdev.=
c fbdev-2.6/drivers/video/riva/fbdev.c
>--- linus-2.6/drivers/video/riva/fbdev.c	2005-06-22 17:09:52.000000000 -=
0700
>+++ fbdev-2.6/drivers/video/riva/fbdev.c	2005-06-24 09:04:13.000000000 -=
0700
>@@ -1704,7 +1704,8 @@
> 		    | FBINFO_HWACCEL_YPAN
> 		    | FBINFO_HWACCEL_COPYAREA
> 		    | FBINFO_HWACCEL_FILLRECT
>-	            | FBINFO_HWACCEL_IMAGEBLIT;
>+	            | FBINFO_HWACCEL_IMAGEBLIT
>+		    | FBINFO_HWACCEL_CURSOR;
>=20
> 	/* Accel seems to not work properly on NV30 yet...*/
> 	if ((par->riva.Architecture =3D=3D NV_ARCH_30) || noaccel) {
>diff -urN -X /home/jsimmons/dontdiff linus-2.6/include/linux/fb.h fbdev-=
2.6/include/linux/fb.h
>--- linus-2.6/include/linux/fb.h	2005-06-22 17:09:52.000000000 -0700
>+++ fbdev-2.6/include/linux/fb.h	2005-06-24 09:04:13.000000000 -0700
>@@ -702,6 +702,7 @@
> #define FBINFO_HWACCEL_XPAN		0x1000 /* optional */
> #define FBINFO_HWACCEL_YPAN		0x2000 /* optional */
> #define FBINFO_HWACCEL_YWRAP		0x4000 /* optional */
>+#define FBINFO_HWACCEL_CURSOR		0x8000 /* required */
>=20
> #define FBINFO_MISC_USEREVENT          0x10000 /* event request
> 						  from userspace */
>
>
>-------------------------------------------------------
>SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
>from IBM. Find simple to follow Roadmaps, straightforward articles,
>informative Webcasts and more! Get everything you need to get up to
>speed, fast. http://ads.osdn.com/?ad_id=3D7477&alloc_id=3D16492&op=3Dcli=
ck
>_______________________________________________
>Linux-fbdev-devel mailing list
>Linux-fbdev-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
>
> =20
>





-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
