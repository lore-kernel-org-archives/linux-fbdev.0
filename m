From: Donghwa Lee <dh09.lee@samsung.com>
Date: Wed, 09 May 2012 05:33:31 +0000
Subject: [PATCH 5/5] video: exynos mipi dsi: support reverse panel type
Message-Id: <4FAA01AB.2080804@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This patch adds panel_reverse variable to support reversed s6e8ax0 panel
type.

Signed-off-by: Donghwa Lee <dh09.lee@samsung.com>
Signed-off-by: Inki Dae <inki.dae@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/video/exynos/s6e8ax0.c   |   15 +++++++++++++--
 include/video/exynos_mipi_dsim.h |    1 +
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/video/exynos/s6e8ax0.c b/drivers/video/exynos/s6e8ax0.c
index 4aa9ac6..05d080b 100644
--- a/drivers/video/exynos/s6e8ax0.c
+++ b/drivers/video/exynos/s6e8ax0.c
@@ -293,9 +293,20 @@ static void s6e8ax0_panel_cond(struct s6e8ax0 *lcd)
 		0x6e, 0x00, 0x00, 0x00, 0x02, 0x08, 0x08, 0x23, 0x23, 0xc0,
 		0xc8, 0x08, 0x48, 0xc1, 0x00, 0xc1, 0xff, 0xff, 0xc8
 	};
+	static const unsigned char data_to_send_panel_reverse[] = {
+		0xf8, 0x19, 0x35, 0x00, 0x00, 0x00, 0x93, 0x00, 0x3c, 0x7d,
+		0x08, 0x27, 0x7d, 0x3f, 0x00, 0x00, 0x00, 0x20, 0x04, 0x08,
+		0x6e, 0x00, 0x00, 0x00, 0x02, 0x08, 0x08, 0x23, 0x23, 0xc0,
+		0xc1, 0x01, 0x41, 0xc1, 0x00, 0xc1, 0xf6, 0xf6, 0xc1
+	};
 
-	ops->cmd_write(lcd_to_master(lcd), MIPI_DSI_DCS_LONG_WRITE,
-		data_to_send, ARRAY_SIZE(data_to_send));
+	if (lcd->dsim_dev->panel_reverse)
+		ops->cmd_write(lcd_to_master(lcd), MIPI_DSI_DCS_LONG_WRITE,
+				data_to_send_panel_reverse,
+				ARRAY_SIZE(data_to_send_panel_reverse));
+	else
+		ops->cmd_write(lcd_to_master(lcd), MIPI_DSI_DCS_LONG_WRITE,
+				data_to_send, ARRAY_SIZE(data_to_send));
 }
 
 static void s6e8ax0_display_cond(struct s6e8ax0 *lcd)
diff --git a/include/video/exynos_mipi_dsim.h b/include/video/exynos_mipi_dsim.h
index 772c770..83ce5e6 100644
--- a/include/video/exynos_mipi_dsim.h
+++ b/include/video/exynos_mipi_dsim.h
@@ -315,6 +315,7 @@ struct mipi_dsim_lcd_device {
 	int			id;
 	int			bus_id;
 	int			irq;
+	int			panel_reverse;
 
 	struct mipi_dsim_device *master;
 	void			*platform_data;
-- 
1.7.4.1
