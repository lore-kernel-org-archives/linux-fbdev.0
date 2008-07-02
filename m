From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] neofb: drop redundant code
Date: Wed, 2 Jul 2008 19:46:46 +0200
Message-ID: <20080702194646.ae2fad0a.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KE6r6-0002vo-P8 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 02 Jul 2008 11:15:00 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KE6r3-0002mp-Nz
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 02 Jul 2008 11:15:00 -0700
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

Drop structure which is only set but never read.
Drop variables which are only set and never read.
Convert one long switch into two shorter ones.

Add cpu_relax() in busy waiting loop.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

diff -urp linux-old/drivers/video/neofb.c linux-2.6.25/drivers/video/neofb.c
--- linux-old/drivers/video/neofb.c	2008-06-29 14:59:20.000000000 +0000
+++ linux-2.6.25/drivers/video/neofb.c	2008-06-29 15:02:26.000000000 +0000
@@ -479,7 +479,8 @@ static inline int neo2200_sync(struct fb
 {
 	struct neofb_par *par = info->par;
 
-	while (readl(&par->neo2200->bltStat) & 1);
+	while (readl(&par->neo2200->bltStat) & 1)
+		cpu_relax();
 	return 0;
 }
 
@@ -587,34 +588,14 @@ static int
 neofb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 {
 	struct neofb_par *par = info->par;
-	unsigned int pixclock = var->pixclock;
-	struct xtimings timings;
 	int memlen, vramlen;
 	int mode_ok = 0;
 
 	DBG("neofb_check_var");
 
-	if (!pixclock)
-		pixclock = 10000;	/* 10ns = 100MHz */
-	timings.pixclock = 1000000000 / pixclock;
-	if (timings.pixclock < 1)
-		timings.pixclock = 1;
-
-	if (timings.pixclock > par->maxClock)
+	if (PICOS2KHZ(var->pixclock) > par->maxClock)
 		return -EINVAL;
 
-	timings.dblscan = var->vmode & FB_VMODE_DOUBLE;
-	timings.interlaced = var->vmode & FB_VMODE_INTERLACED;
-	timings.HDisplay = var->xres;
-	timings.HSyncStart = timings.HDisplay + var->right_margin;
-	timings.HSyncEnd = timings.HSyncStart + var->hsync_len;
-	timings.HTotal = timings.HSyncEnd + var->left_margin;
-	timings.VDisplay = var->yres;
-	timings.VSyncStart = timings.VDisplay + var->lower_margin;
-	timings.VSyncEnd = timings.VSyncStart + var->vsync_len;
-	timings.VTotal = timings.VSyncEnd + var->upper_margin;
-	timings.sync = var->sync;
-
 	/* Is the mode larger than the LCD panel? */
 	if (par->internal_display &&
             ((var->xres > par->NeoPanelWidth) ||
@@ -1923,9 +1904,6 @@ static int __devinit neo_init_hw(struct 
 	int maxClock = 65000;
 	int CursorMem = 1024;
 	int CursorOff = 0x100;
-	int linearSize = 1024;
-	int maxWidth = 1024;
-	int maxHeight = 1024;
 
 	DBG("neo_init_hw");
 
@@ -1944,81 +1922,52 @@ static int __devinit neo_init_hw(struct 
 	case FB_ACCEL_NEOMAGIC_NM2070:
 		videoRam = 896;
 		maxClock = 65000;
-		CursorMem = 2048;
-		CursorOff = 0x100;
-		linearSize = 1024;
-		maxWidth = 1024;
-		maxHeight = 1024;
 		break;
 	case FB_ACCEL_NEOMAGIC_NM2090:
 	case FB_ACCEL_NEOMAGIC_NM2093:
-		videoRam = 1152;
-		maxClock = 80000;
-		CursorMem = 2048;
-		CursorOff = 0x100;
-		linearSize = 2048;
-		maxWidth = 1024;
-		maxHeight = 1024;
-		break;
 	case FB_ACCEL_NEOMAGIC_NM2097:
 		videoRam = 1152;
 		maxClock = 80000;
-		CursorMem = 1024;
-		CursorOff = 0x100;
-		linearSize = 2048;
-		maxWidth = 1024;
-		maxHeight = 1024;
 		break;
 	case FB_ACCEL_NEOMAGIC_NM2160:
 		videoRam = 2048;
 		maxClock = 90000;
-		CursorMem = 1024;
-		CursorOff = 0x100;
-		linearSize = 2048;
-		maxWidth = 1024;
-		maxHeight = 1024;
 		break;
 	case FB_ACCEL_NEOMAGIC_NM2200:
 		videoRam = 2560;
 		maxClock = 110000;
-		CursorMem = 1024;
-		CursorOff = 0x1000;
-		linearSize = 4096;
-		maxWidth = 1280;
-		maxHeight = 1024;	/* ???? */
-
-		par->neo2200 = (Neo2200 __iomem *) par->mmio_vbase;
 		break;
 	case FB_ACCEL_NEOMAGIC_NM2230:
 		videoRam = 3008;
 		maxClock = 110000;
-		CursorMem = 1024;
-		CursorOff = 0x1000;
-		linearSize = 4096;
-		maxWidth = 1280;
-		maxHeight = 1024;	/* ???? */
-
-		par->neo2200 = (Neo2200 __iomem *) par->mmio_vbase;
 		break;
 	case FB_ACCEL_NEOMAGIC_NM2360:
 		videoRam = 4096;
 		maxClock = 110000;
-		CursorMem = 1024;
-		CursorOff = 0x1000;
-		linearSize = 4096;
-		maxWidth = 1280;
-		maxHeight = 1024;	/* ???? */
-
-		par->neo2200 = (Neo2200 __iomem *) par->mmio_vbase;
 		break;
 	case FB_ACCEL_NEOMAGIC_NM2380:
 		videoRam = 6144;
 		maxClock = 110000;
+		break;
+	}
+	switch (info->fix.accel) {
+	case FB_ACCEL_NEOMAGIC_NM2070:
+	case FB_ACCEL_NEOMAGIC_NM2090:
+	case FB_ACCEL_NEOMAGIC_NM2093:
+		CursorMem = 2048;
+		CursorOff = 0x100;
+		break;
+	case FB_ACCEL_NEOMAGIC_NM2097:
+	case FB_ACCEL_NEOMAGIC_NM2160:
+		CursorMem = 1024;
+		CursorOff = 0x100;
+		break;
+	case FB_ACCEL_NEOMAGIC_NM2200:
+	case FB_ACCEL_NEOMAGIC_NM2230:
+	case FB_ACCEL_NEOMAGIC_NM2360:
+	case FB_ACCEL_NEOMAGIC_NM2380:
 		CursorMem = 1024;
 		CursorOff = 0x1000;
-		linearSize = 8192;
-		maxWidth = 1280;
-		maxHeight = 1024;	/* ???? */
 
 		par->neo2200 = (Neo2200 __iomem *) par->mmio_vbase;
 		break;
@@ -2032,7 +1981,7 @@ static int __devinit neo_init_hw(struct 
 */
 	par->maxClock = maxClock;
 	par->cursorOff = CursorOff;
-	return ((videoRam * 1024));
+	return videoRam * 1024;
 }
 
 

----------------------------------------------------------------------
Masz czas tylko do 10 lipca.
Przystap on-line do ING OFE!
Sprawdz >> http://link.interia.pl/f1e54


-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
