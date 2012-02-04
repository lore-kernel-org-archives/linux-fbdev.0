From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Sat, 04 Feb 2012 09:39:05 +0000
Subject: [PATCH 03/13] FB: sa1100: constify rgb structures
Message-Id: <E1Rtc5J-0000aS-Ui@rmk-PC.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20120204093744.GQ889@n2100.arm.linux.org.uk>
In-Reply-To: <20120204093744.GQ889@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The rgb structures should only be read and never written.  Constify
them.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/video/sa1100fb.c |    8 ++++----
 drivers/video/sa1100fb.h |    2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/video/sa1100fb.c b/drivers/video/sa1100fb.c
index bac9d4f..a797220 100644
--- a/drivers/video/sa1100fb.c
+++ b/drivers/video/sa1100fb.c
@@ -199,21 +199,21 @@
 extern void (*sa1100fb_backlight_power)(int on);
 extern void (*sa1100fb_lcd_power)(int on);
 
-static struct sa1100fb_rgb rgb_4 = {
+static const struct sa1100fb_rgb rgb_4 = {
 	.red	= { .offset = 0,  .length = 4, },
 	.green	= { .offset = 0,  .length = 4, },
 	.blue	= { .offset = 0,  .length = 4, },
 	.transp	= { .offset = 0,  .length = 0, },
 };
 
-static struct sa1100fb_rgb rgb_8 = {
+static const struct sa1100fb_rgb rgb_8 = {
 	.red	= { .offset = 0,  .length = 8, },
 	.green	= { .offset = 0,  .length = 8, },
 	.blue	= { .offset = 0,  .length = 8, },
 	.transp	= { .offset = 0,  .length = 0, },
 };
 
-static struct sa1100fb_rgb def_rgb_16 = {
+static const struct sa1100fb_rgb def_rgb_16 = {
 	.red	= { .offset = 11, .length = 5, },
 	.green	= { .offset = 5,  .length = 6, },
 	.blue	= { .offset = 0,  .length = 5, },
@@ -270,7 +270,7 @@ static struct sa1100fb_mach_info h3600_info __devinitdata = {
 	.lccr3		= LCCR3_OutEnH | LCCR3_PixRsEdg | LCCR3_ACBsDiv(2),
 };
 
-static struct sa1100fb_rgb h3600_rgb_16 = {
+static const struct sa1100fb_rgb h3600_rgb_16 = {
 	.red	= { .offset = 12, .length = 4, },
 	.green	= { .offset = 7,  .length = 4, },
 	.blue	= { .offset = 1,  .length = 4, },
diff --git a/drivers/video/sa1100fb.h b/drivers/video/sa1100fb.h
index 1c3b459..7a3d66a 100644
--- a/drivers/video/sa1100fb.h
+++ b/drivers/video/sa1100fb.h
@@ -65,7 +65,7 @@ struct sa1100fb_lcd_reg {
 struct sa1100fb_info {
 	struct fb_info		fb;
 	struct device		*dev;
-	struct sa1100fb_rgb	*rgb[NR_RGB];
+	const struct sa1100fb_rgb *rgb[NR_RGB];
 
 	u_int			max_bpp;
 	u_int			max_xres;
-- 
1.7.4.4

