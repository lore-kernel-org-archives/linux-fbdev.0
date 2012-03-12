From: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Date: Mon, 12 Mar 2012 05:19:54 +0000
Subject: RE: [PATCH 1/2] fbdev: da8xx:: fix reporting of the display timing info
Message-Id: <A73F36158E33644199EB82C5EC81C7BC31780B35@DBDE01.ent.ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1331305336-32644-2-git-send-email-agust@denx.de>
In-Reply-To: <1331305336-32644-2-git-send-email-agust@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi,

On Fri, Mar 09, 2012 at 20:32:15, Anatolij Gustschin wrote:
> Timing info is not properly reported by the driver, e.g.:
> 
> $ fbset -i
> mode "480x272-95"
>     # D: 21.429 MHz, H: 33.018 kHz, V: 95.429 Hz
>     geometry 480 272 480 544 16
>     timings 46666 64 64 32 32 41 10
> 
> According to the timing values defined for LK043T1DG01 display
> it should be reported as:
> 
> mode "480x272-52"
>     # D: 7.834 MHz, H: 14.921 kHz, V: 51.810 Hz
>     geometry 480 272 480 544 16
>     timings 127655 2 2 2 2 41 10
> 
> Initialize additional fb_var_screeninfo fields so fix this problem.
> 
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> Cc: Manjunathappa, Prakash <prakash.pm@ti.com>
> ---
>  drivers/video/da8xx-fb.c |   13 +++++++++++++
>  1 files changed, 13 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
> index 29577bf..27c2794 100644
> --- a/drivers/video/da8xx-fb.c
> +++ b/drivers/video/da8xx-fb.c
> @@ -240,6 +240,14 @@ static struct da8xx_panel known_lcd_panels[] = {
>  	},
>  };
>  
> +static inline unsigned long hz_to_ps(unsigned long hz_val)
> +{
> +	unsigned long long num = 1000000000000ULL;
> +
> +	do_div(num, hz_val);
> +	return (unsigned long)num;
> +}
> +

I have patch to take care of this:

http://davinci-linux-open-source.1494791.n2.nabble.com/PATCH-v2-video-da8xx-fb-calculate-pixel-clock-period-for-the-panel-tt7268377.html#none

>  /* Enable the Raster Engine of the LCD Controller */
>  static inline void lcd_enable_raster(void)
>  {
> @@ -1209,6 +1217,11 @@ static int __devinit fb_probe(struct platform_device *device)
>  
>  	da8xx_fb_var.hsync_len = lcdc_info->hsw;
>  	da8xx_fb_var.vsync_len = lcdc_info->vsw;
> +	da8xx_fb_var.right_margin = lcdc_info->hfp;
> +	da8xx_fb_var.left_margin  = lcdc_info->hbp;
> +	da8xx_fb_var.lower_margin = lcdc_info->vfp;
> +	da8xx_fb_var.upper_margin = lcdc_info->vbp;
> +	da8xx_fb_var.pixclock = hz_to_ps(lcdc_info->pxl_clk);
>  

Above specified patch takes care of updating "pixclock". Remaining updates seems ok.

Thanks,
Prakash

>  	/* Initialize fbinfo */
>  	da8xx_fb_info->flags = FBINFO_FLAG_DEFAULT;
> -- 
> 1.7.7.6
> 
> 

