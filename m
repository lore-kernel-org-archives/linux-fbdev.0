From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 11/13] fbdev: add some missing mac modes
Date: Wed, 4 Nov 2009 00:47:02 +1100 (EST)
Message-ID: <alpine.OSX.2.00.0911031505030.483@silk.local>
Mime-Version: 1.0
Return-path: <linux-m68k-owner@vger.kernel.org>
Sender: linux-m68k-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-m68k@vger.kernel.org

Add the missing mac video modes for the Portrait and 12" RGB displays. The 
specs come from the Mac LC III developer note.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

---
 drivers/video/macmodes.c |   52 +++++++++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 24 deletions(-)

Index: linux-2.6.31/drivers/video/macmodes.c
===================================================================
--- linux-2.6.31.orig/drivers/video/macmodes.c	2009-11-03 03:23:43.000000000 +1100
+++ linux-2.6.31/drivers/video/macmodes.c	2009-11-03 03:23:44.000000000 +1100
@@ -33,6 +33,10 @@
 
 static const struct fb_videomode mac_modedb[] = {
     {
+	/* 512x384, 60Hz, Non-Interlaced (15.67 MHz dot clock) */
+    	"mac2", 60, 512, 384, 63828, 80, 16, 19, 1, 32, 3,
+	0, FB_VMODE_NONINTERLACED
+    }, {
 	/* 640x480, 60 Hz, Non-Interlaced (25.175 MHz dotclock) */
 	"mac5", 60, 640, 480, 39722, 32, 32, 33, 10, 96, 2,
 	0, FB_VMODE_NONINTERLACED
@@ -41,6 +45,10 @@ static const struct fb_videomode mac_mod
 	"mac6", 67, 640, 480, 33334, 80, 80, 39, 3, 64, 3,
 	0, FB_VMODE_NONINTERLACED
     }, {
+	/* 640x870, 75Hz (portrait), Non-Interlaced (57.28 MHz dot clock) */
+	"mac7", 75, 640, 870, 17457, 80, 32, 42, 3, 80, 3,
+	0, FB_VMODE_NONINTERLACED
+    }, {
 	/* 800x600, 56 Hz, Non-Interlaced (36.00 MHz dotclock) */
 	"mac9", 56, 800, 600, 27778, 112, 40, 22, 1, 72, 2,
 	FB_SYNC_HOR_HIGH_ACT|FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
@@ -105,10 +113,6 @@ static const struct fb_videomode mac_mod
 	"mac1", 60, 512, 384, pixclock, left, right, upper, lower, hslen, vslen,
 	sync, FB_VMODE_INTERLACED
     }, {
-	/* VMODE_512_384_60: 512x384, 60Hz, Non-Interlaced */
-    	"mac2", 60, 512, 384, pixclock, left, right, upper, lower, hslen, vslen,
-	sync, FB_VMODE_NONINTERLACED
-    }, {
 	/* VMODE_640_480_50I: 640x480, 50Hz, Interlaced (PAL) */
 	"mac3", 50, 640, 480, pixclock, left, right, upper, lower, hslen, vslen,
 	sync, FB_VMODE_INTERLACED
@@ -117,10 +121,6 @@ static const struct fb_videomode mac_mod
 	"mac4", 60, 640, 480, pixclock, left, right, upper, lower, hslen, vslen,
 	sync, FB_VMODE_INTERLACED
     }, {
-	/* VMODE_640_870_75P: 640x870, 75Hz (portrait), Non-Interlaced */
-	"mac7", 75, 640, 870, pixclock, left, right, upper, lower, hslen, vslen,
-	sync, FB_VMODE_NONINTERLACED
-    }, {
 	/* VMODE_768_576_50I: 768x576, 50Hz (PAL full frame), Interlaced */
 	"mac8", 50, 768, 576, pixclock, left, right, upper, lower, hslen, vslen,
 	sync, FB_VMODE_INTERLACED
@@ -141,31 +141,35 @@ static const struct mode_map {
     int vmode;
     const struct fb_videomode *mode;
 } mac_modes[] = {
+    /* 512x384 */
+    { VMODE_512_384_60, &mac_modedb[0] },
     /* 640x480 */
-    { VMODE_640_480_60, &mac_modedb[0] },
-    { VMODE_640_480_67, &mac_modedb[1] },
+    { VMODE_640_480_60, &mac_modedb[1] },
+    { VMODE_640_480_67, &mac_modedb[2] },
+    /* 640x870 */
+    { VMODE_640_870_75P, &mac_modedb[3] },
     /* 800x600 */
-    { VMODE_800_600_56, &mac_modedb[2] },
-    { VMODE_800_600_60, &mac_modedb[3] },
-    { VMODE_800_600_75, &mac_modedb[5] },
-    { VMODE_800_600_72, &mac_modedb[4] },
+    { VMODE_800_600_56, &mac_modedb[4] },
+    { VMODE_800_600_60, &mac_modedb[5] },
+    { VMODE_800_600_75, &mac_modedb[7] },
+    { VMODE_800_600_72, &mac_modedb[6] },
     /* 832x624 */
-    { VMODE_832_624_75, &mac_modedb[6] },
+    { VMODE_832_624_75, &mac_modedb[8] },
     /* 1024x768 */
-    { VMODE_1024_768_60, &mac_modedb[7] },
-    { VMODE_1024_768_70, &mac_modedb[8] },
-    { VMODE_1024_768_75V, &mac_modedb[9] },
-    { VMODE_1024_768_75, &mac_modedb[10] },
+    { VMODE_1024_768_60, &mac_modedb[9] },
+    { VMODE_1024_768_70, &mac_modedb[10] },
+    { VMODE_1024_768_75V, &mac_modedb[11] },
+    { VMODE_1024_768_75, &mac_modedb[12] },
     /* 1152x768 */
-    { VMODE_1152_768_60, &mac_modedb[14] },
+    { VMODE_1152_768_60, &mac_modedb[16] },
     /* 1152x870 */
-    { VMODE_1152_870_75, &mac_modedb[11] },
+    { VMODE_1152_870_75, &mac_modedb[13] },
     /* 1280x960 */
-    { VMODE_1280_960_75, &mac_modedb[12] },
+    { VMODE_1280_960_75, &mac_modedb[14] },
     /* 1280x1024 */
-    { VMODE_1280_1024_75, &mac_modedb[13] },
+    { VMODE_1280_1024_75, &mac_modedb[15] },
     /* 1600x1024 */
-    { VMODE_1600_1024_60, &mac_modedb[15] },
+    { VMODE_1600_1024_60, &mac_modedb[17] },
     { -1, NULL }
 };
 
