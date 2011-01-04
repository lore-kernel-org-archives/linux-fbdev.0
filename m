From: Kukjin Kim <kgene.kim@samsung.com>
Date: Tue, 04 Jan 2011 08:05:33 +0000
Subject: [PATCH RE-SEND] s3c-fb: Add support S5PV310 FIMD
Message-Id: <1294128333-28736-1-git-send-email-kgene.kim@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-samsung-soc@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: ben-linux@fluff.org, akpm@linux-foundation.org, lethal@linux-sh.org, Jonghun Han <jonghun.han@samsung.com>, Sangbeom Kim <sbkim73@samsung.com>, InKi Dae <inki.dae@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>

From: Jonghun Han <jonghun.han@samsung.com>

This patch adds struct s3c_fb_driverdata s3c_fb_data_s5pv310 for S5PV310
and S5PC210. The clk_type is added to distinguish clock type in it and
lcd_clk is added in structure s3c_fb to calculate divider for lcd panel.

Please refer to below diagrams about clocks of FIMD IP. FIMD driver needs
two clocks for FIMD IP and LCD pixel clock. Actually, the LCD pixel clock
can be selected from 1.clk 'lcd' and 2.SCLK_FIMD before S5PV310. But from
S5PV310, the 2.SCLK_FIMD can be used only for source of LCD pixel clock.

FIMD_CLK_TYPE0:
           ------------------------------------
                      dsys bus
           ----------------+-------------------
                           |
                           |1.clk 'lcd'
                           |
                           | FIMD block
                       +---+-----------+
4.mout_mpll |\         |   |           |
    --------|m|        | +-+-+ +----+  |
            |u|-+      | |   +-+core|  |
            |x| |      | |     +----+  |
            |/  |      | | |\          |
                |      | +-|m|  +---+  |
                |      |   |u|--+div|  |
                +------+---|x|  +---+  |
           2.SCLK_FIMD |   |/     |    |
                       |          |    |
                       +----------+----+
                                  |
           inside of SoC          |
           -----------------------+--------------------------
           outside of SoC         |
                                  | 3.LCD pixel clock
                                  |
                          +--------------+
                          | LCD module   |
                          +--------------+

FIMD_CLK_TYPE1:
           ------------------------------------
                      dsys bus
           ----------------+-------------------
                           |
                           |1.clk 'fimd'
                           |
                           | FIMD block
                       +---+-----------+
4.mout_mpll |\         |   |           |
    --------|m|        |   |   +----+  |
            |u|-+      |   +---+core|  |
            |x| |      |       +----+  |
            |/  |      |               |
                |      |        +---+  |
                |      |     +--+div|  |
                +------+-----+  +---+  |
           2.SCLK_FIMD |          |    |
                       |          |    |
                       +----------+----+
                                  |
           inside of SoC          |
           -----------------------+--------------------------
           outside of SoC         |
                                  | 3.LCD pixel clock
                                  |
                          +--------------+
                          | LCD module   |
                          +--------------+

Signed-off-by: Jonghun Han <jonghun.han@samsung.com>
Signed-off-by: Sangbeom Kim <sbkim73@samsung.com>
Cc: InKi Dae <inki.dae@samsung.com>
Cc: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
Hi Paul,

