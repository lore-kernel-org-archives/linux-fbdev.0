From: Jingoo Han <jg1.han@samsung.com>
Date: Wed, 22 Jun 2011 06:41:36 +0000
Subject: [PATCH V5 4/5] video: s3c-fb: Add support EXYNOS4 FIMD
Message-Id: <1308724896-31485-1-git-send-email-jg1.han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kukjin Kim <kgene.kim@samsung.com>, Paul Mundt <lethal@linux-sh.org>, linux-samsung-soc@vger.kernel.org, linux-fbdev@vger.kernel.org, Jonghun Han <jonghun.han@samsung.com>
Cc: Anand Kumar N <anand.kn@samsung.com>, Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Kyungmin Park <kmpark@infradead.org>, Inki Dae <inki.dae@samsung.com>, ARM Linux <linux@arm.linux.org.uk>, Ben Dooks <ben-linux@fluff.org>, Jingoo Han <jg1.han@samsung.com>

This patch adds struct s3c_fb_driverdata s3c_fb_data_exynos4 for EXYNOS4
and adds lcd clock gating support.

FIMD driver needs two clocks for FIMD IP and LCD pixel clock. Previously,
both clocks are provided by using bus clock such as HCLK. However, EXYNOS4
can not select HCLK for LCD pixel clock because the EXYNOS4 FIMD IP does not
have the CLKSEL bit of VIDCON0. So, FIMD driver should provide the lcd clock
using SCLK_FIMD as LCD pixel clock for EXYNOS4.

The driver selects enabling lcd clock according to has_clksel which means
the CLKSEL bit of VIDCON0. If there is has_clksel, the driver will not
enable the lcd clock using SCLK_FIMD because bus clock using HCLK is used
a LCD pixel clock.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/Kconfig  |    2 +-
 drivers/video/s3c-fb.c |   88 +++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 85 insertions(+), 5 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 549b960..963b8b7 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -2027,7 +2027,7 @@ config FB_TMIO_ACCELL
 
 config FB_S3C
 	tristate "Samsung S3C framebuffer support"
-	depends on FB && S3C_DEV_FB
+	depends on FB && (S3C_DEV_FB || S5P_DEV_FIMD0)
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index 4aecf21..cb0d3ea 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -81,6 +81,7 @@ struct s3c_fb;
  * @palette: Address of palette memory, or 0 if none.
  * @has_prtcon: Set if has PRTCON register.
  * @has_shadowcon: Set if has SHADOWCON register.
+ * @has_clksel: Set if VIDCON0 register has CLKSEL bit.
  */
 struct s3c_fb_variant {
 	unsigned int	is_2443:1;
@@ -98,6 +99,7 @@ struct s3c_fb_variant {
 
 	unsigned int	has_prtcon:1;
 	unsigned int	has_shadowcon:1;
+	unsigned int	has_clksel:1;
 };
 
 /**
@@ -186,6 +188,7 @@ struct s3c_fb_vsync {
  * @dev: The device that we bound to, for printing, etc.
  * @regs_res: The resource we claimed for the IO registers.
  * @bus_clk: The clk (hclk) feeding our interface and possibly pixclk.
+ * @lcd_clk: The clk (sclk) feeding pixclk.
  * @regs: The mapped hardware registers.
  * @variant: Variant information for this hardware.
  * @enabled: A bitmask of enabled hardware windows.
@@ -200,6 +203,7 @@ struct s3c_fb {
 	struct device		*dev;
 	struct resource		*regs_res;
 	struct clk		*bus_clk;
+	struct clk		*lcd_clk;
 	void __iomem		*regs;
 	struct s3c_fb_variant	 variant;
 
@@ -336,10 +340,15 @@ static int s3c_fb_check_var(struct fb_var_screeninfo *var,
  */
 static int s3c_fb_calc_pixclk(struct s3c_fb *sfb, unsigned int pixclk)
 {
-	unsigned long clk = clk_get_rate(sfb->bus_clk);
+	unsigned long clk;
 	unsigned long long tmp;
 	unsigned int result;
 
+	if (sfb->variant.has_clksel)
+		clk = clk_get_rate(sfb->bus_clk);
+	else
+		clk = clk_get_rate(sfb->lcd_clk);
+
 	tmp = (unsigned long long)clk;
 	tmp *= pixclk;
 
@@ -1354,13 +1363,24 @@ static int __devinit s3c_fb_probe(struct platform_device *pdev)
 
 	clk_enable(sfb->bus_clk);
 
+	if (!sfb->variant.has_clksel) {
+		sfb->lcd_clk = clk_get(dev, "sclk_fimd");
+		if (IS_ERR(sfb->lcd_clk)) {
+			dev_err(dev, "failed to get lcd clock\n");
+			ret = PTR_ERR(sfb->lcd_clk);
+			goto err_bus_clk;
+		}
+
+		clk_enable(sfb->lcd_clk);
+	}
+
 	pm_runtime_enable(sfb->dev);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
 		dev_err(dev, "failed to find registers\n");
 		ret = -ENOENT;
-		goto err_clk;
+		goto err_lcd_clk;
 	}
 
 	sfb->regs_res = request_mem_region(res->start, resource_size(res),
@@ -1368,7 +1388,7 @@ static int __devinit s3c_fb_probe(struct platform_device *pdev)
 	if (!sfb->regs_res) {
 		dev_err(dev, "failed to claim register region\n");
 		ret = -ENOENT;
-		goto err_clk;
+		goto err_lcd_clk;
 	}
 
 	sfb->regs = ioremap(res->start, resource_size(res));
@@ -1450,7 +1470,13 @@ err_ioremap:
 err_req_region:
 	release_mem_region(sfb->regs_res->start, resource_size(sfb->regs_res));
 
-err_clk:
+err_lcd_clk:
+	if (!sfb->variant.has_clksel) {
+		clk_disable(sfb->lcd_clk);
+		clk_put(sfb->lcd_clk);
+	}
+
+err_bus_clk:
 	clk_disable(sfb->bus_clk);
 	clk_put(sfb->bus_clk);
 
@@ -1481,6 +1507,11 @@ static int __devexit s3c_fb_remove(struct platform_device *pdev)
 
 	iounmap(sfb->regs);
 
+	if (!sfb->variant.has_clksel) {
+		clk_disable(sfb->lcd_clk);
+		clk_put(sfb->lcd_clk);
+	}
+
 	clk_disable(sfb->bus_clk);
 	clk_put(sfb->bus_clk);
 
@@ -1510,6 +1541,9 @@ static int s3c_fb_suspend(struct device *dev)
 		s3c_fb_blank(FB_BLANK_POWERDOWN, win->fbinfo);
 	}
 
+	if (!sfb->variant.has_clksel)
+		clk_disable(sfb->lcd_clk);
+
 	clk_disable(sfb->bus_clk);
 	return 0;
 }
