From: random <eger-temp_addy-1075244930.6ef584@theboonies.us>
Subject: Re: [PATCH] Radeon 2D Acceleration for 2.6
Date: Wed, 21 Jan 2004 00:09:31 +0100 (CET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.50L0.0401210008080.16594-100000@rosencrantz.pok.ibm.com>
References: <Pine.LNX.4.50L0.0401201543490.1525-200000@rosencrantz.pok.ibm.com>
	<1074638876.793.47.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Aj4zM-0004jT-Pf
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 20 Jan 2004 15:08:52 -0800
Received: from not.theboonies.us ([66.139.79.224])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1Aj4zM-0003XU-6x
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 20 Jan 2004 15:08:52 -0800
In-Reply-To: <1074638876.793.47.camel@gaston>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


Ben asks:
> Can you re-export the cset as a patch in unified diff form please ?
> 
> (bk export -tpatch -du)

Now that I know the shortcut ;-)

-David

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/01/20 15:07:51+01:00 eger@rosencrantz.pok.ibm.com 
#   Added 2D-acceleration support for radeonfb with copyarea() and fillrect()
# 
# include/video/radeon.h
#   2004/01/20 15:04:12+01:00 eger@rosencrantz.pok.ibm.com +1 -0
#   New constant from XFree86 headers: DEFAULT_SC_TOP_LEFT
# 
# drivers/video/aty/radeon_base.c
#   2004/01/20 15:04:12+01:00 eger@rosencrantz.pok.ibm.com +123 -24
#   Added 2D-acceleration support for radeonfb with copyarea() and fillrect()
# 
# BitKeeper/etc/ignore
#   2004/01/20 15:04:12+01:00 eger@rosencrantz.pok.ibm.com +7 -0
#   Added arch/ppc/boot/openfirmware/coffboot arch/ppc/boot/openfirmware/note arch/ppc/boot/prep/zImage arch/ppc/boot/prep/zImage.bin drivers/video/logo/logo_linux_mono.c drivers/video/logo/logo_linux_vga16.c include/asm-ppc/offsets.h to the ignore list
# 
diff -Nru a/drivers/video/aty/radeon_base.c b/drivers/video/aty/radeon_base.c
--- a/drivers/video/aty/radeon_base.c	Wed Jan 21 00:07:29 2004
+++ b/drivers/video/aty/radeon_base.c	Wed Jan 21 00:07:29 2004
@@ -851,12 +851,14 @@
 	OUTREG(SRC_PITCH_OFFSET, (rinfo->pitch << 0x16) | (rinfo->fb_local_base >> 10));
 
 	radeon_fifo_wait (1);
+
 #if defined(__BIG_ENDIAN)
 	OUTREGP(DP_DATATYPE, HOST_BIG_ENDIAN_EN, ~HOST_BIG_ENDIAN_EN);
 #else
 	OUTREGP(DP_DATATYPE, 0, ~HOST_BIG_ENDIAN_EN);
 #endif
 	radeon_fifo_wait (1);
+	OUTREG(DEFAULT_SC_TOP_LEFT, 0);
 	OUTREG(DEFAULT_SC_BOTTOM_RIGHT, (DEFAULT_SC_RIGHT_MAX |
 					 DEFAULT_SC_BOTTOM_MAX));
 
@@ -894,7 +896,7 @@
 	struct radeonfb_info *rinfo = (struct radeonfb_info *) info->par;
         struct fb_var_screeninfo v;
         int nom, den;
-        int accel = (var->accel_flags & FB_ACCELF_TEXT) != 0;
+        int accel = 1;
 	unsigned int pitch;
 
 	if (noaccel)
@@ -1525,7 +1527,7 @@
 	int hsync_start, hsync_fudge, bytpp, hsync_wid, vsync_wid;
 	int primary_mon = PRIMARY_MONITOR(rinfo);
 	int depth = var_to_depth(mode);
-        int accel = (mode->accel_flags & FB_ACCELF_TEXT) != 0;
+	int accel = 1;
 
 	hSyncStart = mode->xres + mode->right_margin;
 	hSyncEnd = hSyncStart + mode->hsync_len;
