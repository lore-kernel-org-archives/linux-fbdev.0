From: Lee Jones <lee.jones@linaro.org>
Date: Thu, 25 Jul 2019 15:06:29 +0000
Subject: Re: [PATCH v1 1/1] backlight: drop EARLY_EVENT_BLANK support
Message-Id: <20190725150629.GN23883@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190725143224.GB31803@ravnborg.org>
 <20190725143934.GH15868@phenom.ffwll.local>
In-Reply-To: <20190725143934.GH15868@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, Gerd Hoffmann <kraxel@redhat.com>, Jingoo Han <jingoohan1@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, Peter Rosin <peda@axentia.se>

On Thu, 25 Jul 2019, Daniel Vetter wrote:

> On Thu, Jul 25, 2019 at 04:32:24PM +0200, Sam Ravnborg wrote:
> > There was no users left - so drop the code to support EARLY_FB_BLANK.
> > This patch removes the support in backlight,
> > and drop the notifier in fbmem.
> > 
> > That EARLY_FB_BLANK is not used can be verified that no driver set any of:
> > 
> >     lcd_ops.early_set_power()
> >     lcd_ops.r_early_set_power()
> > 
> > Noticed while browsing backlight code for other reasons.
> 
> Ah I didn't grep hard enough, I didn't realize that no one sets the
> lcd_ops->(r_)early_set_power hooks. Nice find!
> 
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> 
> > Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Cc: Daniel Thompson <daniel.thompson@linaro.org>
> > Cc: Jingoo Han <jingoohan1@gmail.com>
> > Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Cc: Sam Ravnborg <sam@ravnborg.org>
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: "Michał Mirosław" <mirq-linux@rere.qmqm.pl>
> > Cc: Peter Rosin <peda@axentia.se>
> > Cc: Gerd Hoffmann <kraxel@redhat.com>
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: linux-fbdev@vger.kernel.org
> > ---
> > 
> > Build tested with various architectures, configs.
> > 
> > Lee, Daniel - OK to commit to drm-misc-next where fbdev stuff is
> > maintained today?
> 
> backlight is separate from fbdev in Lee's own tree, not in drm-misc. I
> think at least.

That's correct.  We'll sort that once we have all the Acks.

> >  drivers/video/backlight/lcd.c    |  8 --------
> >  drivers/video/fbdev/core/fbmem.c | 12 +-----------
> >  include/linux/fb.h               |  4 ----
> >  include/linux/lcd.h              | 10 ----------
> >  4 files changed, 1 insertion(+), 33 deletions(-)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
