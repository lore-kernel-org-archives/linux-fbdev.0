From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 23 Jan 2012 05:08:34 +0000
Subject: [PATCH] fbdev: sh_mipi_dsi: add extra settings method for platform
Message-Id: <874nvnhupd.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Some platform needs extra MIPI settings.
This patch add support it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/video/sh_mipi_dsi.c |    8 ++++++++
 include/video/sh_mipi_dsi.h |    3 +++
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/video/sh_mipi_dsi.c b/drivers/video/sh_mipi_dsi.c
index 05151b8..1532894 100644
--- a/drivers/video/sh_mipi_dsi.c
+++ b/drivers/video/sh_mipi_dsi.c
@@ -386,6 +386,14 @@ static int __init sh_mipi_setup(struct sh_mipi *mipi,
 			  pixfmt << 4);
 	sh_mipi_dcs(ch->chan, MIPI_DCS_SET_DISPLAY_ON);
 
+	/*
+	 * extra dcs settings for platform
+	 */
+	if (pdata->set_dcs)
+		pdata->set_dcs(ch->chan,
+			       sh_mipi_dcs,
+			       sh_mipi_dcs_param);
+
 	/* Enable timeout counters */
 	iowrite32(0x00000f00, base + DSICTRL);
 
diff --git a/include/video/sh_mipi_dsi.h b/include/video/sh_mipi_dsi.h
index 434d56b..6e1f7bc 100644
--- a/include/video/sh_mipi_dsi.h
+++ b/include/video/sh_mipi_dsi.h
@@ -52,6 +52,9 @@ struct sh_mipi_dsi_info {
 	unsigned long			flags;
 	u32				clksrc;
 	unsigned int			vsynw_offset;
+	void (*set_dcs)(int handle,
+			int (*mipi_dcs)(int handle, u8 cmd),
+			int (*mipi_dcs_param)(int handle, u8 cmd, u8 param));
 	int	(*set_dot_clock)(struct platform_device *pdev,
 				 void __iomem *base,
 				 int enable);
-- 
1.7.5.4

