From: Jingoo Han <jg1.han@samsung.com>
Date: Wed, 31 Jul 2013 09:02:42 +0000
Subject: Re: [patch] vga16fb: remove an unused variable
Message-Id: <003301ce8dcc$b718be60$254a3b20$@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20130731085414.GC8210@elgon.mountain>
In-Reply-To: <20130731085414.GC8210@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Wednesday, July 31, 2013 5:54 PM, Dan Carpenter wrote:
> 
> Commit e21d2170f3 "video: remove unnecessary platform_set_drvdata()"
> introduces an unused variable compile warning.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Hi Dan Carpenter,

The same patch was submitted by Luis Henriques 2 weeks ago. :)
Also, the patch was already applied by Tomi Valkeinen.
It will be merged to 3.11-rc4.
Thank you for caring it.

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

