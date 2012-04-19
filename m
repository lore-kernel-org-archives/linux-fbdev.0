From: Shawn Guo <shawn.guo@linaro.org>
Date: Thu, 19 Apr 2012 14:41:23 +0000
Subject: Re: [PATCH] i.MX28: Shut down the LCD controller to avoid BootROM sampling bug
Message-Id: <20120419144119.GD22219@S2101-09.ap.freescale.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1334695011-8188-1-git-send-email-marex@denx.de>
 <1334767680-12688-1-git-send-email-marex@denx.de>
In-Reply-To: <1334767680-12688-1-git-send-email-marex@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Apr 18, 2012 at 06:48:00PM +0200, Marek Vasut wrote:
...
> +void mxsfb_shutdown(struct platform_device *pdev)

static?

Otherwise,

Acked-by: Shawn Guo <shawn.guo@linaro.org>

> +{
> +	struct fb_info *fb_info = platform_get_drvdata(pdev);
> +	struct mxsfb_info *host = to_imxfb_host(fb_info);
> +
> +	/*
> +	 * Force stop the LCD controller as keeping it running during reboot
> +	 * might interfere with the BootROM's boot mode pads sampling.
> +	 */
> +	writel(CTRL_RUN, host->base + LCDC_CTRL + REG_CLR);
> +}
> +
>  static struct platform_device_id mxsfb_devtype[] = {
>  	{
>  		.name = "imx23-fb",
> @@ -896,6 +908,7 @@ MODULE_DEVICE_TABLE(platform, mxsfb_devtype);
>  static struct platform_driver mxsfb_driver = {
>  	.probe = mxsfb_probe,
>  	.remove = __devexit_p(mxsfb_remove),
> +	.shutdown = mxsfb_shutdown,
>  	.id_table = mxsfb_devtype,
>  	.driver = {
>  		   .name = DRIVER_NAME,
> -- 
> 1.7.9.5
> 
