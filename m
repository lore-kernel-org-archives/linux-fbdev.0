From: Mikulas Patocka <mpatocka@redhat.com>
Date: Sun, 03 Jun 2018 14:41:11 +0000
Subject: [PATCH 18/21] udlfb: allow reallocating the framebuffer
Message-Id: <20180603144225.463043082@twibright.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180603144053.875668929@twibright.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mikulas Patocka <mpatocka@redhat.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dave Airlie <airlied@redhat.com>, Bernie Thompson <bernie@plugable.com>, Ladislav Michl <ladis@linux-mips.org>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

This patch changes udlfb so that it may reallocate the framebuffer when
setting higher-resolution mode. If we boot the system without monitor
attached, udlfb creates a framebuffer with the size 800x600. This patch
makes it possible to select higher videomode with the fbset command when
a monitor is attached.

Note that there is no reliable way to prevent the system from touching the
old framebuffer, so we must not free it. We add it to the list
dlfb->deferred_free and free it when the driver is unloaded.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 drivers/video/fbdev/udlfb.c |   70 +++++++++++++++++++++++++++++---------------
 include/video/udlfb.h       |    1 
 2 files changed, 48 insertions(+), 23 deletions(-)

Index: linux-4.17-rc7/drivers/video/fbdev/udlfb.c
=================================--- linux-4.17-rc7.orig/drivers/video/fbdev/udlfb.c	2018-06-03 13:17:41.000000000 +0200
+++ linux-4.17-rc7/drivers/video/fbdev/udlfb.c	2018-06-03 13:17:41.000000000 +0200
@@ -73,6 +73,13 @@ static bool fb_defio = 1;  /* Detect mma
 static bool shadow = 1; /* Optionally disable shadow framebuffer */
 static int pixel_limit; /* Optionally force a pixel resolution limit */
 
+struct dlfb_deferred_free {
+	struct list_head list;
+	void *mem;
+};
+
+static int dlfb_realloc_framebuffer(struct dlfb_data *dlfb, struct fb_info *info, u32 new_len);
+
 /* dlfb keeps a list of urbs for efficient bulk transfers */
 static void dlfb_urb_completion(struct urb *urb);
 static struct urb *dlfb_get_urb(struct dlfb_data *dlfb);
