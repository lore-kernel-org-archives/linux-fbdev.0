From: Antonino Daplas <adaplas@gmail.com>
Subject: [PATCH 08/15] ps3fb: Add virtual screen and
	panning support
Date: Sat, 13 Oct 2007 08:28:14 +0800
Message-ID: <4710111E.50806@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IgUyO-0005O2-4X for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 12 Oct 2007 17:35:20 -0700
Received: from rv-out-0910.google.com ([209.85.198.191])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IgUyM-0002xt-Oc
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 12 Oct 2007 17:35:20 -0700
Received: by rv-out-0910.google.com with SMTP id g11so3588679rvb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 12 Oct 2007 17:35:18 -0700 (PDT)
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

ps3fb: Add virtual screen and panning support:
  - The vertical virtual screen size is limited by the amount of memory
    reserved for ps3fb,
  - The horizontal virtual screen size is limited to the fullscreen width,
  - Advertise that we support panning, so fbcon will use it if the virtual
    screen is enabled.
    Enabling a virtual screen (using `fbset -vyres nnn') can speed up text
    console scrolling by a factor of 10-15, depending on the video mode.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/ps3fb.c |   65 ++++++++++++++++++++++++++++++-------------------
 1 files changed, 40 insertions(+), 25 deletions(-)

diff --git a/drivers/video/ps3fb.c b/drivers/video/ps3fb.c
index 41139cb..a57c08b 100644
--- a/drivers/video/ps3fb.c
+++ b/drivers/video/ps3fb.c
@@ -141,6 +141,7 @@ struct ps3fb_par {
 	unsigned int height;
 	unsigned long full_offset;	/* start of fullscreen DDR fb */
 	unsigned long fb_offset;	/* start of actual DDR fb */
+	unsigned long pan_offset;
 };
 
 struct ps3fb_res_table {
@@ -440,8 +441,8 @@ static int ps3fb_sync(struct fb_info *in
 	base = frame * yres * line_length;
 
 	ps3fb_sync_image(info->device, base + par->full_offset,
-			 base + par->fb_offset, base, par->width, par->height,
-			 line_length);
+			 base + par->fb_offset, base + par->pan_offset,
+			 par->width, par->height, line_length);
 
 out:
 	release_console_sem();
@@ -488,27 +489,23 @@ static int ps3fb_check_var(struct fb_var
 	if (!mode)
 		return -EINVAL;
 
-	/*
-	 *  FB_VMODE_CONUPDATE and FB_VMODE_SMOOTH_XPAN are equal!
-	 *  as FB_VMODE_SMOOTH_XPAN is only used internally
-	 */
+	/* Virtual screen */
+	if (var->xres_virtual < var->xres)
+		var->xres_virtual = var->xres;
+	if (var->yres_virtual < var->yres)
+		var->yres_virtual = var->yres;
 
-	if (var->vmode & FB_VMODE_CONUPDATE) {
-		var->vmode |= FB_VMODE_YWRAP;
-		var->xoffset = info->var.xoffset;
-		var->yoffset = info->var.yoffset;
-	}
-
-	/* Virtual screen and panning are not supported */
-	if (var->xres_virtual > var->xres || var->yres_virtual > var->yres ||
-	    var->xoffset || var->yoffset) {
+	if (var->xres_virtual > line_length / BPP) {
 		dev_dbg(info->device,
-			"Virtual screen and panning are not supported\n");
+			"Horizontal virtual screen size too large\n");
 		return -EINVAL;
 	}
 
-	var->xres_virtual = var->xres;
-	var->yres_virtual = var->yres;
+	if (var->xoffset + var->xres > var->xres_virtual ||
+	    var->yoffset + var->yres > var->yres_virtual) {
+		dev_dbg(info->device, "panning out-of-range\n");
+		return -EINVAL;
+	}
 
 	/* We support ARGB8888 only */
 	if (var->bits_per_pixel > 32 || var->grayscale ||
@@ -543,7 +540,7 @@ static int ps3fb_check_var(struct fb_var
 	}
 
 	/* Memory limit */
-	if (var->yres * line_length > ps3fb.xdr_size) {
+	if (var->yres_virtual * line_length > ps3fb.xdr_size) {
 		dev_dbg(info->device, "Not enough memory\n");
 		return -ENOMEM;
 	}
@@ -561,7 +558,7 @@ static int ps3fb_check_var(struct fb_var
 static int ps3fb_set_par(struct fb_info *info)
 {
 	struct ps3fb_par *par = info->par;
-	unsigned int mode, lines, maxlines;
+	unsigned int mode, line_length, lines, maxlines;
 	int i;
 	unsigned long offset, dst;
 
@@ -569,7 +566,7 @@ static int ps3fb_set_par(struct fb_info 
 		info->var.xres, info->var.xres_virtual,
 		info->var.yres, info->var.yres_virtual, info->var.pixclock);
 
-	mode = ps3fb_find_mode(&info->var, &info->fix.line_length);
+	mode = ps3fb_find_mode(&info->var, &line_length);
 	if (!mode)
 		return -EINVAL;
 
@@ -578,6 +575,10 @@ static int ps3fb_set_par(struct fb_info 
 
 	info->fix.smem_start = virt_to_abs(ps3fb.xdr_ea);
 	info->fix.smem_len = ps3fb.xdr_size;
+	info->fix.xpanstep = info->var.xres_virtual > info->var.xres ? 1 : 0;
+	info->fix.ypanstep = info->var.yres_virtual > info->var.yres ? 1 : 0;
+	info->fix.line_length = line_length;
+
 	info->screen_base = (char __iomem *)ps3fb.xdr_ea;
 
 	par->num_frames = info->fix.smem_len/
@@ -591,6 +592,8 @@ static int ps3fb_set_par(struct fb_info 
 	offset = VP_OFF(i);
 	par->fb_offset = GPU_ALIGN_UP(offset);
 	par->full_offset = par->fb_offset - offset;
+	par->pan_offset = info->var.yoffset * line_length +
+			  info->var.xoffset * BPP;
 
 	if (par->new_mode_id != par->mode_id) {
 		if (ps3av_set_video_mode(par->new_mode_id)) {
@@ -607,11 +610,11 @@ static int ps3fb_set_par(struct fb_info 
 	lines = ps3fb_res[i].yres * par->num_frames;
 	if (par->full_offset)
 		lines++;
-	maxlines = ps3fb.xdr_size / info->fix.line_length;
-	for (dst = 0; lines; dst += maxlines * info->fix.line_length) {
+	maxlines = ps3fb.xdr_size / line_length;
+	for (dst = 0; lines; dst += maxlines * line_length) {
 		unsigned int l = min(lines, maxlines);
 		ps3fb_sync_image(info->device, 0, dst, 0, ps3fb_res[i].xres, l,
-				 info->fix.line_length);
+				 line_length);
 		lines -= l;
 	}
 
@@ -641,6 +644,16 @@ static int ps3fb_setcolreg(unsigned int 
 	return 0;
 }
 
+static int ps3fb_pan_display(struct fb_var_screeninfo *var,
+			     struct fb_info *info)
+{
+	struct ps3fb_par *par = info->par;
+
+	par->pan_offset = var->yoffset * info->fix.line_length +
+			  var->xoffset * BPP;
+	return 0;
+}
+
     /*
      *  As we have a virtual frame buffer, we need our own mmap function
      */
@@ -965,6 +978,7 @@ static struct fb_ops ps3fb_ops = {
 	.fb_check_var	= ps3fb_check_var,
 	.fb_set_par	= ps3fb_set_par,
 	.fb_setcolreg	= ps3fb_setcolreg,
+	.fb_pan_display	= ps3fb_pan_display,
 	.fb_fillrect	= sys_fillrect,
 	.fb_copyarea	= sys_copyarea,
 	.fb_imageblit	= sys_imageblit,
@@ -1115,7 +1129,8 @@ static int __devinit ps3fb_probe(struct 
 	info->fix.smem_start = virt_to_abs(ps3fb.xdr_ea);
 	info->fix.smem_len = ps3fb.xdr_size;
 	info->pseudo_palette = par->pseudo_palette;
-	info->flags = FBINFO_DEFAULT | FBINFO_READS_FAST;
+	info->flags = FBINFO_DEFAULT | FBINFO_READS_FAST |
+		      FBINFO_HWACCEL_XPAN | FBINFO_HWACCEL_YPAN;
 
 	retval = fb_alloc_cmap(&info->cmap, 256, 0);
 	if (retval < 0)


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
