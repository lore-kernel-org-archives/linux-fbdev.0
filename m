From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sun, 29 Jul 2012 21:16:00 +0000
Subject: Re: [PATCH] da8xx-fb: do not turn ON LCD backlight unless LCDC is enabled
Message-Id: <5015A810.9020409@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1343103325-7313-1-git-send-email-prakash.pm@ti.com>
In-Reply-To: <1343103325-7313-1-git-send-email-prakash.pm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 07/24/2012 04:15 AM, Manjunathappa, Prakash wrote:
> LCD blink is observed during suspend/resume and blank/unblank
> operations as backlight is ON during LCDC disable and enable.
> So make sure to turn OFF backlight before disabling and turn
> it ON after enabling.
> 
> Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>

Applied.


Thanks,

Florian Tobias Schandinat

> ---
>  drivers/video/da8xx-fb.c |    9 +++++----
>  1 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
> index 0fb4d7d..1a569ae 100644
> --- a/drivers/video/da8xx-fb.c
> +++ b/drivers/video/da8xx-fb.c
> @@ -1056,10 +1056,10 @@ static int cfb_blank(int blank, struct fb_info *info)
>  	par->blank = blank;
>  	switch (blank) {
>  	case FB_BLANK_UNBLANK:
> +		lcd_enable_raster();
> +
>  		if (par->panel_power_ctrl)
>  			par->panel_power_ctrl(1);
> -
> -		lcd_enable_raster();
>  		break;
>  	case FB_BLANK_POWERDOWN:
>  		if (par->panel_power_ctrl)
> @@ -1417,11 +1417,12 @@ static int fb_resume(struct platform_device *dev)
>  	struct da8xx_fb_par *par = info->par;
>  
>  	console_lock();
> +	clk_enable(par->lcdc_clk);
> +	lcd_enable_raster();
> +
>  	if (par->panel_power_ctrl)
>  		par->panel_power_ctrl(1);
>  
> -	clk_enable(par->lcdc_clk);
> -	lcd_enable_raster();
>  	fb_set_suspend(info, 0);
>  	console_unlock();
>  

