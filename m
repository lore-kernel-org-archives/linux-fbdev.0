From: Jonghun Han <jonghun.han@samsung.com>
Date: Thu, 21 Oct 2010 03:45:14 +0000
Subject: RE: [PATCH 3/4] s3c-fb: Add support S5PV310 FIMD
Message-Id: <003301cb70d2$60ae4d70$220ae850$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1287406528-15324-1-git-send-email-sbkim73@samsung.com>
	<1287406528-15324-4-git-send-email-sbkim73@samsung.com>
	<003001cb6f5e$5db43050$191c90f0$%szyprowski@samsung.com>
In-Reply-To: <003001cb6f5e$5db43050$191c90f0$%szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

1AFAAVgAzADEAMAAgAEY
	ASQBNAEQA
x-cr-puzzleid: {B7526269-A73C-412A-8DAE-B8EB603CF9D0}


Hi, 

Marek Szyprowski wrote:

> -----Original Message-----
> From: Marek Szyprowski [mailto:m.szyprowski@samsung.com]
> Sent: Tuesday, October 19, 2010 4:22 PM
> To: 'Sangbeom Kim'; linux-arm-kernel@lists.infradead.org; linux-samsung-
> soc@vger.kernel.org; linux-fbdev@vger.kernel.org
> Cc: 'Jonghun Han'; akpm@linux-foundation.org; kgene.kim@samsung.com; ben-
> linux@fluff.org; kyungmin.park@samsung.com
> Subject: RE: [PATCH 3/4] s3c-fb: Add support S5PV310 FIMD
> 
> 1AFAAVgAzADEAMAAgAEY
> 	ASQBNAEQA
> x-cr-puzzleid: {C4CCB40E-D5C6-4119-AA7C-BBBA7A1503E4}
> 
> Hello,
> 
> On Monday, October 18, 2010 2:55 PM Sangbeom Kim wrote:
> 
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
> > ---
> > NOTE: This patch is only for FIMD0.
> > FIMD1 will be implemented later.
> >  drivers/video/Kconfig  |    2 +-
> >  drivers/video/s3c-fb.c |  128
> ++++++++++++++++++++++++++++++++++++++++++------
> >  2 files changed, 114 insertions(+), 16 deletions(-)
> >

[snip]

> >  	/* write the buffer address */
> > @@ -1286,8 +1292,10 @@ static int __devinit s3c_fb_probe(struct
> platform_device *pdev)
> >  	struct s3c_fb_platdata *pd;
> >  	struct s3c_fb *sfb;
> >  	struct resource *res;
> > +	struct clk *mout_mpll = NULL;
> >  	int win;
> >  	int ret = 0;
> > +	u32 rate = 134000000;
> >
> >  	fbdrv = (struct s3c_fb_driverdata *)platform_get_device_id(pdev)-
> >driver_data;
> >
> > @@ -1314,19 +1322,56 @@ static int __devinit s3c_fb_probe(struct
> platform_device *pdev)
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
fimd\n");
> > +			goto err_sfb;
> > +		}
> > +		clk_enable(sfb->bus_clk);
> > +
> > +		sfb->lcd_clk = clk_get(&pdev->dev, "sclk_fimd");
> > +		if (IS_ERR(sfb->lcd_clk)) {
> > +			dev_err(&pdev->dev, "failed to get sclk for
fimd\n");
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
> 
> I don't think that the driver is the right place to change the parent of
> the sclk_fimd
> clock. It should be done in the boot loader or the board startup code.
> 

As you know, there are two clock sources for LCD pixel clock. 
s3c-fb only used 'lcd' clock as a parent of LCD pixel clock.
But from S5PV310 SCLK_FIMD is only used as a source of LCD pixel clock.
And SCLK_FIMD is only for FIMD. So the parent of the SCLK_FIMD can be
selected in the driver.
In my opinion it doesn't matter.


> We should also be a bit more consistent on clock naming. s3c6410..s5pv210
> used the 'lcd'
> clock name. Maybe you should also provide a patch to rename all these
> clocks to common
> name.
> 
Please refer to the following diagram.
Before S5PV310 clk 'lcd' was used for FIMD IP core clock and source of the
LCD pixel clock.
But the mux used to select source of LCD pixel clock is removed.
So 'lcd' clock is only used for core clock of FIMD IP. It isn't used for LCD
pixel clock.
As a result clock name was changed from lcd to fimd in the S5PV310
datasheet.
I agree to rearrange clock name later.

Before S5PV310
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


S5PV310
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
> platform_device *pdev)
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
[snip]

BRs,


