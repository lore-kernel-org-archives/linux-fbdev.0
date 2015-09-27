From: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Date: Sun, 27 Sep 2015 13:09:48 +0000
Subject: Re: No more new fbdev drivers, please
Message-Id: <5607EA9C.7040909@tronnes.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <5603EC15.9090605@ti.com>
In-Reply-To: <5603EC15.9090605@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fbdev <linux-fbdev@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Dave Airlie <airlied@redhat.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


Den 24.09.2015 14:27, skrev Tomi Valkeinen:
> Hi all,
>
> fbdev is (more or less) maintained, but it's a deprecated framework. All
> new Linux display drivers should be done on DRM.
>
> So let's not add any more new fbdev drivers.
>
> I will continue to maintain the current fbdev drivers, and I don't mind
> adding some new features to those current drivers, as long as the amount
> of code required to add the features stays sensible.
>
> I see we have three fbdev drivers in staging: xgifb, fbtft and sm750fb,
> and the question is what to do with those.
>
> xgifb was added in 2010, and is still in staging.
>
> fbtft looks like maybe some kind of framework on top of fbdev, with
> fbtft specific subdrivers... I didn't look at it in detail, but my gut
> says "never".

I have done some work [1] to try and make fbtft look more like the rest
of the kernel (doc [2]), but that work will result in an almost complete
rewrite of fbtft. When Tomi showed reluctance to move sm712fb out of
staging [3], I started to look at DRM to see if I could find my way
through the myriad of helpers and objects/structs.

I now have this simplified view of DRM [4]:

struct tinydrm_device {
         struct drm_device *base;
         struct drm_plane plane;
         struct drm_crtc crtc;
         struct drm_encoder encoder;
         struct drm_connector connector;
         struct drm_fbdev_cma *fbdev_cma;
         bool enabled;
         u32 width, height;
         void *dev_private;

         int (*enable)(struct tinydrm_device *tdev);
         int (*disable)(struct tinydrm_device *tdev);

         int (*dirty)(struct drm_framebuffer *fb,
                      struct drm_gem_cma_object *cma_obj,
                      unsigned flags, unsigned color,
                      struct drm_clip_rect *clips, unsigned num_clips);
         /* blank() is missing */
         /* maybe some modeset() function to set hw rotation */
};

Currently I'm able to get fbdev framebuffer changes through as dirty()
calls. Next step is to hook up some of the rewritten fbtft code to
actually get something on the display.

This is the display controller abstraction I use in the rewritten fbtft:

struct lcdctrl {
         struct lcdreg *lcdreg;
         u32 width;
         u32 height;
         u32 rotation;
         bool enabled;
         struct regulator *power_supply;
         void *driver_private;
         u64 flags;

         int (*poweron)(struct lcdctrl *ctrl);
         void (*poweroff)(struct lcdctrl *ctrl);
         int (*update)(struct lcdctrl *ctrl, struct lcdctrl_update *update);
         int (*rotate)(struct lcdctrl *ctrl, u32 rotation);
         int (*blank)(struct lcdctrl *ctrl, bool blank);
         bool (*check)(struct lcdctrl *ctrl, u32 value);
};

So what I would like, is to have a simple struct like this to hide the
complexity of the graphics subsystem. Leaving the driver with just a
few lines of code to setup the controller:

static int ada_mipifb_1480_poweron(struct lcdctrl *ctrl)
{
         lcdreg_reset(reg);
         lcdreg_writereg(reg, ILI9340_PWCTRL1, 0x23);
[...]
}

static int ada_mipifb_probe(struct spi_device *spi)
{
         cfg.width = 240;
         cfg.height = 320;
         cfg.addr_mode0 = ILI9340_MADCTL_MX;
         cfg.addr_mode90 = ILI9340_MADCTL_MV | ILI9340_MADCTL_MY |
               ILI9340_MADCTL_MX;
         cfg.addr_mode180 = ILI9340_MADCTL_MY;
         cfg.addr_mode270 = ILI9340_MADCTL_MV;
         cfg.bgr = true;

         reg = devm_lcdreg_spi_init(spi, LCDREG_SPI_4WIRE);

         ctrl = devm_mipi_dbi_init(reg, &cfg);
         ctrl->poweron = ada_mipifb_1480_poweron;

         return devm_lcdctrl_register(ctrl);
}


For me personally it doesn't matter whether these drivers are drm or fbdev.
fbdev has everything these drivers need, but maybe it's not such a good 
choice
for the future.


Noralf.


[1] https://github.com/notro/linux-staging/commits/next
[2] 
https://github.com/notro/linux-staging/blob/next/drivers/staging/fbtft/Documentation/fb/fbtft.txt
[3] https://lkml.org/lkml/2015/9/1/274
[4] https://gist.github.com/notro/59e0c064bc512e85e9b2

