From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH] video: add sh_mobile_lcdc platform flags
Date: Thu, 09 Oct 2008 18:48:16 +0900
Message-ID: <20081009094816.6478.31468.sendpatchset@rx1.opensource.se>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, lethal@linux-sh.org, linux-fbdev-devel@lists.sourceforge.net

From: Magnus Damm <damm@igel.co.jp>

Add platform data flags for detailed lcd display configuration.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Paul, can you please handle this one together with the other patch?

 drivers/video/sh_mobile_lcdcfb.c |    5 +++++
 include/video/sh_mobile_lcdc.h   |    7 +++++++
 2 files changed, 12 insertions(+)

--- 0014/drivers/video/sh_mobile_lcdcfb.c
+++ work/drivers/video/sh_mobile_lcdcfb.c	2008-10-09 18:08:33.000000000 +0900
@@ -262,6 +262,11 @@ static int sh_mobile_lcdc_start(struct s
 		tmp = ch->ldmt1r_value;
 		tmp |= (lcd_cfg->sync & FB_SYNC_VERT_HIGH_ACT) ? 0 : 1 << 28;
 		tmp |= (lcd_cfg->sync & FB_SYNC_HOR_HIGH_ACT) ? 0 : 1 << 27;
+		tmp |= (ch->cfg.flags & LCDC_FLAGS_DWPOL) ? 1 << 26 : 0;
+		tmp |= (ch->cfg.flags & LCDC_FLAGS_DIPOL) ? 1 << 25 : 0;
+		tmp |= (ch->cfg.flags & LCDC_FLAGS_DAPOL) ? 1 << 24 : 0;
+		tmp |= (ch->cfg.flags & LCDC_FLAGS_HSCNT) ? 1 << 17 : 0;
+		tmp |= (ch->cfg.flags & LCDC_FLAGS_DWCNT) ? 1 << 16 : 0;
 		lcdc_write_chan(ch, LDMT1R, tmp);
 
 		/* setup SYS bus */
--- 0014/include/video/sh_mobile_lcdc.h
+++ work/include/video/sh_mobile_lcdc.h	2008-10-09 18:04:53.000000000 +0900
@@ -28,6 +28,12 @@ enum { LCDC_CHAN_DISABLED = 0,
 
 enum { LCDC_CLK_BUS, LCDC_CLK_PERIPHERAL, LCDC_CLK_EXTERNAL };
 
+#define LCDC_FLAGS_DWPOL (1 << 0) /* Rising edge dot clock data latch */
+#define LCDC_FLAGS_DIPOL (1 << 1) /* Active low display enable polarity */
+#define LCDC_FLAGS_DAPOL (1 << 2) /* Active low display data polarity */
+#define LCDC_FLAGS_HSCNT (1 << 3) /* Disable HSYNC during VBLANK */
+#define LCDC_FLAGS_DWCNT (1 << 4) /* Disable dotclock during blanking */
+
 struct sh_mobile_lcdc_sys_bus_cfg {
 	unsigned long ldmt2r;
 	unsigned long ldmt3r;
@@ -57,6 +63,7 @@ struct sh_mobile_lcdc_chan_cfg {
 	int bpp;
 	int interface_type; /* selects RGBn or SYSn I/F, see above */
 	int clock_divider;
+	unsigned long flags; /* LCDC_FLAGS_... */
 	struct fb_videomode lcd_cfg;
 	struct sh_mobile_lcdc_lcd_size_cfg lcd_size_cfg;
 	struct sh_mobile_lcdc_board_cfg board_cfg;
