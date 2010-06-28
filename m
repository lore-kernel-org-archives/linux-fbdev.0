From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Date: Mon, 28 Jun 2010 20:30:29 +0000
Subject: [PATCH 2/4] HID: picolcd: Add minimal palette required by fbcon on
Message-Id: <20100628223029.4f4e5b8e@neptune.home>
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

Add a minimal palette so fbcon does not try to dereference
a NULL point when fb is set to 8bpp.

fbcon stores pixels the other way around in bytes for 1bpp
than intially implemented, correct this.

Signed-off-by: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>
---
 drivers/hid/hid-picolcd.c |   62 +++++++++++++++++++++++++++++++++++++----=
----
 1 files changed, 51 insertions(+), 11 deletions(-)

diff --git a/drivers/hid/hid-picolcd.c b/drivers/hid/hid-picolcd.c
index 883d720..ac7aece 100644
--- a/drivers/hid/hid-picolcd.c
+++ b/drivers/hid/hid-picolcd.c
@@ -127,6 +127,26 @@ static const struct fb_var_screeninfo picolcdfb_var =
=3D {
 	.height         =3D 26,
 	.bits_per_pixel =3D 1,
 	.grayscale      =3D 1,
+	.red            =3D {
+		.offset =3D 0,
+		.length =3D 1,
+		.msb_right =3D 0,
+	},
+	.green          =3D {
+		.offset =3D 0,
+		.length =3D 1,
+		.msb_right =3D 0,
+	},
+	.blue           =3D {
+		.offset =3D 0,
+		.length =3D 1,
+		.msb_right =3D 0,
+	},
+	.transp         =3D {
+		.offset =3D 0,
+		.length =3D 0,
+		.msb_right =3D 0,
+	},
 };
 #endif /* CONFIG_HID_PICOLCD_FB */
=20
@@ -188,6 +208,7 @@ struct picolcd_data {
 	/* Framebuffer stuff */
 	u8 fb_update_rate;
 	u8 fb_bpp;
+	u8 fb_force;
 	u8 *fb_vbitmap;		/* local copy of what was sent to PicoLCD */
 	u8 *fb_bitmap;		/* framebuffer */
 	struct fb_info *fb_info;
@@ -346,7 +367,7 @@ static int picolcd_fb_update_tile(u8 *vbitmap, const u8=
 *bitmap, int bpp,
 			const u8 *bdata =3D bitmap + tile * 256 + chip * 8 + b * 32;
 			for (i =3D 0; i < 64; i++) {
 				tdata[i] <<=3D 1;
-				tdata[i] |=3D (bdata[i/8] >> (7 - i % 8)) & 0x01;
+				tdata[i] |=3D (bdata[i/8] >> (i % 8)) & 0x01;
 			}
 		}
 	} else if (bpp =3D 8) {
@@ -399,13 +420,10 @@ static int picolcd_fb_reset(struct picolcd_data *data=
, int clear)
=20
 	if (data->fb_bitmap) {
 		if (clear) {
-			memset(data->fb_vbitmap, 0xff, PICOLCDFB_SIZE);
+			memset(data->fb_vbitmap, 0, PICOLCDFB_SIZE);
 			memset(data->fb_bitmap, 0, PICOLCDFB_SIZE*data->fb_bpp);
-		} else {
-			/* invert 1 byte in each tile to force resend */
-			for (i =3D 0; i < PICOLCDFB_SIZE; i +=3D 64)
-				data->fb_vbitmap[i] =3D ~data->fb_vbitmap[i];
 		}
+		data->fb_force =3D 1;
 	}
=20
 	/* schedule first output of framebuffer */
@@ -440,7 +458,8 @@ static void picolcd_fb_update(struct picolcd_data *data)
 	for (chip =3D 0; chip < 4; chip++)
 		for (tile =3D 0; tile < 8; tile++)
 			if (picolcd_fb_update_tile(data->fb_vbitmap,
-					data->fb_bitmap, data->fb_bpp, chip, tile)) {
+					data->fb_bitmap, data->fb_bpp, chip, tile) ||
+				data->fb_force) {
 				n +=3D 2;
 				if (n >=3D HID_OUTPUT_FIFO_SIZE / 2) {
 					usbhid_wait_io(data->hdev);
@@ -448,6 +467,7 @@ static void picolcd_fb_update(struct picolcd_data *data)
 				}
 				picolcd_fb_send_tile(data->hdev, chip, tile);
 			}
+	data->fb_force =3D false;
 	if (n)
 		usbhid_wait_io(data->hdev);
 }
@@ -526,10 +546,17 @@ static int picolcd_fb_check_var(struct fb_var_screeni=
nfo *var, struct fb_info *i
 	/* only allow 1/8 bit depth (8-bit is grayscale) */
 	*var =3D picolcdfb_var;
 	var->activate =3D activate;
-	if (bpp >=3D 8)
+	if (bpp >=3D 8) {
 		var->bits_per_pixel =3D 8;
-	else
+		var->red.length     =3D 8;
+		var->green.length   =3D 8;
+		var->blue.length    =3D 8;
+	} else {
 		var->bits_per_pixel =3D 1;
+		var->red.length     =3D 1;
+		var->green.length   =3D 1;
+		var->blue.length    =3D 1;
+	}
 	return 0;
 }
=20
@@ -660,9 +687,10 @@ static int picolcd_init_framebuffer(struct picolcd_dat=
a *data)
 {
 	struct device *dev =3D &data->hdev->dev;
 	struct fb_info *info =3D NULL;
-	int error =3D -ENOMEM;
+	int i, error =3D -ENOMEM;
 	u8 *fb_vbitmap =3D NULL;
 	u8 *fb_bitmap  =3D NULL;
+	u32 *palette;
=20
 	fb_bitmap =3D vmalloc(PICOLCDFB_SIZE*picolcdfb_var.bits_per_pixel);
 	if (fb_bitmap =3D NULL) {
@@ -678,12 +706,23 @@ static int picolcd_init_framebuffer(struct picolcd_da=
ta *data)
=20
 	data->fb_update_rate =3D PICOLCDFB_UPDATE_RATE_DEFAULT;
 	data->fb_defio =3D picolcd_fb_defio;
-	info =3D framebuffer_alloc(0, dev);
+	/* The extra memory is:
+	 * - struct picolcd_fb_cleanup_item
+	 * - u32 for ref_count
+	 * - 256*u32 for pseudo_palette
+	 */
+	info =3D framebuffer_alloc(257 * sizeof(u32), dev);
 	if (info =3D NULL) {
 		dev_err(dev, "failed to allocate a framebuffer\n");
 		goto err_nomem;
 	}
=20
+	palette  =3D info->par;
+	*palette =3D 1;
+	palette++;
+	for (i =3D 0; i < 256; i++)
+		palette[i] =3D i > 0 && i < 16 ? 0xff : 0;
+	info->pseudo_palette =3D palette;
 	info->fbdefio =3D &data->fb_defio;
 	info->screen_base =3D (char __force __iomem *)fb_bitmap;
 	info->fbops =3D &picolcdfb_ops;
@@ -715,6 +754,7 @@ static int picolcd_init_framebuffer(struct picolcd_data=
 *data)
 		goto err_sysfs;
 	}
 	/* schedule first output of framebuffer */
+	data->fb_force =3D 1;
 	schedule_delayed_work(&info->deferred_work, 0);
 	return 0;
=20
--=20
1.7.1

