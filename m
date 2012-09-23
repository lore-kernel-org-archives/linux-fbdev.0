From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sun, 23 Sep 2012 19:46:27 +0000
Subject: Re: [PATCH 2/2] video: s3c2410: fix checkpatch warnings
Message-Id: <505F6713.3070504@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <002d01cd8f42$c06b6690$414233b0$%han@samsung.com>
In-Reply-To: <002d01cd8f42$c06b6690$414233b0$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 09/10/2012 10:55 AM, Jingoo Han wrote:
> This patch fixes the checkpatch warnings listed below:
> 
> WARNING: usleep_range should not use min = max args; see Documentation/timers/timers-howto.txt
> WARNING: quoted string split across lines
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Applied.


Thanks,

Florian Tobias Schandinat

> ---
>  drivers/video/s3c2410fb.c |   12 ++++++------
>  1 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/video/s3c2410fb.c b/drivers/video/s3c2410fb.c
> index 1aa37ea..1083bb9 100644
> --- a/drivers/video/s3c2410fb.c
> +++ b/drivers/video/s3c2410fb.c
> @@ -935,7 +935,7 @@ static int __devinit s3c24xxfb_probe(struct platform_device *pdev,
>  	clk_enable(info->clk);
>  	dprintk("got and enabled clock\n");
>  
> -	usleep_range(1000, 1000);
> +	usleep_range(1000, 1100);
>  
>  	info->clk_rate = clk_get_rate(info->clk);
>  
> @@ -1034,7 +1034,7 @@ static int __devexit s3c2410fb_remove(struct platform_device *pdev)
>  	s3c2410fb_cpufreq_deregister(info);
>  
>  	s3c2410fb_lcd_enable(info, 0);
> -	usleep_range(1000, 1000);
> +	usleep_range(1000, 1100);
>  
>  	s3c2410fb_unmap_video_memory(fbinfo);
>  
> @@ -1071,7 +1071,7 @@ static int s3c2410fb_suspend(struct platform_device *dev, pm_message_t state)
>  	 * the LCD DMA engine is not going to get back on the bus
>  	 * before the clock goes off again (bjd) */
>  
> -	usleep_range(1000, 1000);
> +	usleep_range(1000, 1100);
>  	clk_disable(info->clk);
>  
>  	return 0;
> @@ -1083,7 +1083,7 @@ static int s3c2410fb_resume(struct platform_device *dev)
>  	struct s3c2410fb_info *info = fbinfo->par;
>  
>  	clk_enable(info->clk);
> -	usleep_range(1000, 1000);
> +	usleep_range(1000, 1100);
>  
>  	s3c2410fb_init_registers(fbinfo);
>  
> @@ -1140,8 +1140,8 @@ static void __exit s3c2410fb_cleanup(void)
>  module_init(s3c2410fb_init);
>  module_exit(s3c2410fb_cleanup);
>  
> -MODULE_AUTHOR("Arnaud Patard <arnaud.patard@rtp-net.org>, "
> -	      "Ben Dooks <ben-linux@fluff.org>");
> +MODULE_AUTHOR("Arnaud Patard <arnaud.patard@rtp-net.org>");
> +MODULE_AUTHOR("Ben Dooks <ben-linux@fluff.org>");
>  MODULE_DESCRIPTION("Framebuffer driver for the s3c2410");
>  MODULE_LICENSE("GPL");
>  MODULE_ALIAS("platform:s3c2410-lcd");

