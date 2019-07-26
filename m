From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 26 Jul 2019 11:27:25 +0000
Subject: Re: [PATCH v1 1/1] backlight: drop EARLY_EVENT_BLANK support
Message-Id: <20190726112724.GB20065@ravnborg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190725143224.GB31803@ravnborg.org>
 <20190726095016.wsj7jnni5zdh37dl@holly.lan>
In-Reply-To: <20190726095016.wsj7jnni5zdh37dl@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel@lists.freedesktop.org, =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, Gerd Hoffmann <kraxel@redhat.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Peter Rosin <peda@axentia.se>

Hi Daniel.

On Fri, Jul 26, 2019 at 10:50:16AM +0100, Daniel Thompson wrote:
> On Thu, Jul 25, 2019 at 04:32:24PM +0200, Sam Ravnborg wrote:
> > There was no users left - so drop the code to support EARLY_FB_BLANK.
> 
> Why are we using a different noun for the subject and description?
I fat-fingered the description.
Will fix when I apply - or send out a v2 if requested.

...

> > 
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
> 
> Other than the quibble about the description...
> 
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>

Thanks,

	Sam
