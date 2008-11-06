From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH] drivers/video: Bad error test before a dereference
Date: Thu, 06 Nov 2008 16:33:36 +0100
Message-ID: <49130E50.8090009@atmel.com>
References: <200809261553.45301.brunel@diku.dk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753792AbYKFPeH@vger.kernel.org>
In-Reply-To: <200809261553.45301.brunel@diku.dk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Julien Brunel <brunel@diku.dk>, adaplas@gmail.com, linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

Julien Brunel :
> The error test that follows the call to backlight_device_register
> semms not to concern the right variable.
> 
> A simplified version of the semantic match that finds this problem is
> as follows: 
> (http://www.emn.fr/x-info/coccinelle/)
> // <smpl>
> @def0@
> expression x;
> position p0;
> @@
> x@p0 = backlight_device_register(...)
> 
> @protected@
> expression def0.x,E;
> position def0.p0;
> position p;
> statement S;
> @@
> x@p0
> ... when != x = E
> if (!IS_ERR(x) && ...) {<... x@p ...>} else S
> 
> @unprotected@
> expression def0.x;
> identifier fld;
> position def0.p0;
> position p != protected.p;
> @@
> x@p0
> ... when != x = E
> * x@p->fld
> // </smpl>
> 
> Signed-off-by: Julien Brunel <brunel@diku.dk>
> Signed-off-by: Julia Lawall <julia@diku.dk>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> 
> ---
>  drivers/video/atmel_lcdfb.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff -u -p a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
> --- a/drivers/video/atmel_lcdfb.c
> +++ b/drivers/video/atmel_lcdfb.c
> @@ -132,7 +132,7 @@ static void init_backlight(struct atmel_
>  
>  	bl = backlight_device_register("backlight", &sinfo->pdev->dev,
>  			sinfo, &atmel_lcdc_bl_ops);
> -	if (IS_ERR(sinfo->backlight)) {
> +	if (IS_ERR(bl)) {
>  		dev_err(&sinfo->pdev->dev, "error %ld on backlight register\n",
>  				PTR_ERR(bl));
>  		return;
> 

Thanks, regards,
-- 
Nicolas Ferre
