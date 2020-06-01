From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 01 Jun 2020 13:25:09 +0000
Subject: Re: [PATCH v1] video: fbdev: sm712fb: fix an issue about iounmap for a wrong address
Message-Id: <cdc18f39-b4e2-a8cb-6816-4de3888aeb48@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200422160730eucas1p179849adadf1cb41dfe54d7e5f8b61c8e@eucas1p1.samsung.com>
 <20200422160719.27763-1-zhengdejin5@gmail.com>
In-Reply-To: <20200422160719.27763-1-zhengdejin5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dejin Zheng <zhengdejin5@gmail.com>
Cc: linux-fbdev@vger.kernel.org, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Andy Shevchenko <andy.shevchenko@gmail.com>, sudipm.mukherjee@gmail.com


On 4/22/20 6:07 PM, Dejin Zheng wrote:
> the sfb->fb->screen_base is not save the value get by iounmap() when
> the chip id is 0x720. so iounmap() for address sfb->fb->screen_base
> is not right.
> 
> Fixes: 1461d6672864854 ("staging: sm7xxfb: merge sm712fb with fbdev")
> CC: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>

Applied to drm-misc-next tree (patch should show up in v5.9), thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/video/fbdev/sm712fb.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/video/fbdev/sm712fb.c b/drivers/video/fbdev/sm712fb.c
> index 6a1b4a853d9e..8cd655d6d628 100644
> --- a/drivers/video/fbdev/sm712fb.c
> +++ b/drivers/video/fbdev/sm712fb.c
> @@ -1429,6 +1429,8 @@ static int smtc_map_smem(struct smtcfb_info *sfb,
>  static void smtc_unmap_smem(struct smtcfb_info *sfb)
>  {
>  	if (sfb && sfb->fb->screen_base) {
> +		if (sfb->chip_id = 0x720)
> +			sfb->fb->screen_base -= 0x00200000;
>  		iounmap(sfb->fb->screen_base);
>  		sfb->fb->screen_base = NULL;
>  	}
> 
