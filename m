From: Jingoo Han <jg1.han@samsung.com>
Date: Mon, 14 Apr 2014 08:49:15 +0000
Subject: Re: [patch] video: mmpfb: cleanup some static checker warnings in probe()
Message-Id: <000b01cf57be$6a22ebf0$3e68c3d0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140414080929.GB13372@mwanda>
In-Reply-To: <20140414080929.GB13372@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Monday, April 14, 2014 5:09 PM, Dan Carpenter wrote:
> 
> Sparse complains about using zero instead of NULL for pointers.
> Probably, if we enabled the warning, then GCC would complain about the
> unused initializers.  I've just removed them.
> 
> Smatch complains that we first check if "fbi" is NULL and then
> dereference it in the error handling.  It turns out that "fbi" can't be
> NULL so I've removed the check.

Yes, right.
'fbi' cannot be NULL, because 'info->par' is set as below.

./drivers/video/fbsysfs.c
struct fb_info *framebuffer_alloc(size_t size, struct device *dev)
{
.....
        info = (struct fb_info *) p;

        if (size)
                info->par = p + fb_info_size;

> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Reviewed-by: Jingoo Han <jg1.han@samsung.com>

Best regards,
Jingoo Han

> 
> diff --git a/drivers/video/fbdev/mmp/fb/mmpfb.c b/drivers/video/fbdev/mmp/fb/mmpfb.c
> index 7ab31eb..910fcc6 100644
> --- a/drivers/video/fbdev/mmp/fb/mmpfb.c
> +++ b/drivers/video/fbdev/mmp/fb/mmpfb.c
> @@ -554,8 +554,8 @@ static void fb_info_clear(struct fb_info *info)
>  static int mmpfb_probe(struct platform_device *pdev)
>  {
>  	struct mmp_buffer_driver_mach_info *mi;
> -	struct fb_info *info = 0;
> -	struct mmpfb_info *fbi = 0;
> +	struct fb_info *info;
> +	struct mmpfb_info *fbi;
>  	int ret, modes_num;
> 
>  	mi = pdev->dev.platform_data;
> @@ -569,10 +569,6 @@ static int mmpfb_probe(struct platform_device *pdev)
>  	if (info = NULL)
>  		return -ENOMEM;
>  	fbi = info->par;
> -	if (!fbi) {
> -		ret = -EINVAL;
> -		goto failed;
> -	}
> 
>  	/* init fb */
>  	fbi->fb_info = info;
> @@ -667,7 +663,6 @@ failed_free_buff:
>  		fbi->fb_start_dma);
>  failed_destroy_mutex:
>  	mutex_destroy(&fbi->access_ok);
> -failed:
>  	dev_err(fbi->dev, "mmp-fb: frame buffer device init failed\n");
> 
>  	framebuffer_release(info);

