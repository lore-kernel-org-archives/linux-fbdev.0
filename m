From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Sat, 04 Feb 2012 09:39:46 +0000
Subject: [PATCH 05/13] FB: sa1100: combine RGB bitfield overrides into sa1100fb_mach_info
Message-Id: <E1Rtc5y-0000ad-Pa@rmk-PC.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20120204093744.GQ889@n2100.arm.linux.org.uk>
In-Reply-To: <20120204093744.GQ889@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Allow the sa1100fb_mach_info structure to carry the RGB bitfield
overrides, rather than requiring them to be separately initialized
in sa1100fb_get_machine_info().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/video/sa1100fb.c |   21 ++++++++++++++-------
 drivers/video/sa1100fb.h |   22 ++++++++++------------
 2 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/drivers/video/sa1100fb.c b/drivers/video/sa1100fb.c
index ecd7cd4..a905e20 100644
--- a/drivers/video/sa1100fb.c
+++ b/drivers/video/sa1100fb.c
@@ -252,6 +252,13 @@ static struct sa1100fb_mach_info pal_info __devinitdata = {
 #endif
 
 #ifdef CONFIG_SA1100_H3600
+static const struct sa1100fb_rgb h3600_rgb_16 = {
+	.red	= { .offset = 12, .length = 4, },
+	.green	= { .offset = 7,  .length = 4, },
+	.blue	= { .offset = 1,  .length = 4, },
+	.transp	= { .offset = 0,  .length = 0, },
+};
+
 static struct sa1100fb_mach_info h3600_info __devinitdata = {
 	.pixclock	= 174757, 	.bpp		= 16,
 	.xres		= 320,		.yres		= 240,
@@ -264,13 +271,8 @@ static struct sa1100fb_mach_info h3600_info __devinitdata = {
 
 	.lccr0		= LCCR0_Color | LCCR0_Sngl | LCCR0_Act,
 	.lccr3		= LCCR3_OutEnH | LCCR3_PixRsEdg | LCCR3_ACBsDiv(2),
-};
 
-static const struct sa1100fb_rgb h3600_rgb_16 = {
-	.red	= { .offset = 12, .length = 4, },
-	.green	= { .offset = 7,  .length = 4, },
-	.blue	= { .offset = 1,  .length = 4, },
-	.transp	= { .offset = 0,  .length = 0, },
+	.rgb[RGB_16] = &h3600_rgb_16,
 };
 #endif
 
@@ -413,7 +415,6 @@ sa1100fb_get_machine_info(struct sa1100fb_info *fbi)
 #ifdef CONFIG_SA1100_H3600
 	if (machine_is_h3600()) {
 		inf = &h3600_info;
-		fbi->rgb[RGB_16] = &h3600_rgb_16;
 	}
 #endif
 #ifdef CONFIG_SA1100_COLLIE
@@ -1352,6 +1353,7 @@ static struct sa1100fb_info * __devinit sa1100fb_init_fbinfo(struct device *dev)
 {
 	struct sa1100fb_mach_info *inf;
 	struct sa1100fb_info *fbi;
+	unsigned i;
 
 	fbi = kmalloc(sizeof(struct sa1100fb_info) + sizeof(u32) * 16,
 		      GFP_KERNEL);
@@ -1424,6 +1426,11 @@ static struct sa1100fb_info * __devinit sa1100fb_init_fbinfo(struct device *dev)
 	fbi->fb.fix.smem_len		= fbi->max_xres * fbi->max_yres *
 					  fbi->max_bpp / 8;
 
+	/* Copy the RGB bitfield overrides */
+	for (i = 0; i < NR_RGB; i++)
+		if (inf->rgb[i])
+			fbi->rgb[i] = inf->rgb[i];
+
 	init_waitqueue_head(&fbi->ctrlr_wait);
 	INIT_WORK(&fbi->task, sa1100fb_task);
 	mutex_init(&fbi->ctrlr_lock);
diff --git a/drivers/video/sa1100fb.h b/drivers/video/sa1100fb.h
index b1d5b08..77239b7 100644
--- a/drivers/video/sa1100fb.h
+++ b/drivers/video/sa1100fb.h
@@ -10,10 +10,12 @@
  * for more details.
  */
 
-/*
- * These are the bitfields for each
- * display depth that we support.
- */
+#define RGB_4	0
+#define RGB_8	1
+#define RGB_16	2
+#define NR_RGB	3
+
+/* These are the bitfields for each display depth that we support. */
 struct sa1100fb_rgb {
 	struct fb_bitfield	red;
 	struct fb_bitfield	green;
@@ -21,9 +23,7 @@ struct sa1100fb_rgb {
 	struct fb_bitfield	transp;
 };
 
-/*
- * This structure describes the machine which we are running on.
- */
+/* This structure describes the machine which we are running on. */
 struct sa1100fb_mach_info {
 	u_long		pixclock;
 
@@ -47,6 +47,9 @@ struct sa1100fb_mach_info {
 
 	u_int		lccr0;
 	u_int		lccr3;
+
+	/* Overrides for the default RGB maps */
+	const struct sa1100fb_rgb *rgb[NR_RGB];
 };
 
 /* Shadows for LCD controller registers */
@@ -57,11 +60,6 @@ struct sa1100fb_lcd_reg {
 	unsigned long lccr3;
 };
 
-#define RGB_4	(0)
-#define RGB_8	(1)
-#define RGB_16	(2)
-#define NR_RGB	3
-
 struct sa1100fb_info {
 	struct fb_info		fb;
 	struct device		*dev;
-- 
1.7.4.4

