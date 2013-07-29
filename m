From: Jingoo Han <jg1.han@samsung.com>
Date: Mon, 29 Jul 2013 00:52:32 +0000
Subject: Re: [PATCH] video: remove unused variable dev
Message-Id: <009601ce8bf5$e88bfda0$b9a3f8e0$@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1374919513-15356-1-git-send-email-wangkefeng.wang@huawei.com>
In-Reply-To: <1374919513-15356-1-git-send-email-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Kefeng Wang' <wangkefeng.wang@huawei.com>, 'Tomi Valkeinen' <tomi.valkeinen@ti.com>
Cc: 'Jean-Christophe Plagniol-Villard' <plagnioj@jcrosoft.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, guohanjun@huawei.com, 'Luis Henriques' <luis.henriques@canonical.com>, Jingoo Han <jg1.han@samsung.com>

On Saturday, July 27, 2013 7:05 PM, Kefeng Wang wrote:
> 
> Due to commit: e21d2170f [video: remove unnecessary platform_set_drvdata()],
> variable dev is unused, so remove it.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  drivers/video/vga16fb.c | 1 -
>  1 file changed, 1 deletion(-)

CC'ed Luis Henriques.


Hi Kefeng Wang,

The same patch was submitted by Luis Henriques 2 weeks ago.
Also, the patch was already applied by Tomi Valkeinen.

Best regards,
Jingoo Han

> 
> diff --git a/drivers/video/vga16fb.c b/drivers/video/vga16fb.c
> index 830ded4..2827333 100644
> --- a/drivers/video/vga16fb.c
> +++ b/drivers/video/vga16fb.c
> @@ -1265,7 +1265,6 @@ static void vga16fb_imageblit(struct fb_info *info, const struct fb_image *image
> 
>  static void vga16fb_destroy(struct fb_info *info)
>  {
> -	struct platform_device *dev = container_of(info->device, struct platform_device, dev);
>  	iounmap(info->screen_base);
>  	fb_dealloc_cmap(&info->cmap);
>  	/* XXX unshare VGA regions */
> --
> 1.8.2.2


