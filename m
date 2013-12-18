From: David Herrmann <dh.herrmann@gmail.com>
Date: Wed, 18 Dec 2013 10:21:46 +0000
Subject: Re: cirrusdrmfb broken with simplefb
Message-Id: <CANq1E4SEL6J50tvv-N9xSs6oA=Og96-7TQOECx=p-WGG3mU9=Q@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <s5hlhzik3kk.wl%tiwai@suse.de>
	<CANq1E4TFKDduy71jCXy+8CMS1_OFxWEpsHY3AA0RUJPW4VE8hg@mail.gmail.com>
	<s5hfvpqk0p8.wl%tiwai@suse.de>
	<s5hppouv4y4.wl%tiwai@suse.de>
In-Reply-To: <s5hppouv4y4.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Takashi Iwai <tiwai@suse.de>
Cc: Stephen Warren <swarren@wwwdotorg.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

Hi

On Wed, Dec 18, 2013 at 11:17 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Wed, 18 Dec 2013 09:44:35 +0100,
> Takashi Iwai wrote:
>>
>> At Wed, 18 Dec 2013 09:21:28 +0100,
>> David Herrmann wrote:
>> >
>> > Hi
>> >
>> > On Wed, Dec 18, 2013 at 8:42 AM, Takashi Iwai <tiwai@suse.de> wrote:
>> > > Hi,
>> > >
>> > > with the recent enablement of simplefb on x86, cirrusdrmfb on QEMU/K=
VM
>> > > gets broken now, as reported at:
>> > >     https://bugzilla.novell.com/show_bug.cgi?id=855821
>> > >
>> > > The cirrus VGA resource is reserved at first as "BOOTFB" in
>> > > arch/x86/kernel/sysfb_simplefb.c, which is taken by simplefb platform
>> > > device.  This resource is, however, never released until the platform
>> > > device is destroyed, and the framebuffer switching doesn't trigger
>> > > it.  It calls fb's destroy callback, at most.  Then, cirrus driver
>> > > tries to assign the resource, fails and gives up, resulting in a
>> > > complete blank screen.
>> > >
>> > > The same problem should exist on other KMS drivers like mgag200 or
>> > > ast, not only cirrus.  Intel graphics doesn't hit this problem just
>> > > because the reserved iomem by BOOTFB isn't required by i915 driver.
>> > >
>> > > The patch below is a quick attempt to solve the issue.  It adds a new
>> > > API function for releasing resources of platform_device, and call it
>> > > in destroy op of simplefb.  But, forcibly releasing resources of a
>> > > parent device doesn't sound like a correct design.  We may take such
>> > > as a band aid, but definitely need a more fundamental fix.
>> > >
>> > > Any thoughts?
>> >
>> > That bug always existed, simplefb is just the first driver to hit it
>> > (vesafb/efifb didn't use resources).
>>
>> Heh, the bug didn't "exist" because no other grabbed the resource
>> before.  The way the cirrus driver allocates the resource is no bug,
>> per se.  But the proper resource takeover is missing.
>>
>> > I'm aware of the issue but as a
>> > workaround you can simply disable CONFIG_X86_SYSFB. That restores the
>> > old behavior.
>>
>> Yes, but CONFIG_X86_SYSFB breaks things as of now.  Shouldn't it be
>> mentioned or give some kconfig hints instead of silently giving a
>> broken output, if any quick fix isn't possible?
>>
>> > As a proper fix, I'd propose something like:
>> >   dev =3D platform_find_device("platform-framebuffer");
>> >   platform_remove_device(dev);
>> >
>> > And we wrap this as:
>> >   sysfb_remove_framebuffers()
>> > in arch/x86/kernel/sysfb.c
>> >
>> > This should cause a ->remove() event for the platform-driver and
>> > correctly release the resources. Comments?
>>
>> Who will call this?  From destroy callback?
>> Or can we simply do put_device() the bound platform device instead?
>
> Just tested, put_device() doesn't work since the refcount isn't 1, so
> if any, we need to call platform_device_unregister() to release
> forcibly.
>
> The patch below seems working at a quick test.  But I still have
> some bad feeling for unregistering the parent device from the child's
> destroy callback...

The idea is right, but call it from
"remove_conflicting_framebuffers()". The problem is, if we load a
driver on top of a dummy like vesafb/efifb/simplefb, we never removed
them properly. Instead, we only unregistered their fb driver. But with
the driver-model, that's just removing the driver, not the dummy
device.

So we'd just call platform_device_unregister() in
remove_conflicting_framebuffers() instead of unregister_framebuffer()
on such devices. I'm now at home and will have a look.

Thanks
David

>
> thanks,
>
> Takashi
>
> ---
> diff --git a/drivers/video/simplefb.c b/drivers/video/simplefb.c
> index 210f3a02121a..196360c54157 100644
> --- a/drivers/video/simplefb.c
> +++ b/drivers/video/simplefb.c
> @@ -41,6 +41,11 @@ static struct fb_var_screeninfo simplefb_var =3D {
>         .vmode          =3D FB_VMODE_NONINTERLACED,
>  };
>
> +struct simplefb_priv {
> +       u32 pseudo_palette[16];
> +       struct platform_device *pdev;
> +};
> +
>  static int simplefb_setcolreg(u_int regno, u_int red, u_int green, u_int=
 blue,
>                               u_int transp, struct fb_info *info)
>  {
> @@ -68,8 +73,19 @@ static int simplefb_setcolreg(u_int regno, u_int red, =
u_int green, u_int blue,
>
>  static void simplefb_destroy(struct fb_info *info)
>  {
> +       struct simplefb_priv *priv =3D info->par;
> +       struct platform_device *pdev =3D priv->pdev;
> +
>         if (info->screen_base)
>                 iounmap(info->screen_base);
> +
> +       /* release the bound platform device when called from
> +        * remove_conflicting_framebuffers()
> +        */
> +       if (pdev) {
> +               priv->pdev =3D NULL; /* to avoid double-free */
> +               platform_device_unregister(pdev);
> +       }
>  }
>
>  static struct fb_ops simplefb_ops =3D {
> @@ -169,6 +185,7 @@ static int simplefb_probe(struct platform_device *pde=
v)
>         struct simplefb_params params;
>         struct fb_info *info;
>         struct resource *mem;
> +       struct simplefb_priv *priv;
>
>         if (fb_get_options("simplefb", NULL))
>                 return -ENODEV;
> @@ -188,7 +205,7 @@ static int simplefb_probe(struct platform_device *pde=
v)
>                 return -EINVAL;
>         }
>
> -       info =3D framebuffer_alloc(sizeof(u32) * 16, &pdev->dev);
> +       info =3D framebuffer_alloc(sizeof(struct simplefb_priv), &pdev->d=
ev);
>         if (!info)
>                 return -ENOMEM;
>         platform_set_drvdata(pdev, info);
> @@ -225,7 +242,9 @@ static int simplefb_probe(struct platform_device *pde=
v)
>                 framebuffer_release(info);
>                 return -ENODEV;
>         }
> -       info->pseudo_palette =3D (void *)(info + 1);
> +
> +       priv =3D info->par;
> +       info->pseudo_palette =3D priv->pseudo_palette;
>
>         dev_info(&pdev->dev, "framebuffer at 0x%lx, 0x%x bytes, mapped to=
 0x%p\n",
>                              info->fix.smem_start, info->fix.smem_len,
> @@ -243,6 +262,7 @@ static int simplefb_probe(struct platform_device *pde=
v)
>                 return ret;
>         }
>
> +       priv->pdev =3D pdev;
>         dev_info(&pdev->dev, "fb%d: simplefb registered!\n", info->node);
>
>         return 0;
> @@ -251,8 +271,13 @@ static int simplefb_probe(struct platform_device *pd=
ev)
>  static int simplefb_remove(struct platform_device *pdev)
>  {
>         struct fb_info *info =3D platform_get_drvdata(pdev);
> +       struct simplefb_priv *priv =3D info->par;
> +
> +       if (priv->pdev) {
> +               priv->pdev =3D NULL; /* to avoid double-free */
> +               unregister_framebuffer(info);
> +       }
>
> -       unregister_framebuffer(info);
>         framebuffer_release(info);
>
>         return 0;
