From: Harald Welte <HaraldWelte@viatech.com>
Subject: [PATCH 11/15] viafb: clean up duplicated code
	from 2D acceleration
Date: Thu, 21 May 2009 04:28:49 +0800
Message-ID: <1242851333-325-11-git-send-email-HaraldWelte@viatech.com>
References: <1242851333-325-1-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-2-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-3-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-4-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-5-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-6-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-7-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-8-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-9-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-10-git-send-email-HaraldWelte@viatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <laforge@prithivi.openmoko.org>) id 1M6siJ-00066D-VJ
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 20 May 2009 20:48:35 +0000
Received: from ganesha.gnumonks.org ([213.95.27.120])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1M6siA-0003H5-6w
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 20 May 2009 20:48:30 +0000
In-Reply-To: <1242851333-325-10-git-send-email-HaraldWelte@viatech.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Harald Welte <HaraldWelte@viatech.com>

From: Harald Welte <laforge@gnumonks.org>

There are four parts of the viafb code who initialize the bigtblit
screen base and pitch, some of them actually broken.  This patch
unifies them in one function called viafb_set_2d_mode() which
replaces and enhances the old function to just set the bpp.

Signed-off-by: Harald Welte <HaraldWelte@viatech.com>
---
 drivers/video/via/accel.c    |   35 ++++++++++++-----------
 drivers/video/via/accel.h    |    2 +-
 drivers/video/via/viafbdev.c |   62 +++++-------------------------------------
 3 files changed, 26 insertions(+), 73 deletions(-)

diff --git a/drivers/video/via/accel.c b/drivers/video/via/accel.c
index 45c54bf..4a1183f 100644
--- a/drivers/video/via/accel.c
+++ b/drivers/video/via/accel.c
@@ -191,26 +191,18 @@ void viafb_init_2d_engine(void)
 		}
 	}
 
-	viafb_set_2d_color_depth(viaparinfo->bpp);
-
-	writel(0x0, viaparinfo->io_virt + VIA_REG_SRCBASE);
-	writel(0x0, viaparinfo->io_virt + VIA_REG_DSTBASE);
-
-	writel(VIA_PITCH_ENABLE |
-		   (((viaparinfo->hres *
-		      viaparinfo->bpp >> 3) >> 3) | (((viaparinfo->hres *
-						   viaparinfo->
-						   bpp >> 3) >> 3) << 16)),
-					viaparinfo->io_virt + VIA_REG_PITCH);
+	viafb_set_2d_mode(viafbinfo);
 }
 
-void viafb_set_2d_color_depth(int bpp)
+/* Set the mode-specific parameters for the 2D acceleration, such as
+ * BPP, source and destination base, as well as pitch */
+void viafb_set_2d_mode(struct fb_info *info)
 {
-	u32 dwGEMode;
+	u32 dwGEMode, pitch, pitch_reg, base;
 
+	/* Set BPP */
 	dwGEMode = readl(viaparinfo->io_virt + 0x04) & 0xFFFFFCFF;
-
-	switch (bpp) {
+	switch (viaparinfo->bpp) {
 	case 16:
 		dwGEMode |= VIA_GEM_16bpp;
 		break;
@@ -221,9 +213,18 @@ void viafb_set_2d_color_depth(int bpp)
 		dwGEMode |= VIA_GEM_8bpp;
 		break;
 	}
-
-	/* Set BPP and Pitch */
 	writel(dwGEMode, viaparinfo->io_virt + VIA_REG_GEMODE);
+
+	/* Set source and destination base */
+	base = ((void *)info->screen_base - viafb_FB_MM);
+	writel(base >> 3, viaparinfo->io_virt + VIA_REG_SRCBASE);
+	writel(base >> 3, viaparinfo->io_virt + VIA_REG_DSTBASE);
+
+	/* Set source and destination pitch (128bit aligned) */
+	pitch = (viaparinfo->hres * viaparinfo->bpp >> 3) >> 3;
+	pitch_reg = pitch | (pitch << 16);
+	pitch_reg |= VIA_PITCH_ENABLE;
+	writel(pitch_reg, viaparinfo->io_virt + VIA_REG_PITCH);
 }
 
 void viafb_hw_cursor_init(void)
diff --git a/drivers/video/via/accel.h b/drivers/video/via/accel.h
index 29bf854..bef3134 100644
--- a/drivers/video/via/accel.h
+++ b/drivers/video/via/accel.h
@@ -161,7 +161,7 @@
 
 void viafb_init_accel(void);
 void viafb_init_2d_engine(void);
-void set_2d_color_depth(int);
+void viafb_set_2d_mode(struct fb_info *info);
 void viafb_hw_cursor_init(void);
 void viafb_show_hw_cursor(struct fb_info *info, int Status); int
 viafb_wait_engine_idle(void); void viafb_set_2d_color_depth(int bpp);
diff --git a/drivers/video/via/viafbdev.c b/drivers/video/via/viafbdev.c
index 980eab8..af8acfe 100644
--- a/drivers/video/via/viafbdev.c
+++ b/drivers/video/via/viafbdev.c
@@ -264,7 +264,7 @@ static int viafb_set_par(struct fb_info *info)
 		viafb_accel = info->var.accel_flags;
 
 		if (viafb_accel)
-			viafb_set_2d_color_depth(info->var.bits_per_pixel);
+			viafb_set_2d_mode(info);
 	}
 
 	return 0;
