From: Timur Tabi <timur@tabi.org>
Date: Tue, 10 Nov 2015 03:13:16 +0000
Subject: Re: [PATCH] video: fbdev: fsl: Split DIU initialization entry
Message-Id: <564160CC.7050900@tabi.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1444709355-8905-1-git-send-email-dongsheng.wang@freescale.com>
In-Reply-To: <1444709355-8905-1-git-send-email-dongsheng.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Dongsheng Wang wrote:
> From: Wang Dongsheng <dongsheng.wang@freescale.com>
>
> Split diu initialize from fsl_diu_init into diu probe function, because
> it should be initialized when get the diu device tree node, not always
> do initialization.
>
> Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>

I only have time now for a quick review, ...

>
> diff --git a/drivers/video/fbdev/fsl-diu-fb.c b/drivers/video/fbdev/fsl-diu-fb.c
> index b335c1a..1969863 100644
> --- a/drivers/video/fbdev/fsl-diu-fb.c
> +++ b/drivers/video/fbdev/fsl-diu-fb.c
> @@ -1687,6 +1687,104 @@ static ssize_t show_monitor(struct device *device,
>   	return 0;
>   }
>
> +#ifndef MODULE
> +static int __init fsl_diu_setup(char *options)
> +{
> +	char *opt;
> +	unsigned long val;
> +
> +	if (!options || !*options)
> +		return 0;
> +
> +	while ((opt = strsep(&options, ",")) != NULL) {
> +		if (!*opt)
> +			continue;
> +		if (!strncmp(opt, "monitor=", 8)) {
> +			monitor_port = fsl_diu_name_to_port(opt + 8);
> +		} else if (!strncmp(opt, "bpp=", 4)) {
> +			if (!kstrtoul(opt + 4, 10, &val))
> +				default_bpp = val;
> +		} else {
> +			fb_mode = opt;
> +		}
> +	}
> +
> +	return 0;
> +}
> +#endif
> +
> +static int fsl_diu_perpare(void)

prepare, not perpare.

> +{
> +#ifdef CONFIG_NOT_COHERENT_CACHE
> +	struct device_node *np;
> +	const u32 *prop;
> +#endif
> +#ifndef MODULE
> +	char *option;
> +#endif
> +
> +	if (!diu_ops.set_pixel_clock)
> +		return -ENODEV;
> +
> +#ifndef MODULE
> +	/*
> +	 * For kernel boot options (in 'video=xxxfb:<options>' format)
> +	 */
> +	if (fb_get_options("fslfb", &option))
> +		return -ENODEV;
> +	fsl_diu_setup(option);
> +#else
> +	monitor_port = fsl_diu_name_to_port(monitor_string);
> +#endif
> +	pr_info("Freescale Display Interface Unit (DIU) framebuffer driver\n");
> +
> +#ifdef CONFIG_NOT_COHERENT_CACHE
> +	np = of_find_node_by_type(NULL, "cpu");
> +	if (!np) {
> +		pr_err("fsl-diu-fb: can't find 'cpu' device node\n");
> +		return -ENODEV;
> +	}
> +
> +	prop = of_get_property(np, "d-cache-size", NULL);
> +	if (!prop) {
> +		pr_err("fsl-diu-fb: missing 'd-cache-size'\n");
> +		of_node_put(np);
> +		return -ENODEV;
> +	}
> +
> +	/*
> +	 * Freescale PLRU requires 13/8 times the cache size to do a proper
> +	 * displacement flush
> +	 */
> +	coherence_data_size = be32_to_cpup(prop) * 13;
> +	coherence_data_size /= 8;
> +
> +	pr_debug("fsl-diu-fb: coherence data size is %zu bytes\n",
> +		 coherence_data_size);
> +
> +	prop = of_get_property(np, "d-cache-line-size", NULL);
> +	if (!prop) {
> +		pr_err("fsl-diu-fb: missing 'd-cache-line-size'\n");
> +		of_node_put(np);
> +		return -ENODEV;
> +	}
> +	d_cache_line_size = be32_to_cpup(prop);
> +
> +	pr_debug("fsl-diu-fb: cache lines size is %u bytes\n",
> +		 d_cache_line_size);
> +
> +	of_node_put(np);
> +	coherence_data = vmalloc(coherence_data_size);
> +	if (!coherence_data) {
> +		pr_err("fsl-diu-fb: could not allocate coherence data\n");
> +		pr_err("coherence_data_size=%zu)\n", coherence_data_size);
> +		return -ENOMEM;
> +	}
> +
> +#endif
> +	return 0;
> +}

Split this function into two functions, one for coherent cache and one 
for non-coherent cache.  And then in fsl_diu_probe, use the compatible 
property to differentiate between then, instead of using "#ifdef 
CONFIG_NOT_COHERENT_CACHE".  We want to eliminate that #ifdef and just 
probe on the right compatible property.

