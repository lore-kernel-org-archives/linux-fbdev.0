From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 10 Jul 2020 14:23:45 +0000
Subject: Re: [PATCH] video: fbdev: savage: fix memory leak on error handling path in probe
Message-Id: <8ea4d604-3d42-7d73-f19a-5699635c362b@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200619162158eucas1p14eb0836fe3079ebc2dedec4b7a821a85@eucas1p1.samsung.com>
 <20200619162136.9010-1-novikov@ispras.ru>
In-Reply-To: <20200619162136.9010-1-novikov@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Evgeny Novikov <novikov@ispras.ru>
Cc: ldv-project@linuxtesting.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org


On 6/19/20 6:21 PM, Evgeny Novikov wrote:
> savagefb_probe() calls savage_init_fb_info() that can successfully
> allocate memory for info->pixmap.addr but then fail when
> fb_alloc_cmap() fails. savagefb_probe() goes to label failed_init and
> does not free allocated memory. It is not valid to go to label
> failed_mmio since savage_init_fb_info() can fail during memory
> allocation as well. So, the patch free allocated memory on the error
> handling path in savage_init_fb_info() itself.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Evgeny Novikov <novikov@ispras.ru>

Applied to drm-misc-next tree, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/video/fbdev/savage/savagefb_driver.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/video/fbdev/savage/savagefb_driver.c b/drivers/video/fbdev/savage/savagefb_driver.c
> index 3c8ae87f0ea7..3fd87aeb6c79 100644
> --- a/drivers/video/fbdev/savage/savagefb_driver.c
> +++ b/drivers/video/fbdev/savage/savagefb_driver.c
> @@ -2157,6 +2157,8 @@ static int savage_init_fb_info(struct fb_info *info, struct pci_dev *dev,
>  			info->flags |= FBINFO_HWACCEL_COPYAREA |
>  				       FBINFO_HWACCEL_FILLRECT |
>  				       FBINFO_HWACCEL_IMAGEBLIT;
> +		else
> +			kfree(info->pixmap.addr);
>  	}
>  #endif
>  	return err;
> 
