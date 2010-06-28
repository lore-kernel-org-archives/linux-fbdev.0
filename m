From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Date: Mon, 28 Jun 2010 20:31:20 +0000
Subject: [PATCH 3/4] HID: picolcd: do not reallocate memory on depth change
Message-Id: <20100628223120.4d334f95@neptune.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100509184911.3f136b77@neptune.home>
	<AANLkTik0EkPYKdnhrpF7yK6eXIrHMsNYrzSC6tyeBR0P@mail.gmail.com>
	<20100510080047.5adade6f@pluto.restena.lu>
	<20100526215829.28a4aa47@neptune.home>
	<20100530130945.5c03797f@neptune.home>
	<20100623123225.4c16e653@neptune.home>
	<alpine.LNX.2.00.1006241053360.13809@pobox.suse.cz>
	<20100628222641.489c955a@neptune.home>
In-Reply-To: <20100628222641.489c955a@neptune.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Jiri Kosina <jkosina@suse.cz>
Cc: Jaya Kumar <jayakumar.lkml@gmail.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Reallocating memory in depth change does not work well if some
userspace application has mmapped() the framebuffer as that mapping
does not get adjusted (thus application continues to write to old
buffer).
In addition doing deferred_io_cleanup() and init() inside of set_par()
tends to deadlock with fbcon's flashing cursor.

Avoid all this by allocating a buffer that can hold 8bpp framebuffer
and just use 1/8 of it while running at 1bpp.

Signed-off-by: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>
---
 drivers/hid/hid-picolcd.c |   27 ++++++++++++---------------
 1 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/hid/hid-picolcd.c b/drivers/hid/hid-picolcd.c
index ac7aece..31a0abd 100644
--- a/drivers/hid/hid-picolcd.c
+++ b/drivers/hid/hid-picolcd.c
@@ -563,19 +563,18 @@ static int picolcd_fb_check_var(struct fb_var_screeni=
nfo *var, struct fb_info *i
 static int picolcd_set_par(struct fb_info *info)
 {
 	struct picolcd_data *data =3D info->par;
-	u8 *o_fb, *n_fb;
+	u8 *tmp_fb, *o_fb;
 	if (info->var.bits_per_pixel =3D data->fb_bpp)
 		return 0;
 	/* switch between 1/8 bit depths */
 	if (info->var.bits_per_pixel !=3D 1 && info->var.bits_per_pixel !=3D 8)
 		return -EINVAL;
=20
-	o_fb =3D data->fb_bitmap;
-	n_fb =3D vmalloc(PICOLCDFB_SIZE*info->var.bits_per_pixel);
-	if (!n_fb)
+	o_fb   =3D data->fb_bitmap;
+	tmp_fb =3D kmalloc(PICOLCDFB_SIZE*info->var.bits_per_pixel, GFP_KERNEL);
+	if (!tmp_fb)
 		return -ENOMEM;
=20
-	fb_deferred_io_cleanup(info);
 	/* translate FB content to new bits-per-pixel */
 	if (info->var.bits_per_pixel =3D 1) {
 		int i, b;
@@ -585,24 +584,22 @@ static int picolcd_set_par(struct fb_info *info)
 				p <<=3D 1;
 				p |=3D o_fb[i*8+b] ? 0x01 : 0x00;
 			}
+			tmp_fb[i] =3D p;
 		}
+		memcpy(o_fb, tmp_fb, PICOLCDFB_SIZE);
 		info->fix.visual =3D FB_VISUAL_MONO01;
 		info->fix.line_length =3D PICOLCDFB_WIDTH / 8;
 	} else {
 		int i;
+		memcpy(tmp_fb, o_fb, PICOLCDFB_SIZE);
 		for (i =3D 0; i < PICOLCDFB_SIZE * 8; i++)
-			n_fb[i] =3D o_fb[i/8] & (0x01 << (7 - i % 8)) ? 0xff : 0x00;
-		info->fix.visual =3D FB_VISUAL_TRUECOLOR;
+			o_fb[i] =3D tmp_fb[i/8] & (0x01 << (7 - i % 8)) ? 0xff : 0x00;
+		info->fix.visual =3D FB_VISUAL_DIRECTCOLOR;
 		info->fix.line_length =3D PICOLCDFB_WIDTH;
 	}
=20
-	data->fb_bitmap   =3D n_fb;
+	kfree(tmp_fb);
 	data->fb_bpp      =3D info->var.bits_per_pixel;
-	info->screen_base =3D (char __force __iomem *)n_fb;
-	info->fix.smem_start =3D (unsigned long)n_fb;
-	info->fix.smem_len   =3D PICOLCDFB_SIZE*data->fb_bpp;
-	fb_deferred_io_init(info);
-	vfree(o_fb);
 	return 0;
 }
=20
@@ -692,7 +689,7 @@ static int picolcd_init_framebuffer(struct picolcd_data=
 *data)
 	u8 *fb_bitmap  =3D NULL;
 	u32 *palette;
=20
-	fb_bitmap =3D vmalloc(PICOLCDFB_SIZE*picolcdfb_var.bits_per_pixel);
+	fb_bitmap =3D vmalloc(PICOLCDFB_SIZE*8);
 	if (fb_bitmap =3D NULL) {
 		dev_err(dev, "can't get a free page for framebuffer\n");
 		goto err_nomem;
@@ -728,7 +725,7 @@ static int picolcd_init_framebuffer(struct picolcd_data=
 *data)
 	info->fbops =3D &picolcdfb_ops;
 	info->var =3D picolcdfb_var;
 	info->fix =3D picolcdfb_fix;
-	info->fix.smem_len   =3D PICOLCDFB_SIZE;
+	info->fix.smem_len   =3D PICOLCDFB_SIZE*8;
 	info->fix.smem_start =3D (unsigned long)fb_bitmap;
 	info->par =3D data;
 	info->flags =3D FBINFO_FLAG_DEFAULT;
--=20
1.7.1

