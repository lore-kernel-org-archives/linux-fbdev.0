From: "Maciej W. Rozycki" <macro@linux-mips.org>
Date: Mon, 22 Feb 2016 01:54:46 +0000
Subject: [PATCH] video: fbdev: pmag-ba-fb: Fix the lower margin size
Message-Id: <alpine.LFD.2.20.1602220109160.7431@eddie.linux-mips.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

According to the board specification[1] the width of the vertical sync 
front porch is 12 pixels or the same as the width of the horizontal sync 
front porch.  This in turn means the size of the lower margin is 0, 
because the vertical sync starts as soon as the start of the horizontal 
sync terminates the last line.

References:

[1] "PMAG-BA TURBOchannel Color Frame Buffer Functional Specification",
    Revision 1.2, Workstation Systems Engineering, Digital Equipment
    Corporation, August 27, 1990, Table 3-5: "Video Timing"

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
linux-pmag-ba-lower.patch
Index: linux-20150524-4maxp64/drivers/video/fbdev/pmag-ba-fb.c
=================================--- linux-20150524-4maxp64.orig/drivers/video/fbdev/pmag-ba-fb.c
+++ linux-20150524-4maxp64/drivers/video/fbdev/pmag-ba-fb.c
@@ -60,7 +60,7 @@ static struct fb_var_screeninfo pmagbafb
 	.left_margin	= 116,
 	.right_margin	= 12,
 	.upper_margin	= 34,
-	.lower_margin	= 12,
+	.lower_margin	= 0,
 	.hsync_len	= 128,
 	.vsync_len	= 3,
 	.sync		= FB_SYNC_ON_GREEN,
