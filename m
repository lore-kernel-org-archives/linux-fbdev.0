From: Hans de Goede <hdegoede@redhat.com>
Date: Fri, 31 Aug 2018 10:09:25 +0000
Subject: Re: [PATCH V6 4/4] video: simplefb: switch to use clk_bulk API to simplify clock operations
Message-Id: <b4f91f96-3387-d24e-e2d1-1fe2e9230417@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1535690756-22234-1-git-send-email-aisheng.dong@nxp.com>
 <1535690756-22234-5-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1535690756-22234-5-git-send-email-aisheng.dong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

On 31-08-18 06:45, Dong Aisheng wrote:
> Switching to use clk_bulk API to simplify clock operations.
> 
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: linux-fbdev@vger.kernel.org
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Tested-by: Thor Thayer <thor.thayer@linux.intel.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
> v5->v6:
>   * address Hans's comments

v6 looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> v4->v5:
>   * fix wrong setting of par->clks_enabled
> v3->v4:
>   * no changes
> v2->v3:
>   * fix a build warning on x86 platform due to a wrong
>     of the prototype of simplefb_clocks_enable
> v1->v2:
>   * switch to clk_bulk_get_all from of_clk_bulk_get_all
> ---
>   drivers/video/fbdev/simplefb.c | 72 +++++++++++-------------------------------
>   1 file changed, 18 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
> index 9a9d748..89fb1e7 100644
> --- a/drivers/video/fbdev/simplefb.c
> +++ b/drivers/video/fbdev/simplefb.c
> @@ -181,8 +181,8 @@ struct simplefb_par {
>   	u32 palette[PSEUDO_PALETTE_SIZE];
>   #if defined CONFIG_OF && defined CONFIG_COMMON_CLK
>   	bool clks_enabled;
> -	unsigned int clk_count;
> -	struct clk **clks;
> +	int clk_count;
> +	struct clk_bulk_data *clks;
>   #endif
>   #if defined CONFIG_OF && defined CONFIG_REGULATOR
>   	bool regulators_enabled;
> @@ -214,37 +214,13 @@ static int simplefb_clocks_get(struct simplefb_par *par,
>   			       struct platform_device *pdev)
>   {
>   	struct device_node *np = pdev->dev.of_node;
> -	struct clk *clock;
> -	int i;
>   
>   	if (dev_get_platdata(&pdev->dev) || !np)
>   		return 0;
>   
> -	par->clk_count = of_clk_get_parent_count(np);
> -	if (!par->clk_count)
> -		return 0;
> -
> -	par->clks = kcalloc(par->clk_count, sizeof(struct clk *), GFP_KERNEL);
> -	if (!par->clks)
> -		return -ENOMEM;
> -
> -	for (i = 0; i < par->clk_count; i++) {
> -		clock = of_clk_get(np, i);
> -		if (IS_ERR(clock)) {
> -			if (PTR_ERR(clock) = -EPROBE_DEFER) {
> -				while (--i >= 0) {
> -					if (par->clks[i])
> -						clk_put(par->clks[i]);
> -				}
> -				kfree(par->clks);
> -				return -EPROBE_DEFER;
> -			}
> -			dev_err(&pdev->dev, "%s: clock %d not found: %ld\n",
> -				__func__, i, PTR_ERR(clock));
> -			continue;
> -		}
> -		par->clks[i] = clock;
> -	}
> +	par->clk_count = clk_bulk_get_all(&pdev->dev, &par->clks);
> +	if (par->clk_count = -EPROBE_DEFER)
> +		return -EPROBE_DEFER;
>   
>   	return 0;
>   }
> @@ -252,39 +228,27 @@ static int simplefb_clocks_get(struct simplefb_par *par,
>   static void simplefb_clocks_enable(struct simplefb_par *par,
>   				   struct platform_device *pdev)
>   {
> -	int i, ret;
> +	int ret;
>   
> -	for (i = 0; i < par->clk_count; i++) {
> -		if (par->clks[i]) {
> -			ret = clk_prepare_enable(par->clks[i]);
> -			if (ret) {
> -				dev_err(&pdev->dev,
> -					"%s: failed to enable clock %d: %d\n",
> -					__func__, i, ret);
> -				clk_put(par->clks[i]);
> -				par->clks[i] = NULL;
> -			}
> -		}
> -	}
> -	par->clks_enabled = true;
> +	if (par->clk_count <= 0)
> +		return;
> +
> +	ret = clk_bulk_prepare_enable(par->clk_count, par->clks);
> +	if (ret)
> +		dev_warn(&pdev->dev, "failed to enable clocks\n");
> +	else
> +		par->clks_enabled = true;
>   }
>   
>   static void simplefb_clocks_destroy(struct simplefb_par *par)
>   {
> -	int i;
> -
> -	if (!par->clks)
> +	if (par->clk_count <= 0)
>   		return;
>   
> -	for (i = 0; i < par->clk_count; i++) {
> -		if (par->clks[i]) {
> -			if (par->clks_enabled)
> -				clk_disable_unprepare(par->clks[i]);
> -			clk_put(par->clks[i]);
> -		}
> -	}
> +	if (par->clks_enabled)
> +		clk_bulk_disable_unprepare(par->clk_count, par->clks);
>   
> -	kfree(par->clks);
> +	clk_bulk_put_all(par->clk_count, par->clks);
>   }
>   #else
>   static int simplefb_clocks_get(struct simplefb_par *par,
> 
