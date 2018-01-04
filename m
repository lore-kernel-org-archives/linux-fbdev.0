From: Ladislav Michl <ladis@linux-mips.org>
Date: Thu, 04 Jan 2018 19:39:02 +0000
Subject: [PATCH v2 4/5] video: udlfb: Do not name private data 'dev'
Message-Id: <20180104193902.GE22612@lenoch>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Variable 'dev' is usually used for 'struct device'. Therefore
rename driver private data to dlfb to avoid confusion once
driver will be using dev_*() logging functions.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 Changes:
 - v2: Rebased against next-20180104

 drivers/video/fbdev/udlfb.c | 414 ++++++++++++++++++++++----------------------
 include/video/udlfb.h       |   2 +-
 2 files changed, 208 insertions(+), 208 deletions(-)

diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
index 4a6644432970..47e31668f316 100644
--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -76,10 +76,10 @@ static int pixel_limit; /* Optionally force a pixel resolution limit */
 
 /* dlfb keeps a list of urbs for efficient bulk transfers */
 static void dlfb_urb_completion(struct urb *urb);
-static struct urb *dlfb_get_urb(struct dlfb_data *dev);
-static int dlfb_submit_urb(struct dlfb_data *dev, struct urb * urb, size_t len);
-static int dlfb_alloc_urb_list(struct dlfb_data *dev, int count, size_t size);
-static void dlfb_free_urb_list(struct dlfb_data *dev);
+static struct urb *dlfb_get_urb(struct dlfb_data *dlfb);
+static int dlfb_submit_urb(struct dlfb_data *dlfb, struct urb * urb, size_t len);
+static int dlfb_alloc_urb_list(struct dlfb_data *dlfb, int count, size_t size);
+static void dlfb_free_urb_list(struct dlfb_data *dlfb);
 
 /*
  * All DisplayLink bulk operations start with 0xAF, followed by specific code
@@ -274,7 +274,7 @@ static char *dlfb_set_vid_cmds(char *wrptr, struct fb_var_screeninfo *var)
  * and then generates the appropriate command sequence that then drives the
  * display controller.
  */
