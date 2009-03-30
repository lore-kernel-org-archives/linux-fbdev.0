From: Michal Januszewski <spock@gentoo.org>
Subject: [PATCH] sa1100fb: fix color component length for pseudocolor modes
Date: Tue, 31 Mar 2009 00:12:05 +0200
Message-ID: <20090330221205.GE6993@spock.one.pl>
Reply-To: spock@gentoo.org
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762411AbZC3WMu@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev-devel@lists.sourceforge.net

sa1100fb incorrectly sets the length of the color fields to 8 bits
for PSEUDOCOLOR modes for which only 4 bits are used per pixel.
Fix this by setting the length to 4 bits for these modes.

Signed-off-by: Michal Januszewski <spock@gentoo.org>
---
diff --git a/drivers/video/sa1100fb.c b/drivers/video/sa1100fb.c
index fad58cf..10ddad8 100644
--- a/drivers/video/sa1100fb.c
+++ b/drivers/video/sa1100fb.c
@@ -199,16 +199,20 @@
 extern void (*sa1100fb_backlight_power)(int on);
 extern void (*sa1100fb_lcd_power)(int on);
 
-/*
- * IMHO this looks wrong.  In 8BPP, length should be 8.
- */
-static struct sa1100fb_rgb rgb_8 = {
+static struct sa1100fb_rgb rgb_4 = {
 	.red	= { .offset = 0,  .length = 4, },
 	.green	= { .offset = 0,  .length = 4, },
 	.blue	= { .offset = 0,  .length = 4, },
 	.transp	= { .offset = 0,  .length = 0, },
 };
 
+static struct sa1100fb_rgb rgb_8 = {
+	.red	= { .offset = 0,  .length = 8, },
+	.green	= { .offset = 0,  .length = 8, },
+	.blue	= { .offset = 0,  .length = 8, },
+	.transp	= { .offset = 0,  .length = 0, },
+};
+
 static struct sa1100fb_rgb def_rgb_16 = {
 	.red	= { .offset = 11, .length = 5, },
 	.green	= { .offset = 5,  .length = 6, },
@@ -613,7 +617,7 @@ sa1100fb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 	DPRINTK("var->bits_per_pixel=%d\n", var->bits_per_pixel);
 	switch (var->bits_per_pixel) {
 	case 4:
-		rgbidx = RGB_8;
+		rgbidx = RGB_4;
 		break;
 	case 8:
 		rgbidx = RGB_8;
@@ -1382,6 +1386,7 @@ static struct sa1100fb_info * __init sa1100fb_init_fbinfo(struct device *dev)
 	fbi->fb.monspecs	= monspecs;
 	fbi->fb.pseudo_palette	= (fbi + 1);
 
+	fbi->rgb[RGB_4]		= &rgb_4;
 	fbi->rgb[RGB_8]		= &rgb_8;
 	fbi->rgb[RGB_16]	= &def_rgb_16;
 
diff --git a/drivers/video/sa1100fb.h b/drivers/video/sa1100fb.h
index 86831db..1c3b459 100644
--- a/drivers/video/sa1100fb.h
+++ b/drivers/video/sa1100fb.h
@@ -57,9 +57,10 @@ struct sa1100fb_lcd_reg {
 	unsigned long lccr3;
 };
 
-#define RGB_8	(0)
-#define RGB_16	(1)
-#define NR_RGB	2
+#define RGB_4	(0)
+#define RGB_8	(1)
+#define RGB_16	(2)
+#define NR_RGB	3
 
 struct sa1100fb_info {
 	struct fb_info		fb;
