From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Thu, 23 Aug 2012 20:30:43 +0000
Subject: Re: [patch] video: mb862xxfb: prevent divide by zero bug
Message-Id: <503692F3.40402@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20120818155541.GB22424@elgon.mountain>
In-Reply-To: <20120818155541.GB22424@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 08/18/2012 03:55 PM, Dan Carpenter wrote:
> Do a sanity check on these before using them as divisors.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied.


Thanks,

Florian Tobias Schandinat

> 
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
> 

