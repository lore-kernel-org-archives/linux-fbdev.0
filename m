From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 09 Nov 2011 04:35:14 +0000
Subject: [PATCH 10/15] fbdev: sh_mipi_dsi: add set_dot_clock() for each platform
Message-Id: <87pqh1ap6o.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Dot clock of SH MIPI are depends on each platform board.
This patch adds set_dot_clock() function for it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-ag5evm.c |   36 ++++++++++++++++++++++---
 arch/arm/mach-shmobile/board-ap4evb.c |   25 ++++++++++++++++++
 drivers/video/sh_mipi_dsi.c           |   45 ++++++++-------------------------
 include/video/sh_mipi_dsi.h           |    3 ++
 4 files changed, 70 insertions(+), 39 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ag5evm.c b/arch/arm/mach-shmobile/board-ag5evm.c
index 0895671..a0b7f8d 100644
--- a/arch/arm/mach-shmobile/board-ag5evm.c
+++ b/arch/arm/mach-shmobile/board-ag5evm.c
@@ -321,6 +321,36 @@ static struct resource mipidsi0_resources[] = {
 	},
 };
 
+#define DSI0PHYCR	0xe615006c
+static int sh_mipi_set_dot_clock(struct platform_device *pdev,
+				 void __iomem *base,
+				 int enable)
+{
+	struct clk *pck;
+	int ret;
+
+	pck = clk_get(&pdev->dev, "dsip_clk");
+	if (IS_ERR(pck)) {
+		ret = PTR_ERR(pck);
+		goto sh_mipi_set_dot_clock_pck_err;
+	}
+
+	if (enable) {
+		clk_set_rate(pck, clk_round_rate(pck,  24000000));
+		__raw_writel(0x2a809010, DSI0PHYCR);
+		clk_enable(pck);
+	} else {
+		clk_disable(pck);
+	}
+
+	ret = 0;
+
+	clk_put(pck);
+
+sh_mipi_set_dot_clock_pck_err:
+	return ret;
+}
+
 static struct sh_mipi_dsi_info mipidsi0_info = {
 	.data_format	= MIPI_RGB888,
 	.lcd_chan	= &lcdc0_info.ch[0],
@@ -329,6 +359,7 @@ static struct sh_mipi_dsi_info mipidsi0_info = {
 	.clksrc		= 1,
 	.flags		= SH_MIPI_DSI_HSABM |
 			  SH_MIPI_DSI_SYNC_PULSES_MODE,
+	.set_dot_clock	= sh_mipi_set_dot_clock,
 };
 
 static struct platform_device mipidsi0_device = {
@@ -476,8 +507,6 @@ static void __init ag5evm_map_io(void)
 	shmobile_setup_console();
 }
 
-#define DSI0PHYCR	0xe615006c
-
 static void __init ag5evm_init(void)
 {
 	sh73a0_pinmux_init();
@@ -558,9 +587,6 @@ static void __init ag5evm_init(void)
 	gpio_direction_output(GPIO_PORT235, 0);
 	lcd_backlight_reset();
 
-	/* MIPI-DSI clock setup */
-	__raw_writel(0x2a809010, DSI0PHYCR);
-
 	/* enable SDHI0 on CN15 [SD I/F] */
 	gpio_request(GPIO_FN_SDHICD0, NULL);
 	gpio_request(GPIO_FN_SDHIWP0, NULL);
diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 9b39e86..47f899b 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -564,6 +564,30 @@ static struct platform_device keysc_device = {
 };
 
 /* MIPI-DSI */
+#define PHYCTRL		0x0070
+static int sh_mipi_set_dot_clock(struct platform_device *pdev,
+				 void __iomem *base,
+				 int enable)
+{
+	struct clk *pck = clk_get(&pdev->dev, "dsip_clk");
+	void __iomem *phy =  base + PHYCTRL;
+
+	if (IS_ERR(pck))
+		return PTR_ERR(pck);
+
+	if (enable) {
+		clk_set_rate(pck, clk_round_rate(pck, 24000000));
+		iowrite32(ioread32(phy) | (0xb << 8), phy);
+		clk_enable(pck);
+	} else {
+		clk_disable(pck);
+	}
+
+	clk_put(pck);
+
+	return 0;
+}
+
 static struct resource mipidsi0_resources[] = {
 	[0] = {
 		.start  = 0xffc60000,
@@ -583,6 +607,7 @@ static struct sh_mipi_dsi_info mipidsi0_info = {
 	.lane		= 2,
 	.vsynw_offset	= 17,
 	.flags		= SH_MIPI_DSI_SYNC_PULSES_MODE,
+	.set_dot_clock	= sh_mipi_set_dot_clock,
 };
 
 static struct platform_device mipidsi0_device = {
diff --git a/drivers/video/sh_mipi_dsi.c b/drivers/video/sh_mipi_dsi.c
index 190e941..77743f4 100644
--- a/drivers/video/sh_mipi_dsi.c
+++ b/drivers/video/sh_mipi_dsi.c
@@ -53,7 +53,6 @@ struct sh_mipi {
 	void __iomem	*base;
 	void __iomem	*linkbase;
 	struct clk	*dsit_clk;
-	struct clk	*dsip_clk;
 	struct device	*dev;
 
 	void	*next_board_data;
@@ -307,8 +306,8 @@ static int __init sh_mipi_setup(struct sh_mipi *mipi,
 	/* DSI-Tx bias on */
 	iowrite32(0x00000001, base + PHYCTRL);
 	udelay(200);
-	/* Deassert resets, power on, set multiplier */
-	iowrite32(0x03070b01, base + PHYCTRL);
+	/* Deassert resets, power on */
+	iowrite32(0x03070001, base + PHYCTRL);
 
 	/* setup l-bridge */
 
@@ -421,6 +420,9 @@ static int __init sh_mipi_probe(struct platform_device *pdev)
 	if (!res || !res2 || idx >= ARRAY_SIZE(mipi_dsi) || !pdata)
 		return -ENODEV;
 
+	if (!pdata->set_dot_clock)
+		return -EINVAL;
+
 	mutex_lock(&array_lock);
 	if (idx < 0)
 		for (idx = 0; idx < ARRAY_SIZE(mipi_dsi) && mipi_dsi[idx]; idx++)
@@ -481,34 +483,10 @@ static int __init sh_mipi_probe(struct platform_device *pdev)
 
 	dev_dbg(&pdev->dev, "DSI-T clk %lu -> %lu\n", f_current, rate);
 
-	mipi->dsip_clk = clk_get(&pdev->dev, "dsip_clk");
-	if (IS_ERR(mipi->dsip_clk)) {
-		ret = PTR_ERR(mipi->dsip_clk);
-		goto eclkpget;
-	}
-
-	f_current = clk_get_rate(mipi->dsip_clk);
-	/* Between 10 and 50MHz */
-	rate = clk_round_rate(mipi->dsip_clk, 24000000);
-	if (rate > 0 && rate != f_current)
-		ret = clk_set_rate(mipi->dsip_clk, rate);
-	else
-		ret = rate;
-	if (ret < 0)
-		goto esetprate;
-
-	dev_dbg(&pdev->dev, "DSI-P clk %lu -> %lu\n", f_current, rate);
-
-	msleep(10);
-
 	ret = clk_enable(mipi->dsit_clk);
 	if (ret < 0)
 		goto eclkton;
 
-	ret = clk_enable(mipi->dsip_clk);
-	if (ret < 0)
-		goto eclkpon;
-
 	mipi_dsi[idx] = mipi;
 
 	pm_runtime_enable(&pdev->dev);
@@ -518,6 +496,10 @@ static int __init sh_mipi_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto emipisetup;
 
+	ret = pdata->set_dot_clock(pdev, mipi->base, 1);
+	if (ret < 0)
+		goto emipisetup;
+
 	mutex_unlock(&array_lock);
 	platform_set_drvdata(pdev, mipi);
 
@@ -537,13 +519,8 @@ static int __init sh_mipi_probe(struct platform_device *pdev)
 emipisetup:
 	mipi_dsi[idx] = NULL;
 	pm_runtime_disable(&pdev->dev);
-	clk_disable(mipi->dsip_clk);
-eclkpon:
 	clk_disable(mipi->dsit_clk);
 eclkton:
-esetprate:
-	clk_put(mipi->dsip_clk);
-eclkpget:
 esettrate:
 	clk_put(mipi->dsit_clk);
 eclktget:
@@ -594,10 +571,10 @@ static int __exit sh_mipi_remove(struct platform_device *pdev)
 	pdata->lcd_chan->board_cfg.board_data = NULL;
 
 	pm_runtime_disable(&pdev->dev);
-	clk_disable(mipi->dsip_clk);
 	clk_disable(mipi->dsit_clk);
 	clk_put(mipi->dsit_clk);
-	clk_put(mipi->dsip_clk);
+	pdata->set_dot_clock(pdev, mipi->base, 0);
+
 	iounmap(mipi->linkbase);
 	if (res2)
 		release_mem_region(res2->start, resource_size(res2));
diff --git a/include/video/sh_mipi_dsi.h b/include/video/sh_mipi_dsi.h
index c8225b4..310b883 100644
--- a/include/video/sh_mipi_dsi.h
+++ b/include/video/sh_mipi_dsi.h
@@ -48,6 +48,9 @@ struct sh_mipi_dsi_info {
 	unsigned long			flags;
 	u32				clksrc;
 	unsigned int			vsynw_offset;
+	int	(*set_dot_clock)(struct platform_device *pdev,
+				 void __iomem *base,
+				 int enable);
 };
 
 #endif
-- 
1.7.5.4