@@ -865,7 +865,6 @@ static void viafb_fillrect(struct fb_info *info,
 	const struct fb_fillrect *rect)
 {
 	u32 col = 0, rop = 0;
-	int pitch;
 
 	if (!viafb_accel) {
 		cfb_fillrect(info, rect);
@@ -897,22 +896,8 @@ static void viafb_fillrect(struct fb_info *info,
 		break;
 	}
 
-	/* BitBlt Source Address */
-	writel(0x0, viaparinfo->io_virt + VIA_REG_SRCPOS);
-	/* Source Base Address */
-	writel(0x0, viaparinfo->io_virt + VIA_REG_SRCBASE);
-	/* Destination Base Address */
-	writel(((unsigned long) (info->screen_base) -
-		   (unsigned long) viafb_FB_MM) >> 3,
-		   viaparinfo->io_virt + VIA_REG_DSTBASE);
-	/* Pitch */
-	pitch = (info->var.xres_virtual + 7) & ~7;
-	writel(VIA_PITCH_ENABLE |
-		   (((pitch *
-		      info->var.bits_per_pixel >> 3) >> 3) |
-		      (((pitch * info->
-		      var.bits_per_pixel >> 3) >> 3) << 16)),
-		      viaparinfo->io_virt + VIA_REG_PITCH);
+	viafb_set_2d_mode(info);
+
 	/* BitBlt Destination Address */
 	writel(((rect->dy << 16) | rect->dx),
 		viaparinfo->io_virt + VIA_REG_DSTPOS);
@@ -932,7 +917,6 @@ static void viafb_copyarea(struct fb_info *info,
 {
 	u32 dy = area->dy, sy = area->sy, direction = 0x0;
 	u32 sx = area->sx, dx = area->dx, width = area->width;
-	int pitch;
 
 	DEBUG_MSG(KERN_INFO "viafb_copyarea!!\n");
 
@@ -956,25 +940,8 @@ static void viafb_copyarea(struct fb_info *info,
 		direction |= 0x8000;
 	}
 
-	/* Source Base Address */
-	writel(((unsigned long) (info->screen_base) -
-		   (unsigned long) viafb_FB_MM) >> 3,
-		   viaparinfo->io_virt + VIA_REG_SRCBASE);
-	/* Destination Base Address */
-	writel(((unsigned long) (info->screen_base) -
-		   (unsigned long) viafb_FB_MM) >> 3,
-		   viaparinfo->io_virt + VIA_REG_DSTBASE);
-	/* Pitch */
-	pitch = (info->var.xres_virtual + 7) & ~7;
-	/* VIA_PITCH_ENABLE can be omitted now. */
-	writel(VIA_PITCH_ENABLE |
-		   (((pitch *
-		      info->var.bits_per_pixel >> 3) >> 3) | (((pitch *
-								info->var.
-								bits_per_pixel
-								>> 3) >> 3)
-							      << 16)),
-				viaparinfo->io_virt + VIA_REG_PITCH);
+	viafb_set_2d_mode(info);
+
 	/* BitBlt Source Address */
 	writel(((sy << 16) | sx), viaparinfo->io_virt + VIA_REG_SRCPOS);
 	/* BitBlt Destination Address */
@@ -993,7 +960,6 @@ static void viafb_imageblit(struct fb_info *info,
 {
 	u32 size, bg_col = 0, fg_col = 0, *udata;
 	int i;
-	int pitch;
 
 	if (!viafb_accel) {
 		cfb_imageblit(info, image);
@@ -1018,22 +984,8 @@ static void viafb_imageblit(struct fb_info *info,
 	}
 	size = image->width * image->height;
 
-	/* Source Base Address */
-	writel(0x0, viaparinfo->io_virt + VIA_REG_SRCBASE);
-	/* Destination Base Address */
-	writel(((unsigned long) (info->screen_base) -
-		   (unsigned long) viafb_FB_MM) >> 3,
-		   viaparinfo->io_virt + VIA_REG_DSTBASE);
-	/* Pitch */
-	pitch = (info->var.xres_virtual + 7) & ~7;
-	writel(VIA_PITCH_ENABLE |
-		   (((pitch *
-		      info->var.bits_per_pixel >> 3) >> 3) | (((pitch *
-								info->var.
-								bits_per_pixel
-								>> 3) >> 3)
-							      << 16)),
-				viaparinfo->io_virt + VIA_REG_PITCH);
+	viafb_set_2d_mode(info);
+
 	/* BitBlt Source Address */
 	writel(0x0, viaparinfo->io_virt + VIA_REG_SRCPOS);
 	/* BitBlt Destination Address */
-- 
1.6.2.4


------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables 
unlimited royalty-free distribution of the report engine 
for externally facing server and web deployment. 
http://p.sf.net/sfu/businessobjects
