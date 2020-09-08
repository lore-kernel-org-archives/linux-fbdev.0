From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 08 Sep 2020 11:37:29 +0000
Subject: Re: [PATCH] video: fbdev: replace spurious snprintf() with sprintf()
Message-Id: <8a486558-08cb-b8fa-5a33-77d73482b1ea@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200824174423eucas1p25ee511479ffce613260a49d415e5733f@eucas1p2.samsung.com>
 <20200824174407.429817-1-alex.dewar90@gmail.com>
In-Reply-To: <20200824174407.429817-1-alex.dewar90@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alex Dewar <alex.dewar90@gmail.com>
Cc: linux-fbdev@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Jani Nikula <jani.nikula@intel.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org


On 8/24/20 7:44 PM, Alex Dewar wrote:
> par->vgapass is a u8, so if we are assuming that buf is at least
> PAGE_SIZE then the extra checking is pointless.
> 
> Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>

Applied to drm-misc-next tree, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/video/fbdev/sstfb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/sstfb.c b/drivers/video/fbdev/sstfb.c
> index afe6d1b7c3a0..c05cdabeb11c 100644
> --- a/drivers/video/fbdev/sstfb.c
> +++ b/drivers/video/fbdev/sstfb.c
> @@ -733,7 +733,7 @@ static ssize_t show_vgapass(struct device *device, struct device_attribute *attr
>  {
>  	struct fb_info *info = dev_get_drvdata(device);
>  	struct sstfb_par *par = info->par;
> -	return snprintf(buf, PAGE_SIZE, "%d\n", par->vgapass);
> +	return sprintf(buf, "%d\n", par->vgapass);
>  }
>  
>  static struct device_attribute device_attrs[] = {
> 