> +
>   static int fsl_diu_probe(struct platform_device *pdev)
>   {
>   	struct device_node *np = pdev->dev.of_node;
> @@ -1697,10 +1795,16 @@ static int fsl_diu_probe(struct platform_device *pdev)
>   	unsigned int i;
>   	int ret;
>
> +	ret = fsl_diu_perpare();
> +	if (ret)
> +		goto out_diu_perpare;
> +
>   	data = dmam_alloc_coherent(&pdev->dev, sizeof(struct fsl_diu_data),
>   				   &dma_addr, GFP_DMA | __GFP_ZERO);

If you call dmam_alloc_cohernet() first, before you call 
fsl_diu_prepare(), then you won't need out_diu_prepare.

> -	if (!data)
> -		return -ENOMEM;
> +	if (!data) {
> +		ret = -ENOMEM;
> +		goto out_diu_perpare;
> +	}
>   	data->dma_addr = dma_addr;
>
>   	/*
> @@ -1826,6 +1930,11 @@ error:
>
>   	iounmap(data->diu_reg);
>
> +out_diu_perpare:
> +#if defined(CONFIG_NOT_COHERENT_CACHE)
> +	if (coherence_data)
> +		vfree(coherence_data);
> +#endif



>   	return ret;
>   }
>
> @@ -1844,34 +1953,12 @@ static int fsl_diu_remove(struct platform_device *pdev)
>
>   	iounmap(data->diu_reg);
>
> +#if defined(CONFIG_NOT_COHERENT_CACHE)
> +	vfree(coherence_data);
> +#endif
>   	return 0;
>   }
>
> -#ifndef MODULE
> -static int __init fsl_diu_setup(char *options)
> -{
> -	char *opt;
> -	unsigned long val;
> -
> -	if (!options || !*options)
> -		return 0;
> -
> -	while ((opt = strsep(&options, ",")) != NULL) {
> -		if (!*opt)
> -			continue;
> -		if (!strncmp(opt, "monitor=", 8)) {
> -			monitor_port = fsl_diu_name_to_port(opt + 8);
> -		} else if (!strncmp(opt, "bpp=", 4)) {
> -			if (!kstrtoul(opt + 4, 10, &val))
> -				default_bpp = val;
> -		} else
> -			fb_mode = opt;
> -	}
> -
> -	return 0;
> -}
> -#endif
> -
>   static struct of_device_id fsl_diu_match[] = {
>   #ifdef CONFIG_PPC_MPC512x
>   	{
> @@ -1898,88 +1985,12 @@ static struct platform_driver fsl_diu_driver = {
>
>   static int __init fsl_diu_init(void)
>   {
> -#ifdef CONFIG_NOT_COHERENT_CACHE
> -	struct device_node *np;
> -	const u32 *prop;
> -#endif
> -	int ret;
> -#ifndef MODULE
> -	char *option;
> -
> -	/*
> -	 * For kernel boot options (in 'video=xxxfb:<options>' format)
> -	 */
> -	if (fb_get_options("fslfb", &option))
> -		return -ENODEV;
> -	fsl_diu_setup(option);
> -#else
> -	monitor_port = fsl_diu_name_to_port(monitor_string);
> -#endif
> -	pr_info("Freescale Display Interface Unit (DIU) framebuffer driver\n");
> -
> -#ifdef CONFIG_NOT_COHERENT_CACHE
> -	np = of_find_node_by_type(NULL, "cpu");
> -	if (!np) {
> -		pr_err("fsl-diu-fb: can't find 'cpu' device node\n");
> -		return -ENODEV;
> -	}
> -
> -	prop = of_get_property(np, "d-cache-size", NULL);
> -	if (prop = NULL) {
> -		pr_err("fsl-diu-fb: missing 'd-cache-size' property' "
> -		       "in 'cpu' node\n");
> -		of_node_put(np);
> -		return -ENODEV;
> -	}
> -
> -	/*
> -	 * Freescale PLRU requires 13/8 times the cache size to do a proper
> -	 * displacement flush
> -	 */
> -	coherence_data_size = be32_to_cpup(prop) * 13;
> -	coherence_data_size /= 8;
> -
> -	pr_debug("fsl-diu-fb: coherence data size is %zu bytes\n",
> -		 coherence_data_size);
> -
> -	prop = of_get_property(np, "d-cache-line-size", NULL);
> -	if (prop = NULL) {
> -		pr_err("fsl-diu-fb: missing 'd-cache-line-size' property' "
> -		       "in 'cpu' node\n");
> -		of_node_put(np);
> -		return -ENODEV;
> -	}
> -	d_cache_line_size = be32_to_cpup(prop);
> -
> -	pr_debug("fsl-diu-fb: cache lines size is %u bytes\n",
> -		 d_cache_line_size);
> -
> -	of_node_put(np);
> -	coherence_data = vmalloc(coherence_data_size);
> -	if (!coherence_data) {
> -		pr_err("fsl-diu-fb: could not allocate coherence data "
> -		       "(size=%zu)\n", coherence_data_size);
> -		return -ENOMEM;
> -	}
> -
> -#endif
> -
> -	ret = platform_driver_register(&fsl_diu_driver);
> -	if (ret) {
> -		pr_err("fsl-diu-fb: failed to register platform driver\n");
> -#if defined(CONFIG_NOT_COHERENT_CACHE)
> -		vfree(coherence_data);
> -#endif
> -	}
> -	return ret;
> +	return platform_driver_register(&fsl_diu_driver);
>   }
>
>   static void __exit fsl_diu_exit(void)
>   {
>   	platform_driver_unregister(&fsl_diu_driver);
> -#if defined(CONFIG_NOT_COHERENT_CACHE)
> -	vfree(coherence_data);
> -#endif
>   }
>
>   module_init(fsl_diu_init);
>

