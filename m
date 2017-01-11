From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 11 Jan 2017 15:07:05 +0000
Subject: Re: [PATCH] simplefb: Separate clk / regulator get and enable steps
Message-Id: <8943659.T6ei7HPULA@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20161104144507.18072-1-hdegoede@redhat.com>
 <CGME20170111150708epcas5p41496db3ee192f7401fd041929dff09b3@epcas5p4.samsung.com>
In-Reply-To: <20161104144507.18072-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org


Hi,

On Friday, November 04, 2016 03:45:07 PM Hans de Goede wrote:
> Currently when a simplefb needs both clocks and regulators and one
> of the regulators returns -EPROBE_DEFER when we try to get it, we end
> up disabling the clocks. This causes the screen to go blank; and in some
> cases my cause hardware state to be lost resulting in the framebuffer not
> working at all.
> 
> This commit splits the get and enable steps and only enables
> clocks and regulators after successfully getting all of them,
> fixing the disabling of the clocks which were left enabled by
> the firmware setting up the simplefb.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Thanks, patch queued for 4.11.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/video/fbdev/simplefb.c | 56 ++++++++++++++++++++++++++++++------------
>  1 file changed, 40 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
> index 61f799a..a3c44ec 100644
> --- a/drivers/video/fbdev/simplefb.c
> +++ b/drivers/video/fbdev/simplefb.c
> @@ -180,10 +180,12 @@ static int simplefb_parse_pd(struct platform_device *pdev,
>  struct simplefb_par {
>  	u32 palette[PSEUDO_PALETTE_SIZE];
>  #if defined CONFIG_OF && defined CONFIG_COMMON_CLK
> +	bool clks_enabled;
>  	unsigned int clk_count;
>  	struct clk **clks;
>  #endif
>  #if defined CONFIG_OF && defined CONFIG_REGULATOR
> +	bool regulators_enabled;
>  	u32 regulator_count;
>  	struct regulator **regulators;
>  #endif
> @@ -208,12 +210,12 @@ struct simplefb_par {
>   * the fb probe will not help us much either. So just complain and carry on,
>   * and hope that the user actually gets a working fb at the end of things.
>   */
> -static int simplefb_clocks_init(struct simplefb_par *par,
> -				struct platform_device *pdev)
> +static int simplefb_clocks_get(struct simplefb_par *par,
> +			       struct platform_device *pdev)
>  {
>  	struct device_node *np = pdev->dev.of_node;
>  	struct clk *clock;
> -	int i, ret;
> +	int i;
>  
>  	if (dev_get_platdata(&pdev->dev) || !np)
>  		return 0;
> @@ -244,6 +246,14 @@ static int simplefb_clocks_init(struct simplefb_par *par,
>  		par->clks[i] = clock;
>  	}
>  
> +	return 0;
> +}
> +
> +static void simplefb_clocks_enable(struct simplefb_par *par,
> +				   struct platform_device *pdev)
> +{
> +	int i, ret;
> +
>  	for (i = 0; i < par->clk_count; i++) {
>  		if (par->clks[i]) {
>  			ret = clk_prepare_enable(par->clks[i]);
> @@ -256,8 +266,7 @@ static int simplefb_clocks_init(struct simplefb_par *par,
>  			}
>  		}
>  	}
> -
> -	return 0;
> +	par->clks_enabled = true;
>  }
>  
>  static void simplefb_clocks_destroy(struct simplefb_par *par)
> @@ -269,7 +278,8 @@ static void simplefb_clocks_destroy(struct simplefb_par *par)
>  
>  	for (i = 0; i < par->clk_count; i++) {
>  		if (par->clks[i]) {
> -			clk_disable_unprepare(par->clks[i]);
> +			if (par->clks_enabled)
> +				clk_disable_unprepare(par->clks[i]);
>  			clk_put(par->clks[i]);
>  		}
>  	}
> @@ -277,8 +287,10 @@ static void simplefb_clocks_destroy(struct simplefb_par *par)
>  	kfree(par->clks);
>  }
>  #else
> -static int simplefb_clocks_init(struct simplefb_par *par,
> +static int simplefb_clocks_get(struct simplefb_par *par,
>  	struct platform_device *pdev) { return 0; }
> +static void simplefb_clocks_enable(struct simplefb_par *par,
> +	struct platform_device *pdev) { }
>  static void simplefb_clocks_destroy(struct simplefb_par *par) { }
>  #endif
>  
> @@ -305,14 +317,14 @@ static void simplefb_clocks_destroy(struct simplefb_par *par) { }
>   * the fb probe will not help us much either. So just complain and carry on,
>   * and hope that the user actually gets a working fb at the end of things.
>   */
> -static int simplefb_regulators_init(struct simplefb_par *par,
> -	struct platform_device *pdev)
> +static int simplefb_regulators_get(struct simplefb_par *par,
> +				   struct platform_device *pdev)
>  {
>  	struct device_node *np = pdev->dev.of_node;
>  	struct property *prop;
>  	struct regulator *regulator;
>  	const char *p;
> -	int count = 0, i = 0, ret;
> +	int count = 0, i = 0;
>  
>  	if (dev_get_platdata(&pdev->dev) || !np)
>  		return 0;
> @@ -354,6 +366,14 @@ static int simplefb_regulators_init(struct simplefb_par *par,
>  	}
>  	par->regulator_count = i;
>  
> +	return 0;
> +}
> +
> +static void simplefb_regulators_enable(struct simplefb_par *par,
> +				       struct platform_device *pdev)
> +{
> +	int i, ret;
> +
>  	/* Enable all the regulators */
>  	for (i = 0; i < par->regulator_count; i++) {
>  		ret = regulator_enable(par->regulators[i]);
> @@ -365,15 +385,14 @@ static int simplefb_regulators_init(struct simplefb_par *par,
>  			par->regulators[i] = NULL;
>  		}
>  	}
> -
> -	return 0;
> +	par->regulators_enabled = true;
>  }
>  
>  static void simplefb_regulators_destroy(struct simplefb_par *par)
>  {
>  	int i;
>  
> -	if (!par->regulators)
> +	if (!par->regulators || !par->regulators_enabled)
>  		return;
>  
>  	for (i = 0; i < par->regulator_count; i++)
> @@ -381,8 +400,10 @@ static void simplefb_regulators_destroy(struct simplefb_par *par)
>  			regulator_disable(par->regulators[i]);
>  }
>  #else
> -static int simplefb_regulators_init(struct simplefb_par *par,
> +static int simplefb_regulators_get(struct simplefb_par *par,
>  	struct platform_device *pdev) { return 0; }
> +static void simplefb_regulators_enable(struct simplefb_par *par,
> +	struct platform_device *pdev) { }
>  static void simplefb_regulators_destroy(struct simplefb_par *par) { }
>  #endif
>  
> @@ -453,14 +474,17 @@ static int simplefb_probe(struct platform_device *pdev)
>  	}
>  	info->pseudo_palette = par->palette;
>  
> -	ret = simplefb_clocks_init(par, pdev);
> +	ret = simplefb_clocks_get(par, pdev);
>  	if (ret < 0)
>  		goto error_unmap;
>  
> -	ret = simplefb_regulators_init(par, pdev);
> +	ret = simplefb_regulators_get(par, pdev);
>  	if (ret < 0)
>  		goto error_clocks;
>  
> +	simplefb_clocks_enable(par, pdev);
> +	simplefb_regulators_enable(par, pdev);
> +
>  	dev_info(&pdev->dev, "framebuffer at 0x%lx, 0x%x bytes, mapped to 0x%p\n",
>  			     info->fix.smem_start, info->fix.smem_len,
>  			     info->screen_base);

