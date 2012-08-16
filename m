From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 16 Aug 2012 13:00:39 +0000
Subject: [PATCH 04/19] ARM: mach-shmobile: ag5evm: Add LCDC tx_dev field to platform data
Message-Id: <1345122054-16013-5-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Reference the MIPI-DSI transceiver in the LCDC platform data and make
sure it gets registered before the LCDC.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-ag5evm.c |  157 +++++++++++++++++----------------
 1 files changed, 80 insertions(+), 77 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ag5evm.c b/arch/arm/mach-shmobile/board-ag5evm.c
index 5a6f22f..afae573 100644
--- a/arch/arm/mach-shmobile/board-ag5evm.c
+++ b/arch/arm/mach-shmobile/board-ag5evm.c
@@ -199,6 +199,84 @@ static struct platform_device irda_device = {
 	.num_resources  = ARRAY_SIZE(irda_resources),
 };
 
+/* MIPI-DSI */
+static struct resource mipidsi0_resources[] = {
+	[0] = {
+		.name	= "DSI0",
+		.start  = 0xfeab0000,
+		.end    = 0xfeab3fff,
+		.flags  = IORESOURCE_MEM,
+	},
+	[1] = {
+		.name	= "DSI0",
+		.start  = 0xfeab4000,
+		.end    = 0xfeab7fff,
+		.flags  = IORESOURCE_MEM,
+	},
+};
+
+static int sh_mipi_set_dot_clock(struct platform_device *pdev,
+				 void __iomem *base,
+				 int enable)
+{
+	struct clk *pck, *phy;
+	int ret;
+
+	pck = clk_get(&pdev->dev, "dsip_clk");
+	if (IS_ERR(pck)) {
+		ret = PTR_ERR(pck);
+		goto sh_mipi_set_dot_clock_pck_err;
+	}
+
+	phy = clk_get(&pdev->dev, "dsiphy_clk");
+	if (IS_ERR(phy)) {
+		ret = PTR_ERR(phy);
+		goto sh_mipi_set_dot_clock_phy_err;
+	}
+
+	if (enable) {
+		clk_set_rate(pck, clk_round_rate(pck,  24000000));
+		clk_set_rate(phy, clk_round_rate(pck, 510000000));
+		clk_enable(pck);
+		clk_enable(phy);
+	} else {
+		clk_disable(pck);
+		clk_disable(phy);
+	}
+
+	ret = 0;
+
+	clk_put(phy);
+sh_mipi_set_dot_clock_phy_err:
+	clk_put(pck);
+sh_mipi_set_dot_clock_pck_err:
+	return ret;
+}
+
+static struct sh_mobile_lcdc_info lcdc0_info;
+
+static struct sh_mipi_dsi_info mipidsi0_info = {
+	.data_format	= MIPI_RGB888,
+	.lcd_chan	= &lcdc0_info.ch[0],
+	.lane		= 2,
+	.vsynw_offset	= 20,
+	.clksrc		= 1,
+	.flags		= SH_MIPI_DSI_HSABM		|
+			  SH_MIPI_DSI_SYNC_PULSES_MODE	|
+			  SH_MIPI_DSI_HSbyteCLK,
+	.set_dot_clock	= sh_mipi_set_dot_clock,
+};
+
+static struct platform_device mipidsi0_device = {
+	.name           = "sh-mipi-dsi",
+	.num_resources  = ARRAY_SIZE(mipidsi0_resources),
+	.resource       = mipidsi0_resources,
+	.id             = 0,
+	.dev	= {
+		.platform_data	= &mipidsi0_info,
+	},
+};
+
 static unsigned char lcd_backlight_seq[3][2] = {
 	{ 0x04, 0x07 },
 	{ 0x23, 0x80 },
@@ -261,6 +339,7 @@ static struct sh_mobile_lcdc_info lcdc0_info = {
 			.display_on = lcd_backlight_on,
 			.display_off = lcd_backlight_reset,
 		},
+		.tx_dev = &mipidsi0_device,
 	}
 };
 
@@ -288,82 +367,6 @@ static struct platform_device lcdc0_device = {
 	},
 };
 
-/* MIPI-DSI */
-static struct resource mipidsi0_resources[] = {
-	[0] = {
-		.name	= "DSI0",
-		.start  = 0xfeab0000,
-		.end    = 0xfeab3fff,
-		.flags  = IORESOURCE_MEM,
-	},
-	[1] = {
-		.name	= "DSI0",
-		.start  = 0xfeab4000,
-		.end    = 0xfeab7fff,
-		.flags  = IORESOURCE_MEM,
-	},
-};
-
-static int sh_mipi_set_dot_clock(struct platform_device *pdev,
-				 void __iomem *base,
-				 int enable)
-{
-	struct clk *pck, *phy;
-	int ret;
-
-	pck = clk_get(&pdev->dev, "dsip_clk");
-	if (IS_ERR(pck)) {
-		ret = PTR_ERR(pck);
-		goto sh_mipi_set_dot_clock_pck_err;
-	}
-
-	phy = clk_get(&pdev->dev, "dsiphy_clk");
-	if (IS_ERR(phy)) {
-		ret = PTR_ERR(phy);
-		goto sh_mipi_set_dot_clock_phy_err;
-	}
-
-	if (enable) {
-		clk_set_rate(pck, clk_round_rate(pck,  24000000));
-		clk_set_rate(phy, clk_round_rate(pck, 510000000));
-		clk_enable(pck);
-		clk_enable(phy);
-	} else {
-		clk_disable(pck);
-		clk_disable(phy);
-	}
-
-	ret = 0;
-
-	clk_put(phy);
-sh_mipi_set_dot_clock_phy_err:
-	clk_put(pck);
-sh_mipi_set_dot_clock_pck_err:
-	return ret;
-}
-
-static struct sh_mipi_dsi_info mipidsi0_info = {
-	.data_format	= MIPI_RGB888,
-	.lcd_chan	= &lcdc0_info.ch[0],
-	.lane		= 2,
-	.vsynw_offset	= 20,
-	.clksrc		= 1,
-	.flags		= SH_MIPI_DSI_HSABM		|
-			  SH_MIPI_DSI_SYNC_PULSES_MODE	|
-			  SH_MIPI_DSI_HSbyteCLK,
-	.set_dot_clock	= sh_mipi_set_dot_clock,
-};
-
-static struct platform_device mipidsi0_device = {
-	.name           = "sh-mipi-dsi",
-	.num_resources  = ARRAY_SIZE(mipidsi0_resources),
-	.resource       = mipidsi0_resources,
-	.id             = 0,
-	.dev	= {
-		.platform_data	= &mipidsi0_info,
-	},
-};
-
 /* SDHI0 */
 static struct sh_mobile_sdhi_info sdhi0_info = {
 	.dma_slave_tx	= SHDMA_SLAVE_SDHI0_TX,
@@ -460,8 +463,8 @@ static struct platform_device *ag5evm_devices[] __initdata = {
 	&fsi_device,
 	&mmc_device,
 	&irda_device,
-	&lcdc0_device,
 	&mipidsi0_device,
+	&lcdc0_device,
 	&sdhi0_device,
 	&sdhi1_device,
 };
-- 
1.7.8.6