@@ -927,6 +934,12 @@ static void dlfb_free(struct kref *kref)
 {
 	struct dlfb_data *dlfb = container_of(kref, struct dlfb_data, kref);
 
+	while (!list_empty(&dlfb->deferred_free)) {
+		struct dlfb_deferred_free *d = list_entry(dlfb->deferred_free.next, struct dlfb_deferred_free, list);
+		list_del(&d->list);
+		vfree(d->mem);
+		kfree(d);
+	}
 	vfree(dlfb->backing_buffer);
 	kfree(dlfb->edid);
 	kfree(dlfb);
@@ -1020,10 +1033,6 @@ static int dlfb_ops_check_var(struct fb_
 	struct fb_videomode mode;
 	struct dlfb_data *dlfb = info->par;
 
-	/* TODO: support dynamically changing framebuffer size */
-	if ((var->xres * var->yres * 2) > info->fix.smem_len)
-		return -EINVAL;
-
 	/* set device-specific elements of var unrelated to mode */
 	dlfb_var_color_format(var);
 
@@ -1042,6 +1051,7 @@ static int dlfb_ops_set_par(struct fb_in
 	u16 *pix_framebuffer;
 	int i;
 	struct fb_var_screeninfo fvs;
+	u32 line_length = info->var.xres * (info->var.bits_per_pixel / 8);
 
 	/* clear the activate field because it causes spurious miscompares */
 	fvs = info->var;
@@ -1051,13 +1061,17 @@ static int dlfb_ops_set_par(struct fb_in
 	if (!memcmp(&dlfb->current_mode, &fvs, sizeof(struct fb_var_screeninfo)))
 		return 0;
 
+	result = dlfb_realloc_framebuffer(dlfb, info, info->var.yres * line_length);
+	if (result)
+		return result;
+
 	result = dlfb_set_video_mode(dlfb, &info->var);
 
 	if (result)
 		return result;
 
 	dlfb->current_mode = fvs;
-	info->fix.line_length = info->var.xres * (info->var.bits_per_pixel / 8);
+	info->fix.line_length = line_length;
 
 	if (dlfb->fb_count = 0) {
 
@@ -1066,11 +1080,11 @@ static int dlfb_ops_set_par(struct fb_in
 		pix_framebuffer = (u16 *) info->screen_base;
 		for (i = 0; i < info->fix.smem_len / 2; i++)
 			pix_framebuffer[i] = 0x37e6;
-
-		dlfb_handle_damage(dlfb, 0, 0, info->var.xres, info->var.yres,
-				   info->screen_base);
 	}
 
+	dlfb_handle_damage(dlfb, 0, 0, info->var.xres, info->var.yres,
+			   info->screen_base);
+
 	return 0;
 }
 
@@ -1146,21 +1160,29 @@ static struct fb_ops dlfb_ops = {
 };
 
 
+static void dlfb_deferred_vfree(struct dlfb_data *dlfb, void *mem)
+{
+	struct dlfb_deferred_free *d = kmalloc(sizeof(struct dlfb_deferred_free), GFP_KERNEL);
+	if (!d)
+		return;
+	d->mem = mem;
+	list_add(&d->list, &dlfb->deferred_free);
+}
+
 /*
  * Assumes &info->lock held by caller
  * Assumes no active clients have framebuffer open
  */
-static int dlfb_realloc_framebuffer(struct dlfb_data *dlfb, struct fb_info *info)
+static int dlfb_realloc_framebuffer(struct dlfb_data *dlfb, struct fb_info *info, u32 new_len)
 {
-	int old_len = info->fix.smem_len;
-	int new_len;
+	u32 old_len = info->fix.smem_len;
 	unsigned char *old_fb = info->screen_base;
 	unsigned char *new_fb;
 	unsigned char *new_back = NULL;
 
-	new_len = info->fix.line_length * info->var.yres;
+	new_len = PAGE_ALIGN(new_len);
 
-	if (PAGE_ALIGN(new_len) > old_len) {
+	if (new_len > old_len) {
 		/*
 		 * Alloc system memory for virtual framebuffer
 		 */
@@ -1169,14 +1191,15 @@ static int dlfb_realloc_framebuffer(stru
 			dev_err(info->dev, "Virtual framebuffer alloc failed\n");
 			return -ENOMEM;
 		}
+		memset(new_fb, 0xff, new_len);
 
 		if (info->screen_base) {
 			memcpy(new_fb, old_fb, old_len);
-			vfree(info->screen_base);
+			dlfb_deferred_vfree(dlfb, info->screen_base);
 		}
 
 		info->screen_base = new_fb;
-		info->fix.smem_len = PAGE_ALIGN(new_len);
+		info->fix.smem_len = new_len;
 		info->fix.smem_start = (unsigned long) new_fb;
 		info->flags = udlfb_info_flags;
 
@@ -1192,7 +1215,7 @@ static int dlfb_realloc_framebuffer(stru
 			dev_info(info->dev,
 				 "No shadow/backing buffer allocated\n");
 		else {
-			vfree(dlfb->backing_buffer);
+			dlfb_deferred_vfree(dlfb, dlfb->backing_buffer);
 			dlfb->backing_buffer = new_back;
 		}
 	}
@@ -1344,11 +1367,6 @@ static int dlfb_setup_modes(struct dlfb_
 		 * with mode size info, we can now alloc our framebuffer.
 		 */
 		memcpy(&info->fix, &dlfb_fix, sizeof(dlfb_fix));
-		info->fix.line_length = info->var.xres *
-			(info->var.bits_per_pixel / 8);
-
-		result = dlfb_realloc_framebuffer(dlfb, info);
-
 	} else
 		result = -EINVAL;
 
@@ -1436,7 +1454,10 @@ static ssize_t edid_store(
 	if (!dlfb->edid || memcmp(src, dlfb->edid, src_size))
 		return -EINVAL;
 
-	dlfb_ops_set_par(fb_info);
+	ret = dlfb_ops_set_par(fb_info);
+	if (ret)
+		return ret;
+
 	return src_size;
 }
 
@@ -1596,6 +1617,7 @@ static int dlfb_usb_probe(struct usb_int
 	}
 
 	kref_init(&dlfb->kref); /* matching kref_put in usb .disconnect fn */
+	INIT_LIST_HEAD(&dlfb->deferred_free);
 
 	dlfb->udev = usbdev;
 	usb_set_intfdata(intf, dlfb);
@@ -1693,7 +1715,9 @@ static void dlfb_init_framebuffer_work(s
 	dlfb_select_std_channel(dlfb);
 
 	dlfb_ops_check_var(&info->var, info);
-	dlfb_ops_set_par(info);
+	retval = dlfb_ops_set_par(info);
+	if (retval)
+		goto error;
 
 	retval = register_framebuffer(info);
 	if (retval < 0) {
Index: linux-4.17-rc7/include/video/udlfb.h
=================================--- linux-4.17-rc7.orig/include/video/udlfb.h	2018-06-03 13:17:41.000000000 +0200
+++ linux-4.17-rc7/include/video/udlfb.h	2018-06-03 13:17:41.000000000 +0200
@@ -58,6 +58,7 @@ struct dlfb_data {
 	atomic_t bytes_sent; /* to usb, after compression including overhead */
 	atomic_t cpu_kcycles_used; /* transpired during pixel processing */
 	struct fb_var_screeninfo current_mode;
+	struct list_head deferred_free;
 };
 
 #define NR_USB_REQUEST_I2C_SUB_IO 0x02

