From: Michal Januszewski <michalj@gmail.com>
Subject: [PATCH] fbdev: fix nearest mode search
Date: Thu, 18 Nov 2010 00:08:40 +0100
Message-ID: <20101117230840.GA4514@quadria>
Reply-To: michalj@gmail.com
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev-devel@lists.sourceforge.net

In the framebuffer subsystem the abs() macro is often used as a part of
the calculation of a Manhattan metric, which in turn is used as a measure
of similarity between video modes.  The arguments of abs() are sometimes
unsigned numbers.  This worked fine until commit a49c59c0, which changed
the definition of abs() to prevent truncation.  As a result of this
change, in the following piece of code:

  u32 a = 0, b = 1;
  u32 c = abs(a - b);

'c' will end up with a value of 0xffffffff instead of the expected 0x1.

A problem caused by this change and visible by the end user is that
framebuffer drivers relying on functions from modedb.c will fail to
find high resolution video modes similar to that explicitly requested
by the user if an exact match cannot be found (see e.g.
https://bugs.gentoo.org/show_bug.cgi?id=296539).

Fix this problem by casting all arguments of abs() to an int prior
to the macro evaluation in modedb.c and uvesafb.c.

Signed-off-by: Michal Januszewski <michalj@gmail.com>
---
diff --git a/drivers/video/modedb.c b/drivers/video/modedb.c
index 0a4dbdc..878bea1 100644
--- a/drivers/video/modedb.c
+++ b/drivers/video/modedb.c
@@ -636,8 +636,10 @@ done:
 			if (refresh_specified && db[i].refresh == refresh) {
 				return 1;
 			} else {
-				if (abs(db[i].refresh - refresh) < diff) {
-					diff = abs(db[i].refresh - refresh);
+				if (abs((int)(db[i].refresh - refresh)) <
+				    diff) {
+					diff = abs((int)(db[i].refresh -
+						refresh));
 					best = i;
 				}
 			}
@@ -654,8 +656,8 @@ done:
 	for (i = 0; i < dbsize; i++) {
 		DPRINTK("Trying %ix%i\n", db[i].xres, db[i].yres);
 		if (!fb_try_mode(var, info, &db[i], bpp)) {
-			tdiff = abs(db[i].xres - xres) +
-				abs(db[i].yres - yres);
+			tdiff = abs((int)(db[i].xres - xres)) +
+				abs((int)(db[i].yres - yres));
 
 			/*
 			 * Penalize modes with resolutions smaller
@@ -851,13 +853,13 @@ const struct fb_videomode *fb_find_nearest_mode(const struct fb_videomode *mode,
 		modelist = list_entry(pos, struct fb_modelist, list);
 		cmode = &modelist->mode;
 
-		d = abs(cmode->xres - mode->xres) +
-			abs(cmode->yres - mode->yres);
+		d = abs((int)(cmode->xres - mode->xres)) +
+			abs((int)(cmode->yres - mode->yres));
 		if (diff > d) {
 			diff = d;
 			best = cmode;
 		} else if (diff == d) {
-			d = abs(cmode->refresh - mode->refresh);
+			d = abs((int)(cmode->refresh - mode->refresh));
 			if (diff_refresh > d) {
 				diff_refresh = d;
 				best = cmode;
diff --git a/drivers/video/uvesafb.c b/drivers/video/uvesafb.c
index 7b8839e..6621427 100644
--- a/drivers/video/uvesafb.c
+++ b/drivers/video/uvesafb.c
@@ -320,9 +320,9 @@ static int uvesafb_vbe_find_mode(struct uvesafb_par *par,
 	int i, match = -1, h = 0, d = 0x7fffffff;
 
 	for (i = 0; i < par->vbe_modes_cnt; i++) {
-		h = abs(par->vbe_modes[i].x_res - xres) +
-		    abs(par->vbe_modes[i].y_res - yres) +
-		    abs(depth - par->vbe_modes[i].depth);
+		h = abs((int)(par->vbe_modes[i].x_res - xres)) +
+		    abs((int)(par->vbe_modes[i].y_res - yres)) +
+		    abs((int)(depth - par->vbe_modes[i].depth));
 
 		/*
 		 * We have an exact match in terms of resolution
@@ -1375,7 +1375,7 @@ static int uvesafb_check_var(struct fb_var_screeninfo *var,
 	 * which is theoretically incorrect, but which we'll try to handle
 	 * here.
 	 */
-	if (depth == 0 || abs(depth - var->bits_per_pixel) >= 8)
+	if (depth == 0 || abs((int)(depth - var->bits_per_pixel)) >= 8)
 		depth = var->bits_per_pixel;
 
 	match = uvesafb_vbe_find_mode(par, var->xres, var->yres, depth,
