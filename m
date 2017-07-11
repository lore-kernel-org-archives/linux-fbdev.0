From: Chris Wilson <chris@chris-wilson.co.uk>
Date: Tue, 11 Jul 2017 14:17:19 +0000
Subject: Re: [PATCH 3/3] drm/msm: hijack firmware fb's memory
Message-Id: <149978263930.26523.10944503054836873541@mail.alporthouse.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170711133822.31978-1-robdclark@gmail.com>
 <20170711133822.31978-4-robdclark@gmail.com>
In-Reply-To: <20170711133822.31978-4-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Quoting Rob Clark (2017-07-11 14:38:22)
> +static unsigned long hijack_firmware_fb(struct drm_device *dev)
> +{
> +       struct msm_drm_private *priv = dev->dev_private;
> +       unsigned long size;
> +       int i;
> +
> +       /* if we have simplefb/efifb, find it's aperture and hijack
> +        * that before we kick out the firmware fb's.
> +        *
> +        * TODO we probably should hold registration_lock
> +        */
> +       for (i = 0; i < FB_MAX; i++) {
> +               struct fb_info *fb = get_fb_info(i);
> +
> +               if (IS_ERR_OR_NULL(fb))
> +                       continue;
> +
> +               if (!fb->apertures->count)

Does get_fb_info() not return a reference if its apertures->count=0?

> +                       continue;
> +
> +               /* if we find efifb or simplefb, we are about to
> +                * kick them out, so hijack their memory:
> +                */
> +               if ((strcmp(fb->fix.id, "EFI VGA") = 0) ||
> +                               (strcmp(fb->fix.id, "simple") = 0)) {
> +
> +                       priv->vram.paddr = fb->apertures->ranges[0].base;
> +                       size = fb->apertures->ranges[0].size;
> +               }
> +
> +               put_fb_info(fb);
> +
> +               if (size)
> +                       return size;

size is never initialised to 0. Perhaps just return the reference to the
matching fb? Hopefully sidestepping a few of the worries about it
disappearing during the probe.
-Chris
