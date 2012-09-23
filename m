From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sun, 23 Sep 2012 19:37:01 +0000
Subject: Re: [PATCH v2] da8xx-fb: enable LCDC if FB is unblanked
Message-Id: <505F64DD.4090901@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 08/31/2012 02:18 PM, Manjunathappa, Prakash wrote:
> It is expected that LCDC to continue to be disabled after
> resume if it is blanked before suspend. This is also true
> for DVFS. But it is observed that LCDC being enabled after
> suspend/resume cycle or DVFS.
> 
> Correcting it by having check for FB_BLANK_UNBLANK before
> enabling.
> 
> Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>

Applied.


Thanks,

Florian Tobias Schandinat

> ---
> Applies on top of fbdev-next of Florian Tobias Schandinat's tree.
> Since v1:
> Re-written commit message.
> 
>  drivers/video/da8xx-fb.c |   11 +++++++----
>  1 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
> index 761c8d1..1273354 100644
> --- a/drivers/video/da8xx-fb.c
> +++ b/drivers/video/da8xx-fb.c
> @@ -962,7 +962,8 @@ static int lcd_da8xx_cpufreq_transition(struct notifier_block *nb,
>  			par->lcd_fck_rate = clk_get_rate(par->lcdc_clk);
>  			lcd_disable_raster();
>  			lcd_calc_clk_divider(par);
> -			lcd_enable_raster();
> +			if (par->blank = FB_BLANK_UNBLANK)
> +				lcd_enable_raster();
>  		}
>  	}
>  
> @@ -1486,10 +1487,12 @@ static int fb_resume(struct platform_device *dev)
>  
>  	console_lock();
>  	clk_enable(par->lcdc_clk);
> -	lcd_enable_raster();
> +	if (par->blank = FB_BLANK_UNBLANK) {
> +		lcd_enable_raster();
>  
> -	if (par->panel_power_ctrl)
> -		par->panel_power_ctrl(1);
> +		if (par->panel_power_ctrl)
> +			par->panel_power_ctrl(1);
> +	}
>  
>  	fb_set_suspend(info, 0);
>  	console_unlock();

