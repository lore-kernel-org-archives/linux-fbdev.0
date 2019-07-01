From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Mon, 01 Jul 2019 08:37:58 +0000
Subject: Re: [PATCH 3/3] video: fbdev: don't print error message on framebuffer_alloc() failure
Message-Id: <CAO-hwJJFKQEwEiDe1M6gP5D_yf0BxyzaJH-kxwxqkCVo52WK6g@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190614145128eucas1p2783e7d644ef8823d211896298e8988fc@eucas1p2.samsung.com>
 <3da197ed-a701-2aa7-d775-2bdbe9deab4a@samsung.com>
In-Reply-To: <3da197ed-a701-2aa7-d775-2bdbe9deab4a@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, lkml <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, =?UTF-8?Q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

Hi Bartlomiej,

On Fri, Jun 14, 2019 at 4:52 PM Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
>
> framebuffer_alloc() can fail only on kzalloc() memory allocation
> failure and since kzalloc() will print error message in such case
> we can omit printing extra error message in drivers (which BTW is
> what the majority of framebuffer_alloc() users is doing already).
>
> Cc: "Bruno Pr=C3=A9mont" <bonbons@linux-vserver.org>
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/hid/hid-picolcd_fb.c                   |    4 +---
>  drivers/video/fbdev/amifb.c                    |    4 +---
>  drivers/video/fbdev/arkfb.c                    |    4 +---
>  drivers/video/fbdev/atmel_lcdfb.c              |    4 +---
>  drivers/video/fbdev/aty/aty128fb.c             |    5 ++---
>  drivers/video/fbdev/aty/atyfb_base.c           |   10 ++++------
>  drivers/video/fbdev/aty/radeon_base.c          |    2 --
>  drivers/video/fbdev/chipsfb.c                  |    1 -
>  drivers/video/fbdev/cirrusfb.c                 |    5 +----
>  drivers/video/fbdev/da8xx-fb.c                 |    1 -
>  drivers/video/fbdev/efifb.c                    |    1 -
>  drivers/video/fbdev/grvga.c                    |    4 +---
>  drivers/video/fbdev/gxt4500.c                  |    5 ++---
>  drivers/video/fbdev/hyperv_fb.c                |    4 +---
>  drivers/video/fbdev/i740fb.c                   |    4 +---
>  drivers/video/fbdev/imsttfb.c                  |    5 +----
>  drivers/video/fbdev/intelfb/intelfbdrv.c       |    5 ++---
>  drivers/video/fbdev/jz4740_fb.c                |    4 +---
>  drivers/video/fbdev/mb862xx/mb862xxfbdrv.c     |    5 +----
>  drivers/video/fbdev/mbx/mbxfb.c                |    4 +---
>  drivers/video/fbdev/omap/omapfb_main.c         |    2 --
>  drivers/video/fbdev/omap2/omapfb/omapfb-main.c |    6 +-----
>  drivers/video/fbdev/platinumfb.c               |    5 ++---
>  drivers/video/fbdev/pmag-aa-fb.c               |    4 +---
>  drivers/video/fbdev/pmag-ba-fb.c               |    4 +---
>  drivers/video/fbdev/pmagb-b-fb.c               |    4 +---
>  drivers/video/fbdev/pvr2fb.c                   |    6 +-----
>  drivers/video/fbdev/riva/fbdev.c               |    1 -
>  drivers/video/fbdev/s3c-fb.c                   |    4 +---
>  drivers/video/fbdev/s3fb.c                     |    4 +---
>  drivers/video/fbdev/sh_mobile_lcdcfb.c         |    8 ++------
>  drivers/video/fbdev/sm501fb.c                  |    4 +---
>  drivers/video/fbdev/sm712fb.c                  |    1 -
>  drivers/video/fbdev/smscufx.c                  |    4 +---
>  drivers/video/fbdev/ssd1307fb.c                |    4 +---
>  drivers/video/fbdev/sunxvr1000.c               |    1 -
>  drivers/video/fbdev/sunxvr2500.c               |    1 -
>  drivers/video/fbdev/sunxvr500.c                |    1 -
>  drivers/video/fbdev/tgafb.c                    |    4 +---
>  drivers/video/fbdev/udlfb.c                    |    4 +---
>  drivers/video/fbdev/via/viafbdev.c             |    6 +-----
>  drivers/video/fbdev/vt8623fb.c                 |    4 +---
>  42 files changed, 40 insertions(+), 123 deletions(-)
>
> Index: b/drivers/hid/hid-picolcd_fb.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- a/drivers/hid/hid-picolcd_fb.c
> +++ b/drivers/hid/hid-picolcd_fb.c
> @@ -522,10 +522,8 @@ int picolcd_init_framebuffer(struct pico
>                         sizeof(struct fb_deferred_io) +
>                         sizeof(struct picolcd_fb_data) +
>                         PICOLCDFB_SIZE, dev);
> -       if (info =3D NULL) {
> -               dev_err(dev, "failed to allocate a framebuffer\n");
> +       if (!info)
>                 goto err_nomem;
> -       }

