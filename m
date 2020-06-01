From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 01 Jun 2020 13:25:25 +0000
Subject: Re: [PATCH] video: fbdev: pxafb: Use correct return value for pxafb_probe()
Message-Id: <be2f65ba-e26c-fe3f-82d9-d9532db496eb@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200525071149eucas1p271b0c64a9d44429978e2099257681b70@eucas1p2.samsung.com>
 <1590390705-22898-1-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1590390705-22898-1-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: linux-fbdev@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org


On 5/25/20 9:11 AM, Tiezhu Yang wrote:
> When call function devm_platform_ioremap_resource(), we should use IS_ERR()
> to check the return value and return PTR_ERR() if failed.
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Applied to drm-misc-next tree (patch should show up in v5.9), thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/video/fbdev/pxafb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/pxafb.c b/drivers/video/fbdev/pxafb.c
> index 00b96a7..423331c 100644
> --- a/drivers/video/fbdev/pxafb.c
> +++ b/drivers/video/fbdev/pxafb.c
> @@ -2305,7 +2305,7 @@ static int pxafb_probe(struct platform_device *dev)
>  	fbi->mmio_base = devm_platform_ioremap_resource(dev, 0);
>  	if (IS_ERR(fbi->mmio_base)) {
>  		dev_err(&dev->dev, "failed to get I/O memory\n");
> -		ret = -EBUSY;
> +		ret = PTR_ERR(fbi->mmio_base);
>  		goto failed;
>  	}
>  
> 
