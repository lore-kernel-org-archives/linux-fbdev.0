From: Wan ZongShun <mcuos.com@gmail.com>
Date: Mon, 17 Jan 2011 08:40:02 +0000
Subject: Re: [PATCH 1/2] video: nuc900fb: fix compile error
Message-Id: <AANLkTinXNoxtvobV1go9bLqJohiyic8qzznsoHvyJsh3@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1295253143.12890.3.camel@mola>
In-Reply-To: <1295253143.12890.3.camel@mola>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-arm-kernel@lists.infradead.org

2011/1/17 Axel Lin <axel.lin@gmail.com>:
> >From a4bd940fa4d162f95e51e67c7ec4973b1d5b6866 Mon Sep 17 00:00:00 2001
> From: Axel Lin <axel.lin@gmail.com>
> Date: Mon, 17 Jan 2011 16:24:36 +0800
> Subject: [PATCH 1/2] video: nuc900fb: fix compile error
>
> This patch fixes below compile error:
>
>  CC      drivers/video/nuc900fb.o
> drivers/video/nuc900fb.c: In function 'nuc900fb_suspend':
> drivers/video/nuc900fb.c:726: error: too few arguments to function 'nuc900fb_stop_lcd'
> drivers/video/nuc900fb.c: In function 'nuc900fb_resume':
> drivers/video/nuc900fb.c:743: error: 'bfinfo' undeclared (first use in this function)
> drivers/video/nuc900fb.c:743: error: (Each undeclared identifier is reported only once
> drivers/video/nuc900fb.c:743: error: for each function it appears in.)
> make[2]: *** [drivers/video/nuc900fb.o] Error 1
> make[1]: *** [drivers/video] Error 2
> make: *** [drivers] Error 2
>
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
>  drivers/video/nuc900fb.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/video/nuc900fb.c b/drivers/video/nuc900fb.c
> index 62498bd..29ef92f 100644
> --- a/drivers/video/nuc900fb.c
> +++ b/drivers/video/nuc900fb.c
> @@ -723,7 +723,7 @@ static int nuc900fb_suspend(struct platform_device *dev, pm_message_t state)
>        struct fb_info     *fbinfo = platform_get_drvdata(dev);
>        struct nuc900fb_info *info = fbinfo->par;
>
> -       nuc900fb_stop_lcd();
> +       nuc900fb_stop_lcd(fbinfo);
>        msleep(1);
>        clk_disable(info->clk);
>        return 0;
> @@ -740,7 +740,7 @@ static int nuc900fb_resume(struct platform_device *dev)
>        msleep(1);
>
>        nuc900fb_init_registers(fbinfo);
> -       nuc900fb_activate_var(bfinfo);
> +       nuc900fb_activate_var(fbinfo);
>
>        return 0;
>  }

Thanks for your patches.
Acked-by: Wan ZongShun <mcuos.com@gmail.com>
> --
> 1.7.2
>
>
>
>



-- 
*linux-arm-kernel mailing list
mail addr:linux-arm-kernel@lists.infradead.org
you can subscribe by:
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

* linux-arm-NUC900 mailing list
mail addr:NUC900@googlegroups.com
main web: https://groups.google.com/group/NUC900
you can subscribe it by sending me mail:
mcuos.com@gmail.com
