From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 15 Jan 2020 15:09:06 +0000
Subject: Re: [PATCH] video: fbdev: arcfb: add missed free_irq
Message-Id: <76ebce76-6f24-c4c4-f067-3989a2c41710@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20191116154430eucas1p21c738a988e3bc0c3544a388c71f4a75c@eucas1p2.samsung.com>
 <20191116154416.19390-1-hslester96@gmail.com>
In-Reply-To: <20191116154416.19390-1-hslester96@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chuhong Yuan <hslester96@gmail.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Jaya Kumar <jayalk@intworks.biz>


On 11/16/19 4:44 PM, Chuhong Yuan wrote:
> The driver forgets to free irq in remove which is requested in
> probe.
> Add the missed call to fix it.
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> ---
>  drivers/video/fbdev/arcfb.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/video/fbdev/arcfb.c b/drivers/video/fbdev/arcfb.c
> index a48741aab240..7aed01f001a4 100644
> --- a/drivers/video/fbdev/arcfb.c
> +++ b/drivers/video/fbdev/arcfb.c
> @@ -590,8 +590,11 @@ static int arcfb_probe(struct platform_device *dev)
>  static int arcfb_remove(struct platform_device *dev)
>  {
>  	struct fb_info *info = platform_get_drvdata(dev);
> +	struct arcfb_par *par = info->par;
>  
>  	if (info) {
> +		if (irq)
> +			free_irq(par->irq, info);
>  		unregister_framebuffer(info);

We cannot free IRQ while framebuffer is registered (as we can
deadlock in arcfb_ioctl()).

Also it seems that ordering in the probe function is wrong
(it should not request IRQ or initialize the hardware after
registering framebuffer).

>  		vfree((void __force *)info->screen_base);
>  		framebuffer_release(info);

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
