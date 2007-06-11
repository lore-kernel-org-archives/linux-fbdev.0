From: Krzysztof Helt <krzysztof.h1@wp.pl>
Subject: [PATCH] pm3fb: copyarea and partial imageblit
	support
Date: Tue, 12 Jun 2007 00:20:30 +0200
Message-ID: <466DCAAE.7000501@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060007090704020502090001"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HxsEO-000206-Sj for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 11 Jun 2007 15:19:24 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HxsEN-0001V7-EY
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 11 Jun 2007 15:19:24 -0700
Received: from host-87-99-61-239.lanet.net.pl (HELO [87.99.61.239])
	(krzysztof.h1@[87.99.61.239]) (envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>;
	12 Jun 2007 00:19:18 +0200
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------060007090704020502090001
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch adds accelerated copyarea and partially accelerated imageblit functions.
There is also fixed one register address in the pm3fb.h file.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---
--- linux-2.6.21.old/drivers/video/pm3fb.c	2007-06-11 23:53:24.314415340 +0200
+++ linux-2.6.21/drivers/video/pm3fb.c	2007-06-12 00:11:59.438496095 +0200
@@ -276,15 +276,22 @@ static void pm3fb_init_engine(struct fb_
 
 	PM3_WAIT(par, 2);
 	{
-		unsigned long rm = 1;
+		/* invert bits in bitmask */
+		unsigned long rm = 1 | (3 << 7);
 		switch (info->var.bits_per_pixel) {
 		case 8:
 			PM3_WRITE_REG(par, PM3PixelSize,
 					   PM3PixelSize_GLOBAL_8BIT);
+#ifdef __BIG_ENDIAN
+			rm |= 3 << 15;
+#endif
 			break;
 		case 16:
 			PM3_WRITE_REG(par, PM3PixelSize,
 					   PM3PixelSize_GLOBAL_16BIT);
+#ifdef __BIG_ENDIAN
+			rm |= 2 << 15;
+#endif
 			break;
 		case 32:
 			PM3_WRITE_REG(par, PM3PixelSize,
@@ -394,18 +401,18 @@ static void pm3fb_fillrect (struct fb_in
 		color |= color << 16;
 
 	PM3_WAIT(par, 4);
-
+	/* ROP Ox3 is GXcopy */
 	PM3_WRITE_REG(par, PM3Config2D,
-				  PM3Config2D_UseConstantSource |
-				  PM3Config2D_ForegroundROPEnable |
-				  (PM3Config2D_ForegroundROP(0x3)) |	/* Ox3 is GXcopy */
-				  PM3Config2D_FBWriteEnable);
+			PM3Config2D_UseConstantSource |
+			PM3Config2D_ForegroundROPEnable |
+			(PM3Config2D_ForegroundROP(0x3)) |
+			PM3Config2D_FBWriteEnable);
 
 	PM3_WRITE_REG(par, PM3ForegroundColor, color);
 
 	PM3_WRITE_REG(par, PM3RectanglePosition,
-		      (PM3RectanglePosition_XOffset(modded.dx)) |
-		      (PM3RectanglePosition_YOffset(modded.dy)));
+			(PM3RectanglePosition_XOffset(modded.dx)) |
+			(PM3RectanglePosition_YOffset(modded.dy)));
 
 	PM3_WRITE_REG(par, PM3Render2D,
 		      PM3Render2D_XPositive |
@@ -415,6 +422,154 @@ static void pm3fb_fillrect (struct fb_in
 		      (PM3Render2D_Width(modded.width)) |
 		      (PM3Render2D_Height(modded.height)));
 }
+
+static void pm3fb_copyarea(struct fb_info *info,
+				const struct fb_copyarea *area)
+{
+	struct pm3_par *par = info->par;
+	struct fb_copyarea modded;
+	u32 vxres, vyres;
+	int x_align, o_x, o_y;
+
+	if (info->state != FBINFO_STATE_RUNNING)
+		return;
+	if (info->flags & FBINFO_HWACCEL_DISABLED) {
+		cfb_copyarea(info, area);
+		return;
+	}
+
+	memcpy(&modded, area, sizeof(struct fb_copyarea));
+
+	vxres = info->var.xres_virtual;
+	vyres = info->var.yres_virtual;
+
+	if(!modded.width || !modded.height ||
+	   modded.sx >= vxres || modded.sy >= vyres ||
+	   modded.dx >= vxres || modded.dy >= vyres)
+		return;
+
+	if(modded.sx + modded.width > vxres)
+		modded.width = vxres - modded.sx;
+	if(modded.dx + modded.width > vxres)
+		modded.width = vxres - modded.dx;
+	if(modded.sy + modded.height > vyres)
+		modded.height = vyres - modded.sy;
+	if(modded.dy + modded.height > vyres)
+		modded.height = vyres - modded.dy;
+
+	o_x = modded.sx - modded.dx;	/*(sx > dx ) ? (sx - dx) : (dx - sx); */
+	o_y = modded.sy - modded.dy;	/*(sy > dy ) ? (sy - dy) : (dy - sy); */
+
+	x_align = (modded.sx & 0x1f);
+
+	PM3_WAIT(par, 6);
+
+	PM3_WRITE_REG(par, PM3Config2D,
+			PM3Config2D_UserScissorEnable |
+			PM3Config2D_ForegroundROPEnable |
+			PM3Config2D_Blocking |
+			(PM3Config2D_ForegroundROP(0x3)) | /* Ox3 is GXcopy */
+			PM3Config2D_FBWriteEnable);
+
+	PM3_WRITE_REG(par, PM3ScissorMinXY,
+			((modded.dy & 0x0fff) << 16) | (modded.dx & 0x0fff));
+	PM3_WRITE_REG(par, PM3ScissorMaxXY,
+			(((modded.dy + modded.height) & 0x0fff) << 16) |
+			((modded.dx + modded.width) & 0x0fff));
+
+	PM3_WRITE_REG(par, PM3FBSourceReadBufferOffset,
+			PM3FBSourceReadBufferOffset_XOffset(o_x) |
+			PM3FBSourceReadBufferOffset_YOffset(o_y));
+
+	PM3_WRITE_REG(par, PM3RectanglePosition,
+			(PM3RectanglePosition_XOffset(modded.dx - x_align)) |
+			(PM3RectanglePosition_YOffset(modded.dy)));
+
+	PM3_WRITE_REG(par, PM3Render2D,
+			((modded.sx > modded.dx) ? PM3Render2D_XPositive : 0) |
+			((modded.sy > modded.dy) ? PM3Render2D_YPositive : 0) |
+			PM3Render2D_Operation_Normal |
+			PM3Render2D_SpanOperation |
+			PM3Render2D_FBSourceReadEnable |
+			(PM3Render2D_Width(modded.width + x_align)) |
+			(PM3Render2D_Height(modded.height)));
+}
+
+static void pm3fb_imageblit(struct fb_info *info, const struct fb_image *image)
+{
+	struct pm3_par *par = info->par;
+	u32 height = image->height;
+	u32 fgx, bgx;
+	const u32 *src = (const u32*)image->data;
+
+	switch (info->fix.visual) {
+		case FB_VISUAL_PSEUDOCOLOR:
+			fgx = image->fg_color;
+			bgx = image->bg_color;
+			break;
+		case FB_VISUAL_TRUECOLOR:
+		default:
+			fgx = par->palette[image->fg_color];
+			bgx = par->palette[image->bg_color];
+			break;
+	}
+	if (image->depth != 1 || (image->width & 0x1f)) {
+		return cfb_imageblit(info, image);
+	}
+	if (info->var.bits_per_pixel == 8) {
+		fgx |= fgx << 8;
+		bgx |= bgx << 8;
+	}
+	if (info->var.bits_per_pixel <= 16) {
+		fgx |= fgx << 16;
+		bgx |= bgx << 16;
+	}
+
+	PM3_WAIT(par, 5);
+
+	PM3_WRITE_REG(par, PM3ForegroundColor, fgx);
+	PM3_WRITE_REG(par, PM3BackgroundColor, bgx);
+
+	/* ROP Ox3 is GXcopy */
+	PM3_WRITE_REG(par, PM3Config2D,
+			PM3Config2D_UseConstantSource |
+			PM3Config2D_ForegroundROPEnable |
+			(PM3Config2D_ForegroundROP(0x3)) |
+			PM3Config2D_OpaqueSpan |
+			PM3Config2D_FBWriteEnable);
+	PM3_WRITE_REG(par, PM3RectanglePosition,
+			(PM3RectanglePosition_XOffset(image->dx)) |
+			(PM3RectanglePosition_YOffset(image->dy)));
+	PM3_WRITE_REG(par, PM3Render2D,
+			PM3Render2D_XPositive |
+			PM3Render2D_YPositive |
+			PM3Render2D_Operation_SyncOnBitMask |
+			PM3Render2D_SpanOperation |
+			(PM3Render2D_Width(image->width)) |
+			(PM3Render2D_Height(image->height)));
+
+
+	while (height--) {
+		u32 width = (image->width + 31) >> 5;
+
+		while (width >= PM3_FIFO_SIZE) {
+			int i = PM3_FIFO_SIZE - 1;
+
+			PM3_WAIT(par, PM3_FIFO_SIZE);
+			while (i--) {
+				PM3_WRITE_REG(par, PM3BitMaskPattern, *src);
+				src++;
+			}
+			width -= PM3_FIFO_SIZE - 1;
+		}
+
+		PM3_WAIT(par, width + 1);
+		while (width--) {
+			PM3_WRITE_REG(par, PM3BitMaskPattern, *src);
+			src++;
+		}
+	}
+}
 /* end of acceleration functions */
 
 /* write the mode to registers */
@@ -908,8 +1063,8 @@ static struct fb_ops pm3fb_ops = {
 	.fb_setcolreg	= pm3fb_setcolreg,
 	.fb_pan_display	= pm3fb_pan_display,
 	.fb_fillrect	= pm3fb_fillrect,
-	.fb_copyarea	= cfb_copyarea,
-	.fb_imageblit	= cfb_imageblit,
+	.fb_copyarea	= pm3fb_copyarea,
+	.fb_imageblit	= pm3fb_imageblit,
 	.fb_blank	= pm3fb_blank,
 	.fb_sync	= pm3fb_sync,
 };
@@ -1081,7 +1236,10 @@ static int __devinit pm3fb_probe(struct 
 	info->fix = pm3fb_fix;
 	info->pseudo_palette = par->palette;
 	info->flags = FBINFO_DEFAULT |
-			FBINFO_HWACCEL_FILLRECT;/* | FBINFO_HWACCEL_YPAN;*/
+/*			FBINFO_HWACCEL_YPAN |*/
+			FBINFO_HWACCEL_COPYAREA |
+			FBINFO_HWACCEL_IMAGEBLIT |
+			FBINFO_HWACCEL_FILLRECT;
 
 	/*
 	 * This should give a reasonable default video mode. The following is
--- linux-2.6.21.old/include/video/pm3fb.h	2007-06-06 18:45:12.000000000 +0200
+++ linux-2.6.21/include/video/pm3fb.h	2007-06-11 23:34:18.455525505 +0200
@@ -849,7 +849,7 @@
 	#define PM3Render_FBSourceRead_Enable			(1<<27)
 #define PM3RasterizerMode					0x80a0
 #define PM3RasterizerModeAnd					0xaba0
-#define PM3RasterizerModeOr					0xabb8
+#define PM3RasterizerModeOr					0xaba8
 #define PM3RectangleHeight					0x94e0
 #define PM3Render						0x8038
 #define PM3RepeatLine						0x9328
@@ -1116,6 +1116,9 @@
 /* ***** pm3fb useful define and macro ***** */
 /* ***************************************** */
 
+/* fifo size in chip */
+#define PM3_FIFO_SIZE 120
+
 /* max size of options */
 #define PM3_OPTIONS_SIZE 256
 

--------------060007090704020502090001
Content-Type: text/plain;
 name="pm3fb-copyarea.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pm3fb-copyarea.diff"

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch adds accelerated copyarea and partially accelerated imageblit functions.
There is also fixed one register address in the pm3fb.h file.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

--- linux-2.6.21.old/drivers/video/pm3fb.c	2007-06-11 23:53:24.314415340 +0200
+++ linux-2.6.21/drivers/video/pm3fb.c	2007-06-12 00:11:59.438496095 +0200
@@ -276,15 +276,22 @@ static void pm3fb_init_engine(struct fb_
 
 	PM3_WAIT(par, 2);
 	{
-		unsigned long rm = 1;
+		/* invert bits in bitmask */
+		unsigned long rm = 1 | (3 << 7);
 		switch (info->var.bits_per_pixel) {
 		case 8:
 			PM3_WRITE_REG(par, PM3PixelSize,
 					   PM3PixelSize_GLOBAL_8BIT);
+#ifdef __BIG_ENDIAN
+			rm |= 3 << 15;
+#endif
 			break;
 		case 16:
 			PM3_WRITE_REG(par, PM3PixelSize,
 					   PM3PixelSize_GLOBAL_16BIT);
+#ifdef __BIG_ENDIAN
+			rm |= 2 << 15;
+#endif
 			break;
 		case 32:
 			PM3_WRITE_REG(par, PM3PixelSize,
@@ -394,18 +401,18 @@ static void pm3fb_fillrect (struct fb_in
 		color |= color << 16;
 
 	PM3_WAIT(par, 4);
-
+	/* ROP Ox3 is GXcopy */
 	PM3_WRITE_REG(par, PM3Config2D,
-				  PM3Config2D_UseConstantSource |
-				  PM3Config2D_ForegroundROPEnable |
-				  (PM3Config2D_ForegroundROP(0x3)) |	/* Ox3 is GXcopy */
-				  PM3Config2D_FBWriteEnable);
+			PM3Config2D_UseConstantSource |
+			PM3Config2D_ForegroundROPEnable |
+			(PM3Config2D_ForegroundROP(0x3)) |
+			PM3Config2D_FBWriteEnable);
 
 	PM3_WRITE_REG(par, PM3ForegroundColor, color);
 
 	PM3_WRITE_REG(par, PM3RectanglePosition,
-		      (PM3RectanglePosition_XOffset(modded.dx)) |
-		      (PM3RectanglePosition_YOffset(modded.dy)));
+			(PM3RectanglePosition_XOffset(modded.dx)) |
+			(PM3RectanglePosition_YOffset(modded.dy)));
 
 	PM3_WRITE_REG(par, PM3Render2D,
 		      PM3Render2D_XPositive |
@@ -415,6 +422,154 @@ static void pm3fb_fillrect (struct fb_in
 		      (PM3Render2D_Width(modded.width)) |
 		      (PM3Render2D_Height(modded.height)));
 }
+
+static void pm3fb_copyarea(struct fb_info *info,
+				const struct fb_copyarea *area)
+{
+	struct pm3_par *par = info->par;
+	struct fb_copyarea modded;
+	u32 vxres, vyres;
+	int x_align, o_x, o_y;
+
+	if (info->state != FBINFO_STATE_RUNNING)
+		return;
+	if (info->flags & FBINFO_HWACCEL_DISABLED) {
+		cfb_copyarea(info, area);
+		return;
+	}
+
+	memcpy(&modded, area, sizeof(struct fb_copyarea));
+
+	vxres = info->var.xres_virtual;
+	vyres = info->var.yres_virtual;
+
+	if(!modded.width || !modded.height ||
+	   modded.sx >= vxres || modded.sy >= vyres ||
+	   modded.dx >= vxres || modded.dy >= vyres)
+		return;
+
+	if(modded.sx + modded.width > vxres)
+		modded.width = vxres - modded.sx;
+	if(modded.dx + modded.width > vxres)
+		modded.width = vxres - modded.dx;
+	if(modded.sy + modded.height > vyres)
+		modded.height = vyres - modded.sy;
+	if(modded.dy + modded.height > vyres)
+		modded.height = vyres - modded.dy;
+
+	o_x = modded.sx - modded.dx;	/*(sx > dx ) ? (sx - dx) : (dx - sx); */
+	o_y = modded.sy - modded.dy;	/*(sy > dy ) ? (sy - dy) : (dy - sy); */
+
+	x_align = (modded.sx & 0x1f);
+
+	PM3_WAIT(par, 6);
+
+	PM3_WRITE_REG(par, PM3Config2D,
+			PM3Config2D_UserScissorEnable |
+			PM3Config2D_ForegroundROPEnable |
+			PM3Config2D_Blocking |
+			(PM3Config2D_ForegroundROP(0x3)) | /* Ox3 is GXcopy */
+			PM3Config2D_FBWriteEnable);
+
+	PM3_WRITE_REG(par, PM3ScissorMinXY,
+			((modded.dy & 0x0fff) << 16) | (modded.dx & 0x0fff));
+	PM3_WRITE_REG(par, PM3ScissorMaxXY,
+			(((modded.dy + modded.height) & 0x0fff) << 16) |
+			((modded.dx + modded.width) & 0x0fff));
+
+	PM3_WRITE_REG(par, PM3FBSourceReadBufferOffset,
+			PM3FBSourceReadBufferOffset_XOffset(o_x) |
+			PM3FBSourceReadBufferOffset_YOffset(o_y));
+
+	PM3_WRITE_REG(par, PM3RectanglePosition,
+			(PM3RectanglePosition_XOffset(modded.dx - x_align)) |
+			(PM3RectanglePosition_YOffset(modded.dy)));
+
+	PM3_WRITE_REG(par, PM3Render2D,
+			((modded.sx > modded.dx) ? PM3Render2D_XPositive : 0) |
+			((modded.sy > modded.dy) ? PM3Render2D_YPositive : 0) |
+			PM3Render2D_Operation_Normal |
+			PM3Render2D_SpanOperation |
+			PM3Render2D_FBSourceReadEnable |
+			(PM3Render2D_Width(modded.width + x_align)) |
+			(PM3Render2D_Height(modded.height)));
+}
+
+static void pm3fb_imageblit(struct fb_info *info, const struct fb_image *image)
+{
+	struct pm3_par *par = info->par;
+	u32 height = image->height;
+	u32 fgx, bgx;
+	const u32 *src = (const u32*)image->data;
+
+	switch (info->fix.visual) {
+		case FB_VISUAL_PSEUDOCOLOR:
+			fgx = image->fg_color;
+			bgx = image->bg_color;
+			break;
+		case FB_VISUAL_TRUECOLOR:
+		default:
+			fgx = par->palette[image->fg_color];
+			bgx = par->palette[image->bg_color];
+			break;
+	}
+	if (image->depth != 1 || (image->width & 0x1f)) {
+		return cfb_imageblit(info, image);
+	}
+	if (info->var.bits_per_pixel == 8) {
+		fgx |= fgx << 8;
+		bgx |= bgx << 8;
+	}
+	if (info->var.bits_per_pixel <= 16) {
+		fgx |= fgx << 16;
+		bgx |= bgx << 16;
+	}
+
+	PM3_WAIT(par, 5);
+
+	PM3_WRITE_REG(par, PM3ForegroundColor, fgx);
+	PM3_WRITE_REG(par, PM3BackgroundColor, bgx);
+
+	/* ROP Ox3 is GXcopy */
+	PM3_WRITE_REG(par, PM3Config2D,
+			PM3Config2D_UseConstantSource |
+			PM3Config2D_ForegroundROPEnable |
+			(PM3Config2D_ForegroundROP(0x3)) |
+			PM3Config2D_OpaqueSpan |
+			PM3Config2D_FBWriteEnable);
+	PM3_WRITE_REG(par, PM3RectanglePosition,
+			(PM3RectanglePosition_XOffset(image->dx)) |
+			(PM3RectanglePosition_YOffset(image->dy)));
+	PM3_WRITE_REG(par, PM3Render2D,
+			PM3Render2D_XPositive |
+			PM3Render2D_YPositive |
+			PM3Render2D_Operation_SyncOnBitMask |
+			PM3Render2D_SpanOperation |
+			(PM3Render2D_Width(image->width)) |
+			(PM3Render2D_Height(image->height)));
+
+
+	while (height--) {
+		u32 width = (image->width + 31) >> 5;
+
+		while (width >= PM3_FIFO_SIZE) {
+			int i = PM3_FIFO_SIZE - 1;
+
+			PM3_WAIT(par, PM3_FIFO_SIZE);
+			while (i--) {
+				PM3_WRITE_REG(par, PM3BitMaskPattern, *src);
+				src++;
+			}
+			width -= PM3_FIFO_SIZE - 1;
+		}
+
+		PM3_WAIT(par, width + 1);
+		while (width--) {
+			PM3_WRITE_REG(par, PM3BitMaskPattern, *src);
+			src++;
+		}
+	}
+}
 /* end of acceleration functions */
 
 /* write the mode to registers */
@@ -908,8 +1063,8 @@ static struct fb_ops pm3fb_ops = {
 	.fb_setcolreg	= pm3fb_setcolreg,
 	.fb_pan_display	= pm3fb_pan_display,
 	.fb_fillrect	= pm3fb_fillrect,
-	.fb_copyarea	= cfb_copyarea,
-	.fb_imageblit	= cfb_imageblit,
+	.fb_copyarea	= pm3fb_copyarea,
+	.fb_imageblit	= pm3fb_imageblit,
 	.fb_blank	= pm3fb_blank,
 	.fb_sync	= pm3fb_sync,
 };
@@ -1081,7 +1236,10 @@ static int __devinit pm3fb_probe(struct 
 	info->fix = pm3fb_fix;
 	info->pseudo_palette = par->palette;
 	info->flags = FBINFO_DEFAULT |
-			FBINFO_HWACCEL_FILLRECT;/* | FBINFO_HWACCEL_YPAN;*/
+/*			FBINFO_HWACCEL_YPAN |*/
+			FBINFO_HWACCEL_COPYAREA |
+			FBINFO_HWACCEL_IMAGEBLIT |
+			FBINFO_HWACCEL_FILLRECT;
 
 	/*
 	 * This should give a reasonable default video mode. The following is
--- linux-2.6.21.old/include/video/pm3fb.h	2007-06-06 18:45:12.000000000 +0200
+++ linux-2.6.21/include/video/pm3fb.h	2007-06-11 23:34:18.455525505 +0200
@@ -849,7 +849,7 @@
 	#define PM3Render_FBSourceRead_Enable			(1<<27)
 #define PM3RasterizerMode					0x80a0
 #define PM3RasterizerModeAnd					0xaba0
-#define PM3RasterizerModeOr					0xabb8
+#define PM3RasterizerModeOr					0xaba8
 #define PM3RectangleHeight					0x94e0
 #define PM3Render						0x8038
 #define PM3RepeatLine						0x9328
@@ -1116,6 +1116,9 @@
 /* ***** pm3fb useful define and macro ***** */
 /* ***************************************** */
 
+/* fifo size in chip */
+#define PM3_FIFO_SIZE 120
+
 /* max size of options */
 #define PM3_OPTIONS_SIZE 256
 

--------------060007090704020502090001
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--------------060007090704020502090001
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--------------060007090704020502090001--
