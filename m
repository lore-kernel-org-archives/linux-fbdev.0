From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Thu, 10 May 2012 00:12:33 +0000
Subject: Re: [PATCH] video: mb862xxfbdrv.c: local functions should not be exposed globally
Message-Id: <4FAB07F1.4010900@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201205021737.35719.hartleys@visionengravers.com>
In-Reply-To: <201205021737.35719.hartleys@visionengravers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: H Hartley Sweeten <hartleys@visionengravers.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-fbdev@vger.kernel.org, agust@denx.de

On 05/03/2012 12:37 AM, H Hartley Sweeten wrote:
> Functions not referenced outside of a source file should be marked
> static to prevent them from being exposed globally.
> 
> Quiets the sparse warnings:
> 
> warning: symbol 'mb862xx_intr' was not declared. Should it be static?
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
> Cc: Anatolij Gustschin <agust@denx.de>

Applied.


Thanks,

Florian Tobias Schandinat

> 
> ---
> 
> diff --git a/drivers/video/mb862xx/mb862xxfbdrv.c b/drivers/video/mb862xx/mb862xxfbdrv.c
> index 11a7a33..00ce1f3 100644
> --- a/drivers/video/mb862xx/mb862xxfbdrv.c
> +++ b/drivers/video/mb862xx/mb862xxfbdrv.c
> @@ -579,7 +579,7 @@ static ssize_t mb862xxfb_show_dispregs(struct device *dev,
>  
>  static DEVICE_ATTR(dispregs, 0444, mb862xxfb_show_dispregs, NULL);
>  
> -irqreturn_t mb862xx_intr(int irq, void *dev_id)
> +static irqreturn_t mb862xx_intr(int irq, void *dev_id)
>  {
>  	struct mb862xxfb_par *par = (struct mb862xxfb_par *) dev_id;
>  	unsigned long reg_ist, mask;
> 

