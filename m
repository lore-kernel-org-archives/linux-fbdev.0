From: Inki Dae <inki.dae@samsung.com>
Date: Fri, 12 Nov 2010 09:54:29 +0000
Subject: RE: [PATCH 3/4] s3c-fb: Add support S5PV310 FIMD
Message-Id: <00a501cb824f$9942f300$cbc8d900$%dae@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1287406528-15324-4-git-send-email-sbkim73@samsung.com>
In-Reply-To: <1287406528-15324-4-git-send-email-sbkim73@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hello, all.

This is my opinion and patch.

Jonghun's patch is adding clock type(FIMD_CLK_TYPE1 or FIMD_CLK_TYPE2) and
also
clk_type variable to s3c_fb_variant to select which clock would be used.
I think we could meet that simply if source clock and parent clock
names are set to platform data in machine file.

I added my comments to Jonghun's patch and attached modified patch below.
Thank you.

diff --git a/arch/arm/plat-samsung/include/plat/fb.h
b/arch/arm/plat-samsung/include/plat/fb.h
index ed70fc5..411380e 100644
--- a/arch/arm/plat-samsung/include/plat/fb.h
+++ b/arch/arm/plat-samsung/include/plat/fb.h
@@ -47,6 +47,10 @@ struct s3c_fb_pd_win {
  * @vidcon1: The base vidcon1 values to control the panel data output.
  * @win: The setup data for each hardware window, or NULL for unused.
  * @display_mode: The LCD output display mode.
+ * @sclk_name:	source clock name and sclk_name valiable should be set
+ *		at machine specific file.
+ * @pclk_name: parent clock name and pclk_name valiable should be set
+ *		at machine specific file.
  *
  * The platform data supplies the video driver with all the information
  * it requires to work with the display(s) attached to the machine. It
@@ -63,6 +67,9 @@ struct s3c_fb_platdata {
 
 	u32			 vidcon0;
 	u32			 vidcon1;
+
+	const char		*sclk_name;
+	const char		*pclk_name;
 };
diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index f9aca9d..96a746c 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -27,6 +27,7 @@
 #include <mach/map.h>
 #include <plat/regs-fb-v4.h>
 #include <plat/fb.h>
+#include <plat/clock.h>
 
 /* This driver will export a number of framebuffer interfaces depending
  * on the configuration passed in via the platform data. Each fb instance
@@ -183,7 +184,7 @@ struct s3c_fb_vsync {
  * struct s3c_fb - overall hardware state of the hardware
  * @dev: The device that we bound to, for printing, etc.
  * @regs_res: The resource we claimed for the IO registers.
- * @bus_clk: The clk (hclk) feeding our interface and possibly pixclk.
+ * @lcd_clk: The clk (hclk or sclk) feeding our interface and possibly
pixclk.
  * @regs: The mapped hardware registers.
  * @variant: Variant information for this hardware.
  * @enabled: A bitmask of enabled hardware windows.
@@ -196,7 +197,7 @@ struct s3c_fb_vsync {
 struct s3c_fb {
 	struct device		*dev;
 	struct resource		*regs_res;
-	struct clk		*bus_clk;
+	struct clk		*lcd_clk;
 	void __iomem		*regs;
 	struct s3c_fb_variant	 variant;
 
@@ -334,7 +335,11 @@ static int s3c_fb_check_var(struct fb_var_screeninfo
*var,
  */
 static int s3c_fb_calc_pixclk(struct s3c_fb *sfb, unsigned int pixclk)
 {
-	unsigned long clk = clk_get_rate(sfb->bus_clk);
+	/**
+	 * if it fails to get clock rate from lcd_clk
+	 * then would get it from parent clock of lcd_clk.
+	 */
+	unsigned long clk = clk_get_rate(sfb->lcd_clk);
 	unsigned long long tmp;
 	unsigned int result;
 
@@ -1314,13 +1319,22 @@ static int __devinit s3c_fb_probe(struct
platform_device *pdev)
 	sfb->pdata = pd;
 	sfb->variant = fbdrv->variant;
 
-	sfb->bus_clk = clk_get(dev, "lcd");
-	if (IS_ERR(sfb->bus_clk)) {
-		dev_err(dev, "failed to get bus clock\n");
+	/* if sclk_name is NULL then it would use bus clock as default. */
+	if (!pd->sclk_name)
+		sfb->lcd_clk = clk_get(dev, "lcd");
+	else
+		sfb->lcd_clk = clk_get(dev, pd->sclk_name);
+
+	if (IS_ERR(sfb->lcd_clk)) {
+		dev_err(dev, "failed to get lcd clock\n");
+		clk_put(sfb->lcd_clk);
 		goto err_sfb;
 	}
 
-	clk_enable(sfb->bus_clk);
+	if (pd->pclk_name)
+		sfb->lcd_clk->parent = clk_get(dev, pd->pclk_name);
+
+	clk_enable(sfb->lcd_clk);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
@@ -1414,8 +1428,8 @@ err_req_region:
 	kfree(sfb->regs_res);
 
 err_clk:
-	clk_disable(sfb->bus_clk);
-	clk_put(sfb->bus_clk);
+	clk_disable(sfb->lcd_clk);
+	clk_put(sfb->lcd_clk);
 
 err_sfb:
 	kfree(sfb);
@@ -1442,8 +1456,8 @@ static int __devexit s3c_fb_remove(struct
platform_device *pdev)
 
 	iounmap(sfb->regs);
 
-	clk_disable(sfb->bus_clk);
-	clk_put(sfb->bus_clk);
+	clk_disable(sfb->lcd_clk);
+	clk_put(sfb->lcd_clk);
 
 	release_resource(sfb->regs_res);
 	kfree(sfb->regs_res);
@@ -1469,7 +1483,8 @@ static int s3c_fb_suspend(struct platform_device
*pdev, pm_message_t state)
 		s3c_fb_blank(FB_BLANK_POWERDOWN, win->fbinfo);
 	}
 
-	clk_disable(sfb->bus_clk);
+	clk_disable(sfb->lcd_clk);
+
 	return 0;
 }
 
@@ -1480,7 +1495,7 @@ static int s3c_fb_resume(struct platform_device *pdev)
 	struct s3c_fb_win *win;
 	int win_no;
 
-	clk_enable(sfb->bus_clk);
+	clk_enable(sfb->lcd_clk);
 
 	/* setup registers */
 	writel(pd->vidcon1, sfb->regs + VIDCON1);
@@ -1656,6 +1671,36 @@ static struct s3c_fb_driverdata s3c_fb_data_s5pv210 {
 	.win[4]	= &s3c_fb_data_64xx_wins[4],
 };
 
+static struct s3c_fb_driverdata s3c_fb_data_s5pv310 = {
+       .variant = {
+               .nr_windows     = 5,
+               .vidtcon        = VIDTCON0,
+               .wincon         = WINCON(0),
+               .winmap         = WINxMAP(0),
+               .keycon         = WKEYCON,
+               .osd            = VIDOSD_BASE,
+               .osd_stride     = 16,
+               .buf_start      = VIDW_BUF_START(0),
+               .buf_size       = VIDW_BUF_SIZE(0),
+               .buf_end        = VIDW_BUF_END(0),
+
+               .palette = {
+                       [0] = 0x2400,
+                       [1] = 0x2800,
+                       [2] = 0x2c00,
+                       [3] = 0x3000,
+                       [4] = 0x3400,
+               },
+
+               .has_shadowcon  = 1,
+       },
+       .win[0] = &s3c_fb_data_64xx_wins[0],
+       .win[1] = &s3c_fb_data_64xx_wins[1],
+       .win[2] = &s3c_fb_data_64xx_wins[2],
+       .win[3] = &s3c_fb_data_64xx_wins[3],
+       .win[4] = &s3c_fb_data_64xx_wins[4],
+};
+
 /* S3C2443/S3C2416 style hardware */
 static struct s3c_fb_driverdata s3c_fb_data_s3c2443 = {
 	.variant = {
@@ -1703,6 +1748,9 @@ static struct platform_device_id s3c_fb_driver_ids[] {
 		.name		= "s5pv210-fb",
 		.driver_data	= (unsigned long)&s3c_fb_data_s5pv210,
 	}, {
+		.name		= "s5pv310-fb",
+		.driver_data	= (unsigned long)&s3c_fb_data_s5pv310,
+	}, {
 		.name		= "s3c2443-fb",
 		.driver_data	= (unsigned long)&s3c_fb_data_s3c2443,
 	},

> -----Original Message-----
> From: linux-fbdev-owner@vger.kernel.org [mailto:linux-fbdev-
> owner@vger.kernel.org] On Behalf Of Kukjin Kim
> Sent: Friday, November 12, 2010 2:26 PM
> To: 'Sangbeom Kim'; linux-arm-kernel@lists.infradead.org; linux-samsung-
> soc@vger.kernel.org; linux-fbdev@vger.kernel.org
> Cc: ben-linux@fluff.org; akpm@linux-foundation.org; 'Jonghun Han'
> Subject: RE: [PATCH 3/4] s3c-fb: Add support S5PV310 FIMD
> 
> Sangbeom Kim wrote:
> >
> > From: Jonghun Han <jonghun.han@samsung.com>
> >
> > This patch adds s3c_fb_driverdata for S5PV310 FIMD0. The clk_type is
> added
> > to distinguish clock type in structure s3c_fb_variant and lcd_clk is
> added
> > in structure s3c_fb to calculate divider for lcd panel.
> > FIMD can handles two clocks. The one is for FIMD IP and the other is for
> > LCD pixel clock. Before S5PV310 LCD pixel clock can be same with FIMD IP
> > clock. From S5PV310 LCD pixel clock is separated from FIMD IP clock.
> >
> > Signed-off-by: Jonghun Han <jonghun.han@samsung.com>
> > Reviewed-by: Kukjin Kim <kgene.kim@samsung.com>
> > Signed-off-by: Sangbeom Kim <sbkim73@samsung.com>
> > Cc: Ben Dooks <ben-linux@fluff.org>
> 
> Hi Ben,
> 
> How do you think about this?
> If you're ok, I'd like to send this to upstream via mmotm.
> 
> > ---
> > NOTE: This patch is only for FIMD0.
> > FIMD1 will be implemented later.
> >  drivers/video/Kconfig  |    2 +-
> >  drivers/video/s3c-fb.c |  128
> ++++++++++++++++++++++++++++++++++++++++++----
> > --
> >  2 files changed, 114 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> > index 8b31fdf..3e2e02a 100644
> > --- a/drivers/video/Kconfig
> > +++ b/drivers/video/Kconfig
> > @@ -1946,7 +1946,7 @@ config FB_TMIO_ACCELL
> >
> >  config FB_S3C
> >  	tristate "Samsung S3C framebuffer support"
> > -	depends on FB && S3C_DEV_FB
> > +	depends on FB && (S3C_DEV_FB || S5P_DEV_FIMD0)
> >  	select FB_CFB_FILLRECT
> >  	select FB_CFB_COPYAREA
> >  	select FB_CFB_IMAGEBLIT
> > diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
> > index f9aca9d..bc182ea 100644
> > --- a/drivers/video/s3c-fb.c
> > +++ b/drivers/video/s3c-fb.c
> > @@ -65,6 +65,9 @@ struct s3c_fb;
> >  #define VIDOSD_C(win, variant) (OSD_BASE(win, variant) + 0x08)
> >  #define VIDOSD_D(win, variant) (OSD_BASE(win, variant) + 0x0C)
> >
> > +#define FIMD_CLK_TYPE0	0
> > +#define FIMD_CLK_TYPE1	1
> > +
this macro is unnecessary.

> >  /**
> >   * struct s3c_fb_variant - fb variant information
> >   * @is_2443: Set if S3C2443/S3C2416 style hardware.
> > @@ -97,6 +100,7 @@ struct s3c_fb_variant {
> >
> >  	unsigned int	has_prtcon:1;
> >  	unsigned int	has_shadowcon:1;
> > +	unsigned int	clk_type:1;
> >  };
> >
> >  /**
> > @@ -183,7 +187,8 @@ struct s3c_fb_vsync {
> >   * struct s3c_fb - overall hardware state of the hardware
> >   * @dev: The device that we bound to, for printing, etc.
> >   * @regs_res: The resource we claimed for the IO registers.
> > - * @bus_clk: The clk (hclk) feeding our interface and possibly pixclk.
> > + * @bus_clk: The clk (hclk) feeding FIMD IP core.
> > + * @lcd_clk: The clk (sclk) feeding our interface and possibly pixclk.
> >   * @regs: The mapped hardware registers.
> >   * @variant: Variant information for this hardware.
> >   * @enabled: A bitmask of enabled hardware windows.
> > @@ -197,6 +202,7 @@ struct s3c_fb {
> >  	struct device		*dev;
> >  	struct resource		*regs_res;
> >  	struct clk		*bus_clk;
> > +	struct clk		*lcd_clk;
> >  	void __iomem		*regs;
> >  	struct s3c_fb_variant	 variant;
> >
bus_clk and lcd_clk could be integrated as lcd_clk.
and Ben, lcd_clk is better then bus_clk because hclk or sclk could be used
according to lcd panel on machine for stable use.

> > @@ -334,7 +340,7 @@ static int s3c_fb_check_var(struct fb_var_screeninfo
> *var,
> >   */
> >  static int s3c_fb_calc_pixclk(struct s3c_fb *sfb, unsigned int pixclk)
> >  {
> > -	unsigned long clk = clk_get_rate(sfb->bus_clk);
> > +	unsigned long clk = clk_get_rate(sfb->lcd_clk);
> >  	unsigned long long tmp;
> >  	unsigned int result;
> >
> > @@ -517,7 +523,7 @@ static int s3c_fb_set_par(struct fb_info *info)
> >
> >  		data = VIDTCON2_LINEVAL(var->yres - 1) |
> >  		       VIDTCON2_HOZVAL(var->xres - 1);
> > -		writel(data, regs +sfb->variant.vidtcon + 8 );
> > +		writel(data, regs + sfb->variant.vidtcon + 8);
> >  	}
> >
> >  	/* write the buffer address */
> > @@ -1286,8 +1292,10 @@ static int __devinit s3c_fb_probe(struct
> > platform_device *pdev)
> >  	struct s3c_fb_platdata *pd;
> >  	struct s3c_fb *sfb;
> >  	struct resource *res;
> > +	struct clk *mout_mpll = NULL;
> >  	int win;
> >  	int ret = 0;
> > +	u32 rate = 134000000;
> >
> >  	fbdrv = (struct s3c_fb_driverdata *)platform_get_device_id(pdev)-
> > >driver_data;
> >
> > @@ -1314,19 +1322,56 @@ static int __devinit s3c_fb_probe(struct
> > platform_device *pdev)
> >  	sfb->pdata = pd;
> >  	sfb->variant = fbdrv->variant;
> >
> > -	sfb->bus_clk = clk_get(dev, "lcd");
> > -	if (IS_ERR(sfb->bus_clk)) {
> > -		dev_err(dev, "failed to get bus clock\n");




> > +	switch (sfb->variant.clk_type) {
> > +	case FIMD_CLK_TYPE0:
> > +		sfb->bus_clk = clk_get(dev, "lcd");
> > +		if (IS_ERR(sfb->bus_clk)) {
> > +			dev_err(dev, "failed to get bus clock\n");
> > +			goto err_sfb;
> > +		}
> > +
> > +		clk_enable(sfb->bus_clk);
> > +
> > +		sfb->lcd_clk = sfb->bus_clk;
> > +		break;
> > +
> > +	case FIMD_CLK_TYPE1:
> > +		sfb->bus_clk = clk_get(&pdev->dev, "fimd");
> > +		if (IS_ERR(sfb->bus_clk)) {
> > +			dev_err(&pdev->dev, "failed to get clock for
> fimd\n");
> > +			goto err_sfb;
> > +		}
> > +		clk_enable(sfb->bus_clk);
> > +
> > +		sfb->lcd_clk = clk_get(&pdev->dev, "sclk_fimd");
> > +		if (IS_ERR(sfb->lcd_clk)) {
> > +			dev_err(&pdev->dev, "failed to get sclk for
> fimd\n");
> > +			goto err_bus_clk;
> > +		}
> > +
> > +		mout_mpll = clk_get(&pdev->dev, "mout_mpll");
> > +		if (IS_ERR(mout_mpll)) {
> > +			dev_err(&pdev->dev, "failed to get mout_mpll\n");
> > +			goto err_lcd_clk;
> > +		}
> > +		clk_set_parent(sfb->lcd_clk, mout_mpll);
> > +		clk_put(mout_mpll);
> > +
> > +		clk_set_rate(sfb->lcd_clk, rate);
> > +		clk_enable(sfb->lcd_clk);
> > +		dev_dbg(&pdev->dev, "set fimd sclk rate to %d\n", rate);
> > +		break;
> > +
> > +	default:
> > +		dev_err(dev, "failed to enable clock for FIMD\n");
> >  		goto err_sfb;
> >  	}
> >
This code above is unnecessary. if sclk_name of platform data is null then
it could get clock "lcd" otherwise sclk_name.
in case of "lcd", fimd would use bus clock as parent clock but
for sclk_name, sclk_fimd clock.

and
 if (pd->pclk_name)
	sfb->lcd_clk->parent = clk_get(dev, pd->pclk_name);
by adding the code above,
we could get appropriate clock rate through clk_get_rate(sfb->lcd_clk) call
at s3c_fb_calc_pixclk function.
(clk_get_rate function gets clock rate of parent if lcd_clk->rate is 0)


> > -	clk_enable(sfb->bus_clk);
> > -
> >  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >  	if (!res) {
> >  		dev_err(dev, "failed to find registers\n");
> >  		ret = -ENOENT;
> > -		goto err_clk;
> > +		goto err_lcd_clk;
> >  	}
> >
> >  	sfb->regs_res = request_mem_region(res->start, resource_size(res),
> > @@ -1334,7 +1379,7 @@ static int __devinit s3c_fb_probe(struct
> > platform_device *pdev)
> >  	if (!sfb->regs_res) {
> >  		dev_err(dev, "failed to claim register region\n");
> >  		ret = -ENOENT;
> > -		goto err_clk;
> > +		goto err_lcd_clk;
> >  	}
> >
> >  	sfb->regs = ioremap(res->start, resource_size(res));
> > @@ -1413,9 +1458,15 @@ err_req_region:
> >  	release_resource(sfb->regs_res);
> >  	kfree(sfb->regs_res);
> >
> > -err_clk:
> > -	clk_disable(sfb->bus_clk);
> > -	clk_put(sfb->bus_clk);
> > +err_lcd_clk:
> > +	clk_disable(sfb->lcd_clk);
> > +	clk_put(sfb->lcd_clk);
> > +
> > +err_bus_clk:
> > +	if (sfb->variant.clk_type != FIMD_CLK_TYPE0) {
> > +		clk_disable(sfb->bus_clk);
> > +		clk_put(sfb->bus_clk);
> > +	}
> >
> >  err_sfb:
> >  	kfree(sfb);
> > @@ -1442,8 +1493,20 @@ static int __devexit s3c_fb_remove(struct
> > platform_device *pdev)
> >
> >  	iounmap(sfb->regs);
> >
> > -	clk_disable(sfb->bus_clk);
> > -	clk_put(sfb->bus_clk);


> > +	switch (sfb->variant.clk_type) {
> > +	case FIMD_CLK_TYPE1:
> > +		clk_disable(sfb->lcd_clk);
> > +		clk_put(sfb->lcd_clk);
> > +		/* fall through to default case */
> > +	case FIMD_CLK_TYPE0:
> > +		clk_disable(sfb->bus_clk);
> > +		clk_put(sfb->bus_clk);
> > +		break;
> > +	default:
> > +		dev_err(sfb->dev, "invalid clock type(%d)\n",
> > +			sfb->variant.clk_type);
> > +		break;
> > +	}
this code above is unnecessary anymore.


> >
> >  	release_resource(sfb->regs_res);
> >  	kfree(sfb->regs_res);
> > @@ -1470,6 +1533,7 @@ static int s3c_fb_suspend(struct platform_device
> *pdev,
> > pm_message_t state)
> >  	}
> >
> >  	clk_disable(sfb->bus_clk);
> > +
> >  	return 0;
> >  }
> >
> > @@ -1656,6 +1720,37 @@ static struct s3c_fb_driverdata
> s3c_fb_data_s5pv210
> > > {
> >  	.win[4]	= &s3c_fb_data_64xx_wins[4],
> >  };
> >
> > +static struct s3c_fb_driverdata s3c_fb_data_s5pv310 = {
> > +	.variant = {
> > +		.nr_windows	= 5,
> > +		.vidtcon	= VIDTCON0,
> > +		.wincon		= WINCON(0),
> > +		.winmap		= WINxMAP(0),
> > +		.keycon		= WKEYCON,
> > +		.osd		= VIDOSD_BASE,
> > +		.osd_stride	= 16,
> > +		.buf_start	= VIDW_BUF_START(0),
> > +		.buf_size	= VIDW_BUF_SIZE(0),
> > +		.buf_end	= VIDW_BUF_END(0),
> > +
> > +		.palette = {
> > +			[0] = 0x2400,
> > +			[1] = 0x2800,
> > +			[2] = 0x2c00,
> > +			[3] = 0x3000,
> > +			[4] = 0x3400,
> > +		},
> > +
> > +		.has_shadowcon	= 1,
> > +		.clk_type	= FIMD_CLK_TYPE1,
clk_type is unnecessary anymore.


> > +	},
> > +	.win[0]	= &s3c_fb_data_64xx_wins[0],
> > +	.win[1]	= &s3c_fb_data_64xx_wins[1],
> > +	.win[2]	= &s3c_fb_data_64xx_wins[2],
> > +	.win[3]	= &s3c_fb_data_64xx_wins[3],
> > +	.win[4]	= &s3c_fb_data_64xx_wins[4],
> > +};
> > +
> >  /* S3C2443/S3C2416 style hardware */
> >  static struct s3c_fb_driverdata s3c_fb_data_s3c2443 = {
> >  	.variant = {
> > @@ -1703,6 +1798,9 @@ static struct platform_device_id
> s3c_fb_driver_ids[]
> > > {
> >  		.name		= "s5pv210-fb",
> >  		.driver_data	= (unsigned long)&s3c_fb_data_s5pv210,
> >  	}, {
> > +		.name		= "s5pv310-fb",
> > +		.driver_data	= (unsigned long)&s3c_fb_data_s5pv310,
> > +	}, {
> >  		.name		= "s3c2443-fb",
> >  		.driver_data	= (unsigned long)&s3c_fb_data_s3c2443,
> >  	},
> > --
> 
> 
> Thanks.
> 
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

