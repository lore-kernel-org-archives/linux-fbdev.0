From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Date: Sun, 30 May 2010 11:09:45 +0000
Subject: [Patch] HID: Fix PicoLCD to allow it to run fbcon and handle unplug
Message-Id: <20100530130945.5c03797f@neptune.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100509184911.3f136b77@neptune.home>
	<AANLkTik0EkPYKdnhrpF7yK6eXIrHMsNYrzSC6tyeBR0P@mail.gmail.com>
	<20100510080047.5adade6f@pluto.restena.lu>
	<20100526215829.28a4aa47@neptune.home>
In-Reply-To: <20100526215829.28a4aa47@neptune.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Jaya Kumar <jayakumar.lkml@gmail.com>, Jiri Kosina <jkosina@suse.cz>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

This fixes multiple issues related to FB use:
- NULL-pointer dereference if fbcon wants to use our FB on
  8-bpp framebuffer.
- Getting new vmalloc()ed framebuffer on each depth change
  causes pain if the FB was mmap()ed by userspace, so allocate
  biggest FB needed and just convert its content on depth change
  to avoid the issue
- When FB is in use and our device gets unplugged, wait until
  last user stops using FB before we free fb_info and framebuffer
  (via deferred work)

Signed-off-by: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>
---

This should fix all issues I've seen running fbcon and userspace fb
applications on top of picolcd, even when it gets unplugged.

I would appreciate if a second pair of eyes could could review the
locking and releasing of FB resources (I've tested it on UP, currently
no SMP system available for testing)

Thanks,
Bruno



 drivers/hid/hid-picolcd.c |  201 +++++++++++++++++++++++++++++++++++++----=
----
 1 files changed, 167 insertions(+), 34 deletions(-)

diff --git a/drivers/hid/hid-picolcd.c b/drivers/hid/hid-picolcd.c
index 95253b3..1a0dacc 100644
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
@@ -421,6 +439,9 @@ static void picolcd_fb_update(struct picolcd_data *data)
 	int chip, tile, n;
 	unsigned long flags;
=20
+	if (!data)
+		return;
+
 	spin_lock_irqsave(&data->lock, flags);
 	if (!(data->status & PICOLCD_READY_FB)) {
 		spin_unlock_irqrestore(&data->lock, flags);
@@ -440,14 +461,18 @@ static void picolcd_fb_update(struct picolcd_data *da=
ta)
 	for (chip =3D 0; chip < 4; chip++)
 		for (tile =3D 0; tile < 8; tile++)
 			if (picolcd_fb_update_tile(data->fb_vbitmap,
-					data->fb_bitmap, data->fb_bpp, chip, tile)) {
+					data->fb_bitmap, data->fb_bpp, chip, tile) ||
+				data->fb_force) {
 				n +=3D 2;
+				if (!data->fb_info->par)
+					return; /* device lost! */
 				if (n >=3D HID_OUTPUT_FIFO_SIZE / 2) {
 					usbhid_wait_io(data->hdev);
 					n =3D 0;
 				}
 				picolcd_fb_send_tile(data->hdev, chip, tile);
 			}
+	data->fb_force =3D false;
 	if (n)
 		usbhid_wait_io(data->hdev);
 }
@@ -511,11 +536,23 @@ static int picolcd_fb_blank(int blank, struct fb_info=
 *info)
 static void picolcd_fb_destroy(struct fb_info *info)
 {
 	struct picolcd_data *data =3D info->par;
+	u32 *ref_cnt =3D info->pseudo_palette;
+	int may_release;
+
 	info->par =3D NULL;
 	if (data)
 		data->fb_info =3D NULL;
 	fb_deferred_io_cleanup(info);
-	framebuffer_release(info);
+
+	ref_cnt--;
+	mutex_lock(&info->lock);
+	(*ref_cnt)--;
+	may_release =3D !ref_cnt;
+	mutex_unlock(&info->lock);
+	if (may_release) {
+		framebuffer_release(info);
+		vfree((u8 *)info->fix.smem_start);
+	}
 }
