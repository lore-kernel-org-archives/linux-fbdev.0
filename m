From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 8/13] fbdev: mac_var_to_mode() fix
Date: Wed, 4 Nov 2009 00:43:16 +1100 (EST)
Message-ID: <alpine.OSX.2.00.0911031449170.483@silk.local>
Mime-Version: 1.0
Return-path: <linux-m68k-owner@vger.kernel.org>
Sender: linux-m68k-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-m68k@vger.kernel.org

The valkyriefb driver assumes that this logic holds:

mac_vmode_to_var(X, cmode, &var);
mac_var_to_vmode(&var, &vmode, &cmode);
assert(vmode == X);

But it doesn't hold because mac_var_to_vmode() can return a mode with a 
slower pixel clock, even when a match is available. So we end up with this 
failure:

using video mode 11 and color mode 0.
valkyriefb: vmode 12 not valid.
valkyriefb: can't set default video mode
valkyriefb: vmode 12 not valid.

Rather than have mac_var_to_mode() return the first reasonable mode it 
finds, have it return the mode that is closest to the requested one (or 
the mode with the closest longer pixel clock period if there is no exact 
match).

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

---
 drivers/video/macmodes.c |   40 +++++++++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 9 deletions(-)

Index: linux-2.6.31/drivers/video/macmodes.c
===================================================================
--- linux-2.6.31.orig/drivers/video/macmodes.c	2009-11-03 03:23:24.000000000 +1100
+++ linux-2.6.31/drivers/video/macmodes.c	2009-11-03 03:23:43.000000000 +1100
@@ -134,7 +134,7 @@ static const struct fb_videomode mac_mod
      *
      *  These MUST be ordered in
      *    - increasing resolution
-     *    - decreasing refresh rate
+     *    - decreasing pixel clock period
      */
 
 static const struct mode_map {
@@ -142,20 +142,20 @@ static const struct mode_map {
     const struct fb_videomode *mode;
 } mac_modes[] = {
     /* 640x480 */
-    { VMODE_640_480_67, &mac_modedb[1] },
     { VMODE_640_480_60, &mac_modedb[0] },
+    { VMODE_640_480_67, &mac_modedb[1] },
     /* 800x600 */
+    { VMODE_800_600_56, &mac_modedb[2] },
+    { VMODE_800_600_60, &mac_modedb[3] },
     { VMODE_800_600_75, &mac_modedb[5] },
     { VMODE_800_600_72, &mac_modedb[4] },
-    { VMODE_800_600_60, &mac_modedb[3] },
-    { VMODE_800_600_56, &mac_modedb[2] },
     /* 832x624 */
     { VMODE_832_624_75, &mac_modedb[6] },
     /* 1024x768 */
-    { VMODE_1024_768_75, &mac_modedb[10] },
-    { VMODE_1024_768_75V, &mac_modedb[9] },
-    { VMODE_1024_768_70, &mac_modedb[8] },
     { VMODE_1024_768_60, &mac_modedb[7] },
+    { VMODE_1024_768_70, &mac_modedb[8] },
+    { VMODE_1024_768_75V, &mac_modedb[9] },
+    { VMODE_1024_768_75, &mac_modedb[10] },
     /* 1152x768 */
     { VMODE_1152_768_60, &mac_modedb[14] },
     /* 1152x870 */
@@ -299,7 +299,6 @@ EXPORT_SYMBOL(mac_vmode_to_var);
 int mac_var_to_vmode(const struct fb_var_screeninfo *var, int *vmode,
 		     int *cmode)
 {
-    const struct fb_videomode *mode = NULL;
     const struct mode_map *map;
 
     if (var->bits_per_pixel <= 8)
@@ -311,8 +310,13 @@ int mac_var_to_vmode(const struct fb_var
     else
 	return -EINVAL;
 
+    /*
+     * Find the mac_mode with a matching resolution or failing that, the
+     * closest larger resolution. Skip modes with a shorter pixel clock period.
+     */
     for (map = mac_modes; map->vmode != -1; map++) {
-	mode = map->mode;
+	const struct fb_videomode *mode = map->mode;
+
 	if (var->xres > mode->xres || var->yres > mode->yres)
 	    continue;
 	if (var->xres_virtual > mode->xres || var->yres_virtual > mode->yres)
@@ -322,6 +326,24 @@ int mac_var_to_vmode(const struct fb_var
 	if ((var->vmode & FB_VMODE_MASK) != mode->vmode)
 	    continue;
 	*vmode = map->vmode;
+
+	/*
+	 * Having found a good resolution, find the matching pixel clock
+	 * or failing that, the closest longer pixel clock period.
+	 */
+	map++;
+	while (map->vmode != -1) {
+	    const struct fb_videomode *clk_mode = map->mode;
+
+	    if (mode->xres != clk_mode->xres || mode->yres != clk_mode->yres)
+		break;
+	    if (var->pixclock > mode->pixclock)
+	        break;
+	    if (mode->vmode != clk_mode->vmode)
+		continue;
+	    *vmode = map->vmode;
+	    map++;
+	}
 	return 0;
     }
     return -EINVAL;
