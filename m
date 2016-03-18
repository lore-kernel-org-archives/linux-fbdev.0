From: Rob Herring <robh@kernel.org>
Date: Fri, 18 Mar 2016 16:23:26 +0000
Subject: Re: [PATCH v2 1/2] video: goldfishfb: add devicetree bindings
Message-Id: <20160318162326.GA10559@rob-hp-laptop>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160310153845.8996.17736.stgit@localhost.localdomain>
In-Reply-To: <20160310153845.8996.17736.stgit-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alan <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org, plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org

On Thu, Mar 10, 2016 at 03:39:00PM +0000, Alan wrote:
> From: Greg Hackmann <ghackmann@google.com>
> 
> Add device tree bindings to the Goldfish frame buffer interface.
> 
> Signed-off-by: Greg Hackmann <ghackmann@google.com>
> Signed-off-by: Jin Qian <jinqian@android.com>
> Signed-off-by: Alan Cox <alan@linux.intel.com>
> ---

[...]

> diff --git a/drivers/video/fbdev/goldfishfb.c b/drivers/video/fbdev/goldfishfb.c
> index 7f6c9e6..f0e651b 100644
> --- a/drivers/video/fbdev/goldfishfb.c
> +++ b/drivers/video/fbdev/goldfishfb.c
> @@ -304,12 +304,19 @@ static int goldfish_fb_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static const struct of_device_id goldfish_fb_of_match[] = {
> +	{ .compatible = "google,goldfish-fb", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, goldfish_fb_of_match);
>  
>  static struct platform_driver goldfish_fb_driver = {
>  	.probe		= goldfish_fb_probe,
>  	.remove		= goldfish_fb_remove,
>  	.driver = {
> -		.name = "goldfish_fb"
> +		.name = "goldfish_fb",
> +		.owner = THIS_MODULE,

This can be dropped. Otherwise,

Acked-by: Rob Herring <robh@kernel.org>

> +		.of_match_table = goldfish_fb_of_match,
>  	}
>  };
>  
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
