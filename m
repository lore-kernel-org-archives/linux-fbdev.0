From: Antonino Daplas <adaplas@gmail.com>
Subject: [PATCH 07/15] ps3fb: Dont keep the borders for
 non-fullscreen modes in XDR memory
Date: Sat, 13 Oct 2007 08:27:15 +0800
Message-ID: <471010E3.2090205@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IgUyG-0005Nn-6F for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 12 Oct 2007 17:35:12 -0700
Received: from rv-out-0910.google.com ([209.85.198.191])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IgUyF-0002xt-Nb
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 12 Oct 2007 17:35:12 -0700
Received: by rv-out-0910.google.com with SMTP id g11so3588679rvb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 12 Oct 2007 17:35:11 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

Don't keep the borders for non-fullscreen modes in XDR memory:
  - Extract ps3fb_sync_image()
  - Work around the alignment restrictions of L1GPU_CONTEXT_ATTRIBUTE_FB_BLIT
    by using an offset with L1GPU_CONTEXT_ATTRIBUTE_DISPLAY_FLIP
  - Only copy the visible part of the screen on every vblank
  - Always put the real frame buffer at the start of video memory
  - Clear fullscreen DDR memory on mode change

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/ps3fb.c |  131 ++++++++++++++++++++++++++++---------------------
 1 files changed, 75 insertions(+), 56 deletions(-)

diff --git a/drivers/video/ps3fb.c b/drivers/video/ps3fb.c
index 2f6080e..41139cb 100644
--- a/drivers/video/ps3fb.c
+++ b/drivers/video/ps3fb.c
@@ -54,6 +54,7 @@ #define L1GPU_DISPLAY_SYNC_VSYNC		2
 #define DDR_SIZE				(0)	/* used no ddr */
 #define GPU_CMD_BUF_SIZE			(64 * 1024)
 #define GPU_IOIF				(0x0d000000UL)
+#define GPU_ALIGN_UP(x)				_ALIGN_UP((x), 64)
 
 #define PS3FB_FULL_MODE_BIT			0x80
 
@@ -136,6 +137,10 @@ struct ps3fb_par {
 	int mode_id, new_mode_id;
 	int res_index;
 	unsigned int num_frames;	/* num of frame buffers */
+	unsigned int width;
+	unsigned int height;
+	unsigned long full_offset;	/* start of fullscreen DDR fb */
+	unsigned long fb_offset;	/* start of actual DDR fb */
 };
 
 struct ps3fb_res_table {
@@ -291,15 +296,6 @@ #define BPP		4			/* number of bytes per 
 /* Start of the virtual frame buffer (relative to fullscreen ) */
 #define VP_OFF(i)	((WIDTH(i) * Y_OFF(i) + X_OFF(i)) * BPP)
 
-/*
- * Start of the virtual frame buffer (relative to start of video memory)
- * This is PAGE_SIZE aligned for easier mmap()
- */
-#define VFB_OFF(i)	PAGE_ALIGN(VP_OFF(i))
-
-/* Start of the fullscreen frame buffer (relative to start of video memory) */
-#define FB_OFF(i)	(-VP_OFF(i) & ~PAGE_MASK)
-
 
 static int ps3fb_mode;
 module_param(ps3fb_mode, int, 0);
@@ -386,63 +382,72 @@ static const struct fb_videomode *ps3fb_
 	return &ps3fb_modedb[mode - 1];
 }
 
