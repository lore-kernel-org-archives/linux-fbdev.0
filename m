From: "Maciej W. Rozycki" <macro@linux-mips.org>
Date: Mon, 22 Feb 2016 01:55:12 +0000
Subject: [PATCH 3/7] video: fbdev: pmag-aa-fb: Report video timings
Message-Id: <alpine.LFD.2.20.1602220138260.7431@eddie.linux-mips.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <alpine.LFD.2.20.1602220110330.7431@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.20.1602220110330.7431@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

The board uses hardwired timings compatible with 72Hz DEC VR319-DA and 
VRM17-AA monitors, according to the board owner's manual[1].  These 
timings are accordingly taken from the VR319 manual[2].

References:

[1] "The Monochrome Frame Buffer TURBOchannel Module", Digital Equipment
    Corporation, Order Number: EK-MFBOM-TC-001, December 1991

[2] "Installing and Using the VR319 Monochrome Monitor", Digital
    Equipment Corporation, Order Number: EK-VR319-IN-001, First Edition,
    January 1990, Table 6-1 "Video Timing--1280 x 1024 Resolution"

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
linux-pmag-aa-timing.patch
Index: linux-20160211-4maxp64/drivers/video/fbdev/pmag-aa-fb.c
=================================--- linux-20160211-4maxp64.orig/drivers/video/fbdev/pmag-aa-fb.c
+++ linux-20160211-4maxp64/drivers/video/fbdev/pmag-aa-fb.c
@@ -79,6 +79,13 @@ static struct fb_var_screeninfo aafb_def
 	.blue.length	= 0,
 	.activate	= FB_ACTIVATE_NOW,
 	.accel_flags	= FB_ACCEL_NONE,
+	.pixclock	= 7645,
+	.left_margin	= 224,
+	.right_margin	= 32,
+	.upper_margin	= 33,
+	.lower_margin	= 3,
+	.hsync_len	= 160,
+	.vsync_len	= 3,
 	.sync		= FB_SYNC_ON_GREEN,
 	.vmode		= FB_VMODE_NONINTERLACED,
 };
