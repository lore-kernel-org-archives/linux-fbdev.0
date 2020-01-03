From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 03 Jan 2020 11:29:06 +0000
Subject: Re: [PATCH v6 47/57] video: Remove dev_err() usage after platform_get_irq()
Message-Id: <467ee450-e6de-e517-b8d9-7048c14a1931@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190730181557.90391-1-swboyd@chromium.org>
 <CGME20190730181641epcas3p26b5bd99f64726e7d110e20f1b673efeb@epcas3p2.samsung.com>
 <20190730181557.90391-48-swboyd@chromium.org>
In-Reply-To: <20190730181557.90391-48-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Boyd <swboyd@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org


Hi,

Sorry for the late reply.

On 7/30/19 8:15 PM, Stephen Boyd wrote:
> We don't need dev_err() messages when platform_get_irq() fails now that
> platform_get_irq() prints an error message itself when something goes
> wrong. Let's remove these prints with a simple semantic patch.

This patch changes handling of -EPROBE_DEFER in the modified drivers
(most don't support it and error message will no longer be printed).

I cannot apply it as it is (seems that -EPROBE_DEFER handling should
be audited/fixed in the affected drivers first).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> // <smpl>
> @@
> expression ret;
> struct platform_device *E;
> @@
> 
> ret > (
> platform_get_irq(E, ...)
> |
> platform_get_irq_byname(E, ...)
> );
> 
> if ( \( ret < 0 \| ret <= 0 \) )
> {
> (
> -if (ret != -EPROBE_DEFER)
> -{ ...
> -dev_err(...);
> -... }
> |
> ...
> -dev_err(...);
> )
> ...
> }
> // </smpl>
> 
> While we're here, remove braces on if statements that only have one
> statement (manually).
> 
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
> 
> Please apply directly to subsystem trees
> 
>  drivers/video/fbdev/atmel_lcdfb.c     | 1 -
>  drivers/video/fbdev/mmp/hw/mmp_ctrl.c | 1 -
>  drivers/video/fbdev/nuc900fb.c        | 4 +---
>  drivers/video/fbdev/pxa168fb.c        | 4 +---
>  drivers/video/fbdev/pxa3xx-gcu.c      | 4 +---
>  drivers/video/fbdev/pxafb.c           | 1 -
>  drivers/video/fbdev/s3c2410fb.c       | 4 +---
>  drivers/video/fbdev/vt8500lcdfb.c     | 1 -
>  8 files changed, 4 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/video/fbdev/atmel_lcdfb.c b/drivers/video/fbdev/atmel_lcdfb.c
> index 5ff8e0320d95..4a16354d65c8 100644
> --- a/drivers/video/fbdev/atmel_lcdfb.c
> +++ b/drivers/video/fbdev/atmel_lcdfb.c
> @@ -1114,7 +1114,6 @@ static int __init atmel_lcdfb_probe(struct platform_device *pdev)
>  
>  	sinfo->irq_base = platform_get_irq(pdev, 0);
>  	if (sinfo->irq_base < 0) {
> -		dev_err(dev, "unable to get irq\n");
>  		ret = sinfo->irq_base;
>  		goto stop_clk;
>  	}
> diff --git a/drivers/video/fbdev/mmp/hw/mmp_ctrl.c b/drivers/video/fbdev/mmp/hw/mmp_ctrl.c
> index 17174cd7a5bb..d6124976139b 100644
> --- a/drivers/video/fbdev/mmp/hw/mmp_ctrl.c
> +++ b/drivers/video/fbdev/mmp/hw/mmp_ctrl.c
> @@ -447,7 +447,6 @@ static int mmphw_probe(struct platform_device *pdev)
>  
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq < 0) {
> -		dev_err(&pdev->dev, "%s: no IRQ defined\n", __func__);
>  		ret = -ENOENT;
>  		goto failed;
>  	}
> diff --git a/drivers/video/fbdev/nuc900fb.c b/drivers/video/fbdev/nuc900fb.c
> index 4fd851598584..c4606c734f44 100644
> --- a/drivers/video/fbdev/nuc900fb.c
> +++ b/drivers/video/fbdev/nuc900fb.c
> @@ -526,10 +526,8 @@ static int nuc900fb_probe(struct platform_device *pdev)
>  	display = mach_info->displays + mach_info->default_display;
>  
>  	irq = platform_get_irq(pdev, 0);
> -	if (irq < 0) {
> -		dev_err(&pdev->dev, "no irq for device\n");
> +	if (irq < 0)
>  		return -ENOENT;
> -	}
>  
>  	fbinfo = framebuffer_alloc(sizeof(struct nuc900fb_info), &pdev->dev);
>  	if (!fbinfo)
> diff --git a/drivers/video/fbdev/pxa168fb.c b/drivers/video/fbdev/pxa168fb.c
> index 1410f476e135..d9e5258503f0 100644
> --- a/drivers/video/fbdev/pxa168fb.c
> +++ b/drivers/video/fbdev/pxa168fb.c
> @@ -625,10 +625,8 @@ static int pxa168fb_probe(struct platform_device *pdev)
>  	}
>  
>  	irq = platform_get_irq(pdev, 0);
> -	if (irq < 0) {
> -		dev_err(&pdev->dev, "no IRQ defined\n");
> +	if (irq < 0)
>  		return -ENOENT;
> -	}
>  
>  	info = framebuffer_alloc(sizeof(struct pxa168fb_info), &pdev->dev);
>  	if (info = NULL) {
> diff --git a/drivers/video/fbdev/pxa3xx-gcu.c b/drivers/video/fbdev/pxa3xx-gcu.c
> index 74ffb446e00c..07414d43cb3f 100644
> --- a/drivers/video/fbdev/pxa3xx-gcu.c
> +++ b/drivers/video/fbdev/pxa3xx-gcu.c
> @@ -614,10 +614,8 @@ static int pxa3xx_gcu_probe(struct platform_device *pdev)
>  
>  	/* request the IRQ */
>  	irq = platform_get_irq(pdev, 0);
> -	if (irq < 0) {
> -		dev_err(dev, "no IRQ defined: %d\n", irq);
> +	if (irq < 0)
>  		return irq;
> -	}
>  
>  	ret = devm_request_irq(dev, irq, pxa3xx_gcu_handle_irq,
>  			       0, DRV_NAME, priv);
> diff --git a/drivers/video/fbdev/pxafb.c b/drivers/video/fbdev/pxafb.c
> index 4282cb117b92..b44f402ce552 100644
> --- a/drivers/video/fbdev/pxafb.c
> +++ b/drivers/video/fbdev/pxafb.c
> @@ -2353,7 +2353,6 @@ static int pxafb_probe(struct platform_device *dev)
>  
>  	irq = platform_get_irq(dev, 0);
>  	if (irq < 0) {
> -		dev_err(&dev->dev, "no IRQ defined\n");
>  		ret = -ENODEV;
>  		goto failed_free_mem;
>  	}
> diff --git a/drivers/video/fbdev/s3c2410fb.c b/drivers/video/fbdev/s3c2410fb.c
> index a702da89910b..2a846fd5da2a 100644
> --- a/drivers/video/fbdev/s3c2410fb.c
> +++ b/drivers/video/fbdev/s3c2410fb.c
> @@ -849,10 +849,8 @@ static int s3c24xxfb_probe(struct platform_device *pdev,
>  	display = mach_info->displays + mach_info->default_display;
>  
>  	irq = platform_get_irq(pdev, 0);
> -	if (irq < 0) {
> -		dev_err(&pdev->dev, "no irq for device\n");
> +	if (irq < 0)
>  		return -ENOENT;
> -	}
>  
>  	fbinfo = framebuffer_alloc(sizeof(struct s3c2410fb_info), &pdev->dev);
>  	if (!fbinfo)
> diff --git a/drivers/video/fbdev/vt8500lcdfb.c b/drivers/video/fbdev/vt8500lcdfb.c
> index be8d9702cbb2..a10088e1cdb0 100644
> --- a/drivers/video/fbdev/vt8500lcdfb.c
> +++ b/drivers/video/fbdev/vt8500lcdfb.c
> @@ -372,7 +372,6 @@ static int vt8500lcd_probe(struct platform_device *pdev)
>  
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq < 0) {
> -		dev_err(&pdev->dev, "no IRQ defined\n");
>  		ret = -ENODEV;
>  		goto failed_free_palette;
>  	}
