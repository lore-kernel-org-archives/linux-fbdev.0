From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 03 Jan 2020 12:13:12 +0000
Subject: Re: [PATCH -next] fbdev: da8xx-fb: use devm_platform_ioremap_resource() to simplify code
Message-Id: <3c33d508-9295-1d3a-6f39-43197ad1fccf@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190904115137epcas2p49e26fe2b912c423caa61e97887849c15@epcas2p4.samsung.com>
 <20190904115028.25392-1-yuehaibing@huawei.com>
In-Reply-To: <20190904115028.25392-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: YueHaibing <yuehaibing@huawei.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, rfontana@redhat.com, mcgrof@kernel.org, tglx@linutronix.de, allison@lohutok.net


On 9/4/19 1:50 PM, YueHaibing wrote:
> Use devm_platform_ioremap_resource() to simplify the code a bit.
> This is detected by coccinelle.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

This has been already fixed by:

commit c957c88f7be109a14294289f013b03bbe94e8af5
Author:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
AuthorDate: Mon Jul 22 15:44:21 2019 +0200
Commit:     Sekhar Nori <nsekhar@ti.com>
CommitDate: Mon Aug 26 17:53:59 2019 +0530

    fbdev: da8xx-fb: use devm_platform_ioremap_resource()
    
    Shrink the code a bit by using the new helper wrapping the calls to
    platform_get_resource() and devm_ioremap_resource() together.
    
    Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
    Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
    Signed-off-by: Sekhar Nori <nsekhar@ti.com>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/video/fbdev/da8xx-fb.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/video/fbdev/da8xx-fb.c b/drivers/video/fbdev/da8xx-fb.c
> index b1cf248..57518d7 100644
> --- a/drivers/video/fbdev/da8xx-fb.c
> +++ b/drivers/video/fbdev/da8xx-fb.c
> @@ -1328,7 +1328,6 @@ static int fb_probe(struct platform_device *device)
>  {
>  	struct da8xx_lcdc_platform_data *fb_pdata >  						dev_get_platdata(&device->dev);
> -	struct resource *lcdc_regs;
>  	struct lcd_ctrl_config *lcd_cfg;
>  	struct fb_videomode *lcdc_info;
>  	struct fb_info *da8xx_fb_info;
> @@ -1346,8 +1345,7 @@ static int fb_probe(struct platform_device *device)
>  	if (lcdc_info = NULL)
>  		return -ENODEV;
>  
> -	lcdc_regs = platform_get_resource(device, IORESOURCE_MEM, 0);
> -	da8xx_fb_reg_base = devm_ioremap_resource(&device->dev, lcdc_regs);
> +	da8xx_fb_reg_base = devm_platform_ioremap_resource(device, 0);
>  	if (IS_ERR(da8xx_fb_reg_base))
>  		return PTR_ERR(da8xx_fb_reg_base);
> 
