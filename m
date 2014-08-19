From: "Jon Medhurst (Tixy)" <tixy@linaro.org>
Date: Tue, 19 Aug 2014 13:07:31 +0000
Subject: [PATCH] video: ARM CLCD: Ensure bits-per-pixel is a power of 2 and <= 32
Message-Id: <1408453651.3746.41.camel@linaro1.home>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

If the device-tree specifies a max-memory-bandwidth property then
the CLCD driver uses that to calculate the bits-per-pixel supported,
however, it doesn't ensure that the result is a sane value, i.e. a
power of 2 and <= 32 as the rest of the code assumes.

Acked-by: Pawel Moll <pawel.moll@arm.com>
Signed-off-by: Jon Medhurst <tixy@linaro.org>
---

This fixes code which is new in 3.17 (commit d10715be03) and so I assume
is a candidate for adding to a coming -rc ? Without the fix, people can
be left (as I was) with a blank non-functioning screen even if they
create a valid device-tree for the new driver functionality.

 drivers/video/fbdev/amba-clcd.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/amba-clcd.c b/drivers/video/fbdev/amba-clcd.c
index beadd3e..98b66b7 100644
--- a/drivers/video/fbdev/amba-clcd.c
+++ b/drivers/video/fbdev/amba-clcd.c
@@ -24,6 +24,7 @@
 #include <linux/list.h>
 #include <linux/amba/bus.h>
 #include <linux/amba/clcd.h>
+#include <linux/bitops.h>
 #include <linux/clk.h>
 #include <linux/hardirq.h>
 #include <linux/dma-mapping.h>
@@ -650,6 +651,7 @@ static int clcdfb_of_init_display(struct clcd_fb *fb)
 {
 	struct device_node *endpoint;
 	int err;
+	int bpp;
 	u32 max_bandwidth;
 	u32 tft_r0b0g0[3];
 
@@ -667,11 +669,15 @@ static int clcdfb_of_init_display(struct clcd_fb *fb)
 
 	err = of_property_read_u32(fb->dev->dev.of_node, "max-memory-bandwidth",
 			&max_bandwidth);
-	if (!err)
-		fb->panel->bpp = 8 * max_bandwidth / (fb->panel->mode.xres *
+	if (!err) {
+		bpp = 8 * max_bandwidth / (fb->panel->mode.xres *
 				fb->panel->mode.yres * fb->panel->mode.refresh);
-	else
-		fb->panel->bpp = 32;
+		bpp = rounddown_pow_of_two(bpp);
+		if (bpp > 32)
+			bpp = 32;
+	} else
+		bpp = 32;
+	fb->panel->bpp = bpp;
 
 #ifdef CONFIG_CPU_BIG_ENDIAN
 	fb->panel->cntl |= CNTL_BEBO;
-- 
2.0.1


