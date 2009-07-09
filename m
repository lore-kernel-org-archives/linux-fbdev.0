From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH 3/4] [ARM] s3c-fb: Add support for display panning
Date: Thu, 9 Jul 2009 19:49:12 +0200
Message-ID: <20090709194912.5e3fcc8e.krzysztof.h1@poczta.fm>
References: <E4D3F24EA6C9E54F817833EAE0D912AC076E71C7EE@bssrvexch01.BS.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <E4D3F24EA6C9E54F817833EAE0D912AC076E71C7EE@bssrvexch01.BS.local>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: Pawel Osciak <p.osciak@samsung.com>
Cc: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, "adaplas@gmail.com" <adaplas@gmail.com>, "ben-linux@fluff.org" <ben-linux@fluff.org>, =?UTF-8?Q?=EB=B0=95=EA=B2=BD=EB=AF=BC?= <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>

On Thu, 09 Jul 2009 17:09:00 +0200
Pawel Osciak <p.osciak@samsung.com> wrote:

> Added support for panning the display in all directions.
> 
> 
> Reviewed-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: Kyungmin Park <kyungmin.park@samsung.com>
> Signed-off-by: Pawel Osciak <p.osciak@samsung.com>
> 
> 
> 
> diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
> index ff0b1a3..77b77a2 100644
> --- a/drivers/video/s3c-fb.c
> +++ b/drivers/video/s3c-fb.c
> @@ -294,6 +294,8 @@ static int s3c_fb_set_par(struct fb_info *info)
>  	}
>  
>  	info->fix.line_length = (var->xres_virtual * var->bits_per_pixel) / 8;
> +	info->fix.xpanstep = info->var.xres_virtual > info->var.xres ? 1 : 0;
> +	info->fix.ypanstep = info->var.yres_virtual > info->var.yres ? 1 : 0;
>  

These two lines are not need. If the xres_virtual > xres  there is no 
panning possible (the same is true for yres and yres_virtual).

>  	/* disable the window whilst we update it */
>  	writel(0, regs + WINCON(win_no));
> @@ -640,6 +642,38 @@ static int s3c_fb_blank(int blank_mode, struct fb_info *info)
>  	return 0;
>  }
>  
> +/**
> + * s3c_fb_pan_display() - Pan the display.
> + *
> + * Note, that the offsets can be written to the device at any time, as their
> + * values are latched at each vsync automatically. This also means that only
> + * the last call to this function will have any effect on next vsync, but
> + * there is no need to sleep waiting for it to prevent tearing.
> + *
> + * @var: The screen information to verify.
> + * @info: The framebuffer device.
> + */
> +static int s3c_fb_pan_display(struct fb_var_screeninfo *var,
> +			      struct fb_info *info)
> +{
> +	struct s3c_fb_win *win	= info->par;
> +	struct s3c_fb *sfb	= win->parent;
> +	unsigned int start_byte_offset, end_byte_offset;
> +
> +	/* Offset in bytes to the start of the displayed area */
> +	start_byte_offset = var->yoffset * info->fix.line_length
> +			    + var->xoffset * (info->var.bits_per_pixel) / 8;
> +	writel(info->fix.smem_start + start_byte_offset,
> +	       sfb->regs + VIDW_BUF_START(win->index));
> +

Check out carefully what units are used for VIDW_BUF_START (pixels, bytes, words, 
dwords). This x panning may not work on all depths supported by the driver
(18-bit, 19-bit, 1-bit, etc). Do you really want panning in the x direction?
Please test it in all depths.

Regards,
Krzysztof
 


----------------------------------------------------------------------
Rowerem do pracy? Czemu nie!
Kliknij >>> http://link.interia.pl/f2256


-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