@@ -1524,6 +1558,9 @@ static int s3c_fb_resume(struct device *dev)
 
 	clk_enable(sfb->bus_clk);
 
+	if (!sfb->variant.has_clksel)
+		clk_enable(sfb->lcd_clk);
+
 	/* setup gpio and output polarity controls */
 	pd->setup_gpio();
 	writel(pd->vidcon1, sfb->regs + VIDCON1);
@@ -1569,6 +1606,9 @@ static int s3c_fb_runtime_suspend(struct device *dev)
 		s3c_fb_blank(FB_BLANK_POWERDOWN, win->fbinfo);
 	}
 
+	if (!sfb->variant.has_clksel)
+		clk_disable(sfb->lcd_clk);
+
 	clk_disable(sfb->bus_clk);
 	return 0;
 }
@@ -1583,6 +1623,9 @@ static int s3c_fb_runtime_resume(struct device *dev)
 
 	clk_enable(sfb->bus_clk);
 
+	if (!sfb->variant.has_clksel)
+		clk_enable(sfb->lcd_clk);
+
 	/* setup gpio and output polarity controls */
 	pd->setup_gpio();
 	writel(pd->vidcon1, sfb->regs + VIDCON1);
@@ -1755,6 +1798,7 @@ static struct s3c_fb_driverdata s3c_fb_data_64xx = {
 		},
 
 		.has_prtcon	= 1,
+		.has_clksel	= 1,
 	},
 	.win[0]	= &s3c_fb_data_64xx_wins[0],
 	.win[1]	= &s3c_fb_data_64xx_wins[1],
@@ -1785,6 +1829,7 @@ static struct s3c_fb_driverdata s3c_fb_data_s5pc100 = {
 		},
 
 		.has_prtcon	= 1,
+		.has_clksel	= 1,
 	},
 	.win[0]	= &s3c_fb_data_s5p_wins[0],
 	.win[1]	= &s3c_fb_data_s5p_wins[1],
@@ -1815,6 +1860,37 @@ static struct s3c_fb_driverdata s3c_fb_data_s5pv210 = {
 		},
 
 		.has_shadowcon	= 1,
+		.has_clksel	= 1,
+	},
+	.win[0]	= &s3c_fb_data_s5p_wins[0],
+	.win[1]	= &s3c_fb_data_s5p_wins[1],
+	.win[2]	= &s3c_fb_data_s5p_wins[2],
+	.win[3]	= &s3c_fb_data_s5p_wins[3],
+	.win[4]	= &s3c_fb_data_s5p_wins[4],
+};
+
+static struct s3c_fb_driverdata s3c_fb_data_exynos4 = {
+	.variant = {
+		.nr_windows	= 5,
+		.vidtcon	= VIDTCON0,
+		.wincon		= WINCON(0),
+		.winmap		= WINxMAP(0),
+		.keycon		= WKEYCON,
+		.osd		= VIDOSD_BASE,
+		.osd_stride	= 16,
+		.buf_start	= VIDW_BUF_START(0),
+		.buf_size	= VIDW_BUF_SIZE(0),
+		.buf_end	= VIDW_BUF_END(0),
+
+		.palette = {
+			[0] = 0x2400,
+			[1] = 0x2800,
+			[2] = 0x2c00,
+			[3] = 0x3000,
+			[4] = 0x3400,
+		},
+
+		.has_shadowcon	= 1,
 	},
 	.win[0]	= &s3c_fb_data_s5p_wins[0],
 	.win[1]	= &s3c_fb_data_s5p_wins[1],
@@ -1843,6 +1919,7 @@ static struct s3c_fb_driverdata s3c_fb_data_s3c2443 = {
 			[0] = 0x400,
 			[1] = 0x800,
 		},
+		.has_clksel	= 1,
 	},
 	.win[0] = &(struct s3c_fb_win_variant) {
 		.palette_sz	= 256,
@@ -1870,6 +1947,9 @@ static struct platform_device_id s3c_fb_driver_ids[] = {
 		.name		= "s5pv210-fb",
 		.driver_data	= (unsigned long)&s3c_fb_data_s5pv210,
 	}, {
+		.name		= "exynos4-fb",
+		.driver_data	= (unsigned long)&s3c_fb_data_exynos4,
+	}, {
 		.name		= "s3c2443-fb",
 		.driver_data	= (unsigned long)&s3c_fb_data_s3c2443,
 	},
-- 
1.7.1

