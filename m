From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] cirrusfb: check_par fixes
Date: Sun, 24 Aug 2008 21:53:05 +0200
Message-ID: <20080824215305.f2563827.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KXLYB-00017S-Tl for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 24 Aug 2008 12:46:59 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KXLYA-0008Dw-4q
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 24 Aug 2008 12:46:59 -0700
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
To: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@linux-foundation.org>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

1. Check if virtual resolution fits into memory.
   Otherwise, Linux hangs during panning.
2. When selected use all available memory to
    maximize yres_virtual to speed up panning
   (previously also xres_virtual was increased).
3. Simplify memory restriction calculations.
---
 drivers/video/cirrusfb.c |   59 ++++++++++++++--------------------------------
 1 files changed, 18 insertions(+), 41 deletions(-)

diff --git a/drivers/video/cirrusfb.c b/drivers/video/cirrusfb.c
index 66e768d..09f4214 100644
--- a/drivers/video/cirrusfb.c
+++ b/drivers/video/cirrusfb.c
@@ -628,27 +628,18 @@ static long cirrusfb_get_mclk(long freq, int bpp, long *div)
 static int cirrusfb_check_var(struct fb_var_screeninfo *var,
 			      struct fb_info *info)
 {
-	int nom, den;		/* translyting from pixels->bytes */
-	int yres, i;
-	static struct { int xres, yres; } modes[] =
-	{ { 1600, 1280 },
-	  { 1280, 1024 },
-	  { 1024, 768 },
-	  { 800, 600 },
-	  { 640, 480 },
-	  { -1, -1 } };
+	int yres;
+	/* memory size in pixels */
+	unsigned pixels = info->screen_size * 8 / var->bits_per_pixel;
 
 	switch (var->bits_per_pixel) {
 	case 1:
-		nom = 4;
-		den = 8;
+		pixels /= 4;
 		break;		/* 8 pixel per byte, only 1/4th of mem usable */
 	case 8:
 	case 16:
 	case 24:
 	case 32:
-		nom = var->bits_per_pixel / 8;
-		den = 1;
 		break;		/* 1 pixel == 1 byte */
 	default:
 		printk(KERN_ERR "cirrusfb: mode %dx%dx%d rejected..."
@@ -658,43 +649,29 @@ static int cirrusfb_check_var(struct fb_var_screeninfo *var,
 		return -EINVAL;
 	}
 
-	if (var->xres * nom / den * var->yres > info->screen_size) {
-		printk(KERN_ERR "cirrusfb: mode %dx%dx%d rejected..."
-			"resolution too high to fit into video memory!\n",
-			var->xres, var->yres, var->bits_per_pixel);
-		DPRINTK("EXIT - EINVAL error\n");
-		return -EINVAL;
-	}
-
+	if (var->xres_virtual < var->xres)
+		var->xres_virtual = var->xres;
 	/* use highest possible virtual resolution */
-	if (var->xres_virtual == -1 &&
-	    var->yres_virtual == -1) {
-		printk(KERN_INFO
-		     "cirrusfb: using maximum available virtual resolution\n");
-		for (i = 0; modes[i].xres != -1; i++) {
-			int size = modes[i].xres * nom / den * modes[i].yres;
-			if (size < info->screen_size / 2)
-				break;
-		}
-		if (modes[i].xres == -1) {
-			printk(KERN_ERR "cirrusfb: could not find a virtual "
-				"resolution that fits into video memory!!\n");
-			DPRINTK("EXIT - EINVAL error\n");
-			return -EINVAL;
-		}
-		var->xres_virtual = modes[i].xres;
-		var->yres_virtual = modes[i].yres;
+	if (var->yres_virtual == -1) {
+		var->yres_virtual = pixels / var->xres_virtual;
 
 		printk(KERN_INFO "cirrusfb: virtual resolution set to "
 			"maximum of %dx%d\n", var->xres_virtual,
 			var->yres_virtual);
 	}
-
-	if (var->xres_virtual < var->xres)
-		var->xres_virtual = var->xres;
 	if (var->yres_virtual < var->yres)
 		var->yres_virtual = var->yres;
 
+	if (var->xres_virtual * var->yres_virtual > pixels) {
+		printk(KERN_ERR "cirrusfb: mode %dx%dx%d rejected... "
+		      "virtual resolution too high to fit into video memory!\n",
+			var->xres_virtual, var->yres_virtual,
+			var->bits_per_pixel);
+		DPRINTK("EXIT - EINVAL error\n");
+		return -EINVAL;
+	}
+
+
 	if (var->xoffset < 0)
 		var->xoffset = 0;
 	if (var->yoffset < 0)
-- 
1.5.2.2


----------------------------------------------------------------------
Nie szukam kochanka!
>> http://link.interia.pl/f1eeb


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
