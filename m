From: Jingoo Han <jg1.han@samsung.com>
Date: Mon, 03 Sep 2012 00:54:48 +0000
Subject: Re: [PATCH] video: s3c2410fb: Use pr_* and dev_* instead of printk
Message-Id: <003401cd896e$b8007ce0$280176a0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Friday, August 31, 2012 8:50 PM Sachin Kamat wrote:
> 
> printk calls are replaced by pr_* and dev_* calls to silence
> checkpatch warnings.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/video/s3c2410fb.c |   18 ++++++++++--------
>  1 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/video/s3c2410fb.c b/drivers/video/s3c2410fb.c
> index 77f34c6..a54e3f9 100644
> --- a/drivers/video/s3c2410fb.c
> +++ b/drivers/video/s3c2410fb.c
> @@ -11,6 +11,8 @@
>   * Driver based on skeletonfb.c, sa1100fb.c and others.
>  */
> 
> +#define pr_fmt(fmt) "s3c2410fb: " fmt
> +

Hi Sachin Kamat,

How about using KBUILD_MODNAME instead of "s3c2410fb: "?
It is because prefix is the same with module name.

#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt


Best regards,
Jingoo Han

>  #include <linux/module.h>
>  #include <linux/kernel.h>
>  #include <linux/err.h>
> @@ -48,7 +50,7 @@ static int debug	= 1;
>  static int debug;
>  #endif
> 
> -#define dprintk(msg...)	if (debug) printk(KERN_DEBUG "s3c2410fb: " msg);
> +#define dprintk(msg...)	if (debug) pr_debug(msg);
> 
>  /* useful functions */
> 
> @@ -598,11 +600,11 @@ static int s3c2410fb_debug_store(struct device *dev,
>  	if (strnicmp(buf, "on", 2) = 0 ||
>  	    strnicmp(buf, "1", 1) = 0) {
>  		debug = 1;
> -		printk(KERN_DEBUG "s3c2410fb: Debug On");
> +		dev_dbg(dev, "s3c2410fb: Debug On");
>  	} else if (strnicmp(buf, "off", 3) = 0 ||
>  		   strnicmp(buf, "0", 1) = 0) {
>  		debug = 0;
> -		printk(KERN_DEBUG "s3c2410fb: Debug Off");
> +		dev_dbg(dev, "s3c2410fb: Debug Off");
>  	} else {
>  		return -EINVAL;
>  	}
> @@ -921,7 +923,7 @@ static int __devinit s3c24xxfb_probe(struct platform_device *pdev,
> 
>  	info->clk = clk_get(NULL, "lcd");
>  	if (IS_ERR(info->clk)) {
> -		printk(KERN_ERR "failed to get lcd clock source\n");
> +		dev_err(&pdev->dev, "failed to get lcd clock source\n");
>  		ret = PTR_ERR(info->clk);
>  		goto release_irq;
>  	}
> @@ -947,7 +949,7 @@ static int __devinit s3c24xxfb_probe(struct platform_device *pdev,
>  	/* Initialize video memory */
>  	ret = s3c2410fb_map_video_memory(fbinfo);
>  	if (ret) {
> -		printk(KERN_ERR "Failed to allocate video RAM: %d\n", ret);
> +		dev_err(&pdev->dev, "Failed to allocate video RAM: %d\n", ret);
>  		ret = -ENOMEM;
>  		goto release_clock;
>  	}
> @@ -970,7 +972,7 @@ static int __devinit s3c24xxfb_probe(struct platform_device *pdev,
> 
>  	ret = register_framebuffer(fbinfo);
>  	if (ret < 0) {
> -		printk(KERN_ERR "Failed to register framebuffer device: %d\n",
> +		dev_err(&pdev->dev, "Failed to register framebuffer device: %d\n",
>  			ret);
>  		goto free_cpufreq;
>  	}
> @@ -978,9 +980,9 @@ static int __devinit s3c24xxfb_probe(struct platform_device *pdev,
>  	/* create device files */
>  	ret = device_create_file(&pdev->dev, &dev_attr_debug);
>  	if (ret)
> -		printk(KERN_ERR "failed to add debug attribute\n");
> +		dev_err(&pdev->dev, "failed to add debug attribute\n");
> 
> -	printk(KERN_INFO "fb%d: %s frame buffer device\n",
> +	dev_info(&pdev->dev, "fb%d: %s frame buffer device\n",
>  		fbinfo->node, fbinfo->fix.id);
> 
>  	return 0;
> --
> 1.7.4.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

