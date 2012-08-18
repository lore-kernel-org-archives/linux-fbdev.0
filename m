From: Anatolij Gustschin <agust@denx.de>
Date: Sat, 18 Aug 2012 18:35:07 +0000
Subject: Re: [patch] video: mb862xxfb: prevent divide by zero bug
Message-Id: <20120818203507.558ccf09@wker>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20120818155541.GB22424@elgon.mountain>
In-Reply-To: <20120818155541.GB22424-mgFCXtclrQlZLf2FXnZxJA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Florian Tobias Schandinat <FlorianSchandinat-Mmb7MZpHnFY@public.gmane.org>, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, David Brown <davidb-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>

On Sat, 18 Aug 2012 18:55:41 +0300
Dan Carpenter <dan.carpenter@oracle.com> wrote:

> Do a sanity check on these before using them as divisors.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Acked-by: Anatolij Gustschin <agust@denx.de>

> diff --git a/drivers/video/mb862xx/mb862xxfbdrv.c b/drivers/video/mb862xx/mb862xxfbdrv.c
> index 00ce1f3..57d940b 100644
> --- a/drivers/video/mb862xx/mb862xxfbdrv.c
> +++ b/drivers/video/mb862xx/mb862xxfbdrv.c
> @@ -328,6 +328,8 @@ static int mb862xxfb_ioctl(struct fb_info *fbi, unsigned int cmd,
>  	case MB862XX_L1_SET_CFG:
>  		if (copy_from_user(l1_cfg, argp, sizeof(*l1_cfg)))
>  			return -EFAULT;
> +		if (l1_cfg->dh = 0 || l1_cfg->dw = 0)
> +			return -EINVAL;
>  		if ((l1_cfg->sw >= l1_cfg->dw) && (l1_cfg->sh >= l1_cfg->dh)) {
>  			/* downscaling */
>  			outreg(cap, GC_CAP_CSC,

Thanks,

Anatolij
