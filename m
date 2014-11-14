From: Grant Likely <grant.likely@linaro.org>
Date: Fri, 14 Nov 2014 09:28:25 +0000
Subject: Re: [PATCH v4 2/4] simplefb: Add support for enumerating simplefb dt nodes in /chosen
Message-Id: <CACxGe6u3_GJA6pbDGX6puDhyJ2E9T+WujmzASw2VE+5-x9q9sA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1415906594-2461-1-git-send-email-hdegoede@redhat.com>
 <1415906594-2461-2-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1415906594-2461-2-git-send-email-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Nov 13, 2014 at 7:23 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> Update simplefb to support the new preferred location for simplefb dt nodes
> under /chosen.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> --
> Changes in v2:
> -Make name array larger in case we ever encounter more then 10000 framebuffers
> Changes in v3:
> -Switch to for_each_child_of_node to loop over the nodes under chosen
> Changes in v4:
> -Wrap the chosen enumeration code in #ifdef CONFIG_OF, as simplefb is used on
>  non devicetree platforms too
> -simplefb can only be built-in, so drop the module_exit function calling
>  platform_driver_unregister
> ---
>  drivers/video/fbdev/simplefb.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
> index 868099a..e381a53 100644
> --- a/drivers/video/fbdev/simplefb.c
> +++ b/drivers/video/fbdev/simplefb.c
> @@ -27,6 +27,7 @@
>  #include <linux/platform_data/simplefb.h>
>  #include <linux/platform_device.h>
>  #include <linux/clk-provider.h>
> +#include <linux/of_platform.h>
>
>  static struct fb_fix_screeninfo simplefb_fix = {
>         .id             = "simple",
> @@ -390,7 +391,27 @@ static struct platform_driver simplefb_driver = {
>         .probe = simplefb_probe,
>         .remove = simplefb_remove,
>  };
> -module_platform_driver(simplefb_driver);
> +
> +static int __init simplefb_init(void)
> +{
> +       int ret;
> +       struct device_node __maybe_unused *np;
> +
> +       ret = platform_driver_register(&simplefb_driver);
> +       if (ret)
> +               return ret;
> +
> +#ifdef CONFIG_OF
> +       for_each_child_of_node(of_chosen, np) {
> +               if (of_device_is_compatible(np, "simple-framebuffer"))
> +                       of_platform_device_create(np, NULL, NULL);
> +       }
> +#endif

Nit: Kind of ugly. This should work instead:

        if (IS_ENABLED(CONFIG_OF_PLATFORM) && of_chosen) {
                for_each_child_of_node(of_chosen, np)
                        if (of_device_is_compatible(np, "simple-framebuffer"))
                                of_platform_device_create(np, NULL, NULL);
        }

And move the forward declaration of of_chosen in include/linux/of.h up
5 lines so that it is always declared. gcc will optimize it out, but
it will still get properly syntax checked on every build.

> +
> +       return 0;
> +}
> +
> +module_init(simplefb_init);
>
>  MODULE_AUTHOR("Stephen Warren <swarren@wwwdotorg.org>");
>  MODULE_DESCRIPTION("Simple framebuffer driver");
> --
> 2.1.0
>
