From: Rob Clark <robdclark@gmail.com>
Date: Tue, 11 Jul 2017 14:31:42 +0000
Subject: Re: [PATCH 3/3] drm/msm: hijack firmware fb's memory
Message-Id: <CAF6AEGsh-5SAEtSjWz9kPZRpZA7yaVOS3PiKAutMLJEdTS7ogg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170711133822.31978-1-robdclark@gmail.com>
 <20170711133822.31978-4-robdclark@gmail.com>
 <CAKMK7uGLEaiZcTgd=2JzO22=+uMqF7iGzeJTy5Jdf2Qsf4Ecaw@mail.gmail.com>
In-Reply-To: <CAKMK7uGLEaiZcTgd=2JzO22=+uMqF7iGzeJTy5Jdf2Qsf4Ecaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Vetter <daniel@ffwll.ch>
Cc: linux-arm-msm <linux-arm-msm@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On Tue, Jul 11, 2017 at 10:03 AM, Daniel Vetter <daniel@ffwll.ch> wrote:
> On Tue, Jul 11, 2017 at 3:38 PM, Rob Clark <robdclark@gmail.com> wrote:
>> +static unsigned long hijack_firmware_fb(struct drm_device *dev)
>> +{
>> +       struct msm_drm_private *priv = dev->dev_private;
>> +       unsigned long size;
>> +       int i;
>> +
>> +       /* if we have simplefb/efifb, find it's aperture and hijack
>> +        * that before we kick out the firmware fb's.
>> +        *
>> +        * TODO we probably should hold registration_lock
>> +        */
>> +       for (i = 0; i < FB_MAX; i++) {
>> +               struct fb_info *fb = get_fb_info(i);
>> +
>> +               if (IS_ERR_OR_NULL(fb))
>> +                       continue;
>> +
>> +               if (!fb->apertures->count)
>> +                       continue;
>> +
>> +               /* if we find efifb or simplefb, we are about to
>> +                * kick them out, so hijack their memory:
>> +                */
>> +               if ((strcmp(fb->fix.id, "EFI VGA") = 0) ||
>> +                               (strcmp(fb->fix.id, "simple") = 0)) {
>> +
>> +                       priv->vram.paddr = fb->apertures->ranges[0].base;
>> +                       size = fb->apertures->ranges[0].size;
>> +               }
>> +
>> +               put_fb_info(fb);
>> +
>> +               if (size)
>> +                       return size;
>> +       }
>> +
>> +       return 0;
>> +}
>
> I think this should be a helper function in at least drm_fb_helper.c,
> which would then fill in both base&size in a passed-in struct. But
> yeah this seems a lot better than the old one.

Yeah, I guess we could do that.. but probably not in drm_fb_helper.c
since that is compile-time optional.  Better suggestions about where
it should live?  If you have fbdev but not DRM_FBDEV_EMULATION you
still want to do this, I think.  Otherwise we can't completely take
over the display setup by firmware (ie. no way to create
plane->state->fb).

BR,
-R


> In the future we could then also extend this with kicking out other
> firmware fb things.
> -Daniel
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> +41 (0) 79 365 57 48 - http://blog.ffwll.ch
