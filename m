From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] Test: Improve radeonfb mode setting on CRT
Date: Sun, 13 Mar 2005 10:56:10 +1100
Message-ID: <1110671770.19810.57.camel@gaston>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DAGTO-0002AR-Ev
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 12 Mar 2005 15:56:46 -0800
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1DAGTN-0005qO-Tm
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 12 Mar 2005 15:56:46 -0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Linux Kernel list <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Hi !

Recent radeonfb's tend to be a bit anal with accepting or refusing a
mode on a CRT since they expect exact resolution, which doesn't really
happen with fbcon.

This patch reworks the mode matching function to fix that issue, but I
didn't have a chance to test it, so feedback appreciated.

Index: linux-work/drivers/video/aty/radeon_monitor.c
===================================================================
--- linux-work.orig/drivers/video/aty/radeon_monitor.c	2005-03-11 16:54:25.000000000 +1100
+++ linux-work/drivers/video/aty/radeon_monitor.c	2005-03-11 16:58:04.000000000 +1100
@@ -903,7 +903,7 @@
  */
 
 /*
- * This is used when looking for modes. We assign a "goodness" value
+ * This is used when looking for modes. We assign a "distance" value
  * to a mode in the modedb depending how "close" it is from what we
  * are looking for.
  * Currently, we don't compare that much, we could do better but
@@ -912,13 +912,11 @@
 static int radeon_compare_modes(const struct fb_var_screeninfo *var,
 				const struct fb_videomode *mode)
 {
-	int goodness = 0;
+	int distance = 0;
 
-	if (var->yres == mode->yres)
-		goodness += 10;
-	if (var->xres == mode->xres)
-		goodness += 9;
-	return goodness;
+	distance = mode->yres - var->yres;
+	distance += (mode->xres - var->xres)/2;
+	return distance;
 }
 
 /*
@@ -940,7 +938,7 @@
 	const struct fb_videomode	*db = vesa_modes;
 	int				i, dbsize = 34;
 	int				has_rmx, native_db = 0;
-	int				goodness = 0;
+	int				distance = INT_MAX;
 	const struct fb_videomode	*candidate = NULL;
 
 	/* Start with a copy of the requested mode */
@@ -976,19 +974,19 @@
 	/* Now look for a mode in the database */
 	while (db) {
 		for (i = 0; i < dbsize; i++) {
-			int g;
+			int d;
 
 			if (db[i].yres < src->yres)
 				continue;	
 			if (db[i].xres < src->xres)
 				continue;
-			g = radeon_compare_modes(src, &db[i]);
+			d = radeon_compare_modes(src, &db[i]);
 			/* If the new mode is at least as good as the previous one,
 			 * then it's our new candidate
 			 */
-			if (g >= goodness) {
+			if (d < distance) {
 				candidate = &db[i];
-				goodness = g;
+				distance = d;
 			}
 		}
 		db = NULL;




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
