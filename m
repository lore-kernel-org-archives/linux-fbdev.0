From: Jingoo Han <jg1.han@samsung.com>
Date: Sat, 11 May 2013 05:37:22 +0000
Subject: Re: [RFC 33/42] drivers/video/omap2: don't check resource with devm_ioremap_resource
Message-Id: <002e01ce4e09$9c849590$d58dc0b0$@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1368173847-5661-1-git-send-email-wsa@the-dreams.de>
 <1368173847-5661-34-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1368173847-5661-34-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Wolfram Sang' <wsa@the-dreams.de>, linux-kernel@vger.kernel.org
Cc: 'Tomi Valkeinen' <tomi.valkeinen@ti.com>, 'Florian Tobias Schandinat' <FlorianSchandinat@gmx.de>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Friday, May 10, 2013 5:17 PM, Wolfram Sang wrote:
> 
> devm_ioremap_resource does sanity checks on the given resource. No need to
> duplicate this in the driver.
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

Reviewed-by: Jingoo Han <jg1.han@samsung.com>

Best regards,
Jingoo Han

> ---
>  drivers/video/omap2/vrfb.c |    5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/video/omap2/vrfb.c b/drivers/video/omap2/vrfb.c
> index 5261229..f346b02 100644
> --- a/drivers/video/omap2/vrfb.c
> +++ b/drivers/video/omap2/vrfb.c
> @@ -353,11 +353,6 @@ static int __init vrfb_probe(struct platform_device *pdev)
>  	/* first resource is the register res, the rest are vrfb contexts */
> 
>  	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!mem) {
> -		dev_err(&pdev->dev, "can't get vrfb base address\n");
> -		return -EINVAL;
> -	}
> -
>  	vrfb_base = devm_ioremap_resource(&pdev->dev, mem);
>  	if (IS_ERR(vrfb_base))
>  		return PTR_ERR(vrfb_base);
> --
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

