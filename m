From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 13 Aug 2014 08:40:46 +0000
Subject: Re: [PATCH 3/4] simplefb: disable dt node upon remove
Message-Id: <CACxGe6vaPUa4QvYWBA-QY7MTmJYoeqnPt9Zh5jpky6S9UYbrvQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1407914239-12054-1-git-send-email-libv@skynet.be>
 <1407914239-12054-4-git-send-email-libv@skynet.be>
In-Reply-To: <1407914239-12054-4-git-send-email-libv@skynet.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Aug 13, 2014 at 8:17 AM, Luc Verhaegen <libv@skynet.be> wrote:
> The next commit will handle clocks correctly, so that these do not get
> automatically disabled on certain SoC simplefb implementations. As a
> result, the removal of this simplefb driver, and the release of the
> clocks, is rather final, and only a full display driver can work after
> this. So, it makes sense to also flag the dt node as disabled, even
> though it has no real value today.
>
> Signed-off-by: Luc Verhaegen <libv@skynet.be>

Please, no.

Drivers should not be modifying the device tree without and
exceptionally good reason for doing so. Drivers are to treat the DT as
immutable.

* the exception is an overlay driver which add new devices to the
kernel. Definitely not the case here.

g.

> ---
>  drivers/video/fbdev/simplefb.c |   43 ++++++++++++++++++++++++++++++++++++---
>  1 files changed, 39 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
> index 72a4f20..74c4b2a 100644
> --- a/drivers/video/fbdev/simplefb.c
> +++ b/drivers/video/fbdev/simplefb.c
> @@ -138,6 +138,32 @@ static int simplefb_parse_dt(struct platform_device *pdev,
>         return 0;
>  }
>
> +/*
> + * Make sure that nothing tries to inadvertedly re-use this node...
> + */
> +static int
> +simplefb_dt_disable(struct platform_device *pdev)
> +{
> +       struct device_node *np = pdev->dev.of_node;
> +       struct property *property;
> +       int ret;
> +
> +       property = kzalloc(sizeof(struct property), GFP_KERNEL);
> +       if (!property)
> +               return -ENOMEM;
> +
> +       property->name = "status";
> +       property->value = "disabled";
> +       property->length = strlen(property->value) + 1;
> +
> +       ret = of_update_property(np, property);
> +       if (ret)
> +               dev_err(&pdev->dev, "%s: failed to update property: %d\n",
> +                       __func__, ret);
> +
> +       return ret;
> +}
> +
>  static int simplefb_parse_pd(struct platform_device *pdev,
>                              struct simplefb_params *params)
>  {
> @@ -187,17 +213,20 @@ static int simplefb_probe(struct platform_device *pdev)
>                 ret = simplefb_parse_dt(pdev, &params);
>
>         if (ret)
> -               return ret;
> +               goto error_dt_disable;
>
>         mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>         if (!mem) {
>                 dev_err(&pdev->dev, "No memory resource\n");
> -               return -EINVAL;
> +               ret = -EINVAL;
> +               goto error_dt_disable;
>         }
>
>         info = framebuffer_alloc(sizeof(struct simplefb_par), &pdev->dev);
> -       if (!info)
> -               return -ENOMEM;
> +       if (!info) {
> +               ret = -ENOMEM;
> +               goto error_dt_disable;
> +       }
>         platform_set_drvdata(pdev, info);
>
>         par = info->par;
> @@ -260,6 +289,10 @@ static int simplefb_probe(struct platform_device *pdev)
>   error_fb_release:
>         framebuffer_release(info);
>
> + error_dt_disable:
> +       if (!dev_get_platdata(&pdev->dev) && pdev->dev.of_node)
> +               simplefb_dt_disable(pdev);
> +
>         return ret;
>  }
>
> @@ -269,6 +302,8 @@ static int simplefb_remove(struct platform_device *pdev)
>
>         unregister_framebuffer(info);
>         framebuffer_release(info);
> +       if (!dev_get_platdata(&pdev->dev) && pdev->dev.of_node)
> +               simplefb_dt_disable(pdev);
>
>         return 0;
>  }
> --
> 1.7.7
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
