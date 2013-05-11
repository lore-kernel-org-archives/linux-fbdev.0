From: Jingoo Han <jg1.han@samsung.com>
Date: Sat, 11 May 2013 05:33:56 +0000
Subject: Re: [RFC 32/42] drivers/video: don't check resource with devm_ioremap_resource
Message-Id: <002c01ce4e09$218612b0$64923810$@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1368173847-5661-1-git-send-email-wsa@the-dreams.de>
 <1368173847-5661-33-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1368173847-5661-33-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Wolfram Sang' <wsa@the-dreams.de>, linux-kernel@vger.kernel.org
Cc: 'Florian Tobias Schandinat' <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org, 'Tomi Valkeinen' <tomi.valkeinen@ti.com>, 'Shawn Guo' <shawn.guo@freescale.com>, Fabio Estevam <fabio.estevam@freescale.com>

On Friday, May 10, 2013 5:17 PM, Wolfram Sang wrote:
> 
> devm_ioremap_resource does sanity checks on the given resource. No need to
> duplicate this in the driver.
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

CC'ed Tomi Valkeinen, Shawn Guo, Fabio Estevam


It looks good.
Reviewed-by: Jingoo Han <jg1.han@samsung.com>

Best regards,
Jingoo Han

> ---
>  drivers/video/mxsfb.c |    7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/video/mxsfb.c b/drivers/video/mxsfb.c
> index 1b2c26d..3dc3265 100644
> --- a/drivers/video/mxsfb.c
> +++ b/drivers/video/mxsfb.c
> @@ -883,12 +883,6 @@ static int mxsfb_probe(struct platform_device *pdev)
>  	if (of_id)
>  		pdev->id_entry = of_id->data;
> 
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!res) {
> -		dev_err(&pdev->dev, "Cannot get memory IO resource\n");
> -		return -ENODEV;
> -	}
> -
>  	fb_info = framebuffer_alloc(sizeof(struct mxsfb_info), &pdev->dev);
>  	if (!fb_info) {
>  		dev_err(&pdev->dev, "Failed to allocate fbdev\n");
> @@ -897,6 +891,7 @@ static int mxsfb_probe(struct platform_device *pdev)
> 
>  	host = to_imxfb_host(fb_info);
> 
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	host->base = devm_ioremap_resource(&pdev->dev, res);
>  	if (IS_ERR(host->base)) {
>  		dev_err(&pdev->dev, "ioremap failed\n");
> --
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