-static int dlfb_set_video_mode(struct dlfb_data *dev,
+static int dlfb_set_video_mode(struct dlfb_data *dlfb,
 				struct fb_var_screeninfo *var)
 {
 	char *buf;
@@ -283,10 +283,10 @@ static int dlfb_set_video_mode(struct dlfb_data *dev,
 	int writesize;
 	struct urb *urb;
 
-	if (!atomic_read(&dev->usb_active))
+	if (!atomic_read(&dlfb->usb_active))
 		return -EPERM;
 
-	urb = dlfb_get_urb(dev);
+	urb = dlfb_get_urb(dlfb);
 	if (!urb)
 		return -ENOMEM;
 
@@ -302,7 +302,7 @@ static int dlfb_set_video_mode(struct dlfb_data *dev,
 	/* set base for 16bpp segment to 0 */
 	wrptr = dlfb_set_base16bpp(wrptr, 0);
 	/* set base for 8bpp segment to end of fb */
-	wrptr = dlfb_set_base8bpp(wrptr, dev->info->fix.smem_len);
+	wrptr = dlfb_set_base8bpp(wrptr, dlfb->info->fix.smem_len);
 
 	wrptr = dlfb_set_vid_cmds(wrptr, var);
 	wrptr = dlfb_blanking(wrptr, FB_BLANK_UNBLANK);
@@ -310,9 +310,9 @@ static int dlfb_set_video_mode(struct dlfb_data *dev,
 
 	writesize = wrptr - buf;
 
-	retval = dlfb_submit_urb(dev, urb, writesize);
+	retval = dlfb_submit_urb(dlfb, urb, writesize);
 
-	dev->blank_mode = FB_BLANK_UNBLANK;
+	dlfb->blank_mode = FB_BLANK_UNBLANK;
 
 	return retval;
 }
@@ -513,13 +513,13 @@ static void dlfb_compress_hline(
  * (that we can only write to, slowly, and can never read), and (optionally)
  * our shadow copy that tracks what's been sent to that hardware buffer.
  */
-static int dlfb_render_hline(struct dlfb_data *dev, struct urb **urb_ptr,
+static int dlfb_render_hline(struct dlfb_data *dlfb, struct urb **urb_ptr,
 			      const char *front, char **urb_buf_ptr,
 			      u32 byte_offset, u32 byte_width,
 			      int *ident_ptr, int *sent_ptr)
 {
 	const u8 *line_start, *line_end, *next_pixel;
-	u32 dev_addr = dev->base16 + byte_offset;
+	u32 dev_addr = dlfb->base16 + byte_offset;
 	struct urb *urb = *urb_ptr;
 	u8 *cmd = *urb_buf_ptr;
 	u8 *cmd_end = (u8 *) urb->transfer_buffer + urb->transfer_buffer_length;
@@ -528,9 +528,9 @@ static int dlfb_render_hline(struct dlfb_data *dev, struct urb **urb_ptr,
 	next_pixel = line_start;
 	line_end = next_pixel + byte_width;
 
-	if (dev->backing_buffer) {
+	if (dlfb->backing_buffer) {
 		int offset;
-		const u8 *back_start = (u8 *) (dev->backing_buffer
+		const u8 *back_start = (u8 *) (dlfb->backing_buffer
 						+ byte_offset);
 
 		*ident_ptr += dlfb_trim_hline(back_start, &next_pixel,
@@ -554,10 +554,10 @@ static int dlfb_render_hline(struct dlfb_data *dev, struct urb **urb_ptr,
 
 		if (cmd >= cmd_end) {
 			int len = cmd - (u8 *) urb->transfer_buffer;
-			if (dlfb_submit_urb(dev, urb, len))
+			if (dlfb_submit_urb(dlfb, urb, len))
 				return 1; /* lost pixels is set */
 			*sent_ptr += len;
-			urb = dlfb_get_urb(dev);
+			urb = dlfb_get_urb(dlfb);
 			if (!urb)
 				return 1; /* lost_pixels is set */
 			*urb_ptr = urb;
@@ -571,7 +571,7 @@ static int dlfb_render_hline(struct dlfb_data *dev, struct urb **urb_ptr,
 	return 0;
 }
 
-static int dlfb_handle_damage(struct dlfb_data *dev, int x, int y,
+static int dlfb_handle_damage(struct dlfb_data *dlfb, int x, int y,
 	       int width, int height, char *data)
 {
 	int i, ret;
@@ -589,24 +589,24 @@ static int dlfb_handle_damage(struct dlfb_data *dev, int x, int y,
 	x = aligned_x;
 
 	if ((width <= 0) ||
-	    (x + width > dev->info->var.xres) ||
-	    (y + height > dev->info->var.yres))
+	    (x + width > dlfb->info->var.xres) ||
+	    (y + height > dlfb->info->var.yres))
 		return -EINVAL;
 
-	if (!atomic_read(&dev->usb_active))
+	if (!atomic_read(&dlfb->usb_active))
 		return 0;
 
-	urb = dlfb_get_urb(dev);
+	urb = dlfb_get_urb(dlfb);
 	if (!urb)
 		return 0;
 	cmd = urb->transfer_buffer;
 
 	for (i = y; i < y + height ; i++) {
-		const int line_offset = dev->info->fix.line_length * i;
+		const int line_offset = dlfb->info->fix.line_length * i;
 		const int byte_offset = line_offset + (x * BPP);
 
-		if (dlfb_render_hline(dev, &urb,
-				      (char *) dev->info->fix.smem_start,
+		if (dlfb_render_hline(dlfb, &urb,
+				      (char *) dlfb->info->fix.smem_start,
 				      &cmd, byte_offset, width * BPP,
 				      &bytes_identical, &bytes_sent))
 			goto error;
@@ -615,19 +615,19 @@ static int dlfb_handle_damage(struct dlfb_data *dev, int x, int y,
 	if (cmd > (char *) urb->transfer_buffer) {
 		/* Send partial buffer remaining before exiting */
 		int len = cmd - (char *) urb->transfer_buffer;
-		ret = dlfb_submit_urb(dev, urb, len);
+		ret = dlfb_submit_urb(dlfb, urb, len);
 		bytes_sent += len;
 	} else
 		dlfb_urb_completion(urb);
 
 error:
-	atomic_add(bytes_sent, &dev->bytes_sent);
-	atomic_add(bytes_identical, &dev->bytes_identical);
-	atomic_add(width*height*2, &dev->bytes_rendered);
+	atomic_add(bytes_sent, &dlfb->bytes_sent);
+	atomic_add(bytes_identical, &dlfb->bytes_identical);
+	atomic_add(width*height*2, &dlfb->bytes_rendered);
 	end_cycles = get_cycles();
 	atomic_add(((unsigned int) ((end_cycles - start_cycles)
 		    >> 10)), /* Kcycles */
-		   &dev->cpu_kcycles_used);
+		   &dlfb->cpu_kcycles_used);
 
 	return 0;
 }
@@ -642,7 +642,7 @@ static ssize_t dlfb_ops_write(struct fb_info *info, const char __user *buf,
 			  size_t count, loff_t *ppos)
 {
 	ssize_t result;
-	struct dlfb_data *dev = info->par;
+	struct dlfb_data *dlfb = info->par;
 	u32 offset = (u32) *ppos;
 
 	result = fb_sys_write(info, buf, count, ppos);
@@ -652,7 +652,7 @@ static ssize_t dlfb_ops_write(struct fb_info *info, const char __user *buf,
 		int lines = min((u32)((result / info->fix.line_length) + 1),
 				(u32)info->var.yres);
 
-		dlfb_handle_damage(dev, 0, start, info->var.xres,
+		dlfb_handle_damage(dlfb, 0, start, info->var.xres,
 			lines, info->screen_base);
 	}
 
@@ -664,33 +664,33 @@ static void dlfb_ops_copyarea(struct fb_info *info,
 				const struct fb_copyarea *area)
 {
 
-	struct dlfb_data *dev = info->par;
+	struct dlfb_data *dlfb = info->par;
 
 	sys_copyarea(info, area);
 
-	dlfb_handle_damage(dev, area->dx, area->dy,
+	dlfb_handle_damage(dlfb, area->dx, area->dy,
 			area->width, area->height, info->screen_base);
 }
 
 static void dlfb_ops_imageblit(struct fb_info *info,
 				const struct fb_image *image)
 {
-	struct dlfb_data *dev = info->par;
+	struct dlfb_data *dlfb = info->par;
 
 	sys_imageblit(info, image);
 
-	dlfb_handle_damage(dev, image->dx, image->dy,
+	dlfb_handle_damage(dlfb, image->dx, image->dy,
 			image->width, image->height, info->screen_base);
 }
 
 static void dlfb_ops_fillrect(struct fb_info *info,
 			  const struct fb_fillrect *rect)
 {
-	struct dlfb_data *dev = info->par;
+	struct dlfb_data *dlfb = info->par;
 
 	sys_fillrect(info, rect);
 
-	dlfb_handle_damage(dev, rect->dx, rect->dy, rect->width,
+	dlfb_handle_damage(dlfb, rect->dx, rect->dy, rect->width,
 			      rect->height, info->screen_base);
 }
 
@@ -705,7 +705,7 @@ static void dlfb_dpy_deferred_io(struct fb_info *info,
 {
 	struct page *cur;
 	struct fb_deferred_io *fbdefio = info->fbdefio;
-	struct dlfb_data *dev = info->par;
+	struct dlfb_data *dlfb = info->par;
 	struct urb *urb;
 	char *cmd;
 	cycles_t start_cycles, end_cycles;
@@ -716,12 +716,12 @@ static void dlfb_dpy_deferred_io(struct fb_info *info,
 	if (!fb_defio)
 		return;
 
-	if (!atomic_read(&dev->usb_active))
+	if (!atomic_read(&dlfb->usb_active))
 		return;
 
 	start_cycles = get_cycles();
 
-	urb = dlfb_get_urb(dev);
+	urb = dlfb_get_urb(dlfb);
 	if (!urb)
 		return;
 
@@ -730,7 +730,7 @@ static void dlfb_dpy_deferred_io(struct fb_info *info,
 	/* walk the written page list and render each to device */
 	list_for_each_entry(cur, &fbdefio->pagelist, lru) {
 
-		if (dlfb_render_hline(dev, &urb, (char *) info->fix.smem_start,
+		if (dlfb_render_hline(dlfb, &urb, (char *) info->fix.smem_start,
 				  &cmd, cur->index << PAGE_SHIFT,
 				  PAGE_SIZE, &bytes_identical, &bytes_sent))
 			goto error;
@@ -740,22 +740,22 @@ static void dlfb_dpy_deferred_io(struct fb_info *info,
 	if (cmd > (char *) urb->transfer_buffer) {
 		/* Send partial buffer remaining before exiting */
 		int len = cmd - (char *) urb->transfer_buffer;
-		dlfb_submit_urb(dev, urb, len);
+		dlfb_submit_urb(dlfb, urb, len);
 		bytes_sent += len;
 	} else
 		dlfb_urb_completion(urb);
 
 error:
-	atomic_add(bytes_sent, &dev->bytes_sent);
-	atomic_add(bytes_identical, &dev->bytes_identical);
-	atomic_add(bytes_rendered, &dev->bytes_rendered);
+	atomic_add(bytes_sent, &dlfb->bytes_sent);
+	atomic_add(bytes_identical, &dlfb->bytes_identical);
+	atomic_add(bytes_rendered, &dlfb->bytes_rendered);
 	end_cycles = get_cycles();
 	atomic_add(((unsigned int) ((end_cycles - start_cycles)
 		    >> 10)), /* Kcycles */
-		   &dev->cpu_kcycles_used);
+		   &dlfb->cpu_kcycles_used);
 }
 
-static int dlfb_get_edid(struct dlfb_data *dev, char *edid, int len)
+static int dlfb_get_edid(struct dlfb_data *dlfb, char *edid, int len)
 {
 	int i;
 	int ret;
@@ -766,8 +766,8 @@ static int dlfb_get_edid(struct dlfb_data *dev, char *edid, int len)
 		return 0;
 
 	for (i = 0; i < len; i++) {
-		ret = usb_control_msg(dev->udev,
-				      usb_rcvctrlpipe(dev->udev, 0), 0x02,
+		ret = usb_control_msg(dlfb->udev,
+				      usb_rcvctrlpipe(dlfb->udev, 0), 0x02,
 				      (0x80 | (0x02 << 5)), i << 8, 0xA1,
 				      rbuf, 2, USB_CTRL_GET_TIMEOUT);
 		if (ret < 2) {
@@ -787,15 +787,15 @@ static int dlfb_ops_ioctl(struct fb_info *info, unsigned int cmd,
 				unsigned long arg)
 {
 
-	struct dlfb_data *dev = info->par;
+	struct dlfb_data *dlfb = info->par;
 
-	if (!atomic_read(&dev->usb_active))
+	if (!atomic_read(&dlfb->usb_active))
 		return 0;
 
 	/* TODO: Update X server to get this from sysfs instead */
 	if (cmd = DLFB_IOCTL_RETURN_EDID) {
 		void __user *edid = (void __user *)arg;
-		if (copy_to_user(edid, dev->edid, dev->edid_size))
+		if (copy_to_user(edid, dlfb->edid, dlfb->edid_size))
 			return -EFAULT;
 		return 0;
 	}
@@ -830,7 +830,7 @@ static int dlfb_ops_ioctl(struct fb_info *info, unsigned int cmd,
 		if (area.y > info->var.yres)
 			area.y = info->var.yres;
 
-		dlfb_handle_damage(dev, area.x, area.y, area.w, area.h,
+		dlfb_handle_damage(dlfb, area.x, area.y, area.w, area.h,
 			   info->screen_base);
 	}
 
@@ -871,7 +871,7 @@ dlfb_ops_setcolreg(unsigned regno, unsigned red, unsigned green,
  */
 static int dlfb_ops_open(struct fb_info *info, int user)
 {
-	struct dlfb_data *dev = info->par;
+	struct dlfb_data *dlfb = info->par;
 
 	/*
 	 * fbcon aggressively connects to first framebuffer it finds,
@@ -882,12 +882,12 @@ static int dlfb_ops_open(struct fb_info *info, int user)
 		return -EBUSY;
 
 	/* If the USB device is gone, we don't accept new opens */
-	if (dev->virtualized)
+	if (dlfb->virtualized)
 		return -ENODEV;
 
-	dev->fb_count++;
+	dlfb->fb_count++;
 
-	kref_get(&dev->kref);
+	kref_get(&dlfb->kref);
 
 	if (fb_defio && (info->fbdefio = NULL)) {
 		/* enable defio at last moment if not disabled by client */
@@ -906,7 +906,7 @@ static int dlfb_ops_open(struct fb_info *info, int user)
 	}
 
 	pr_notice("open /dev/fb%d user=%d fb_info=%p count=%d\n",
-	    info->node, user, info, dev->fb_count);
+	    info->node, user, info, dlfb->fb_count);
 
 	return 0;
 }
@@ -918,11 +918,11 @@ static int dlfb_ops_open(struct fb_info *info, int user)
  */
 static void dlfb_free(struct kref *kref)
 {
-	struct dlfb_data *dev = container_of(kref, struct dlfb_data, kref);
+	struct dlfb_data *dlfb = container_of(kref, struct dlfb_data, kref);
 
-	vfree(dev->backing_buffer);
-	kfree(dev->edid);
-	kfree(dev);
+	vfree(dlfb->backing_buffer);
+	kfree(dlfb->edid);
+	kfree(dlfb);
 }
 
 static void dlfb_release_urb_work(struct work_struct *work)
@@ -930,12 +930,12 @@ static void dlfb_release_urb_work(struct work_struct *work)
 	struct urb_node *unode = container_of(work, struct urb_node,
 					      release_urb_work.work);
 
-	up(&unode->dev->urbs.limit_sem);
+	up(&unode->dlfb->urbs.limit_sem);
 }
 
-static void dlfb_free_framebuffer(struct dlfb_data *dev)
+static void dlfb_free_framebuffer(struct dlfb_data *dlfb)
 {
-	struct fb_info *info = dev->info;
+	struct fb_info *info = dlfb->info;
 
 	if (info) {
 		unregister_framebuffer(info);
@@ -948,36 +948,36 @@ static void dlfb_free_framebuffer(struct dlfb_data *dev)
 
 		fb_destroy_modelist(&info->modelist);
 
-		dev->info = NULL;
+		dlfb->info = NULL;
 
 		/* Assume info structure is freed after this point */
 		framebuffer_release(info);
 	}
 
 	/* ref taken in probe() as part of registering framebfufer */
-	kref_put(&dev->kref, dlfb_free);
+	kref_put(&dlfb->kref, dlfb_free);
 }
 
 static void dlfb_free_framebuffer_work(struct work_struct *work)
 {
-	struct dlfb_data *dev = container_of(work, struct dlfb_data,
+	struct dlfb_data *dlfb = container_of(work, struct dlfb_data,
 					     free_framebuffer_work.work);
-	dlfb_free_framebuffer(dev);
+	dlfb_free_framebuffer(dlfb);
 }
 /*
  * Assumes caller is holding info->lock mutex (for open and release at least)
  */
 static int dlfb_ops_release(struct fb_info *info, int user)
 {
-	struct dlfb_data *dev = info->par;
+	struct dlfb_data *dlfb = info->par;
 
-	dev->fb_count--;
+	dlfb->fb_count--;
 
 	/* We can't free fb_info here - fbmem will touch it when we return */
-	if (dev->virtualized && (dev->fb_count = 0))
-		schedule_delayed_work(&dev->free_framebuffer_work, HZ);
+	if (dlfb->virtualized && (dlfb->fb_count = 0))
+		schedule_delayed_work(&dlfb->free_framebuffer_work, HZ);
 
-	if ((dev->fb_count = 0) && (info->fbdefio)) {
+	if ((dlfb->fb_count = 0) && (info->fbdefio)) {
 		fb_deferred_io_cleanup(info);
 		kfree(info->fbdefio);
 		info->fbdefio = NULL;
@@ -985,9 +985,9 @@ static int dlfb_ops_release(struct fb_info *info, int user)
 	}
 
 	pr_warn("released /dev/fb%d user=%d count=%d\n",
-		  info->node, user, dev->fb_count);
+		  info->node, user, dlfb->fb_count);
 
-	kref_put(&dev->kref, dlfb_free);
+	kref_put(&dlfb->kref, dlfb_free);
 
 	return 0;
 }
@@ -999,9 +999,9 @@ static int dlfb_ops_release(struct fb_info *info, int user)
 static int dlfb_is_valid_mode(struct fb_videomode *mode,
 		struct fb_info *info)
 {
-	struct dlfb_data *dev = info->par;
+	struct dlfb_data *dlfb = info->par;
 
-	if (mode->xres * mode->yres > dev->sku_pixel_limit) {
+	if (mode->xres * mode->yres > dlfb->sku_pixel_limit) {
 		pr_warn("%dx%d beyond chip capabilities\n",
 		       mode->xres, mode->yres);
 		return 0;
@@ -1047,14 +1047,14 @@ static int dlfb_ops_check_var(struct fb_var_screeninfo *var,
 
 static int dlfb_ops_set_par(struct fb_info *info)
 {
-	struct dlfb_data *dev = info->par;
+	struct dlfb_data *dlfb = info->par;
 	int result;
 	u16 *pix_framebuffer;
 	int i;
 
-	result = dlfb_set_video_mode(dev, &info->var);
+	result = dlfb_set_video_mode(dlfb, &info->var);
 
-	if ((result = 0) && (dev->fb_count = 0)) {
+	if ((result = 0) && (dlfb->fb_count = 0)) {
 
 		/* paint greenscreen */
 
@@ -1062,7 +1062,7 @@ static int dlfb_ops_set_par(struct fb_info *info)
 		for (i = 0; i < info->fix.smem_len / 2; i++)
 			pix_framebuffer[i] = 0x37e6;
 
-		dlfb_handle_damage(dev, 0, 0, info->var.xres, info->var.yres,
+		dlfb_handle_damage(dlfb, 0, 0, info->var.xres, info->var.yres,
 				   info->screen_base);
 	}
 
@@ -1089,21 +1089,21 @@ static char *dlfb_dummy_render(char *buf)
  */
 static int dlfb_ops_blank(int blank_mode, struct fb_info *info)
 {
-	struct dlfb_data *dev = info->par;
+	struct dlfb_data *dlfb = info->par;
 	char *bufptr;
 	struct urb *urb;
 
 	pr_debug("/dev/fb%d FB_BLANK mode %d --> %d\n",
-		 info->node, dev->blank_mode, blank_mode);
+		 info->node, dlfb->blank_mode, blank_mode);
 
-	if ((dev->blank_mode = FB_BLANK_POWERDOWN) &&
+	if ((dlfb->blank_mode = FB_BLANK_POWERDOWN) &&
 	    (blank_mode != FB_BLANK_POWERDOWN)) {
 
 		/* returning from powerdown requires a fresh modeset */
-		dlfb_set_video_mode(dev, &info->var);
+		dlfb_set_video_mode(dlfb, &info->var);
 	}
 
-	urb = dlfb_get_urb(dev);
+	urb = dlfb_get_urb(dlfb);
 	if (!urb)
 		return 0;
 
@@ -1115,10 +1115,10 @@ static int dlfb_ops_blank(int blank_mode, struct fb_info *info)
 	/* seems like a render op is needed to have blank change take effect */
 	bufptr = dlfb_dummy_render(bufptr);
 
-	dlfb_submit_urb(dev, urb, bufptr -
+	dlfb_submit_urb(dlfb, urb, bufptr -
 			(char *) urb->transfer_buffer);
 
-	dev->blank_mode = blank_mode;
+	dlfb->blank_mode = blank_mode;
 
 	return 0;
 }
@@ -1145,7 +1145,7 @@ static struct fb_ops dlfb_ops = {
  * Assumes &info->lock held by caller
  * Assumes no active clients have framebuffer open
  */
-static int dlfb_realloc_framebuffer(struct dlfb_data *dev, struct fb_info *info)
+static int dlfb_realloc_framebuffer(struct dlfb_data *dlfb, struct fb_info *info)
 {
 	int retval = -ENOMEM;
 	int old_len = info->fix.smem_len;
@@ -1187,8 +1187,8 @@ static int dlfb_realloc_framebuffer(struct dlfb_data *dev, struct fb_info *info)
 		if (!new_back)
 			pr_info("No shadow/backing buffer allocated\n");
 		else {
-			vfree(dev->backing_buffer);
-			dev->backing_buffer = new_back;
+			vfree(dlfb->backing_buffer);
+			dlfb->backing_buffer = new_back;
 		}
 	}
 
@@ -1212,7 +1212,7 @@ static int dlfb_realloc_framebuffer(struct dlfb_data *dev, struct fb_info *info)
  * monspecs is NULL, and fb_var_screeninfo is set to safe VESA mode
  * Returns 0 if successful
  */
-static int dlfb_setup_modes(struct dlfb_data *dev,
+static int dlfb_setup_modes(struct dlfb_data *dlfb,
 			   struct fb_info *info,
 			   char *default_edid, size_t default_edid_size)
 {
@@ -1241,14 +1241,14 @@ static int dlfb_setup_modes(struct dlfb_data *dev,
 	 */
 	while (tries--) {
 
-		i = dlfb_get_edid(dev, edid, EDID_LENGTH);
+		i = dlfb_get_edid(dlfb, edid, EDID_LENGTH);
 
 		if (i >= EDID_LENGTH)
 			fb_edid_to_monspecs(edid, &info->monspecs);
 
 		if (info->monspecs.modedb_len > 0) {
-			dev->edid = edid;
-			dev->edid_size = i;
+			dlfb->edid = edid;
+			dlfb->edid_size = i;
 			break;
 		}
 	}
@@ -1258,8 +1258,8 @@ static int dlfb_setup_modes(struct dlfb_data *dev,
 
 		pr_err("Unable to get valid EDID from device/display\n");
 
-		if (dev->edid) {
-			fb_edid_to_monspecs(dev->edid, &info->monspecs);
+		if (dlfb->edid) {
+			fb_edid_to_monspecs(dlfb->edid, &info->monspecs);
 			if (info->monspecs.modedb_len > 0)
 				pr_err("Using previously queried EDID\n");
 		}
@@ -1271,8 +1271,8 @@ static int dlfb_setup_modes(struct dlfb_data *dev,
 			fb_edid_to_monspecs(default_edid, &info->monspecs);
 			if (info->monspecs.modedb_len > 0) {
 				memcpy(edid, default_edid, default_edid_size);
-				dev->edid = edid;
-				dev->edid_size = default_edid_size;
+				dlfb->edid = edid;
+				dlfb->edid_size = default_edid_size;
 				pr_err("Using default/backup EDID\n");
 			}
 		}
@@ -1327,7 +1327,7 @@ static int dlfb_setup_modes(struct dlfb_data *dev,
 	}
 
 	/* If we have good mode and no active clients*/
-	if ((default_vmode != NULL) && (dev->fb_count = 0)) {
+	if ((default_vmode != NULL) && (dlfb->fb_count = 0)) {
 
 		fb_videomode_to_var(&info->var, default_vmode);
 		dlfb_var_color_format(&info->var);
@@ -1339,13 +1339,13 @@ static int dlfb_setup_modes(struct dlfb_data *dev,
 		info->fix.line_length = info->var.xres *
 			(info->var.bits_per_pixel / 8);
 
-		result = dlfb_realloc_framebuffer(dev, info);
+		result = dlfb_realloc_framebuffer(dlfb, info);
 
 	} else
 		result = -EINVAL;
 
 error:
-	if (edid && (dev->edid != edid))
+	if (edid && (dlfb->edid != edid))
 		kfree(edid);
 
 	if (info->dev)
@@ -1357,33 +1357,33 @@ static int dlfb_setup_modes(struct dlfb_data *dev,
 static ssize_t metrics_bytes_rendered_show(struct device *fbdev,
 				   struct device_attribute *a, char *buf) {
 	struct fb_info *fb_info = dev_get_drvdata(fbdev);
-	struct dlfb_data *dev = fb_info->par;
+	struct dlfb_data *dlfb = fb_info->par;
 	return snprintf(buf, PAGE_SIZE, "%u\n",
-			atomic_read(&dev->bytes_rendered));
+			atomic_read(&dlfb->bytes_rendered));
 }
 
 static ssize_t metrics_bytes_identical_show(struct device *fbdev,
 				   struct device_attribute *a, char *buf) {
 	struct fb_info *fb_info = dev_get_drvdata(fbdev);
-	struct dlfb_data *dev = fb_info->par;
+	struct dlfb_data *dlfb = fb_info->par;
 	return snprintf(buf, PAGE_SIZE, "%u\n",
-			atomic_read(&dev->bytes_identical));
+			atomic_read(&dlfb->bytes_identical));
 }
 
 static ssize_t metrics_bytes_sent_show(struct device *fbdev,
 				   struct device_attribute *a, char *buf) {
 	struct fb_info *fb_info = dev_get_drvdata(fbdev);
-	struct dlfb_data *dev = fb_info->par;
+	struct dlfb_data *dlfb = fb_info->par;
 	return snprintf(buf, PAGE_SIZE, "%u\n",
-			atomic_read(&dev->bytes_sent));
+			atomic_read(&dlfb->bytes_sent));
 }
 
 static ssize_t metrics_cpu_kcycles_used_show(struct device *fbdev,
 				   struct device_attribute *a, char *buf) {
 	struct fb_info *fb_info = dev_get_drvdata(fbdev);
-	struct dlfb_data *dev = fb_info->par;
+	struct dlfb_data *dlfb = fb_info->par;
 	return snprintf(buf, PAGE_SIZE, "%u\n",
-			atomic_read(&dev->cpu_kcycles_used));
+			atomic_read(&dlfb->cpu_kcycles_used));
 }
 
 static ssize_t edid_show(
@@ -1392,18 +1392,18 @@ static ssize_t edid_show(
 			 char *buf, loff_t off, size_t count) {
 	struct device *fbdev = container_of(kobj, struct device, kobj);
 	struct fb_info *fb_info = dev_get_drvdata(fbdev);
-	struct dlfb_data *dev = fb_info->par;
+	struct dlfb_data *dlfb = fb_info->par;
 
-	if (dev->edid = NULL)
+	if (dlfb->edid = NULL)
 		return 0;
 
-	if ((off >= dev->edid_size) || (count > dev->edid_size))
+	if ((off >= dlfb->edid_size) || (count > dlfb->edid_size))
 		return 0;
 
-	if (off + count > dev->edid_size)
-		count = dev->edid_size - off;
+	if (off + count > dlfb->edid_size)
+		count = dlfb->edid_size - off;
 
-	memcpy(buf, dev->edid, count);
+	memcpy(buf, dlfb->edid, count);
 
 	return count;
 }
@@ -1414,18 +1414,18 @@ static ssize_t edid_store(
 			char *src, loff_t src_off, size_t src_size) {
 	struct device *fbdev = container_of(kobj, struct device, kobj);
 	struct fb_info *fb_info = dev_get_drvdata(fbdev);
-	struct dlfb_data *dev = fb_info->par;
+	struct dlfb_data *dlfb = fb_info->par;
 	int ret;
 
 	/* We only support write of entire EDID at once, no offset*/
 	if ((src_size != EDID_LENGTH) || (src_off != 0))
 		return -EINVAL;
 
-	ret = dlfb_setup_modes(dev, fb_info, src, src_size);
+	ret = dlfb_setup_modes(dlfb, fb_info, src, src_size);
 	if (ret)
 		return ret;
 
-	if (!dev->edid || memcmp(src, dev->edid, src_size))
+	if (!dlfb->edid || memcmp(src, dlfb->edid, src_size))
 		return -EINVAL;
 
 	dlfb_ops_set_par(fb_info);
@@ -1437,12 +1437,12 @@ static ssize_t metrics_reset_store(struct device *fbdev,
 			   const char *buf, size_t count)
 {
 	struct fb_info *fb_info = dev_get_drvdata(fbdev);
-	struct dlfb_data *dev = fb_info->par;
+	struct dlfb_data *dlfb = fb_info->par;
 
-	atomic_set(&dev->bytes_rendered, 0);
-	atomic_set(&dev->bytes_identical, 0);
-	atomic_set(&dev->bytes_sent, 0);
-	atomic_set(&dev->cpu_kcycles_used, 0);
+	atomic_set(&dlfb->bytes_rendered, 0);
+	atomic_set(&dlfb->bytes_identical, 0);
+	atomic_set(&dlfb->bytes_sent, 0);
+	atomic_set(&dlfb->cpu_kcycles_used, 0);
 
 	return count;
 }
@@ -1466,7 +1466,7 @@ static struct device_attribute fb_device_attrs[] = {
 /*
  * This is necessary before we can communicate with the display controller.
  */
-static int dlfb_select_std_channel(struct dlfb_data *dev)
+static int dlfb_select_std_channel(struct dlfb_data *dlfb)
 {
 	int ret;
 	void *buf;
@@ -1481,7 +1481,7 @@ static int dlfb_select_std_channel(struct dlfb_data *dev)
 	if (!buf)
 		return -ENOMEM;
 
-	ret = usb_control_msg(dev->udev, usb_sndctrlpipe(dev->udev, 0),
+	ret = usb_control_msg(dlfb->udev, usb_sndctrlpipe(dlfb->udev, 0),
 			NR_USB_REQUEST_CHANNEL,
 			(USB_DIR_OUT | USB_TYPE_VENDOR), 0, 0,
 			buf, sizeof(set_def_chn), USB_CTRL_SET_TIMEOUT);
@@ -1491,7 +1491,7 @@ static int dlfb_select_std_channel(struct dlfb_data *dev)
 	return ret;
 }
 
-static int dlfb_parse_vendor_descriptor(struct dlfb_data *dev,
+static int dlfb_parse_vendor_descriptor(struct dlfb_data *dlfb,
 					struct usb_interface *interface)
 {
 	char *desc;
@@ -1544,7 +1544,7 @@ static int dlfb_parse_vendor_descriptor(struct dlfb_data *dev,
 				max_area = le32_to_cpu(*((u32 *)desc));
 				pr_warn("DL chip limited to %d pixel modes\n",
 					max_area);
-				dev->sku_pixel_limit = max_area;
+				dlfb->sku_pixel_limit = max_area;
 				break;
 			}
 			default:
@@ -1573,37 +1573,37 @@ static int dlfb_usb_probe(struct usb_interface *interface,
 			const struct usb_device_id *id)
 {
 	struct usb_device *usbdev;
-	struct dlfb_data *dev;
+	struct dlfb_data *dlfb;
 	int retval = -ENOMEM;
 
 	/* usb initialization */
 
 	usbdev = interface_to_usbdev(interface);
 
-	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
-	if (dev = NULL) {
+	dlfb = kzalloc(sizeof(*dlfb), GFP_KERNEL);
+	if (dlfb = NULL) {
 		dev_err(&interface->dev, "dlfb_usb_probe: failed alloc of dev struct\n");
 		goto error;
 	}
 
-	kref_init(&dev->kref); /* matching kref_put in usb .disconnect fn */
+	kref_init(&dlfb->kref); /* matching kref_put in usb .disconnect fn */
 
-	dev->udev = usbdev;
-	usb_set_intfdata(interface, dev);
+	dlfb->udev = usbdev;
+	usb_set_intfdata(interface, dlfb);
 
 	pr_info("%s %s - serial #%s\n",
 		usbdev->manufacturer, usbdev->product, usbdev->serial);
 	pr_info("vid_%04x&pid_%04x&rev_%04x driver's dlfb_data struct at %p\n",
 		le16_to_cpu(usbdev->descriptor.idVendor),
 		le16_to_cpu(usbdev->descriptor.idProduct),
-		le16_to_cpu(usbdev->descriptor.bcdDevice), dev);
+		le16_to_cpu(usbdev->descriptor.bcdDevice), dlfb);
 	pr_info("console enable=%d\n", console);
 	pr_info("fb_defio enable=%d\n", fb_defio);
 	pr_info("shadow enable=%d\n", shadow);
 
-	dev->sku_pixel_limit = 2048 * 1152; /* default to maximum */
+	dlfb->sku_pixel_limit = 2048 * 1152; /* default to maximum */
 
-	if (!dlfb_parse_vendor_descriptor(dev, interface)) {
+	if (!dlfb_parse_vendor_descriptor(dlfb, interface)) {
 		pr_err("firmware not recognized. Assume incompatible device\n");
 		goto error;
 	}
@@ -1611,32 +1611,32 @@ static int dlfb_usb_probe(struct usb_interface *interface,
 	if (pixel_limit) {
 		pr_warn("DL chip limit of %d overridden"
 			" by module param to %d\n",
-			dev->sku_pixel_limit, pixel_limit);
-		dev->sku_pixel_limit = pixel_limit;
+			dlfb->sku_pixel_limit, pixel_limit);
+		dlfb->sku_pixel_limit = pixel_limit;
 	}
 
 
-	if (!dlfb_alloc_urb_list(dev, WRITES_IN_FLIGHT, MAX_TRANSFER)) {
+	if (!dlfb_alloc_urb_list(dlfb, WRITES_IN_FLIGHT, MAX_TRANSFER)) {
 		retval = -ENOMEM;
 		pr_err("dlfb_alloc_urb_list failed\n");
 		goto error;
 	}
 
-	kref_get(&dev->kref); /* matching kref_put in free_framebuffer_work */
+	kref_get(&dlfb->kref); /* matching kref_put in free_framebuffer_work */
 
-	/* We don't register a new USB class. Our client interface is fbdev */
+	/* We don't register a new USB class. Our client interface is dlfbev */
 
 	/* Workitem keep things fast & simple during USB enumeration */
-	INIT_DELAYED_WORK(&dev->init_framebuffer_work,
+	INIT_DELAYED_WORK(&dlfb->init_framebuffer_work,
 			  dlfb_init_framebuffer_work);
-	schedule_delayed_work(&dev->init_framebuffer_work, 0);
+	schedule_delayed_work(&dlfb->init_framebuffer_work, 0);
 
 	return 0;
 
 error:
-	if (dev) {
+	if (dlfb) {
 
-		kref_put(&dev->kref, dlfb_free); /* last ref from kref_init */
+		kref_put(&dlfb->kref, dlfb_free); /* last ref from kref_init */
 
 		/* dev has been deallocated. Do not dereference */
 	}
@@ -1646,22 +1646,22 @@ static int dlfb_usb_probe(struct usb_interface *interface,
 
 static void dlfb_init_framebuffer_work(struct work_struct *work)
 {
-	struct dlfb_data *dev = container_of(work, struct dlfb_data,
+	struct dlfb_data *dlfb = container_of(work, struct dlfb_data,
 					     init_framebuffer_work.work);
 	struct fb_info *info;
 	int retval;
 	int i;
 
 	/* allocates framebuffer driver structure, not framebuffer memory */
-	info = framebuffer_alloc(0, &dev->udev->dev);
+	info = framebuffer_alloc(0, &dlfb->udev->dev);
 	if (!info) {
 		pr_err("framebuffer_alloc failed\n");
 		goto error;
 	}
 
-	dev->info = info;
-	info->par = dev;
-	info->pseudo_palette = dev->pseudo_palette;
+	dlfb->info = info;
+	info->par = dlfb;
+	info->pseudo_palette = dlfb->pseudo_palette;
 	info->fbops = &dlfb_ops;
 
 	retval = fb_alloc_cmap(&info->cmap, 256, 0);
@@ -1670,12 +1670,12 @@ static void dlfb_init_framebuffer_work(struct work_struct *work)
 		goto error;
 	}
 
-	INIT_DELAYED_WORK(&dev->free_framebuffer_work,
+	INIT_DELAYED_WORK(&dlfb->free_framebuffer_work,
 			  dlfb_free_framebuffer_work);
 
 	INIT_LIST_HEAD(&info->modelist);
 
-	retval = dlfb_setup_modes(dev, info, NULL, 0);
+	retval = dlfb_setup_modes(dlfb, info, NULL, 0);
 	if (retval != 0) {
 		pr_err("unable to find common mode for display and adapter\n");
 		goto error;
@@ -1683,8 +1683,8 @@ static void dlfb_init_framebuffer_work(struct work_struct *work)
 
 	/* ready to begin using device */
 
-	atomic_set(&dev->usb_active, 1);
-	dlfb_select_std_channel(dev);
+	atomic_set(&dlfb->usb_active, 1);
+	dlfb_select_std_channel(dlfb);
 
 	dlfb_ops_check_var(&info->var, info);
 	dlfb_ops_set_par(info);
@@ -1710,33 +1710,33 @@ static void dlfb_init_framebuffer_work(struct work_struct *work)
 	pr_info("DisplayLink USB device /dev/fb%d attached. %dx%d resolution."
 			" Using %dK framebuffer memory\n", info->node,
 			info->var.xres, info->var.yres,
-			((dev->backing_buffer) ?
+			((dlfb->backing_buffer) ?
 			info->fix.smem_len * 2 : info->fix.smem_len) >> 10);
 	return;
 
 error:
-	dlfb_free_framebuffer(dev);
+	dlfb_free_framebuffer(dlfb);
 }
 
 static void dlfb_usb_disconnect(struct usb_interface *interface)
 {
-	struct dlfb_data *dev;
+	struct dlfb_data *dlfb;
 	struct fb_info *info;
 	int i;
 
-	dev = usb_get_intfdata(interface);
-	info = dev->info;
+	dlfb = usb_get_intfdata(interface);
+	info = dlfb->info;
 
 	pr_info("USB disconnect starting\n");
 
 	/* we virtualize until all fb clients release. Then we free */
-	dev->virtualized = true;
+	dlfb->virtualized = true;
 
 	/* When non-active we'll update virtual framebuffer, but no new urbs */
-	atomic_set(&dev->usb_active, 0);
+	atomic_set(&dlfb->usb_active, 0);
 
 	/* this function will wait for all in-flight urbs to complete */
-	dlfb_free_urb_list(dev);
+	dlfb_free_urb_list(dlfb);
 
 	if (info) {
 		/* remove udlfb's sysfs interfaces */
@@ -1747,14 +1747,14 @@ static void dlfb_usb_disconnect(struct usb_interface *interface)
 	}
 
 	usb_set_intfdata(interface, NULL);
-	dev->udev = NULL;
+	dlfb->udev = NULL;
 
 	/* if clients still have us open, will be freed on last close */
-	if (dev->fb_count = 0)
-		schedule_delayed_work(&dev->free_framebuffer_work, 0);
+	if (dlfb->fb_count = 0)
+		schedule_delayed_work(&dlfb->free_framebuffer_work, 0);
 
 	/* release reference taken by kref_init in probe() */
-	kref_put(&dev->kref, dlfb_free);
+	kref_put(&dlfb->kref, dlfb_free);
 
 	/* consider dlfb_data freed */
 }
@@ -1771,7 +1771,7 @@ module_usb_driver(dlfb_driver);
 static void dlfb_urb_completion(struct urb *urb)
 {
 	struct urb_node *unode = urb->context;
-	struct dlfb_data *dev = unode->dev;
+	struct dlfb_data *dlfb = unode->dlfb;
 	unsigned long flags;
 
 	/* sync/async unlink faults aren't errors */
@@ -1781,16 +1781,16 @@ static void dlfb_urb_completion(struct urb *urb)
 		    urb->status = -ESHUTDOWN)) {
 			pr_err("%s - nonzero write bulk status received: %d\n",
 				__func__, urb->status);
-			atomic_set(&dev->lost_pixels, 1);
+			atomic_set(&dlfb->lost_pixels, 1);
 		}
 	}
 
-	urb->transfer_buffer_length = dev->urbs.size; /* reset to actual */
+	urb->transfer_buffer_length = dlfb->urbs.size; /* reset to actual */
 
-	spin_lock_irqsave(&dev->urbs.lock, flags);
-	list_add_tail(&unode->entry, &dev->urbs.list);
-	dev->urbs.available++;
-	spin_unlock_irqrestore(&dev->urbs.lock, flags);
+	spin_lock_irqsave(&dlfb->urbs.lock, flags);
+	list_add_tail(&unode->entry, &dlfb->urbs.list);
+	dlfb->urbs.available++;
+	spin_unlock_irqrestore(&dlfb->urbs.lock, flags);
 
 	/*
 	 * When using fb_defio, we deadlock if up() is called
@@ -1799,12 +1799,12 @@ static void dlfb_urb_completion(struct urb *urb)
 	if (fb_defio)
 		schedule_delayed_work(&unode->release_urb_work, 0);
 	else
-		up(&dev->urbs.limit_sem);
+		up(&dlfb->urbs.limit_sem);
 }
 
-static void dlfb_free_urb_list(struct dlfb_data *dev)
+static void dlfb_free_urb_list(struct dlfb_data *dlfb)
 {
-	int count = dev->urbs.count;
+	int count = dlfb->urbs.count;
 	struct list_head *node;
 	struct urb_node *unode;
 	struct urb *urb;
@@ -1815,47 +1815,47 @@ static void dlfb_free_urb_list(struct dlfb_data *dev)
 	while (count--) {
 
 		/* Getting interrupted means a leak, but ok at disconnect */
-		ret = down_interruptible(&dev->urbs.limit_sem);
+		ret = down_interruptible(&dlfb->urbs.limit_sem);
 		if (ret)
 			break;
 
-		spin_lock_irqsave(&dev->urbs.lock, flags);
+		spin_lock_irqsave(&dlfb->urbs.lock, flags);
 
-		node = dev->urbs.list.next; /* have reserved one with sem */
+		node = dlfb->urbs.list.next; /* have reserved one with sem */
 		list_del_init(node);
 
-		spin_unlock_irqrestore(&dev->urbs.lock, flags);
+		spin_unlock_irqrestore(&dlfb->urbs.lock, flags);
 
 		unode = list_entry(node, struct urb_node, entry);
 		urb = unode->urb;
 
 		/* Free each separately allocated piece */
-		usb_free_coherent(urb->dev, dev->urbs.size,
+		usb_free_coherent(urb->dev, dlfb->urbs.size,
 				  urb->transfer_buffer, urb->transfer_dma);
 		usb_free_urb(urb);
 		kfree(node);
 	}
 
-	dev->urbs.count = 0;
+	dlfb->urbs.count = 0;
 }
 
-static int dlfb_alloc_urb_list(struct dlfb_data *dev, int count, size_t size)
+static int dlfb_alloc_urb_list(struct dlfb_data *dlfb, int count, size_t size)
 {
 	int i = 0;
 	struct urb *urb;
 	struct urb_node *unode;
 	char *buf;
 
-	spin_lock_init(&dev->urbs.lock);
+	spin_lock_init(&dlfb->urbs.lock);
 
-	dev->urbs.size = size;
-	INIT_LIST_HEAD(&dev->urbs.list);
+	dlfb->urbs.size = size;
+	INIT_LIST_HEAD(&dlfb->urbs.list);
 
 	while (i < count) {
 		unode = kzalloc(sizeof(*unode), GFP_KERNEL);
 		if (!unode)
 			break;
-		unode->dev = dev;
+		unode->dlfb = dlfb;
 
 		INIT_DELAYED_WORK(&unode->release_urb_work,
 			  dlfb_release_urb_work);
@@ -1867,7 +1867,7 @@ static int dlfb_alloc_urb_list(struct dlfb_data *dev, int count, size_t size)
 		}
 		unode->urb = urb;
 
-		buf = usb_alloc_coherent(dev->udev, MAX_TRANSFER, GFP_KERNEL,
+		buf = usb_alloc_coherent(dlfb->udev, MAX_TRANSFER, GFP_KERNEL,
 					 &urb->transfer_dma);
 		if (!buf) {
 			kfree(unode);
@@ -1876,23 +1876,23 @@ static int dlfb_alloc_urb_list(struct dlfb_data *dev, int count, size_t size)
 		}
 
 		/* urb->transfer_buffer_length set to actual before submit */
-		usb_fill_bulk_urb(urb, dev->udev, usb_sndbulkpipe(dev->udev, 1),
+		usb_fill_bulk_urb(urb, dlfb->udev, usb_sndbulkpipe(dlfb->udev, 1),
 			buf, size, dlfb_urb_completion, unode);
 		urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
 
-		list_add_tail(&unode->entry, &dev->urbs.list);
+		list_add_tail(&unode->entry, &dlfb->urbs.list);
 
 		i++;
 	}
 
-	sema_init(&dev->urbs.limit_sem, i);
-	dev->urbs.count = i;
-	dev->urbs.available = i;
+	sema_init(&dlfb->urbs.limit_sem, i);
+	dlfb->urbs.count = i;
+	dlfb->urbs.available = i;
 
 	return i;
 }
 
-static struct urb *dlfb_get_urb(struct dlfb_data *dev)
+static struct urb *dlfb_get_urb(struct dlfb_data *dlfb)
 {
 	int ret;
 	struct list_head *entry;
@@ -1900,38 +1900,38 @@ static struct urb *dlfb_get_urb(struct dlfb_data *dev)
 	unsigned long flags;
 
 	/* Wait for an in-flight buffer to complete and get re-queued */
-	ret = down_timeout(&dev->urbs.limit_sem, GET_URB_TIMEOUT);
+	ret = down_timeout(&dlfb->urbs.limit_sem, GET_URB_TIMEOUT);
 	if (ret) {
-		atomic_set(&dev->lost_pixels, 1);
+		atomic_set(&dlfb->lost_pixels, 1);
 		pr_warn("wait for urb interrupted: %x available: %d\n",
-		       ret, dev->urbs.available);
+		       ret, dlfb->urbs.available);
 		return NULL;
 	}
 
-	spin_lock_irqsave(&dev->urbs.lock, flags);
+	spin_lock_irqsave(&dlfb->urbs.lock, flags);
 
-	BUG_ON(list_empty(&dev->urbs.list)); /* reserved one with limit_sem */
-	entry = dev->urbs.list.next;
+	BUG_ON(list_empty(&dlfb->urbs.list)); /* reserved one with limit_sem */
+	entry = dlfb->urbs.list.next;
 	list_del_init(entry);
-	dev->urbs.available--;
+	dlfb->urbs.available--;
 
-	spin_unlock_irqrestore(&dev->urbs.lock, flags);
+	spin_unlock_irqrestore(&dlfb->urbs.lock, flags);
 
 	unode = list_entry(entry, struct urb_node, entry);
 	return unode->urb;
 }
 
-static int dlfb_submit_urb(struct dlfb_data *dev, struct urb *urb, size_t len)
+static int dlfb_submit_urb(struct dlfb_data *dlfb, struct urb *urb, size_t len)
 {
 	int ret;
 
-	BUG_ON(len > dev->urbs.size);
+	BUG_ON(len > dlfb->urbs.size);
 
 	urb->transfer_buffer_length = len; /* set to actual payload len */
 	ret = usb_submit_urb(urb, GFP_KERNEL);
 	if (ret) {
 		dlfb_urb_completion(urb); /* because no one else will */
-		atomic_set(&dev->lost_pixels, 1);
+		atomic_set(&dlfb->lost_pixels, 1);
 		pr_err("usb_submit_urb error %x\n", ret);
 	}
 	return ret;
diff --git a/include/video/udlfb.h b/include/video/udlfb.h
index 7b4f567dd1fe..0cabe6b09095 100644
--- a/include/video/udlfb.h
+++ b/include/video/udlfb.h
@@ -19,7 +19,7 @@ struct dloarea {
 
 struct urb_node {
 	struct list_head entry;
-	struct dlfb_data *dev;
+	struct dlfb_data *dlfb;
 	struct delayed_work release_urb_work;
 	struct urb *urb;
 };
-- 
2.15.1

