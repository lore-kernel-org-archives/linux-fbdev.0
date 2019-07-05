From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 05 Jul 2019 15:26:48 +0000
Subject: Re: [PATCH -next] video: fbdev: imxfb: fix a typo in imxfb_probe()
Message-Id: <2b579d3f-a441-39c9-fdb7-6089edea3cb1@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190704094615epcas2p30e66b919c33afcfa233c9218eae892b7@epcas2p3.samsung.com>
 <20190704095225.143177-1-weiyongjun1@huawei.com>
In-Reply-To: <20190704095225.143177-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wei Yongjun <weiyongjun1@huawei.com>
Cc: linux-fbdev@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, kernel-janitors@vger.kernel.org, dri-devel@lists.freedesktop.org, NXP Linux Team <linux-imx@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, linux-arm-kernel@lists.infradead.org


On 7/4/19 11:52 AM, Wei Yongjun wrote:
> Fix the return value check which testing the wrong variable
> in imxfb_probe().

I added following comment while merging the patch:

b.zolnierkie: please note that ->screen_base and ->screen_buffer
are equivalent (they are part of unnamed union in struct fb_info)

> Fixes: 739a6439c2bf ("video: fbdev: imxfb: fix sparse warnings about using incorrect types")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Patch queued for v5.3, thanks.

> ---
>  drivers/video/fbdev/imxfb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
> index 8d1053e9ef9f..b3286d1fa543 100644
> --- a/drivers/video/fbdev/imxfb.c
> +++ b/drivers/video/fbdev/imxfb.c
> @@ -976,7 +976,7 @@ static int imxfb_probe(struct platform_device *pdev)
>  	fbi->map_size = PAGE_ALIGN(info->fix.smem_len);
>  	info->screen_buffer = dma_alloc_wc(&pdev->dev, fbi->map_size,
>  					   &fbi->map_dma, GFP_KERNEL);
> -	if (!info->screen_base) {
> +	if (!info->screen_buffer) {
>  		dev_err(&pdev->dev, "Failed to allocate video RAM: %d\n", ret);
>  		ret = -ENOMEM;
>  		goto failed_map;

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