I and Mr. Han, Jonghun sent below patch several weeks ago.
But I couldn't find it in your tree...
(Re-made against on your latest fbdev-2.6.git #master)

I think this should be merged for supporting S5PV310/S5PC210 frame buffer.
So could you please let me know your opinion or plan about this?

NOTE: Needs following platform device patches for S5PV310/S5PC210 frame buffer.
And I already applied that in my tree as S5P SoCs architecture maintainer.

0001-ARM-S5PV310-Add-FIMD-resource-definition.patch
0002-ARM-S5PV310-Add-platform-device-and-helper-functio.patch
0004-ARM-S5PV310-Add-support-FIMD0-and-LTE480WV-LCD-for.patch

 drivers/video/Kconfig  |    2 +-
 drivers/video/s3c-fb.c |  125 +++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 113 insertions(+), 14 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index e231041..dea54c7 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -2043,7 +2043,7 @@ config FB_TMIO_ACCELL
 
 config FB_S3C
 	tristate "Samsung S3C framebuffer support"
-	depends on FB && S3C_DEV_FB
+	depends on FB && (S3C_DEV_FB || S5P_DEV_FIMD0)
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index 83ce9a0..6d478dd 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -66,6 +66,9 @@ struct s3c_fb;
 #define VIDOSD_C(win, variant) (OSD_BASE(win, variant) + 0x08)
 #define VIDOSD_D(win, variant) (OSD_BASE(win, variant) + 0x0C)
 
+#define FIMD_CLK_TYPE0	0
+#define FIMD_CLK_TYPE1	1
+
 /**
  * struct s3c_fb_variant - fb variant information
  * @is_2443: Set if S3C2443/S3C2416 style hardware.
@@ -98,6 +101,7 @@ struct s3c_fb_variant {
 
 	unsigned int	has_prtcon:1;
 	unsigned int	has_shadowcon:1;
+	unsigned int	clk_type:1;
 };
 
 /**
@@ -184,7 +188,8 @@ struct s3c_fb_vsync {
  * struct s3c_fb - overall hardware state of the hardware
  * @dev: The device that we bound to, for printing, etc.
  * @regs_res: The resource we claimed for the IO registers.
- * @bus_clk: The clk (hclk) feeding our interface and possibly pixclk.
+ * @bus_clk: The clk (hclk) feeding FIMD IP core.
+ * @lcd_clk: The clk (sclk) feeding our interface and possibly pixclk.
  * @regs: The mapped hardware registers.
  * @variant: Variant information for this hardware.
  * @enabled: A bitmask of enabled hardware windows.
@@ -198,6 +203,7 @@ struct s3c_fb {
 	struct device		*dev;
 	struct resource		*regs_res;
 	struct clk		*bus_clk;
+	struct clk		*lcd_clk;
 	void __iomem		*regs;
 	struct s3c_fb_variant	 variant;
 
@@ -335,7 +341,7 @@ static int s3c_fb_check_var(struct fb_var_screeninfo *var,
  */
 static int s3c_fb_calc_pixclk(struct s3c_fb *sfb, unsigned int pixclk)
 {
-	unsigned long clk = clk_get_rate(sfb->bus_clk);
+	unsigned long clk = clk_get_rate(sfb->lcd_clk);
 	unsigned long long tmp;
 	unsigned int result;
 
@@ -518,7 +524,7 @@ static int s3c_fb_set_par(struct fb_info *info)
 
 		data = VIDTCON2_LINEVAL(var->yres - 1) |
 		       VIDTCON2_HOZVAL(var->xres - 1);
-		writel(data, regs +sfb->variant.vidtcon + 8 );
+		writel(data, regs + sfb->variant.vidtcon + 8);
 	}
 
 	/* write the buffer address */
@@ -1309,8 +1315,10 @@ static int __devinit s3c_fb_probe(struct platform_device *pdev)
 	struct s3c_fb_platdata *pd;
 	struct s3c_fb *sfb;
 	struct resource *res;
+	struct clk *mout_mpll = NULL;
 	int win;
 	int ret = 0;
+	u32 rate = 134000000;
 
 	fbdrv = (struct s3c_fb_driverdata *)platform_get_device_id(pdev)->driver_data;
 
@@ -1337,9 +1345,48 @@ static int __devinit s3c_fb_probe(struct platform_device *pdev)
 	sfb->pdata = pd;
 	sfb->variant = fbdrv->variant;
 
-	sfb->bus_clk = clk_get(dev, "lcd");
-	if (IS_ERR(sfb->bus_clk)) {
-		dev_err(dev, "failed to get bus clock\n");
+	switch (sfb->variant.clk_type) {
+	case FIMD_CLK_TYPE0:
+		sfb->bus_clk = clk_get(dev, "lcd");
+		if (IS_ERR(sfb->bus_clk)) {
+			dev_err(dev, "failed to get bus clock\n");
+			goto err_sfb;
+		}
+
+		clk_enable(sfb->bus_clk);
+
+		sfb->lcd_clk = sfb->bus_clk;
+		break;
+
+	case FIMD_CLK_TYPE1:
+		sfb->bus_clk = clk_get(&pdev->dev, "fimd");
+		if (IS_ERR(sfb->bus_clk)) {
+			dev_err(&pdev->dev, "failed to get clock for fimd\n");
+			goto err_sfb;
+		}
+		clk_enable(sfb->bus_clk);
+
+		sfb->lcd_clk = clk_get(&pdev->dev, "sclk_fimd");
+		if (IS_ERR(sfb->lcd_clk)) {
+			dev_err(&pdev->dev, "failed to get sclk for fimd\n");
+			goto err_bus_clk;
+		}
+
+		mout_mpll = clk_get(&pdev->dev, "mout_mpll");
+		if (IS_ERR(mout_mpll)) {
+			dev_err(&pdev->dev, "failed to get mout_mpll\n");
+			goto err_lcd_clk;
+		}
+		clk_set_parent(sfb->lcd_clk, mout_mpll);
+		clk_put(mout_mpll);
+
+		clk_set_rate(sfb->lcd_clk, rate);
+		clk_enable(sfb->lcd_clk);
+		dev_dbg(&pdev->dev, "set fimd sclk rate to %d\n", rate);
+		break;
+
+	default:
+		dev_err(dev, "failed to enable clock for FIMD\n");
 		goto err_sfb;
 	}
 
@@ -1351,7 +1398,7 @@ static int __devinit s3c_fb_probe(struct platform_device *pdev)
 	if (!res) {
 		dev_err(dev, "failed to find registers\n");
 		ret = -ENOENT;
-		goto err_clk;
+		goto err_lcd_clk;
 	}
 
 	sfb->regs_res = request_mem_region(res->start, resource_size(res),
@@ -1359,7 +1406,7 @@ static int __devinit s3c_fb_probe(struct platform_device *pdev)
 	if (!sfb->regs_res) {
 		dev_err(dev, "failed to claim register region\n");
 		ret = -ENOENT;
-		goto err_clk;
+		goto err_lcd_clk;
 	}
 
 	sfb->regs = ioremap(res->start, resource_size(res));
@@ -1442,9 +1489,15 @@ err_req_region:
 	release_resource(sfb->regs_res);
 	kfree(sfb->regs_res);
 
-err_clk:
-	clk_disable(sfb->bus_clk);
-	clk_put(sfb->bus_clk);
+err_lcd_clk:
+	clk_disable(sfb->lcd_clk);
+	clk_put(sfb->lcd_clk);
+
+err_bus_clk:
+	if (sfb->variant.clk_type != FIMD_CLK_TYPE0) {
+		clk_disable(sfb->bus_clk);
+		clk_put(sfb->bus_clk);
+	}
 
 err_sfb:
 	kfree(sfb);
@@ -1473,8 +1526,20 @@ static int __devexit s3c_fb_remove(struct platform_device *pdev)
 
 	iounmap(sfb->regs);
 
-	clk_disable(sfb->bus_clk);
-	clk_put(sfb->bus_clk);
+	switch (sfb->variant.clk_type) {
+	case FIMD_CLK_TYPE1:
+		clk_disable(sfb->lcd_clk);
+		clk_put(sfb->lcd_clk);
+		/* fall through to default case */
+	case FIMD_CLK_TYPE0:
+		clk_disable(sfb->bus_clk);
+		clk_put(sfb->bus_clk);
+		break;
+	default:
+		dev_err(sfb->dev, "invalid clock type(%d)\n",
+			sfb->variant.clk_type);
+		break;
+	}
 
 	release_resource(sfb->regs_res);
 	kfree(sfb->regs_res);
@@ -1753,6 +1818,37 @@ static struct s3c_fb_driverdata s3c_fb_data_s5pv210 = {
 	.win[4]	= &s3c_fb_data_64xx_wins[4],
 };
 
+static struct s3c_fb_driverdata s3c_fb_data_s5pv310 = {
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
+		.clk_type	= FIMD_CLK_TYPE1,
+	},
+	.win[0]	= &s3c_fb_data_64xx_wins[0],
+	.win[1]	= &s3c_fb_data_64xx_wins[1],
+	.win[2]	= &s3c_fb_data_64xx_wins[2],
+	.win[3]	= &s3c_fb_data_64xx_wins[3],
+	.win[4]	= &s3c_fb_data_64xx_wins[4],
+};
+
 /* S3C2443/S3C2416 style hardware */
 static struct s3c_fb_driverdata s3c_fb_data_s3c2443 = {
 	.variant = {
@@ -1800,6 +1896,9 @@ static struct platform_device_id s3c_fb_driver_ids[] = {
 		.name		= "s5pv210-fb",
 		.driver_data	= (unsigned long)&s3c_fb_data_s5pv210,
 	}, {
+		.name		= "s5pv310-fb",
+		.driver_data	= (unsigned long)&s3c_fb_data_s5pv310,
+	}, {
 		.name		= "s3c2443-fb",
 		.driver_data	= (unsigned long)&s3c_fb_data_s3c2443,
 	},
-- 
1.6.2.5