It would have been better to split this change as the HID and fbdev
are different trees.

However, I do not expect a conflict here (there hasn't been updates of
hid-picolcd_fb.c in a while), so feel free to take this patch through
the fbdev tree with my:
Acked-By: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

>
>         info->fbdefio =3D info->par;
>         *info->fbdefio =3D picolcd_fb_defio;
> Index: b/drivers/video/fbdev/amifb.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- a/drivers/video/fbdev/amifb.c
> +++ b/drivers/video/fbdev/amifb.c
> @@ -3554,10 +3554,8 @@ static int __init amifb_probe(struct pla
>         custom.dmacon =3D DMAF_ALL | DMAF_MASTER;
>
>         info =3D framebuffer_alloc(sizeof(struct amifb_par), &pdev->dev);
> -       if (!info) {
> -               dev_err(&pdev->dev, "framebuffer_alloc failed\n");
> +       if (!info)
>                 return -ENOMEM;
> -       }
>
>         strcpy(info->fix.id, "Amiga ");
>         info->fix.visual =3D FB_VISUAL_PSEUDOCOLOR;
> Index: b/drivers/video/fbdev/arkfb.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- a/drivers/video/fbdev/arkfb.c
> +++ b/drivers/video/fbdev/arkfb.c
> @@ -954,10 +954,8 @@ static int ark_pci_probe(struct pci_dev
>
>         /* Allocate and fill driver data structure */
>         info =3D framebuffer_alloc(sizeof(struct arkfb_info), &(dev->dev)=
);
> -       if (! info) {
> -               dev_err(&(dev->dev), "cannot allocate memory\n");
> +       if (!info)
>                 return -ENOMEM;
> -       }
>
>         par =3D info->par;
>         mutex_init(&par->open_lock);
> Index: b/drivers/video/fbdev/atmel_lcdfb.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- a/drivers/video/fbdev/atmel_lcdfb.c
> +++ b/drivers/video/fbdev/atmel_lcdfb.c
> @@ -1053,10 +1053,8 @@ static int __init atmel_lcdfb_probe(stru
>
>         ret =3D -ENOMEM;
>         info =3D framebuffer_alloc(sizeof(struct atmel_lcdfb_info), dev);
> -       if (!info) {
> -               dev_err(dev, "cannot allocate memory\n");
> +       if (!info)
>                 goto out;
> -       }
>
>         sinfo =3D info->par;
>         sinfo->pdev =3D pdev;
> Index: b/drivers/video/fbdev/aty/aty128fb.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- a/drivers/video/fbdev/aty/aty128fb.c
> +++ b/drivers/video/fbdev/aty/aty128fb.c
> @@ -2102,10 +2102,9 @@ static int aty128_probe(struct pci_dev *
>
>         /* We have the resources. Now virtualize them */
>         info =3D framebuffer_alloc(sizeof(struct aty128fb_par), &pdev->de=
v);
> -       if (info =3D NULL) {
> -               printk(KERN_ERR "aty128fb: can't alloc fb_info_aty128\n");
> +       if (!info)
>                 goto err_free_mmio;
> -       }
> +
>         par =3D info->par;
>
>         info->pseudo_palette =3D par->pseudo_palette;
> Index: b/drivers/video/fbdev/aty/atyfb_base.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- a/drivers/video/fbdev/aty/atyfb_base.c
> +++ b/drivers/video/fbdev/aty/atyfb_base.c
> @@ -3550,10 +3550,9 @@ static int atyfb_pci_probe(struct pci_de
>
>         /* Allocate framebuffer */
>         info =3D framebuffer_alloc(sizeof(struct atyfb_par), &pdev->dev);
> -       if (!info) {
> -               PRINTKE("atyfb_pci_probe() can't alloc fb_info\n");
> +       if (!info)
>                 return -ENOMEM;
> -       }
> +
>         par =3D info->par;
>         par->bus_type =3D PCI;
>         info->fix =3D atyfb_fix;
> @@ -3643,10 +3642,9 @@ static int __init atyfb_atari_probe(void
>                 }
>
>                 info =3D framebuffer_alloc(sizeof(struct atyfb_par), NULL=
);
> -               if (!info) {
> -                       PRINTKE("atyfb_atari_probe() can't alloc fb_info\=
n");
> +               if (!info)
>                         return -ENOMEM;
> -               }
> +
>                 par =3D info->par;
>
>                 info->fix =3D atyfb_fix;
> Index: b/drivers/video/fbdev/aty/radeon_base.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- a/drivers/video/fbdev/aty/radeon_base.c
> +++ b/drivers/video/fbdev/aty/radeon_base.c
> @@ -2294,8 +2294,6 @@ static int radeonfb_pci_register(struct
>
>         info =3D framebuffer_alloc(sizeof(struct radeonfb_info), &pdev->d=
ev);
>         if (!info) {
> -               printk (KERN_ERR "radeonfb (%s): could not allocate memor=
y\n",
> -                       pci_name(pdev));
>                 ret =3D -ENOMEM;
>                 goto err_disable;
>         }
> Index: b/drivers/video/fbdev/chipsfb.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- a/drivers/video/fbdev/chipsfb.c
> +++ b/drivers/video/fbdev/chipsfb.c
> @@ -366,7 +366,6 @@ static int chipsfb_pci_init(struct pci_d
>
>         p =3D framebuffer_alloc(0, &dp->dev);
>         if (p =3D NULL) {
> -               dev_err(&dp->dev, "Cannot allocate framebuffer structure\=
n");
>                 rc =3D -ENOMEM;
>                 goto err_disable;
>         }
> Index: b/drivers/video/fbdev/cirrusfb.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- a/drivers/video/fbdev/cirrusfb.c
> +++ b/drivers/video/fbdev/cirrusfb.c
> @@ -2093,7 +2093,6 @@ static int cirrusfb_pci_register(struct
>
>         info =3D framebuffer_alloc(sizeof(struct cirrusfb_info), &pdev->d=
ev);
>         if (!info) {
> -               printk(KERN_ERR "cirrusfb: could not allocate memory\n");
>                 ret =3D -ENOMEM;
>                 goto err_out;
>         }
> @@ -2206,10 +2205,8 @@ static int cirrusfb_zorro_register(struc
>         struct cirrusfb_info *cinfo;
>
>         info =3D framebuffer_alloc(sizeof(struct cirrusfb_info), &z->dev);
> -       if (!info) {
> -               printk(KERN_ERR "cirrusfb: could not allocate memory\n");
> +       if (!info)
>                 return -ENOMEM;
> -       }
>
>         zcl =3D (const struct zorrocl *)ent->driver_data;
>         btype =3D zcl->type;
> Index: b/drivers/video/fbdev/da8xx-fb.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- a/drivers/video/fbdev/da8xx-fb.c
> +++ b/drivers/video/fbdev/da8xx-fb.c
> @@ -1400,7 +1400,6 @@ static int fb_probe(struct platform_devi
>         da8xx_fb_info =3D framebuffer_alloc(sizeof(struct da8xx_fb_par),
>                                         &device->dev);
>         if (!da8xx_fb_info) {
> -               dev_dbg(&device->dev, "Memory allocation failed for fb_in=
fo\n");
>                 ret =3D -ENOMEM;
>                 goto err_pm_runtime_disable;
>         }
> Index: b/drivers/video/fbdev/efifb.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- a/drivers/video/fbdev/efifb.c
> +++ b/drivers/video/fbdev/efifb.c
> @@ -448,7 +448,6 @@ static int efifb_probe(struct platform_d
>
>         info =3D framebuffer_alloc(sizeof(u32) * 16, &dev->dev);
>         if (!info) {
> -               pr_err("efifb: cannot allocate framebuffer\n");
>                 err =3D -ENOMEM;
>                 goto err_release_mem;
>         }
> Index: b/drivers/video/fbdev/grvga.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- a/drivers/video/fbdev/grvga.c
> +++ b/drivers/video/fbdev/grvga.c
> @@ -341,10 +341,8 @@ static int grvga_probe(struct platform_d
>         char *options =3D NULL, *mode_opt =3D NULL;
>
>         info =3D framebuffer_alloc(sizeof(struct grvga_par), &dev->dev);
> -       if (!info) {
> -               dev_err(&dev->dev, "framebuffer_alloc failed\n");
> +       if (!info)
>                 return -ENOMEM;
> -       }
>
>         /* Expecting: "grvga: modestring, [addr:<framebuffer physical add=
ress>], [size:<framebuffer size>]
>          *
> Index: b/drivers/video/fbdev/gxt4500.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- a/drivers/video/fbdev/gxt4500.c
> +++ b/drivers/video/fbdev/gxt4500.c
> @@ -642,10 +642,9 @@ static int gxt4500_probe(struct pci_dev
>         }
>
>         info =3D framebuffer_alloc(sizeof(struct gxt4500_par), &pdev->dev=
);
> -       if (!info) {
> -               dev_err(&pdev->dev, "gxt4500: cannot alloc FB info record=
\n");
> +       if (!info)
>                 goto err_free_fb;
> -       }
> +
>         par =3D info->par;
>         cardtype =3D ent->driver_data;
>         par->refclk_ps =3D cardinfo[cardtype].refclk_ps;
> Index: b/drivers/video/fbdev/hyperv_fb.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- a/drivers/video/fbdev/hyperv_fb.c
> +++ b/drivers/video/fbdev/hyperv_fb.c
> @@ -771,10 +771,8 @@ static int hvfb_probe(struct hv_device *
>         int ret;
>
>         info =3D framebuffer_alloc(sizeof(struct hvfb_par), &hdev->device=
);
> -       if (!info) {
> -               pr_err("No memory for framebuffer info\n");
> +       if (!info)
>                 return -ENOMEM;
> -       }
>
>         par =3D info->par;
>         par->info =3D info;
> Index: b/drivers/video/fbdev/i740fb.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- a/drivers/video/fbdev/i740fb.c
> +++ b/drivers/video/fbdev/i740fb.c
> @@ -1005,10 +1005,8 @@ static int i740fb_probe(struct pci_dev *
>         u8 *edid;
>
>         info =3D framebuffer_alloc(sizeof(struct i740fb_par), &(dev->dev)=
);
> -       if (!info) {
> -               dev_err(&(dev->dev), "cannot allocate framebuffer\n");
> +       if (!info)
>                 return -ENOMEM;
> -       }
>
>         par =3D info->par;
>         mutex_init(&par->open_lock);
> Index: b/drivers/video/fbdev/imsttfb.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- a/drivers/video/fbdev/imsttfb.c
> +++ b/drivers/video/fbdev/imsttfb.c
> @@ -1477,11 +1477,8 @@ static int imsttfb_probe(struct pci_dev
>                 printk(KERN_ERR "imsttfb: no OF node for pci device\n");
>
>         info =3D framebuffer_alloc(sizeof(struct imstt_par), &pdev->dev);
> -
> -       if (!info) {
> -               printk(KERN_ERR "imsttfb: Can't allocate memory\n");
> +       if (!info)
>                 return -ENOMEM;
> -       }
>
>         par =3D info->par;
>
> Index: b/drivers/video/fbdev/intelfb/intelfbdrv.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- a/drivers/video/fbdev/intelfb/intelfbdrv.c
> +++ b/drivers/video/fbdev/intelfb/intelfbdrv.c
> @@ -491,10 +491,9 @@ static int intelfb_pci_register(struct p
>         }
>
>         info =3D framebuffer_alloc(sizeof(struct intelfb_info), &pdev->de=
v);
> -       if (!info) {
> -               ERR_MSG("Could not allocate memory for intelfb_info.\n");
> +       if (!info)
>                 return -ENOMEM;
> -       }
> +
>         if (fb_alloc_cmap(&info->cmap, 256, 1) < 0) {
>                 ERR_MSG("Could not allocate cmap for intelfb_info.\n");
>                 goto err_out_cmap;
> Index: b/drivers/video/fbdev/jz4740_fb.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- a/drivers/video/fbdev/jz4740_fb.c
> +++ b/drivers/video/fbdev/jz4740_fb.c
> @@ -544,10 +544,8 @@ static int jzfb_probe(struct platform_de
>         }
>
>         fb =3D framebuffer_alloc(sizeof(struct jzfb), &pdev->dev);
> -       if (!fb) {
> -               dev_err(&pdev->dev, "Failed to allocate framebuffer devic=
e\n");
> +       if (!fb)
>                 return -ENOMEM;
> -       }
>
>         fb->fbops =3D &jzfb_ops;
>         fb->flags =3D FBINFO_DEFAULT;
> Index: b/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- a/drivers/video/fbdev/mb862xx/mb862xxfbdrv=
.c
> +++ b/drivers/video/fbdev/mb862xx/mb862xxfbdrv.c
> @@ -684,10 +684,8 @@ static int of_platform_mb862xx_probe(str
>         }
>
>         info =3D framebuffer_alloc(sizeof(struct mb862xxfb_par), dev);
> -       if (info =3D NULL) {
> -               dev_err(dev, "cannot allocate framebuffer\n");
> +       if (!info)
>                 return -ENOMEM;
> -       }
>
>         par =3D info->par;
>         par->info =3D info;
> @@ -1009,7 +1007,6 @@ static int mb862xx_pci_probe(struct pci_
>
>         info =3D framebuffer_alloc(sizeof(struct mb862xxfb_par), dev);
>         if (!info) {
> -               dev_err(dev, "framebuffer alloc failed\n");
>                 ret =3D -ENOMEM;
>                 goto dis_dev;
>         }
> Index: b/drivers/video/fbdev/mbx/mbxfb.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- a/drivers/video/fbdev/mbx/mbxfb.c
> +++ b/drivers/video/fbdev/mbx/mbxfb.c
> @@ -899,10 +899,8 @@ static int mbxfb_probe(struct platform_d
>         }
>
>         fbi =3D framebuffer_alloc(sizeof(struct mbxfb_info), &dev->dev);
> -       if (fbi =3D NULL) {
> -               dev_err(&dev->dev, "framebuffer_alloc failed\n");
> +       if (!fbi)
>                 return -ENOMEM;
> -       }
>
>         mfbi =3D fbi->par;
>         fbi->pseudo_palette =3D mfbi->pseudo_palette;
> Index: b/drivers/video/fbdev/omap/omapfb_main.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- a/drivers/video/fbdev/omap/omapfb_main.c
> +++ b/drivers/video/fbdev/omap/omapfb_main.c
> @@ -1515,8 +1515,6 @@ static int planes_init(struct omapfb_dev
>                 fbi =3D framebuffer_alloc(sizeof(struct omapfb_plane_stru=
ct),
>                                         fbdev->dev);
>                 if (fbi =3D NULL) {
> -                       dev_err(fbdev->dev,
> -                               "unable to allocate memory for plane info=
\n");
>                         planes_cleanup(fbdev);
>                         return -ENOMEM;
>                 }
> Index: b/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- a/drivers/video/fbdev/omap2/omapfb/omapfb-=
main.c
> +++ b/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
> @@ -1892,12 +1892,8 @@ static int omapfb_create_framebuffers(st
>
>                 fbi =3D framebuffer_alloc(sizeof(struct omapfb_info),
>                                 fbdev->dev);
> -
> -               if (fbi =3D NULL) {
> -                       dev_err(fbdev->dev,
> -                               "unable to allocate memory for plane info=
\n");
> +               if (!fbi)
>                         return -ENOMEM;
> -               }
>
>                 clear_fb_info(fbi);
>
> Index: b/drivers/video/fbdev/platinumfb.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- a/drivers/video/fbdev/platinumfb.c
> +++ b/drivers/video/fbdev/platinumfb.c
> @@ -538,10 +538,9 @@ static int platinumfb_probe(struct platf
>         dev_info(&odev->dev, "Found Apple Platinum video hardware\n");
>
>         info =3D framebuffer_alloc(sizeof(*pinfo), &odev->dev);
> -       if (info =3D NULL) {
> -               dev_err(&odev->dev, "Failed to allocate fbdev !\n");
> +       if (!info)
>                 return -ENOMEM;
> -       }
> +
>         pinfo =3D info->par;
>
>         if (of_address_to_resource(dp, 0, &pinfo->rsrc_reg) ||
> Index: b/drivers/video/fbdev/pmag-aa-fb.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- a/drivers/video/fbdev/pmag-aa-fb.c
> +++ b/drivers/video/fbdev/pmag-aa-fb.c
> @@ -165,10 +165,8 @@ static int pmagaafb_probe(struct device
>         int err;
>
>         info =3D framebuffer_alloc(sizeof(struct aafb_par), dev);
> -       if (!info) {
> -               printk(KERN_ERR "%s: Cannot allocate memory\n", dev_name(=
dev));
> +       if (!info)
>                 return -ENOMEM;
> -       }
>
>         par =3D info->par;
>         dev_set_drvdata(dev, info);
> Index: b/drivers/video/fbdev/pmag-ba-fb.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- a/drivers/video/fbdev/pmag-ba-fb.c
> +++ b/drivers/video/fbdev/pmag-ba-fb.c
> @@ -150,10 +150,8 @@ static int pmagbafb_probe(struct device
>         int err;
>
>         info =3D framebuffer_alloc(sizeof(struct pmagbafb_par), dev);
> -       if (!info) {
> -               printk(KERN_ERR "%s: Cannot allocate memory\n", dev_name(=
dev));
> +       if (!info)
>                 return -ENOMEM;
> -       }
>
>         par =3D info->par;
>         dev_set_drvdata(dev, info);
> Index: b/drivers/video/fbdev/pmagb-b-fb.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- a/drivers/video/fbdev/pmagb-b-fb.c
> +++ b/drivers/video/fbdev/pmagb-b-fb.c
> @@ -257,10 +257,8 @@ static int pmagbbfb_probe(struct device
>         int err;
>
>         info =3D framebuffer_alloc(sizeof(struct pmagbbfb_par), dev);
> -       if (!info) {
> -               printk(KERN_ERR "%s: Cannot allocate memory\n", dev_name(=
dev));
> +       if (!info)
>                 return -ENOMEM;
> -       }
>
>         par =3D info->par;
>         dev_set_drvdata(dev, info);
> Index: b/drivers/video/fbdev/pvr2fb.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- a/drivers/video/fbdev/pvr2fb.c
> +++ b/drivers/video/fbdev/pvr2fb.c
> @@ -1069,12 +1069,8 @@ static int __init pvr2fb_init(void)
>  #endif
>
>         fb_info =3D framebuffer_alloc(sizeof(struct pvr2fb_par), NULL);
> -
> -       if (!fb_info) {
> -               printk(KERN_ERR "Failed to allocate memory for fb_info\n"=
);
> +       if (!fb_info)
>                 return -ENOMEM;
> -       }
> -
>
>         currentpar =3D fb_info->par;
>
> Index: b/drivers/video/fbdev/riva/fbdev.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- a/drivers/video/fbdev/riva/fbdev.c
> +++ b/drivers/video/fbdev/riva/fbdev.c
> @@ -1902,7 +1902,6 @@ static int rivafb_probe(struct pci_dev *
>
>         info =3D framebuffer_alloc(sizeof(struct riva_par), &pd->dev);
>         if (!info) {
> -               printk (KERN_ERR PFX "could not allocate memory\n");
>                 ret =3D -ENOMEM;
>                 goto err_ret;
>         }
> Index: b/drivers/video/fbdev/s3c-fb.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- a/drivers/video/fbdev/s3c-fb.c
> +++ b/drivers/video/fbdev/s3c-fb.c
> @@ -1189,10 +1189,8 @@ static int s3c_fb_probe_win(struct s3c_f
>
>         fbinfo =3D framebuffer_alloc(sizeof(struct s3c_fb_win) +
>                                    palette_size * sizeof(u32), sfb->dev);
> -       if (!fbinfo) {
> -               dev_err(sfb->dev, "failed to allocate framebuffer\n");
> +       if (!fbinfo)
>                 return -ENOMEM;
> -       }
>
>         windata =3D sfb->pdata->win[win_no];
>         initmode =3D *sfb->pdata->vtiming;
> Index: b/drivers/video/fbdev/s3fb.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- a/drivers/video/fbdev/s3fb.c
> +++ b/drivers/video/fbdev/s3fb.c
> @@ -1128,10 +1128,8 @@ static int s3_pci_probe(struct pci_dev *
>
>         /* Allocate and fill driver data structure */
>         info =3D framebuffer_alloc(sizeof(struct s3fb_info), &(dev->dev));
> -       if (!info) {
> -               dev_err(&(dev->dev), "cannot allocate memory\n");
> +       if (!info)
>                 return -ENOMEM;
> -       }
>
>         par =3D info->par;
>         mutex_init(&par->open_lock);
> Index: b/drivers/video/fbdev/sh_mobile_lcdcfb.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- a/drivers/video/fbdev/sh_mobile_lcdcfb.c
> +++ b/drivers/video/fbdev/sh_mobile_lcdcfb.c
> @@ -1644,10 +1644,8 @@ sh_mobile_lcdc_overlay_fb_init(struct sh
>
>         /* Allocate and initialize the frame buffer device. */
>         info =3D framebuffer_alloc(0, priv->dev);
> -       if (info =3D NULL) {
> -               dev_err(priv->dev, "unable to allocate fb_info\n");
> +       if (!info)
>                 return -ENOMEM;
> -       }
>
>         ovl->info =3D info;
>
> @@ -2138,10 +2136,8 @@ sh_mobile_lcdc_channel_fb_init(struct sh
>          * list and allocate the color map.
>          */
>         info =3D framebuffer_alloc(0, priv->dev);
> -       if (info =3D NULL) {
> -               dev_err(priv->dev, "unable to allocate fb_info\n");
> +       if (!info)
>                 return -ENOMEM;
> -       }
>
>         ch->info =3D info;
>
> Index: b/drivers/video/fbdev/sm501fb.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- a/drivers/video/fbdev/sm501fb.c
> +++ b/drivers/video/fbdev/sm501fb.c
> @@ -1868,10 +1868,8 @@ static int sm501fb_probe_one(struct sm50
>         }
>
>         fbi =3D framebuffer_alloc(sizeof(struct sm501fb_par), info->dev);
> -       if (fbi =3D NULL) {
> -               dev_err(info->dev, "cannot allocate %s framebuffer\n", na=
me);
> +       if (!fbi)
>                 return -ENOMEM;
> -       }
>
>         par =3D fbi->par;
>         par->info =3D info;
> Index: b/drivers/video/fbdev/sm712fb.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- a/drivers/video/fbdev/sm712fb.c
> +++ b/drivers/video/fbdev/sm712fb.c
> @@ -1538,7 +1538,6 @@ static int smtcfb_pci_probe(struct pci_d
>
>         info =3D framebuffer_alloc(sizeof(*sfb), &pdev->dev);
>         if (!info) {
> -               dev_err(&pdev->dev, "framebuffer_alloc failed\n");
>                 err =3D -ENOMEM;
>                 goto failed_free;
>         }
> Index: b/drivers/video/fbdev/smscufx.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- a/drivers/video/fbdev/smscufx.c
> +++ b/drivers/video/fbdev/smscufx.c
> @@ -1653,10 +1653,8 @@ static int ufx_usb_probe(struct usb_inte
>
>         /* allocates framebuffer driver structure, not framebuffer memory=
 */
>         info =3D framebuffer_alloc(0, &usbdev->dev);
> -       if (!info) {
> -               dev_err(dev->gdev, "framebuffer_alloc failed\n");
> +       if (!info)
>                 goto e_nomem;
> -       }
>
>         dev->info =3D info;
>         info->par =3D dev;
> Index: b/drivers/video/fbdev/ssd1307fb.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- a/drivers/video/fbdev/ssd1307fb.c
> +++ b/drivers/video/fbdev/ssd1307fb.c
> @@ -556,10 +556,8 @@ static int ssd1307fb_probe(struct i2c_cl
>         }
>
>         info =3D framebuffer_alloc(sizeof(struct ssd1307fb_par), &client-=
>dev);
> -       if (!info) {
> -               dev_err(&client->dev, "Couldn't allocate framebuffer.\n");
> +       if (!info)
>                 return -ENOMEM;
> -       }
>
>         par =3D info->par;
>         par->info =3D info;
> Index: b/drivers/video/fbdev/sunxvr1000.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- a/drivers/video/fbdev/sunxvr1000.c
> +++ b/drivers/video/fbdev/sunxvr1000.c
> @@ -121,7 +121,6 @@ static int gfb_probe(struct platform_dev
>
>         info =3D framebuffer_alloc(sizeof(struct gfb_info), &op->dev);
>         if (!info) {
> -               printk(KERN_ERR "gfb: Cannot allocate fb_info\n");
>                 err =3D -ENOMEM;
>                 goto err_out;
>         }
> Index: b/drivers/video/fbdev/sunxvr2500.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- a/drivers/video/fbdev/sunxvr2500.c
> +++ b/drivers/video/fbdev/sunxvr2500.c
> @@ -132,7 +132,6 @@ static int s3d_pci_register(struct pci_d
>
>         info =3D framebuffer_alloc(sizeof(struct s3d_info), &pdev->dev);
>         if (!info) {
> -               printk(KERN_ERR "s3d: Cannot allocate fb_info\n");
>                 err =3D -ENOMEM;
>                 goto err_disable;
>         }
> Index: b/drivers/video/fbdev/sunxvr500.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- a/drivers/video/fbdev/sunxvr500.c
> +++ b/drivers/video/fbdev/sunxvr500.c
> @@ -272,7 +272,6 @@ static int e3d_pci_register(struct pci_d
>
>         info =3D framebuffer_alloc(sizeof(struct e3d_info), &pdev->dev);
>         if (!info) {
> -               printk(KERN_ERR "e3d: Cannot allocate fb_info\n");
>                 err =3D -ENOMEM;
>                 goto err_disable;
>         }
> Index: b/drivers/video/fbdev/tgafb.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- a/drivers/video/fbdev/tgafb.c
> +++ b/drivers/video/fbdev/tgafb.c
> @@ -1416,10 +1416,8 @@ static int tgafb_register(struct device
>
>         /* Allocate the fb and par structures.  */
>         info =3D framebuffer_alloc(sizeof(struct tga_par), dev);
> -       if (!info) {
> -               printk(KERN_ERR "tgafb: Cannot allocate memory\n");
> +       if (!info)
>                 return -ENOMEM;
> -       }
>
>         par =3D info->par;
>         dev_set_drvdata(dev, info);
> Index: b/drivers/video/fbdev/udlfb.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- a/drivers/video/fbdev/udlfb.c
> +++ b/drivers/video/fbdev/udlfb.c
> @@ -1689,10 +1689,8 @@ static int dlfb_usb_probe(struct usb_int
>
>         /* allocates framebuffer driver structure, not framebuffer memory=
 */
>         info =3D framebuffer_alloc(0, &dlfb->udev->dev);
> -       if (!info) {
> -               dev_err(&dlfb->udev->dev, "framebuffer_alloc failed\n");
> +       if (!info)
>                 goto error;
> -       }
>
>         dlfb->info =3D info;
>         info->par =3D dlfb;
> Index: b/drivers/video/fbdev/via/viafbdev.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- a/drivers/video/fbdev/via/viafbdev.c
> +++ b/drivers/video/fbdev/via/viafbdev.c
> @@ -1756,10 +1756,8 @@ int via_fb_pci_probe(struct viafb_dev *v
>         viafbinfo =3D framebuffer_alloc(viafb_par_length +
>                 ALIGN(sizeof(struct viafb_shared), BITS_PER_LONG/8),
>                 &vdev->pdev->dev);
> -       if (!viafbinfo) {
> -               printk(KERN_ERR"Could not allocate memory for viafb_info.=
\n");
> +       if (!viafbinfo)
>                 return -ENOMEM;
> -       }
>
>         viaparinfo =3D (struct viafb_par *)viafbinfo->par;
>         viaparinfo->shared =3D viafbinfo->par + viafb_par_length;
> @@ -1834,8 +1832,6 @@ int via_fb_pci_probe(struct viafb_dev *v
>                 viafbinfo1 =3D framebuffer_alloc(viafb_par_length,
>                                 &vdev->pdev->dev);
>                 if (!viafbinfo1) {
> -                       printk(KERN_ERR
> -                       "allocate the second framebuffer struct error\n");
>                         rc =3D -ENOMEM;
>                         goto out_fb_release;
>                 }
> Index: b/drivers/video/fbdev/vt8623fb.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- a/drivers/video/fbdev/vt8623fb.c
> +++ b/drivers/video/fbdev/vt8623fb.c
> @@ -669,10 +669,8 @@ static int vt8623_pci_probe(struct pci_d
>
>         /* Allocate and fill driver data structure */
>         info =3D framebuffer_alloc(sizeof(struct vt8623fb_info), &(dev->d=
ev));
> -       if (! info) {
> -               dev_err(&(dev->dev), "cannot allocate memory\n");
> +       if (!info)
>                 return -ENOMEM;
> -       }
>
>         par =3D info->par;
>         mutex_init(&par->open_lock);