-static int ps3fb_sync(struct fb_info *info, u32 frame)
+static void ps3fb_sync_image(struct device *dev, u64 frame_offset,
+			     u64 dst_offset, u64 src_offset, u32 width,
+			     u32 height, u64 line_length)
 {
-	struct ps3fb_par *par = info->par;
-	int i, status, error = 0;
-	u32 xres, yres;
-	u64 fb_ioif, offset;
-
-	acquire_console_sem();
-
-	i = par->res_index;
-	xres = ps3fb_res[i].xres;
-	yres = ps3fb_res[i].yres;
-
-	if (frame > par->num_frames - 1) {
-		dev_dbg(info->device, "%s: invalid frame number (%u)\n",
-			__func__, frame);
-		error = -EINVAL;
-		goto out;
-	}
-	offset = xres * yres * BPP * frame;
+	int status;
 
-	fb_ioif = GPU_IOIF + FB_OFF(i) + offset;
 	status = lv1_gpu_context_attribute(ps3fb.context_handle,
 					   L1GPU_CONTEXT_ATTRIBUTE_FB_BLIT,
-					   offset, fb_ioif,
+					   dst_offset, GPU_IOIF + src_offset,
 					   L1GPU_FB_BLIT_WAIT_FOR_COMPLETION |
-					   (xres << 16) | yres,
-					   xres * BPP);	/* line_length */
+					   (width << 16) | height,
+					   line_length);
 	if (status)
-		dev_err(info->device,
+		dev_err(dev,
 			"%s: lv1_gpu_context_attribute FB_BLIT failed: %d\n",
 			__func__, status);
 #ifdef HEAD_A
 	status = lv1_gpu_context_attribute(ps3fb.context_handle,
 					   L1GPU_CONTEXT_ATTRIBUTE_DISPLAY_FLIP,
-					   0, offset, 0, 0);
+					   0, frame_offset, 0, 0);
 	if (status)
-		dev_err(info->device,
-			"%s: lv1_gpu_context_attribute FLIP failed: %d\n",
+		dev_err(dev, "%s: lv1_gpu_context_attribute FLIP failed: %d\n",
 			__func__, status);
 #endif
 #ifdef HEAD_B
 	status = lv1_gpu_context_attribute(ps3fb.context_handle,
 					   L1GPU_CONTEXT_ATTRIBUTE_DISPLAY_FLIP,
-					   1, offset, 0, 0);
+					   1, frame_offset, 0, 0);
 	if (status)
-		dev_err(info->device,
-			"%s: lv1_gpu_context_attribute FLIP failed: %d\n",
+		dev_err(dev, "%s: lv1_gpu_context_attribute FLIP failed: %d\n",
 			__func__, status);
 #endif
+}
+
+static int ps3fb_sync(struct fb_info *info, u32 frame)
+{
+	struct ps3fb_par *par = info->par;
+	int i, error = 0;
+	u32 xres, yres;
+	u64 line_length, base;
+
+	acquire_console_sem();
+
+	if (frame > par->num_frames - 1) {
+		dev_dbg(info->device, "%s: invalid frame number (%u)\n",
+			__func__, frame);
+		error = -EINVAL;
+		goto out;
+	}
+
+	i = par->res_index;
+	xres = ps3fb_res[i].xres;
+	yres = ps3fb_res[i].yres;
+
+	line_length = xres * BPP;
+	base = frame * yres * line_length;
+
+	ps3fb_sync_image(info->device, base + par->full_offset,
+			 base + par->fb_offset, base, par->width, par->height,
+			 line_length);
 
 out:
 	release_console_sem();
 	return error;
 }
 
