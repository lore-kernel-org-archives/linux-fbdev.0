From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Sat, 04 Feb 2012 09:40:07 +0000
Subject: [PATCH 06/13] FB: sa1100: move machine inf structures to <video/sa1100fb.h>
Message-Id: <E1Rtc6J-0000ah-76@rmk-PC.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20120204093744.GQ889@n2100.arm.linux.org.uk>
In-Reply-To: <20120204093744.GQ889@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Move the LCD data structures to an include file which can be shared
with the board code in arch/arm/mach-sa1100.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/video/sa1100fb.c |    6 ++++-
 drivers/video/sa1100fb.h |   42 --------------------------------
 include/video/sa1100fb.h |   59 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+), 43 deletions(-)
 create mode 100644 include/video/sa1100fb.h

diff --git a/drivers/video/sa1100fb.c b/drivers/video/sa1100fb.c
index a905e20..8f5557a 100644
--- a/drivers/video/sa1100fb.c
+++ b/drivers/video/sa1100fb.c
@@ -178,6 +178,8 @@
 #include <linux/mutex.h>
 #include <linux/io.h>
 
+#include <video/sa1100fb.h>
+
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
 #include <mach/assabet.h>
@@ -1388,7 +1390,9 @@ static struct sa1100fb_info * __devinit sa1100fb_init_fbinfo(struct device *dev)
 	fbi->rgb[RGB_8]		= &rgb_8;
 	fbi->rgb[RGB_16]	= &def_rgb_16;
 
-	inf = sa1100fb_get_machine_info(fbi);
+	inf = dev->platform_data;
+	if (!inf)
+		inf = sa1100fb_get_machine_info(fbi);
 
 	/*
 	 * People just don't seem to get this.  We don't support
diff --git a/drivers/video/sa1100fb.h b/drivers/video/sa1100fb.h
index 77239b7..9ff9ba9 100644
--- a/drivers/video/sa1100fb.h
+++ b/drivers/video/sa1100fb.h
@@ -10,48 +10,6 @@
  * for more details.
  */
 
-#define RGB_4	0
-#define RGB_8	1
-#define RGB_16	2
-#define NR_RGB	3
-
-/* These are the bitfields for each display depth that we support. */
-struct sa1100fb_rgb {
-	struct fb_bitfield	red;
-	struct fb_bitfield	green;
-	struct fb_bitfield	blue;
-	struct fb_bitfield	transp;
-};
-
-/* This structure describes the machine which we are running on. */
-struct sa1100fb_mach_info {
-	u_long		pixclock;
-
-	u_short		xres;
-	u_short		yres;
-
-	u_char		bpp;
-	u_char		hsync_len;
-	u_char		left_margin;
-	u_char		right_margin;
-
-	u_char		vsync_len;
-	u_char		upper_margin;
-	u_char		lower_margin;
-	u_char		sync;
-
-	u_int		cmap_greyscale:1,
-			cmap_inverse:1,
-			cmap_static:1,
-			unused:29;
-
-	u_int		lccr0;
-	u_int		lccr3;
-
-	/* Overrides for the default RGB maps */
-	const struct sa1100fb_rgb *rgb[NR_RGB];
-};
-
 /* Shadows for LCD controller registers */
 struct sa1100fb_lcd_reg {
 	unsigned long lccr0;
diff --git a/include/video/sa1100fb.h b/include/video/sa1100fb.h
new file mode 100644
index 0000000..e73c813
--- /dev/null
+++ b/include/video/sa1100fb.h
@@ -0,0 +1,59 @@
+/*
+ * StrongARM 1100 LCD Controller Frame Buffer Device
+ *
+ * Copyright (C) 1999 Eric A. Thomas
+ *  Based on acornfb.c Copyright (C) Russell King.
+ *  
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file COPYING in the main directory of this archive
+ * for more details.
+ */
+#ifndef _VIDEO_SA1100FB_H
+#define _VIDEO_SA1100FB_H
+
+#include <linux/fb.h>
+#include <linux/types.h>
+
+#define RGB_4	0
+#define RGB_8	1
+#define RGB_16	2
+#define NR_RGB	3
+
+/* These are the bitfields for each display depth that we support. */
+struct sa1100fb_rgb {
+	struct fb_bitfield	red;
+	struct fb_bitfield	green;
+	struct fb_bitfield	blue;
+	struct fb_bitfield	transp;
+};
+
+/* This structure describes the machine which we are running on. */
+struct sa1100fb_mach_info {
+	u_long		pixclock;
+
+	u_short		xres;
+	u_short		yres;
+
+	u_char		bpp;
+	u_char		hsync_len;
+	u_char		left_margin;
+	u_char		right_margin;
+
+	u_char		vsync_len;
+	u_char		upper_margin;
+	u_char		lower_margin;
+	u_char		sync;
+
+	u_int		cmap_greyscale:1,
+			cmap_inverse:1,
+			cmap_static:1,
+			unused:29;
+
+	u_int		lccr0;
+	u_int		lccr3;
+
+	/* Overrides for the default RGB maps */
+	const struct sa1100fb_rgb *rgb[NR_RGB];
+};
+
+#endif
-- 
1.7.4.4

