From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 09 Dec 2015 15:59:30 +0000
Subject: [PATCH 02/23] OMAPDSS: DISPC: always set ALIGN when available
Message-Id: <1449676791-26304-3-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

By default DISPC asserts hsync and vsync sequentially, i.e. there's
first hsync and that is immediately followed by vsync. This is the only
available behaviour on OMAP2/3, and default behaviour on OMAP4+.

OMAP4+ has ALIGN bit in POL_FREQ register, which makes DISPC assert both
syncs at the same time.

It has been observed that some panels don't like sequential syncs (AM5
EVM's panel). After studying the datasheets for multiple panels and
encoders, and MIPI DPI spec, it looks like there is no standard way to
handle this.

Sometimes the datasheets don't mention the required syncs behaviour at
all, sometimes the datasheets have images that hint towards simultaneous
syncs, and sometimes it is explicitly mentioned that simultaneous syncs
are needed. No panels or encoders requiring sequential sync was found.

It thus seems to be safe to default to simultaneous syncs when the ALIGN
bit is available. This fixed AM5 EVM's panel, and no side effects have
been observed on other panels or encoders.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dispc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/video/fbdev/omap2/dss/dispc.c b/drivers/video/fbdev/omap2/dss/dispc.c
index be716c9ffb88..ced6050666cc 100644
--- a/drivers/video/fbdev/omap2/dss/dispc.c
+++ b/drivers/video/fbdev/omap2/dss/dispc.c
@@ -99,6 +99,9 @@ struct dispc_features {
 
 	/* PIXEL_INC is not added to the last pixel of a line */
 	bool last_pixel_inc_missing:1;
+
+	/* POL_FREQ has ALIGN bit */
+	bool supports_sync_align:1;
 };
 
 #define DISPC_MAX_NR_FIFOS 5
@@ -3163,6 +3166,10 @@ static void _dispc_mgr_set_lcd_timings(enum omap_channel channel, int hsw,
 		FLD_VAL(hs, 13, 13) |
 		FLD_VAL(vs, 12, 12);
 
+	/* always set ALIGN bit when available */
+	if (dispc.feat->supports_sync_align)
+		l |= (1 << 18);
+
 	dispc_write_reg(DISPC_POL_FREQ(channel), l);
 
 	if (dispc.syscon_pol) {
@@ -3854,6 +3861,7 @@ static const struct dispc_features omap44xx_dispc_feats = {
 	.num_fifos		=	5,
 	.gfx_fifo_workaround	=	true,
 	.set_max_preload	=	true,
+	.supports_sync_align	=	true,
 };
 
 static const struct dispc_features omap54xx_dispc_feats = {
@@ -3875,6 +3883,7 @@ static const struct dispc_features omap54xx_dispc_feats = {
 	.gfx_fifo_workaround	=	true,
 	.mstandby_workaround	=	true,
 	.set_max_preload	=	true,
+	.supports_sync_align	=	true,
 };
 
 static int dispc_init_features(struct platform_device *pdev)
-- 
2.5.0

