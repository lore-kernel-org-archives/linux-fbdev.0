From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Wed, 21 Mar 2012 18:40:31 +0000
Subject: Re: [PATCH v2 1/2] fbdev: da8xx:: fix reporting of the display timing info
Message-Id: <4F6A209F.3080608@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1331644384-5408-1-git-send-email-agust@denx.de>
In-Reply-To: <1331644384-5408-1-git-send-email-agust@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Applied both patches of this series.


Thanks,

Florian Tobias Schandinat

On 03/13/2012 01:13 PM, Anatolij Gustschin wrote:
> Timing info is not properly reported by the driver, e.g.:
> 
> $ fbset -i
> mode "480x272-35"
>     # D: 7.895 MHz, H: 12.165 kHz, V: 35.158 Hz
>     geometry 480 272 480 544 16
>     timings 126666 64 64 32 32 41 10
> 
> According to the timing values defined for LK043T1DG01 display
> it should be reported as:
> 
> mode "480x272-53"
>     # D: 7.895 MHz, H: 15.038 kHz, V: 52.579 Hz
>     geometry 480 272 480 544 16
>     timings 126666 2 2 2 2 41 10
> 
> Initialize additional fb_var_screeninfo fields so fix this problem.
> 
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> Cc: Manjunathappa, Prakash <prakash.pm@ti.com>
> ---
> v2:
>  - removed pixclock setting as it is already done in fbdev-next
>  - rebased on fbdev-next branch
> 
>  drivers/video/da8xx-fb.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
> index dd80386..8f7e051 100644
> --- a/drivers/video/da8xx-fb.c
> +++ b/drivers/video/da8xx-fb.c
> @@ -1231,6 +1231,10 @@ static int __devinit fb_probe(struct platform_device *device)
>  
>  	da8xx_fb_var.hsync_len = lcdc_info->hsw;
>  	da8xx_fb_var.vsync_len = lcdc_info->vsw;
> +	da8xx_fb_var.right_margin = lcdc_info->hfp;
> +	da8xx_fb_var.left_margin  = lcdc_info->hbp;
> +	da8xx_fb_var.lower_margin = lcdc_info->vfp;
> +	da8xx_fb_var.upper_margin = lcdc_info->vbp;
>  	da8xx_fb_var.pixclock = da8xxfb_pixel_clk_period(par);
>  
>  	/* Initialize fbinfo */

