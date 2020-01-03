From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 03 Jan 2020 12:34:41 +0000
Subject: Re: [PATCH] video: pxafb: Use devm_platform_ioremap_resource() in pxafb_probe()
Message-Id: <0d499b49-dc8c-de58-8268-36e3cced5ff0@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190919150135epcas3p2bf5ab33712e12edd90af2766eeaaccda@epcas3p2.samsung.com>
 <a1b804b1-43c2-327a-d6d1-df49aebec680@web.de>
In-Reply-To: <a1b804b1-43c2-327a-d6d1-df49aebec680@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Markus Elfring <Markus.Elfring@web.de>, Daniel Mack <daniel@zonque.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, YueHaibing <yuehaibing@huawei.com>
Cc: linux-fbdev@vger.kernel.org, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Himanshu Jha <himanshujha199640@gmail.com>


On 9/19/19 5:01 PM, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 19 Sep 2019 16:51:38 +0200
> 
> Simplify this function implementation by using a known wrapper function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Thanks, patch queued for v5.6 (also sorry for the delay).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/video/fbdev/pxafb.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/drivers/video/fbdev/pxafb.c b/drivers/video/fbdev/pxafb.c
> index f70c9f79622e..237f8f436fdb 100644
> --- a/drivers/video/fbdev/pxafb.c
> +++ b/drivers/video/fbdev/pxafb.c
> @@ -2237,7 +2237,6 @@ static int pxafb_probe(struct platform_device *dev)
>  {
>  	struct pxafb_info *fbi;
>  	struct pxafb_mach_info *inf, *pdata;
> -	struct resource *r;
>  	int i, irq, ret;
> 
>  	dev_dbg(&dev->dev, "pxafb_probe\n");
> @@ -2303,14 +2302,7 @@ static int pxafb_probe(struct platform_device *dev)
>  		fbi->lcd_supply = NULL;
>  	}
> 
> -	r = platform_get_resource(dev, IORESOURCE_MEM, 0);
> -	if (r = NULL) {
> -		dev_err(&dev->dev, "no I/O memory resource defined\n");
> -		ret = -ENODEV;
> -		goto failed;
> -	}
> -
> -	fbi->mmio_base = devm_ioremap_resource(&dev->dev, r);
> +	fbi->mmio_base = devm_platform_ioremap_resource(dev, 0);
>  	if (IS_ERR(fbi->mmio_base)) {
>  		dev_err(&dev->dev, "failed to get I/O memory\n");
>  		ret = -EBUSY;
> --
> 2.23.0