-
 static int ps3fb_open(struct fb_info *info, int user)
 {
 	atomic_inc(&ps3fb.f_count);
@@ -472,7 +477,6 @@ static int ps3fb_check_var(struct fb_var
 {
 	u32 line_length;
 	int mode;
-	int i;
 
 	dev_dbg(info->device, "var->xres:%u info->var.xres:%u\n", var->xres,
 		info->var.xres);
@@ -539,9 +543,7 @@ static int ps3fb_check_var(struct fb_var
 	}
 
 	/* Memory limit */
-	i = ps3fb_get_res_table(var->xres, var->yres, mode);
-	if (ps3fb_res[i].xres*ps3fb_res[i].yres*BPP >
-	    ps3fb.xdr_size - VFB_OFF(i)) {
+	if (var->yres * line_length > ps3fb.xdr_size) {
 		dev_dbg(info->device, "Not enough memory\n");
 		return -ENOMEM;
 	}
@@ -559,9 +561,9 @@ static int ps3fb_check_var(struct fb_var
 static int ps3fb_set_par(struct fb_info *info)
 {
 	struct ps3fb_par *par = info->par;
-	unsigned int mode;
+	unsigned int mode, lines, maxlines;
 	int i;
-	unsigned long offset;
+	unsigned long offset, dst;
 
 	dev_dbg(info->device, "xres:%d xv:%d yres:%d yv:%d clock:%d\n",
 		info->var.xres, info->var.xres_virtual,
@@ -574,11 +576,9 @@ static int ps3fb_set_par(struct fb_info 
 	i = ps3fb_get_res_table(info->var.xres, info->var.yres, mode);
 	par->res_index = i;
 
-	offset = VFB_OFF(i);
-	info->fix.smem_start = virt_to_abs(ps3fb.xdr_ea) + offset;
-	info->fix.smem_len = ps3fb.xdr_size - offset;
-	info->screen_base = (char __iomem *)ps3fb.xdr_ea + offset;
-	memset(ps3fb.xdr_ea, 0, ps3fb.xdr_size);
+	info->fix.smem_start = virt_to_abs(ps3fb.xdr_ea);
+	info->fix.smem_len = ps3fb.xdr_size;
+	info->screen_base = (char __iomem *)ps3fb.xdr_ea;
 
 	par->num_frames = info->fix.smem_len/
 			  (ps3fb_res[i].xres*ps3fb_res[i].yres*BPP);
@@ -586,6 +586,12 @@ static int ps3fb_set_par(struct fb_info 
 	/* Keep the special bits we cannot set using fb_var_screeninfo */
 	par->new_mode_id = (par->new_mode_id & ~PS3AV_MODE_MASK) | mode;
 
+	par->width = info->var.xres;
+	par->height = info->var.yres;
+	offset = VP_OFF(i);
+	par->fb_offset = GPU_ALIGN_UP(offset);
+	par->full_offset = par->fb_offset - offset;
+
 	if (par->new_mode_id != par->mode_id) {
 		if (ps3av_set_video_mode(par->new_mode_id)) {
 			par->new_mode_id = par->mode_id;
@@ -594,6 +600,21 @@ static int ps3fb_set_par(struct fb_info 
 		par->mode_id = par->new_mode_id;
 	}
 
+	/* Clear XDR frame buffer memory */
+	memset(ps3fb.xdr_ea, 0, ps3fb.xdr_size);
+
+	/* Clear DDR frame buffer memory */
+	lines = ps3fb_res[i].yres * par->num_frames;
+	if (par->full_offset)
+		lines++;
+	maxlines = ps3fb.xdr_size / info->fix.line_length;
+	for (dst = 0; lines; dst += maxlines * info->fix.line_length) {
+		unsigned int l = min(lines, maxlines);
+		ps3fb_sync_image(info->device, 0, dst, 0, ps3fb_res[i].xres, l,
+				 info->fix.line_length);
+		lines -= l;
+	}
+
 	return 0;
 }
 
@@ -1005,7 +1026,6 @@ static int __devinit ps3fb_probe(struct 
 	u64 lpar_reports_size = 0;
 	u64 xdr_lpar;
 	int status, res_index;
-	unsigned long offset;
 	struct task_struct *task;
 
 	status = ps3_open_hv_device(dev);
@@ -1088,13 +1108,12 @@ static int __devinit ps3fb_probe(struct 
 	par->res_index = res_index;
 	par->num_frames = 1;
 
-	offset = VFB_OFF(res_index);
-	info->screen_base = (char __iomem *)ps3fb.xdr_ea + offset;
+	info->screen_base = (char __iomem *)ps3fb.xdr_ea;
 	info->fbops = &ps3fb_ops;
 
 	info->fix = ps3fb_fix;
-	info->fix.smem_start = virt_to_abs(ps3fb.xdr_ea) + offset;
-	info->fix.smem_len = ps3fb.xdr_size - offset;
+	info->fix.smem_start = virt_to_abs(ps3fb.xdr_ea);
+	info->fix.smem_len = ps3fb.xdr_size;
 	info->pseudo_palette = par->pseudo_palette;
 	info->flags = FBINFO_DEFAULT | FBINFO_READS_FAST;
 


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
