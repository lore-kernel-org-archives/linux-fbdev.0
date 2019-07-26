From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 26 Jul 2019 16:09:53 +0000
Subject: Re: [PATCH v1 1/1] backlight: drop EARLY_EVENT_BLANK support
Message-Id: <20190726160953.GA25708@ravnborg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190725143224.GB31803@ravnborg.org>
 <20190725143934.GH15868@phenom.ffwll.local>
 <20190725150629.GN23883@dell>
In-Reply-To: <20190725150629.GN23883@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, Gerd Hoffmann <kraxel@redhat.com>, Jingoo Han <jingoohan1@gmail.com>, Peter Rosin <peda@axentia.se>

Hi Lee.

On Thu, Jul 25, 2019 at 04:06:29PM +0100, Lee Jones wrote:
> On Thu, 25 Jul 2019, Daniel Vetter wrote:
> 
> > On Thu, Jul 25, 2019 at 04:32:24PM +0200, Sam Ravnborg wrote:
> > > There was no users left - so drop the code to support EARLY_FB_BLANK.
> > > This patch removes the support in backlight,
> > > and drop the notifier in fbmem.
> > > 
> > > That EARLY_FB_BLANK is not used can be verified that no driver set any of:
> > > 
> > >     lcd_ops.early_set_power()
> > >     lcd_ops.r_early_set_power()
> > > 
> > > Noticed while browsing backlight code for other reasons.
> > 
> > Ah I didn't grep hard enough, I didn't realize that no one sets the
> > lcd_ops->(r_)early_set_power hooks. Nice find!
> > 
> > Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > 
> > > Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> > > Cc: Lee Jones <lee.jones@linaro.org>
> > > Cc: Daniel Thompson <daniel.thompson@linaro.org>
> > > Cc: Jingoo Han <jingoohan1@gmail.com>
> > > Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > > Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> > > Cc: Sam Ravnborg <sam@ravnborg.org>
> > > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > > Cc: "Michał Mirosław" <mirq-linux@rere.qmqm.pl>
> > > Cc: Peter Rosin <peda@axentia.se>
> > > Cc: Gerd Hoffmann <kraxel@redhat.com>
> > > Cc: dri-devel@lists.freedesktop.org
> > > Cc: linux-fbdev@vger.kernel.org
> > > ---
> > > 
> > > Build tested with various architectures, configs.
> > > 
> > > Lee, Daniel - OK to commit to drm-misc-next where fbdev stuff is
> > > maintained today?
> > 
> > backlight is separate from fbdev in Lee's own tree, not in drm-misc. I
> > think at least.
> 
> That's correct.  We'll sort that once we have all the Acks.

We have acks all around now.
OK that I commit this to drm-misc-next?

This is where we maintain fbdev these days. Or you could apply it to
your backlight tree.

Both solutins would be fine as the risk of introducing merge conflicts
in these code paths are minimal.

	Sam
