From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH] i.MX Framebuffer: remove header file
Date: Tue,  2 Sep 2008 13:24:50 +0200
Message-ID: <1220354697-13648-8-git-send-email-s.hauer@pengutronix.de>
References: <1220354697-13648-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KaU5d-0001DA-In for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 02 Sep 2008 04:30:29 -0700
Received: from metis.extern.pengutronix.de ([83.236.181.26])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KaU5c-0001yC-L8
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 02 Sep 2008 04:30:29 -0700
In-Reply-To: <1220354697-13648-1-git-send-email-s.hauer@pengutronix.de>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Andrew Dyer <amdyer@gmail.com>

Move contents of imxfb.h to imxfb.c since it is used only
in this file

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/video/imxfb.c |   62 +++++++++++++++++++++++++++++++++++++++-
 drivers/video/imxfb.h |   74 -------------------------------------------------
 2 files changed, 60 insertions(+), 76 deletions(-)
 delete mode 100644 drivers/video/imxfb.h

diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
index feaae73..7b3400c 100644
--- a/drivers/video/imxfb.c
+++ b/drivers/video/imxfb.c
@@ -40,8 +40,6 @@
  */
 #define DEBUG_VAR 1
 
-#include "imxfb.h"
-
 #define DRIVER_NAME "imx-fb"
 
 #define LCDC_SSA	0x00
@@ -109,6 +107,66 @@
 #define LCDISR_EOF	(1<<1)
 #define LCDISR_BOF	(1<<0)
 
+/*
+ * These are the bitfields for each
+ * display depth that we support.
+ */
+struct imxfb_rgb {
+	struct fb_bitfield	red;
+	struct fb_bitfield	green;
+	struct fb_bitfield	blue;
+	struct fb_bitfield	transp;
+};
+
+#define RGB_16	(0)
+#define RGB_8	(1)
+#define NR_RGB	2
+
+struct imxfb_info {
+	struct platform_device  *pdev;
+	void __iomem		*regs;
+
+	struct imxfb_rgb	*rgb[NR_RGB];
+
+	u_int			max_bpp;
+	u_int			max_xres;
+	u_int			max_yres;
+
+	/*
+	 * These are the addresses we mapped
+	 * the framebuffer memory region to.
+	 */
+	dma_addr_t		map_dma;
+	u_char			*map_cpu;
+	u_int			map_size;
+
+	u_char			*screen_cpu;
+	dma_addr_t		screen_dma;
+	u_int			palette_size;
+
+	dma_addr_t		dbar1;
+	dma_addr_t		dbar2;
+
+	u_int			pcr;
+	u_int			pwmr;
+	u_int			lscr1;
+	u_int			dmacr;
+	u_int			cmap_inverse:1,
+				cmap_static:1,
+				unused:30;
+
+	void (*lcd_power)(int);
+	void (*backlight_power)(int);
+};
+
+#define IMX_NAME	"IMX"
+
+/*
+ * Minimum X and Y resolutions
+ */
+#define MIN_XRES	64
+#define MIN_YRES	64
+
 static struct imxfb_rgb def_rgb_16 = {
 	.red	= { .offset = 8,  .length = 4, },
 	.green	= { .offset = 4,  .length = 4, },
diff --git a/drivers/video/imxfb.h b/drivers/video/imxfb.h
deleted file mode 100644
index baa86a0..0000000
--- a/drivers/video/imxfb.h
+++ /dev/null
@@ -1,74 +0,0 @@
-/*
- * linux/drivers/video/imxfb.h
- *
- *  Freescale i.MX Frame Buffer device driver
- *
- *  Copyright (C) 2004 S.Hauer, Pengutronix
- *
- *  Copyright (C) 1999 Eric A. Thomas
- *   Based on acornfb.c Copyright (C) Russell King.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file COPYING in the main directory of this archive
- * for more details.
- */
-
-/*
- * These are the bitfields for each
- * display depth that we support.
- */
-struct imxfb_rgb {
-	struct fb_bitfield	red;
-	struct fb_bitfield	green;
-	struct fb_bitfield	blue;
-	struct fb_bitfield	transp;
-};
-
-#define RGB_16	(0)
-#define RGB_8	(1)
-#define NR_RGB	2
-
-struct imxfb_info {
-	void __iomem		*regs;
-
-	struct imxfb_rgb	*rgb[NR_RGB];
-
-	u_int			max_bpp;
-	u_int			max_xres;
-	u_int			max_yres;
-
-	/*
-	 * These are the addresses we mapped
-	 * the framebuffer memory region to.
-	 */
-	dma_addr_t		map_dma;
-	u_char *		map_cpu;
-	u_int			map_size;
-
-	u_char *		screen_cpu;
-	dma_addr_t		screen_dma;
-	u_int			palette_size;
-
-	dma_addr_t		dbar1;
-	dma_addr_t		dbar2;
-
-	u_int			pcr;
-	u_int			pwmr;
-	u_int			lscr1;
-	u_int			dmacr;
-	u_int			cmap_inverse:1,
-				cmap_static:1,
-				unused:30;
-
-	void (*lcd_power)(int);
-	void (*backlight_power)(int);
-};
-
-#define IMX_NAME	"IMX"
-
-/*
- * Minimum X and Y resolutions
- */
-#define MIN_XRES	64
-#define MIN_YRES	64
-
-- 
1.5.6.3


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
