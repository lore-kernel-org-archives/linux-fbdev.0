From: Hans de Goede <hdegoede@redhat.com>
Date: Tue, 19 Apr 2016 19:53:33 +0000
Subject: Re: [PATCH] simplefb: Disable at runtime when a native driver (vc4) is present.
Message-Id: <57168CBD.7050309@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1461093565-18631-1-git-send-email-eric@anholt.net>
In-Reply-To: <1461093565-18631-1-git-send-email-eric@anholt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Eric,

On 04/19/2016 09:19 PM, Eric Anholt wrote:
> With simplefb and vc4 both enabled, simplefb would probe first and be
> fb0, displaying for a moment before vc4 probed fb1 and reconfigured
> the graphics hardware so that only its fbdev worked.

The way this is supposed to work (theoretically you're the first
one to hit this on ARM) is that you call remove_conflicting_framebuffers()
from the probe of your driver.

simplefb can only be built-in and uses fs_initcall() to register itself,
so that it becomes available early on, so it should always be probed
before the vc4 driver.

When we discussed how all of this should fit together (again theoretically)
at ELCE 2014, we decided to follow what the x86 kms driver do here, the
idea was that u-boot would set up a console (so that the user can interact
with u-boot / see error messages without hooking up a serial console) and
then simplefb would pick up the u-boot console asap, so that the kernel
can show error msg. This is esp. important for the Debian / Fedora ARM
images where things like the vc4 driver will be a module and we want
the user to see errors from the initrd if things go wrong before loading
e.g. the vc4 module.

So the boot sequence would be:

1) u-boot configures a framebuffer, shows msgs there
2) kernel brings on builtin simplefb early, shows msgs that way
3) vc4 driver loads calls remove_conflicting_framebuffers which should
    disable/remove the simplefb framebuffer
4) vc4 driver register its own framebuffer, kernel msgs get displayed there

I hope this makes sense, let me know if you've any questions.

Regards,

Hans





>
> Cc: javier@osg.samsung.com
>
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>
> Ccing Javier, since it looks like Exynos has also had this trouble,
> and may want to get some compatible string in the list.
>
>   drivers/video/fbdev/simplefb.c | 33 +++++++++++++++++++++++++++++++++
>   1 file changed, 33 insertions(+)
>
> diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
> index e9cf19977285..a2971aa686f5 100644
> --- a/drivers/video/fbdev/simplefb.c
> +++ b/drivers/video/fbdev/simplefb.c
> @@ -512,11 +512,44 @@ static struct platform_driver simplefb_driver = {
>   	.remove = simplefb_remove,
>   };
>
> +/* Returns true if a simplefb node that's present should be ignored.
> + *
> + * The U-Boot bootloader, and possibly others, may add a simplefb
> + * device node to the existing device tree based on the video
> + * configuration initialized by the firmware.  If we have a native
> + * driver for graphics, then simplefb would just be writing into
> + * memory that's no longer being scanned out.
> + */
> +static bool
> +simplefb_superseded(void)
> +{
> +	static const char *compats[] __initconst = {
> +#ifdef CONFIG_DRM_VC4
> +		"brcm,bcm2835-vc4",
> +#endif
> +	};
> +	struct device_node *node;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(compats); i++) {
> +		node = of_find_compatible_node(NULL, NULL, compats[i]);
> +		if (node) {
> +			of_node_put(node);
> +			return true;
> +		}
> +	}
> +
> +	return false;
> +}
> +
>   static int __init simplefb_init(void)
>   {
>   	int ret;
>   	struct device_node *np;
>
> +	if (simplefb_superseded())
> +		return 0;
> +
>   	ret = platform_driver_register(&simplefb_driver);
>   	if (ret)
>   		return ret;
>