@@ -1803,26 +1805,125 @@
 	return 0;
 }
 
+/* ------------ Accelerated Functions --------------------- */
+/* the accelerated functions here are patterned after the 
+ * "ACCEL_MMIO" ifdef branches in XFree86             --dte */
+void radeonfb_prim_fillrect(struct radeonfb_info *rinfo, 
+                       const struct fb_fillrect *region)
+{
+	radeon_fifo_wait(4);  
+  
+	OUTREG(DP_GUI_MASTER_CNTL,  
+		rinfo->dp_gui_master_cntl  /* contains, like GMC_DST_32BPP */
+                | GMC_BRUSH_SOLID_COLOR
+                | ROP3_P);
+	OUTREG(DP_BRUSH_FRGD_CLR, region->color);
+	OUTREG(DP_WRITE_MSK, 0xffffffff);
+	OUTREG(DP_CNTL, (DST_X_LEFT_TO_RIGHT | DST_Y_TOP_TO_BOTTOM));
+
+	radeon_fifo_wait(2);  
+	OUTREG(DST_Y_X, (region->dy << 16) | region->dx);
+	OUTREG(DST_WIDTH_HEIGHT, (region->width << 16) | region->height);
+	radeon_engine_idle ();
+}
+
+void radeonfb_fillrect(struct fb_info *info, 
+                       const struct fb_fillrect *region)
+{
+	struct radeonfb_info *rinfo = (struct radeonfb_info *)info;
+	struct fb_fillrect modded;
+	int vxres, vyres;
+  
+	vxres = info->var.xres;
+	vyres = info->var.yres;
+
+	memcpy(&modded, region, sizeof(struct fb_fillrect));
+
+	if(!modded.width || !modded.height ||
+	   modded.dx >= vxres || modded.dy >= vyres)
+		return;
+  
+	if(modded.dx + modded.width  > vxres) modded.width  = vxres - modded.dx;
+	if(modded.dy + modded.height > vyres) modded.height = vyres - modded.dy;
+
+	radeonfb_prim_fillrect(rinfo, &modded);
+}
+
+void radeonfb_prim_copyarea(struct radeonfb_info *rinfo, 
+                       const struct fb_copyarea *area)
+{
+	radeon_fifo_wait(3);
+	OUTREG(DP_GUI_MASTER_CNTL,
+		rinfo->dp_gui_master_cntl /* i.e. GMC_DST_32BPP */
+		| GMC_SRC_DSTCOLOR
+		| ROP3_S 
+		| DP_SRC_RECT );
+	OUTREG(DP_WRITE_MSK, 0xffffffff);
+	OUTREG(DP_CNTL, (DST_X_LEFT_TO_RIGHT | DST_Y_TOP_TO_BOTTOM));
+
+	radeon_fifo_wait(3);
+	OUTREG(SRC_Y_X, (area->sy << 16) | area->sx);
+	OUTREG(DST_Y_X, (area->dy << 16) | area->dx);
+	OUTREG(DST_HEIGHT_WIDTH, (area->height << 16) | area->width);
+	radeon_engine_idle ();
+}
+
+
+void radeonfb_copyarea(struct fb_info *info, const struct fb_copyarea *area)
+{
+	struct radeonfb_info *rinfo = (struct radeonfb_info *)info;
+	struct fb_copyarea modded;
+	u32 vxres, vyres;
+	modded.sx = area->sx;
+	modded.sy = area->sy;
+	modded.dx = area->dx;
+	modded.dy = area->dy;
+	modded.width  = area->width;
+	modded.height = area->height;
+  
+	vxres = info->var.xres;
+	vyres = info->var.yres;
+
+	if(!modded.width || !modded.height ||
+	   modded.sx >= vxres || modded.sy >= vyres ||
+	   modded.dx >= vxres || modded.dy >= vyres)
+		return;
+  
+	if(modded.sx + modded.width > vxres)  modded.width = vxres - modded.sx;
+	if(modded.dx + modded.width > vxres)  modded.width = vxres - modded.dx;
+	if(modded.sy + modded.height > vyres) modded.height = vyres - modded.sy;
+	if(modded.dy + modded.height > vyres) modded.height = vyres - modded.dy;
+  
+	radeonfb_prim_copyarea(rinfo, &modded);
+}
+
 
 
 static struct fb_ops radeonfb_ops = {
-	.owner			= THIS_MODULE,
-	.fb_check_var		= radeonfb_check_var,
-	.fb_set_par		= radeonfb_set_par,
-	.fb_setcolreg		= radeonfb_setcolreg,
-	.fb_pan_display 	= radeonfb_pan_display,
-	.fb_blank		= radeonfb_blank,
-	.fb_ioctl		= radeonfb_ioctl,
-#if 0
+	.owner		= THIS_MODULE,
+	.fb_check_var	= radeonfb_check_var,
+	.fb_set_par	= radeonfb_set_par,
+	.fb_setcolreg	= radeonfb_setcolreg,
+	.fb_pan_display	= radeonfb_pan_display,
+	.fb_blank	= radeonfb_blank,
+	.fb_ioctl	= radeonfb_ioctl,
 	.fb_fillrect	= radeonfb_fillrect,
 	.fb_copyarea	= radeonfb_copyarea,
-	.fb_imageblit	= radeonfb_imageblit,
-	.fb_rasterimg	= radeonfb_rasterimg,
-#else
+	.fb_imageblit	= cfb_imageblit,
+	.fb_cursor	= soft_cursor,
+};
+
+static struct fb_ops radeonfb_noaccel_ops = {
+	.owner		= THIS_MODULE,
+	.fb_check_var	= radeonfb_check_var,
+	.fb_set_par	= radeonfb_set_par,
+	.fb_setcolreg	= radeonfb_setcolreg,
+	.fb_pan_display	= radeonfb_pan_display,
+	.fb_blank	= radeonfb_blank,
+	.fb_ioctl	= radeonfb_ioctl,
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
-#endif
 	.fb_cursor	= soft_cursor,
 };
 
