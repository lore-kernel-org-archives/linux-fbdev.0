From: David Herrmann <dh.herrmann@gmail.com>
Date: Wed, 18 Dec 2013 08:21:28 +0000
Subject: Re: cirrusdrmfb broken with simplefb
Message-Id: <CANq1E4TFKDduy71jCXy+8CMS1_OFxWEpsHY3AA0RUJPW4VE8hg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <s5hlhzik3kk.wl%tiwai@suse.de>
In-Reply-To: <s5hlhzik3kk.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Takashi Iwai <tiwai@suse.de>
Cc: Stephen Warren <swarren@wwwdotorg.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

Hi

On Wed, Dec 18, 2013 at 8:42 AM, Takashi Iwai <tiwai@suse.de> wrote:
> Hi,
>
> with the recent enablement of simplefb on x86, cirrusdrmfb on QEMU/KVM
> gets broken now, as reported at:
>     https://bugzilla.novell.com/show_bug.cgi?id=855821
>
> The cirrus VGA resource is reserved at first as "BOOTFB" in
> arch/x86/kernel/sysfb_simplefb.c, which is taken by simplefb platform
> device.  This resource is, however, never released until the platform
> device is destroyed, and the framebuffer switching doesn't trigger
> it.  It calls fb's destroy callback, at most.  Then, cirrus driver
> tries to assign the resource, fails and gives up, resulting in a
> complete blank screen.
>
> The same problem should exist on other KMS drivers like mgag200 or
> ast, not only cirrus.  Intel graphics doesn't hit this problem just
> because the reserved iomem by BOOTFB isn't required by i915 driver.
>
> The patch below is a quick attempt to solve the issue.  It adds a new
> API function for releasing resources of platform_device, and call it
> in destroy op of simplefb.  But, forcibly releasing resources of a
> parent device doesn't sound like a correct design.  We may take such
> as a band aid, but definitely need a more fundamental fix.
>
> Any thoughts?

That bug always existed, simplefb is just the first driver to hit it
(vesafb/efifb didn't use resources). I'm aware of the issue but as a
workaround you can simply disable CONFIG_X86_SYSFB. That restores the
old behavior.

As a proper fix, I'd propose something like:
  dev =3D platform_find_device("platform-framebuffer");
  platform_remove_device(dev);

And we wrap this as:
  sysfb_remove_framebuffers()
in arch/x86/kernel/sysfb.c

This should cause a ->remove() event for the platform-driver and
correctly release the resources. Comments?
I will try to write a patch and send it later.

Thanks
David

>
> thanks,
>
> Takashi
>
> ---
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 3a94b79..f939236 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -267,6 +267,23 @@ int platform_device_add_data(struct platform_device =
*pdev, const void *data,
>  }
>  EXPORT_SYMBOL_GPL(platform_device_add_data);
>
> +static void do_release_resources(struct platform_device *pdev, int nums)
> +{
> +       int i;
> +
> +       for (i =3D 0; i < nums; i++) {
> +               struct resource *r =3D &pdev->resource[i];
> +               unsigned long type =3D resource_type(r);
> +
> +               if (type =3D IORESOURCE_MEM || type =3D IORESOURCE_IO)
> +                       release_resource(r);
> +       }
> +
> +       kfree(pdev->resource);
> +       pdev->resource =3D NULL;
> +       pdev->num_resources =3D 0;
> +}
> +
>  /**
>   * platform_device_add - add a platform device to device hierarchy
>   * @pdev: platform device we're adding
> @@ -342,13 +359,7 @@ int platform_device_add(struct platform_device *pdev)
>                 pdev->id =3D PLATFORM_DEVID_AUTO;
>         }
>
> -       while (--i >=3D 0) {
> -               struct resource *r =3D &pdev->resource[i];
> -               unsigned long type =3D resource_type(r);
> -
> -               if (type =3D IORESOURCE_MEM || type =3D IORESOURCE_IO)
> -                       release_resource(r);
> -       }
> +       do_release_resources(pdev, i - 1);
>
>   err_out:
>         return ret;
> @@ -365,8 +376,6 @@ EXPORT_SYMBOL_GPL(platform_device_add);
>   */
>  void platform_device_del(struct platform_device *pdev)
>  {
> -       int i;
> -
>         if (pdev) {
>                 device_del(&pdev->dev);
>
> @@ -375,17 +384,17 @@ void platform_device_del(struct platform_device *pd=
ev)
>                         pdev->id =3D PLATFORM_DEVID_AUTO;
>                 }
>
> -               for (i =3D 0; i < pdev->num_resources; i++) {
> -                       struct resource *r =3D &pdev->resource[i];
> -                       unsigned long type =3D resource_type(r);
> -
> -                       if (type =3D IORESOURCE_MEM || type =3D IORESOURC=
E_IO)
> -                               release_resource(r);
> -               }
> +               do_release_resources(pdev, pdev->num_resources);
>         }
>  }
>  EXPORT_SYMBOL_GPL(platform_device_del);
>
> +void platform_device_release_resources(struct platform_device *pdev)
> +{
> +       do_release_resources(pdev, pdev->num_resources);
> +}
> +EXPORT_SYMBOL_GPL(platform_device_release_resources);
> +
>  /**
>   * platform_device_register - add a platform-level device
>   * @pdev: platform device we're adding
> diff --git a/drivers/video/simplefb.c b/drivers/video/simplefb.c
> index 210f3a0..fbf5e89 100644
> --- a/drivers/video/simplefb.c
> +++ b/drivers/video/simplefb.c
> @@ -70,6 +70,7 @@ static void simplefb_destroy(struct fb_info *info)
>  {
>         if (info->screen_base)
>                 iounmap(info->screen_base);
> +       platform_device_release_resources(to_platform_device(info->device=
));
>  }
>
>  static struct fb_ops simplefb_ops =3D {
> diff --git a/include/linux/platform_device.h b/include/linux/platform_dev=
ice.h
> index 16f6654..7cc1f54 100644
> --- a/include/linux/platform_device.h
> +++ b/include/linux/platform_device.h
> @@ -42,6 +42,7 @@ struct platform_device {
>
>  extern int platform_device_register(struct platform_device *);
>  extern void platform_device_unregister(struct platform_device *);
> +extern void platform_device_release_resources(struct platform_device *pd=
ev);
>
>  extern struct bus_type platform_bus_type;
>  extern struct device platform_bus;