=20
 static int picolcd_fb_check_var(struct fb_var_screeninfo *var, struct fb_i=
nfo *info)
@@ -526,29 +563,37 @@ static int picolcd_fb_check_var(struct fb_var_screeni=
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
 static int picolcd_set_par(struct fb_info *info)
 {
 	struct picolcd_data *data =3D info->par;
-	u8 *o_fb, *n_fb;
+	u8 *tmp_fb, *o_fb;
+	if (!data)
+		return -ENODEV;
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
@@ -558,24 +603,87 @@ static int picolcd_set_par(struct fb_info *info)
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
+	return 0;
+}
+
+/* Do refcounting on our FB and cleanup per worker if FB is
+ * closed after unplug of our device
+ * (fb_release holds info->lock and still touches info after
+ *  we return so we can't release it immediately.
+ */
+struct picolcd_fb_cleanup_item {
+	struct fb_info *info;
+	struct picolcd_fb_cleanup_item *next;
+};
+static struct picolcd_fb_cleanup_item *fb_pending;
+DEFINE_SPINLOCK(fb_pending_lock);
+
+static void picolcd_fb_do_cleanup(struct work_struct *data)
+{
+	struct picolcd_fb_cleanup_item *item;
+	unsigned long flags;
+
+	do {
+		spin_lock_irqsave(&fb_pending_lock, flags);
+		item =3D fb_pending;
+		fb_pending =3D item ? item->next : NULL;
+		spin_unlock_irqrestore(&fb_pending_lock, flags);
+
+		if (item) {
+			u8 *fb =3D (u8 *)item->info->fix.smem_start;
+			/* make sure we do not race against fb core when
+			 * releasing */
+			mutex_lock(&item->info->lock);
+			mutex_unlock(&item->info->lock);
+			framebuffer_release(item->info);
+			vfree(fb);
+		}
+	} while (item);
+}
+
+DECLARE_WORK(picolcd_fb_cleanup, picolcd_fb_do_cleanup);
+
+static int picolcd_fb_open(struct fb_info *info, int u)
+{
+	u32 *ref_cnt =3D info->pseudo_palette;
+	ref_cnt--;
+
+	(*ref_cnt)++;
+	return 0;
+}
+
+static int picolcd_fb_release(struct fb_info *info, int u)
+{
+	u32 *ref_cnt =3D info->pseudo_palette;
+	ref_cnt--;
+
+	(*ref_cnt)++;
+	if (!*ref_cnt) {
+		unsigned long flags;
+		struct picolcd_fb_cleanup_item *item =3D (struct picolcd_fb_cleanup_item=
 *)ref_cnt;
+		item--;
+		spin_lock_irqsave(&fb_pending_lock, flags);
+		item->next =3D fb_pending;
+		fb_pending =3D item;
+		spin_unlock_irqrestore(&fb_pending_lock, flags);
+		schedule_work(&picolcd_fb_cleanup);
+	}
 	return 0;
 }
=20
@@ -583,6 +691,8 @@ static int picolcd_set_par(struct fb_info *info)
 static struct fb_ops picolcdfb_ops =3D {
 	.owner        =3D THIS_MODULE,
 	.fb_destroy   =3D picolcd_fb_destroy,
+	.fb_open      =3D picolcd_fb_open,
+	.fb_release   =3D picolcd_fb_release,
 	.fb_read      =3D fb_sys_read,
 	.fb_write     =3D picolcd_fb_write,
 	.fb_blank     =3D picolcd_fb_blank,
@@ -660,11 +770,12 @@ static int picolcd_init_framebuffer(struct picolcd_da=
ta *data)
 {
 	struct device *dev =3D &data->hdev->dev;
 	struct fb_info *info =3D NULL;
-	int error =3D -ENOMEM;
+	int i, error =3D -ENOMEM;
 	u8 *fb_vbitmap =3D NULL;
 	u8 *fb_bitmap  =3D NULL;
+	u32 *palette;
=20
-	fb_bitmap =3D vmalloc(PICOLCDFB_SIZE*picolcdfb_var.bits_per_pixel);
+	fb_bitmap =3D vmalloc(PICOLCDFB_SIZE*8);
 	if (fb_bitmap =3D NULL) {
 		dev_err(dev, "can't get a free page for framebuffer\n");
 		goto err_nomem;
@@ -678,18 +789,29 @@ static int picolcd_init_framebuffer(struct picolcd_da=
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
+	info =3D framebuffer_alloc(257 * sizeof(u32) + sizeof(struct picolcd_fb_c=
leanup_item), dev);
 	if (info =3D NULL) {
 		dev_err(dev, "failed to allocate a framebuffer\n");
 		goto err_nomem;
 	}
=20
+	palette  =3D info->par + sizeof(struct picolcd_fb_cleanup_item);
+	*palette =3D 1;
+	palette++;
+	for (i =3D 0; i < 256; i++)
+		palette[i] =3D i > 0 && i < 16 ? 0xff : 0;
+	info->pseudo_palette =3D palette;
 	info->fbdefio =3D &data->fb_defio;
 	info->screen_base =3D (char __force __iomem *)fb_bitmap;
 	info->fbops =3D &picolcdfb_ops;
 	info->var =3D picolcdfb_var;
 	info->fix =3D picolcdfb_fix;
-	info->fix.smem_len   =3D PICOLCDFB_SIZE;
+	info->fix.smem_len   =3D PICOLCDFB_SIZE*8;
 	info->fix.smem_start =3D (unsigned long)fb_bitmap;
 	info->par =3D data;
 	info->flags =3D FBINFO_FLAG_DEFAULT;
@@ -707,18 +829,20 @@ static int picolcd_init_framebuffer(struct picolcd_da=
ta *data)
 		dev_err(dev, "failed to create sysfs attributes\n");
 		goto err_cleanup;
 	}
+	fb_deferred_io_init(info);
 	data->fb_info    =3D info;
 	error =3D register_framebuffer(info);
 	if (error) {
 		dev_err(dev, "failed to register framebuffer\n");
 		goto err_sysfs;
 	}
-	fb_deferred_io_init(info);
 	/* schedule first output of framebuffer */
+	data->fb_force =3D 1;
 	schedule_delayed_work(&info->deferred_work, 0);
 	return 0;
=20
 err_sysfs:
+	fb_deferred_io_cleanup(info);
 	device_remove_file(dev, &dev_attr_fb_update_rate);
 err_cleanup:
 	data->fb_vbitmap =3D NULL;
@@ -728,8 +852,8 @@ err_cleanup:
=20
 err_nomem:
 	framebuffer_release(info);
-	vfree(fb_bitmap);
 	kfree(fb_vbitmap);
+	vfree(fb_bitmap);
 	return error;
 }
=20
@@ -737,19 +861,17 @@ static void picolcd_exit_framebuffer(struct picolcd_d=
ata *data)
 {
 	struct fb_info *info =3D data->fb_info;
 	u8 *fb_vbitmap =3D data->fb_vbitmap;
-	u8 *fb_bitmap  =3D data->fb_bitmap;
=20
 	if (!info)
 		return;
=20
+	info->par =3D NULL;
+	device_remove_file(&data->hdev->dev, &dev_attr_fb_update_rate);
+	unregister_framebuffer(info);
 	data->fb_vbitmap =3D NULL;
 	data->fb_bitmap  =3D NULL;
 	data->fb_bpp     =3D 0;
 	data->fb_info    =3D NULL;
-	device_remove_file(&data->hdev->dev, &dev_attr_fb_update_rate);
-	fb_deferred_io_cleanup(info);
-	unregister_framebuffer(info);
-	vfree(fb_bitmap);
 	kfree(fb_vbitmap);
 }
=20
@@ -2566,6 +2688,13 @@ static void picolcd_remove(struct hid_device *hdev)
 	spin_lock_irqsave(&data->lock, flags);
 	data->status |=3D PICOLCD_FAILED;
 	spin_unlock_irqrestore(&data->lock, flags);
+#ifdef CONFIG_HID_PICOLCD_FB
+	/* short-circuit FB as early as possible in order to
+	 * avoid long delays if we host console.
+	 */
+	if (data->fb_info)
+		data->fb_info->par =3D NULL;
+#endif
=20
 	picolcd_exit_devfs(data);
 	device_remove_file(&hdev->dev, &dev_attr_operation_mode);
@@ -2623,6 +2752,10 @@ static int __init picolcd_init(void)
 static void __exit picolcd_exit(void)
 {
 	hid_unregister_driver(&picolcd_driver);
+#ifdef CONFIG_HID_PICOLCD_FB
+	flush_scheduled_work();
+	WARN_ON(fb_pending);
+#endif
 }
=20
 module_init(picolcd_init);
--=20
1.6.4.4