@@ -1837,7 +1938,6 @@
 	info->par = rinfo;
 	info->pseudo_palette = rinfo->pseudo_palette;
         info->flags = FBINFO_FLAG_DEFAULT;
-        info->fbops = &radeonfb_ops;
         info->display_fg = NULL;
         info->screen_base = (char *)rinfo->fb_base;
 
@@ -1853,17 +1953,16 @@
         info->fix.type_aux = 0;
         info->fix.mmio_start = rinfo->mmio_base_phys;
         info->fix.mmio_len = RADEON_REGSIZE;
-	if (noaccel)
-	        info->fix.accel = FB_ACCEL_NONE;
-	else
-		info->fix.accel = FB_ACCEL_ATI_RADEON;
-
-	fb_alloc_cmap(&info->cmap, 256, 0);
-
-	if (noaccel)
+	if (noaccel) {
+		info->fix.accel = FB_ACCEL_NONE;
 		info->var.accel_flags &= ~FB_ACCELF_TEXT;
-	else
+		info->fbops = &radeonfb_noaccel_ops;
+	} else {
+		info->fix.accel = FB_ACCEL_ATI_RADEON;
 		info->var.accel_flags |= FB_ACCELF_TEXT;
+		info->fbops = &radeonfb_ops;
+	}
+	fb_alloc_cmap(&info->cmap, 256, 0);
 
         return 0;
 }
diff -Nru a/include/video/radeon.h b/include/video/radeon.h
--- a/include/video/radeon.h	Wed Jan 21 00:07:29 2004
+++ b/include/video/radeon.h	Wed Jan 21 00:07:29 2004
@@ -365,6 +365,7 @@
 #define DSTCACHE_CTLSTAT                       0x1714  
 #define DEFAULT_PITCH_OFFSET                   0x16E0  
 #define DEFAULT_SC_BOTTOM_RIGHT                0x16E8  
+#define DEFAULT_SC_TOP_LEFT                    0x16EC
 #define SRC_PITCH_OFFSET                       0x1428
 #define DST_PITCH_OFFSET                       0x142C
 #define DP_GUI_MASTER_CNTL                     0x146C  


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
