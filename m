From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 17/33] pm3fb: improvements and cleanups
Date: Thu, 26 Jul 2007 20:22:56 +0800
Message-ID: <46A89220.4070003@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IE2uS-00012W-KY for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 26 Jul 2007 05:57:40 -0700
Received: from wa-out-1112.google.com ([209.85.146.178])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IE2uS-00084u-7p
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 26 Jul 2007 05:57:40 -0700
Received: by wa-out-1112.google.com with SMTP id k22so614502waf
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 26 Jul 2007 05:57:40 -0700 (PDT)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch contains improvements:
- it adds ROP_XOR in pm3fb_fillrect()
- it conforms closer to coding style
- it removes redundant parentheses and setting bits with 0 value
- it checks if hardware acceleration is disabled in pm3fb_imageblit
- it adds module description

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/pm3fb.c |   68 +++++++++++++++++++++++++++----------------------
 1 files changed, 38 insertions(+), 30 deletions(-)

diff --git a/drivers/video/pm3fb.c b/drivers/video/pm3fb.c
index fb91b64..88af072 100644
--- a/drivers/video/pm3fb.c
+++ b/drivers/video/pm3fb.c
@@ -135,7 +135,7 @@ static void pm3fb_clear_colormap(struct 
 
 }
 
-/* Calculating various clock parameter */
+/* Calculating various clock parameters */
 static void pm3fb_calculate_clock(unsigned long reqclock,
 				unsigned char *prescale,
 				unsigned char *feedback,
@@ -166,7 +166,7 @@ static void pm3fb_calculate_clock(unsign
 
 static inline int pm3fb_depth(const struct fb_var_screeninfo *var)
 {
-	if ( var->bits_per_pixel == 16 )
+	if (var->bits_per_pixel == 16)
 		return var->red.length + var->green.length
 			+ var->blue.length;
 
@@ -351,7 +351,7 @@ #endif
 
 	PM3_WRITE_REG(par, PM3dXDom, 0x0);
 	PM3_WRITE_REG(par, PM3dXSub, 0x0);
-	PM3_WRITE_REG(par, PM3dY, (1 << 16));
+	PM3_WRITE_REG(par, PM3dY, 1 << 16);
 	PM3_WRITE_REG(par, PM3StartXDom, 0x0);
 	PM3_WRITE_REG(par, PM3StartXSub, 0x0);
 	PM3_WRITE_REG(par, PM3StartY, 0x0);
@@ -372,16 +372,21 @@ static void pm3fb_fillrect (struct fb_in
 	struct pm3_par *par = info->par;
 	struct fb_fillrect modded;
 	int vxres, vyres;
+	int rop;
 	u32 color = (info->fix.visual == FB_VISUAL_TRUECOLOR) ?
 		((u32*)info->pseudo_palette)[region->color] : region->color;
 
 	if (info->state != FBINFO_STATE_RUNNING)
 		return;
-	if ((info->flags & FBINFO_HWACCEL_DISABLED) ||
-		region->rop != ROP_COPY ) {
+	if (info->flags & FBINFO_HWACCEL_DISABLED) {
 		cfb_fillrect(info, region);
 		return;
 	}
+	if (region->rop == ROP_COPY )
+		rop = PM3Config2D_ForegroundROP(0x3); /* GXcopy */
+	else
+		rop = PM3Config2D_ForegroundROP(0x6) | /* GXxor */
+			PM3Config2D_FBDestReadEnable;
 
 	vxres = info->var.xres_virtual;
 	vyres = info->var.yres_virtual;
@@ -407,22 +412,22 @@ static void pm3fb_fillrect (struct fb_in
 	PM3_WRITE_REG(par, PM3Config2D,
 			PM3Config2D_UseConstantSource |
 			PM3Config2D_ForegroundROPEnable |
-			(PM3Config2D_ForegroundROP(0x3)) |
+			rop |
 			PM3Config2D_FBWriteEnable);
 
 	PM3_WRITE_REG(par, PM3ForegroundColor, color);
 
 	PM3_WRITE_REG(par, PM3RectanglePosition,
-			(PM3RectanglePosition_XOffset(modded.dx)) |
-			(PM3RectanglePosition_YOffset(modded.dy)));
+			PM3RectanglePosition_XOffset(modded.dx) |
+			PM3RectanglePosition_YOffset(modded.dy));
 
 	PM3_WRITE_REG(par, PM3Render2D,
 		      PM3Render2D_XPositive |
 		      PM3Render2D_YPositive |
 		      PM3Render2D_Operation_Normal |
 		      PM3Render2D_SpanOperation |
-		      (PM3Render2D_Width(modded.width)) |
-		      (PM3Render2D_Height(modded.height)));
+		      PM3Render2D_Width(modded.width) |
+		      PM3Render2D_Height(modded.height));
 }
 
 static void pm3fb_copyarea(struct fb_info *info,
@@ -470,7 +475,7 @@ static void pm3fb_copyarea(struct fb_inf
 			PM3Config2D_UserScissorEnable |
 			PM3Config2D_ForegroundROPEnable |
 			PM3Config2D_Blocking |
-			(PM3Config2D_ForegroundROP(0x3)) | /* Ox3 is GXcopy */
+			PM3Config2D_ForegroundROP(0x3) | /* Ox3 is GXcopy */
 			PM3Config2D_FBWriteEnable);
 
 	PM3_WRITE_REG(par, PM3ScissorMinXY,
@@ -484,8 +489,8 @@ static void pm3fb_copyarea(struct fb_inf
 			PM3FBSourceReadBufferOffset_YOffset(o_y));
 
 	PM3_WRITE_REG(par, PM3RectanglePosition,
-			(PM3RectanglePosition_XOffset(modded.dx - x_align)) |
-			(PM3RectanglePosition_YOffset(modded.dy)));
+			PM3RectanglePosition_XOffset(modded.dx - x_align) |
+			PM3RectanglePosition_YOffset(modded.dy));
 
 	PM3_WRITE_REG(par, PM3Render2D,
 			((modded.sx > modded.dx) ? PM3Render2D_XPositive : 0) |
@@ -493,8 +498,8 @@ static void pm3fb_copyarea(struct fb_inf
 			PM3Render2D_Operation_Normal |
 			PM3Render2D_SpanOperation |
 			PM3Render2D_FBSourceReadEnable |
-			(PM3Render2D_Width(modded.width + x_align)) |
-			(PM3Render2D_Height(modded.height)));
+			PM3Render2D_Width(modded.width + x_align) |
+			PM3Render2D_Height(modded.height));
 }
 
 static void pm3fb_imageblit(struct fb_info *info, const struct fb_image *image)
@@ -504,6 +509,12 @@ static void pm3fb_imageblit(struct fb_in
 	u32 fgx, bgx;
 	const u32 *src = (const u32*)image->data;
 
+	if (info->state != FBINFO_STATE_RUNNING)
+		return;
+	if (info->flags & FBINFO_HWACCEL_DISABLED) {
+		cfb_imageblit(info, image);
+		return;
+	}
 	switch (info->fix.visual) {
 		case FB_VISUAL_PSEUDOCOLOR:
 			fgx = image->fg_color;
@@ -537,7 +548,7 @@ static void pm3fb_imageblit(struct fb_in
 			PM3Config2D_UserScissorEnable |
 			PM3Config2D_UseConstantSource |
 			PM3Config2D_ForegroundROPEnable |
-			(PM3Config2D_ForegroundROP(0x3)) |
+			PM3Config2D_ForegroundROP(0x3) |
 			PM3Config2D_OpaqueSpan |
 			PM3Config2D_FBWriteEnable);
 	PM3_WRITE_REG(par, PM3ScissorMinXY,
@@ -546,15 +557,15 @@ static void pm3fb_imageblit(struct fb_in
 			(((image->dy + image->height) & 0x0fff) << 16) |
 			((image->dx + image->width) & 0x0fff));
 	PM3_WRITE_REG(par, PM3RectanglePosition,
-			(PM3RectanglePosition_XOffset(image->dx)) |
-			(PM3RectanglePosition_YOffset(image->dy)));
+			PM3RectanglePosition_XOffset(image->dx) |
+			PM3RectanglePosition_YOffset(image->dy));
 	PM3_WRITE_REG(par, PM3Render2D,
 			PM3Render2D_XPositive |
 			PM3Render2D_YPositive |
 			PM3Render2D_Operation_SyncOnBitMask |
 			PM3Render2D_SpanOperation |
-			(PM3Render2D_Width(image->width)) |
-			(PM3Render2D_Height(image->height)));
+			PM3Render2D_Width(image->width) |
+			PM3Render2D_Height(image->height));
 
 
 	while (height--) {
@@ -783,7 +794,7 @@ static int pm3fb_check_var(struct fb_var
 	unsigned bpp = var->red.length + var->green.length
 			+ var->blue.length + var->transp.length;
 
-	if ( bpp != var->bits_per_pixel ) {
+	if (bpp != var->bits_per_pixel) {
 		/* set predefined mode for bits_per_pixel settings */
 
 		switch(var->bits_per_pixel) {
@@ -838,7 +849,7 @@ static int pm3fb_check_var(struct fb_var
 	}
 
 	var->xres = (var->xres + 31) & ~31; /* could sometimes be 8 */
-	lpitch = var->xres * ((var->bits_per_pixel + 7)>>3);
+	lpitch = var->xres * ((var->bits_per_pixel + 7) >> 3);
 
 	if (var->xres < 200 || var->xres > 2048) {
 		DPRINTK("width not supported: %u\n", var->xres);
@@ -890,15 +901,12 @@ static int pm3fb_set_par(struct fb_info 
 
 	if ((info->var.vmode & FB_VMODE_MASK) == FB_VMODE_DOUBLE)
 		par->video |= PM3VideoControl_LINE_DOUBLE_ON;
-	else
-		par->video |= PM3VideoControl_LINE_DOUBLE_OFF;
 
 	if ((info->var.activate & FB_ACTIVATE_MASK) == FB_ACTIVATE_NOW)
 		par->video |= PM3VideoControl_ENABLE;
-	else {
-		par->video &= ~PM3VideoControl_ENABLE;
+	else
 		DPRINTK("PM3Video disabled\n");
-	}
+
 	switch (bpp) {
 	case 8:
 		par->video |= PM3VideoControl_PIXELSIZE_8BIT;
@@ -916,8 +924,7 @@ static int pm3fb_set_par(struct fb_info 
 
 	info->fix.visual =
 		(bpp == 8) ? FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_TRUECOLOR;
-	info->fix.line_length = ((info->var.xres_virtual + 7)  & ~7)
-					* bpp / 8;
+	info->fix.line_length = ((info->var.xres_virtual + 7)  >> 3) * bpp;
 
 /*	pm3fb_clear_memory(info, 0);*/
 	pm3fb_clear_colormap(par, 0, 0, 0);
@@ -1035,7 +1042,7 @@ static int pm3fb_blank(int blank_mode, s
 		video |= PM3VideoControl_ENABLE;
 		break;
 	case FB_BLANK_NORMAL:
-		video &= ~(PM3VideoControl_ENABLE);
+		video &= ~PM3VideoControl_ENABLE;
 		break;
 	case FB_BLANK_HSYNC_SUSPEND:
 		video &= ~(PM3VideoControl_HSYNC_MASK |
@@ -1367,4 +1374,5 @@ static void __exit pm3fb_exit(void)
 module_init(pm3fb_init);
 module_exit(pm3fb_exit);
 
+MODULE_DESCRIPTION("Permedia3 framebuffer device driver");
 MODULE_LICENSE("GPL");


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
