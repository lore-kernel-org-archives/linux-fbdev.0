From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sun, 04 Dec 2011 00:40:46 +0000
Subject: Re: [PATCH] video: s3c2410: fix checkpatch error and warnings
Message-Id: <4EDAC18E.20106@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 11/29/2011 09:48 AM, Jingoo Han wrote:
> This patch fixes the checkpatch errors listed below:
> 
> ERROR: do not initialise statics to 0 or NULL
> WARNING: Use #include <linux/io.h> instead of <asm/io.h>
> WARNING: braces {} are not necessary for single statement blocks
> WARNING: braces {} are not necessary for any arm of this statement
> WARNING: static char array declaration should probably be static const char
> WARNING: line over 80 characters
> WARNING: msleep < 20ms can sleep for up to 20ms; see Documentation/timers/timers-howto.txt
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Applied this patch.


Thanks,

Florian Tobias Schandinat

> ---
>  drivers/video/s3c2410fb.c |   29 +++++++++++++++--------------
>  1 files changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/video/s3c2410fb.c b/drivers/video/s3c2410fb.c
> index ee4c0df..77f34c6 100644
> --- a/drivers/video/s3c2410fb.c
> +++ b/drivers/video/s3c2410fb.c
> @@ -26,8 +26,8 @@
>  #include <linux/platform_device.h>
>  #include <linux/clk.h>
>  #include <linux/cpufreq.h>
> +#include <linux/io.h>
>  
> -#include <asm/io.h>
>  #include <asm/div64.h>
>  
>  #include <asm/mach/map.h>
> @@ -45,10 +45,10 @@
>  #ifdef CONFIG_FB_S3C2410_DEBUG
>  static int debug	= 1;
>  #else
> -static int debug	= 0;
> +static int debug;
>  #endif
>  
> -#define dprintk(msg...)	if (debug) { printk(KERN_DEBUG "s3c2410fb: " msg); }
> +#define dprintk(msg...)	if (debug) printk(KERN_DEBUG "s3c2410fb: " msg);
>  
>  /* useful functions */
>  
> @@ -567,11 +567,10 @@ static int s3c2410fb_blank(int blank_mode, struct fb_info *info)
>  
>  	tpal_reg += is_s3c2412(fbi) ? S3C2412_TPAL : S3C2410_TPAL;
>  
> -	if (blank_mode = FB_BLANK_POWERDOWN) {
> +	if (blank_mode = FB_BLANK_POWERDOWN)
>  		s3c2410fb_lcd_enable(fbi, 0);
> -	} else {
> +	else
>  		s3c2410fb_lcd_enable(fbi, 1);
> -	}
>  
>  	if (blank_mode = FB_BLANK_UNBLANK)
>  		writel(0x0, tpal_reg);
> @@ -812,7 +811,7 @@ static inline void s3c2410fb_cpufreq_deregister(struct s3c2410fb_info *info)
>  #endif
>  
>  
> -static char driver_name[] = "s3c2410fb";
> +static const char driver_name[] = "s3c2410fb";
>  
>  static int __devinit s3c24xxfb_probe(struct platform_device *pdev,
>  				  enum s3c_drv_type drv_type)
> @@ -881,7 +880,10 @@ static int __devinit s3c24xxfb_probe(struct platform_device *pdev,
>  		goto release_mem;
>  	}
>  
> -	info->irq_base = info->io + ((drv_type = DRV_S3C2412) ? S3C2412_LCDINTBASE : S3C2410_LCDINTBASE);
> +	if (drv_type = DRV_S3C2412)
> +		info->irq_base = info->io + S3C2412_LCDINTBASE;
> +	else
> +		info->irq_base = info->io + S3C2410_LCDINTBASE;
>  
>  	dprintk("devinit\n");
>  
> @@ -927,7 +929,7 @@ static int __devinit s3c24xxfb_probe(struct platform_device *pdev,
>  	clk_enable(info->clk);
>  	dprintk("got and enabled clock\n");
>  
> -	msleep(1);
> +	usleep_range(1000, 1000);
>  
>  	info->clk_rate = clk_get_rate(info->clk);
>  
> @@ -975,9 +977,8 @@ static int __devinit s3c24xxfb_probe(struct platform_device *pdev,
>  
>  	/* create device files */
>  	ret = device_create_file(&pdev->dev, &dev_attr_debug);
> -	if (ret) {
> +	if (ret)
>  		printk(KERN_ERR "failed to add debug attribute\n");
> -	}
>  
>  	printk(KERN_INFO "fb%d: %s frame buffer device\n",
>  		fbinfo->node, fbinfo->fix.id);
> @@ -1027,7 +1028,7 @@ static int __devexit s3c2410fb_remove(struct platform_device *pdev)
>  	s3c2410fb_cpufreq_deregister(info);
>  
>  	s3c2410fb_lcd_enable(info, 0);
> -	msleep(1);
> +	usleep_range(1000, 1000);
>  
>  	s3c2410fb_unmap_video_memory(fbinfo);
>  
> @@ -1064,7 +1065,7 @@ static int s3c2410fb_suspend(struct platform_device *dev, pm_message_t state)
>  	 * the LCD DMA engine is not going to get back on the bus
>  	 * before the clock goes off again (bjd) */
>  
> -	msleep(1);
> +	usleep_range(1000, 1000);
>  	clk_disable(info->clk);
>  
>  	return 0;
> @@ -1076,7 +1077,7 @@ static int s3c2410fb_resume(struct platform_device *dev)
>  	struct s3c2410fb_info *info = fbinfo->par;
>  
>  	clk_enable(info->clk);
> -	msleep(1);
> +	usleep_range(1000, 1000);
>  
>  	s3c2410fb_init_registers(fbinfo);
>  

