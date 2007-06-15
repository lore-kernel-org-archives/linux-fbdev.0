From: Krzysztof Helt <krzysztof.h1@wp.pl>
Subject: [PATCH] pm3fb: improvements and cleanups
Date: Fri, 15 Jun 2007 06:22:48 +0200
Message-ID: <46721418.5060201@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010202000406080001080400"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hz3JQ-0003qo-Se for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 14 Jun 2007 21:21:28 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Hz3JP-0004cS-Re
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 14 Jun 2007 21:21:28 -0700
Received: from host-87-99-61-239.lanet.net.pl (HELO [87.99.61.239])
	(krzysztof.h1@[87.99.61.239]) (envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>;
	15 Jun 2007 06:21:17 +0200
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------010202000406080001080400
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch contains improvements:
- it adds ROP_XOR in pm3fb_fillrect()
- it conforms closer to coding style
- it removes redundant parentheses and setting bits with 0 value
- it checks if hardware acceleration is disabled in pm3fb_imageblit
- it adds module description

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

This is a final patch in effort to port the pm3fb driver from the 2.4. I am going to stop development of this driver so please step in to test and contribute (especially people who can run it on big endian machines).

This patch requires all previous patches I sent to the list (acceleration and small fixes).

Kind regards,
Krzysztof

--- linux-2.6.21.old/drivers/video/pm3fb.c	2007-06-14 20:42:13.781206495 +0200
+++ linux-2.6.21/drivers/video/pm3fb.c	2007-06-14 20:43:59.287218880 +0200
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
 
@@ -351,7 +351,7 @@ static void pm3fb_init_engine(struct fb_
 
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
@@ -785,7 +796,7 @@ static int pm3fb_check_var(struct fb_var
 	unsigned bpp = var->red.length + var->green.length
 			+ var->blue.length + var->transp.length;
 
-	if ( bpp != var->bits_per_pixel ) {
+	if (bpp != var->bits_per_pixel) {
 		/* set predefined mode for bits_per_pixel settings */
 
 		switch(var->bits_per_pixel) {
@@ -840,7 +851,7 @@ static int pm3fb_check_var(struct fb_var
 	}
 
 	var->xres = (var->xres + 31) & ~31; /* could sometimes be 8 */
-	lpitch = var->xres * ((var->bits_per_pixel + 7)>>3);
+	lpitch = var->xres * ((var->bits_per_pixel + 7) >> 3);
 
 	if (var->xres < 200 || var->xres > 2048) {
 		DPRINTK("width not supported: %u\n", var->xres);
@@ -892,15 +903,12 @@ static int pm3fb_set_par(struct fb_info 
 
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
@@ -918,8 +926,7 @@ static int pm3fb_set_par(struct fb_info 
 
 	info->fix.visual =
 		(bpp == 8) ? FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_TRUECOLOR;
-	info->fix.line_length = ((info->var.xres_virtual + 7)  & ~7)
-					* bpp / 8;
+	info->fix.line_length = ((info->var.xres_virtual + 7)  >> 3) * bpp;
 
 	pm3fb_clear_colormap(par, 0, 0, 0);
 	PM3_WRITE_DAC_REG(par, PM3RD_CursorMode, 0);
@@ -1036,7 +1043,7 @@ static int pm3fb_blank(int blank_mode, s
 		video |= PM3VideoControl_ENABLE;
 		break;
 	case FB_BLANK_NORMAL:
-		video &= ~(PM3VideoControl_ENABLE);
+		video &= ~PM3VideoControl_ENABLE;
 		break;
 	case FB_BLANK_HSYNC_SUSPEND:
 		video &= ~(PM3VideoControl_HSYNC_MASK |
@@ -1391,4 +1398,5 @@ static void __exit pm3fb_exit(void)
 module_init(pm3fb_init);
 module_exit(pm3fb_exit);
 
+MODULE_DESCRIPTION("Permedia3 framebuffer device driver");
 MODULE_LICENSE("GPL");


--------------010202000406080001080400
Content-Type: text/plain;
 name="pm3fb-final.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pm3fb-final.diff"

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch contains improvements:
- it adds ROP_XOR in pm3fb_fillrect()
- it conforms closer to coding style
- it removes redundant parentheses and setting bits with 0 value
- it checks if hardware acceleration is disabled in pm3fb_imageblit
- it adds module description

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

--- linux-2.6.21.old/drivers/video/pm3fb.c	2007-06-14 20:42:13.781206495 +0200
+++ linux-2.6.21/drivers/video/pm3fb.c	2007-06-14 20:43:59.287218880 +0200
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
 
@@ -351,7 +351,7 @@ static void pm3fb_init_engine(struct fb_
 
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
@@ -785,7 +796,7 @@ static int pm3fb_check_var(struct fb_var
 	unsigned bpp = var->red.length + var->green.length
 			+ var->blue.length + var->transp.length;
 
-	if ( bpp != var->bits_per_pixel ) {
+	if (bpp != var->bits_per_pixel) {
 		/* set predefined mode for bits_per_pixel settings */
 
 		switch(var->bits_per_pixel) {
@@ -840,7 +851,7 @@ static int pm3fb_check_var(struct fb_var
 	}
 
 	var->xres = (var->xres + 31) & ~31; /* could sometimes be 8 */
-	lpitch = var->xres * ((var->bits_per_pixel + 7)>>3);
+	lpitch = var->xres * ((var->bits_per_pixel + 7) >> 3);
 
 	if (var->xres < 200 || var->xres > 2048) {
 		DPRINTK("width not supported: %u\n", var->xres);
@@ -892,15 +903,12 @@ static int pm3fb_set_par(struct fb_info 
 
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
@@ -918,8 +926,7 @@ static int pm3fb_set_par(struct fb_info 
 
 	info->fix.visual =
 		(bpp == 8) ? FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_TRUECOLOR;
-	info->fix.line_length = ((info->var.xres_virtual + 7)  & ~7)
-					* bpp / 8;
+	info->fix.line_length = ((info->var.xres_virtual + 7)  >> 3) * bpp;
 
 	pm3fb_clear_colormap(par, 0, 0, 0);
 	PM3_WRITE_DAC_REG(par, PM3RD_CursorMode, 0);
@@ -1036,7 +1043,7 @@ static int pm3fb_blank(int blank_mode, s
 		video |= PM3VideoControl_ENABLE;
 		break;
 	case FB_BLANK_NORMAL:
-		video &= ~(PM3VideoControl_ENABLE);
+		video &= ~PM3VideoControl_ENABLE;
 		break;
 	case FB_BLANK_HSYNC_SUSPEND:
 		video &= ~(PM3VideoControl_HSYNC_MASK |
@@ -1391,4 +1398,5 @@ static void __exit pm3fb_exit(void)
 module_init(pm3fb_init);
 module_exit(pm3fb_exit);
 
+MODULE_DESCRIPTION("Permedia3 framebuffer device driver");
 MODULE_LICENSE("GPL");

--------------010202000406080001080400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--------------010202000406080001080400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--------------010202000406080001080400--
