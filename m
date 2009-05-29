From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: s3c-fb: CPUFREQ frequency scaling support
Date: Fri, 29 May 2009 13:44:59 -0700
Message-ID: <20090529134459.adb744df.akpm@linux-foundation.org>
References: <20090528210430.494053822@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <akpm@linux-foundation.org>) id 1MA8xh-0005MI-KN
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 29 May 2009 20:45:57 +0000
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MA8x9-0007Bz-Ko
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 29 May 2009 20:45:57 +0000
In-Reply-To: <20090528210430.494053822@fluff.org.uk>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Ben Dooks <ben@simtec.co.uk>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux@simtec.co.uk, adaplas@gmail.com, cpufreq@www.linux.org.uk

On Thu, 28 May 2009 22:04:30 +0100
Ben Dooks <ben@simtec.co.uk> wrote:

> Add support for CPU frequency scaling in the S3C24XX video driver.
> 

Looks nice and neat.

Did you get to look at Krzysztof's
s3c-fb-fix-resource-releasing-on-error-during-probing.patch, btw?  Is
it 2.6.30 material?

> 
> ---
>  drivers/video/s3c2410fb.c |   67 ++++++++++++++++++++++++++++++++++++++++++++--
>  drivers/video/s3c2410fb.h |    5 +++
>  2 files changed, 70 insertions(+), 2 deletions(-)
> 
> Index: b/drivers/video/s3c2410fb.c
> ===================================================================
> --- a/drivers/video/s3c2410fb.c	2009-02-02 11:30:38.372867510 +0000
> +++ b/drivers/video/s3c2410fb.c	2009-02-02 11:30:58.703595503 +0000
> @@ -24,6 +24,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/platform_device.h>
>  #include <linux/clk.h>
> +#include <linux/cpufreq.h>
>  
>  #include <asm/io.h>
>  #include <asm/div64.h>
> @@ -89,7 +90,7 @@ static void s3c2410fb_set_lcdaddr(struct
>  static unsigned int s3c2410fb_calc_pixclk(struct s3c2410fb_info *fbi,
>  					  unsigned long pixclk)
>  {
> -	unsigned long clk = clk_get_rate(fbi->clk);
> +	unsigned long clk = fbi->clk_rate;
>  	unsigned long long div;
>  
>  	/* pixclk is in picoseconds, our clock is in Hz
> @@ -758,6 +759,57 @@ static irqreturn_t s3c2410fb_irq(int irq
>  	return IRQ_HANDLED;
>  }
>  
> +#ifdef CONFIG_CPU_FREQ
> +
> +static int s3c2410fb_cpufreq_transition(struct notifier_block *nb,
> +					unsigned long val, void *data)
> +{
> +	struct cpufreq_freqs *freqs = data;
> +	struct s3c2410fb_info *info;
> +	struct fb_info *fbinfo;
> +	long delta_f;
> +
> +	info = container_of(nb, struct s3c2410fb_info, freq_transition);
> +	fbinfo = platform_get_drvdata(to_platform_device(info->dev));
> +
> +	/* work out change, <0 for speed-up */
> +	delta_f = info->clk_rate - clk_get_rate(info->clk);
> +
> +	if ((val == CPUFREQ_POSTCHANGE && delta_f > 0) ||
> +	    (val == CPUFREQ_PRECHANGE && delta_f < 0)) {
> +		info->clk_rate = clk_get_rate(info->clk);
> +		s3c2410fb_activate_var(fbinfo);
> +	}
> +
> +	return 0;
> +}
> +
> +static inline int s3c2410fb_cpufreq_register(struct s3c2410fb_info *info)
> +{
> +	info->freq_transition.notifier_call = s3c2410fb_cpufreq_transition;
> +
> +	return cpufreq_register_notifier(&info->freq_transition,
> +					 CPUFREQ_TRANSITION_NOTIFIER);
> +}
> +
> +static inline void s3c2410fb_cpufreq_deregister(struct s3c2410fb_info *info)
> +{
> +	cpufreq_unregister_notifier(&info->freq_transition,
> +				    CPUFREQ_TRANSITION_NOTIFIER);
> +}
> +
> +#else
> +static inline int s3c2410fb_cpufreq_register(struct s3c2410fb_info *info)
> +{
> +	return 0;
> +}
> +
> +static inline void s3c2410fb_cpufreq_deregister(struct s3c2410fb_info *info)
> +{
> +}
> +#endif
> +
> +
>  static char driver_name[] = "s3c2410fb";
>  
>  static int __init s3c24xxfb_probe(struct platform_device *pdev,
> @@ -875,6 +927,8 @@ static int __init s3c24xxfb_probe(struct
>  
>  	msleep(1);
>  
> +	info->clk_rate = clk_get_rate(info->clk);
> +
>  	/* find maximum required memory size for display */
>  	for (i = 0; i < mach_info->num_displays; i++) {
>  		unsigned long smem_len = mach_info->displays[i].xres;
> @@ -904,11 +958,17 @@ static int __init s3c24xxfb_probe(struct
>  
>  	s3c2410fb_check_var(&fbinfo->var, fbinfo);
>  
> +	ret = s3c2410fb_cpufreq_register(info);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Failed to register cpufreq\n");
> +		goto free_video_memory;
> +	}
> +
>  	ret = register_framebuffer(fbinfo);
>  	if (ret < 0) {
>  		printk(KERN_ERR "Failed to register framebuffer device: %d\n",
>  			ret);
> -		goto free_video_memory;
> +		goto free_cpufreq;
>  	}
>  
>  	/* create device files */
> @@ -922,6 +982,8 @@ static int __init s3c24xxfb_probe(struct
>  
>  	return 0;
>  
> + free_cpufreq:
> +	s3c2410fb_cpufreq_deregister(info);
>  free_video_memory:
>  	s3c2410fb_unmap_video_memory(fbinfo);
>  release_clock:
> @@ -961,6 +1023,7 @@ static int s3c2410fb_remove(struct platf
>  	int irq;
>  
>  	unregister_framebuffer(fbinfo);
> +	s3c2410fb_cpufreq_deregister(info);
>  
>  	s3c2410fb_lcd_enable(info, 0);
>  	msleep(1);
> Index: b/drivers/video/s3c2410fb.h
> ===================================================================
> --- a/drivers/video/s3c2410fb.h	2009-02-02 11:29:48.488096579 +0000
> +++ b/drivers/video/s3c2410fb.h	2009-02-02 11:30:58.723594471 +0000
> @@ -29,8 +29,13 @@ struct s3c2410fb_info {
>  	enum s3c_drv_type	drv_type;
>  	struct s3c2410fb_hw	regs;
>  
> +	unsigned long		clk_rate;
>  	unsigned int		palette_ready;
>  
> +#ifdef CONFIG_CPU_FREQ
> +	struct notifier_block	freq_transition;
> +#endif
> +
>  	/* keep these registers in case we need to re-write palette */
>  	u32			palette_buffer[256];
>  	u32			pseudo_pal[16];
> 

afacit freq_transition.priority never gets initialised.

afacit this is a cpufreq bug, as cpufreq_register_notifier() has no
interface to set the notifier_block.priority and probably it's not the
role of cpufreq clients to be diddling the notifier priority.

I'd expect this problem to trigger kmemcheck warnings, at least.


------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT 
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp as they present alongside digital heavyweights like Barbarian 
Group, R/GA, & Big Spaceship. http://p.sf.net/sfu/creativitycat-com 
