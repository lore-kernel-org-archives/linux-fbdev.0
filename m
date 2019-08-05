From: Lee Jones <lee.jones@linaro.org>
Date: Mon, 05 Aug 2019 10:36:00 +0000
Subject: Re: [PATCH v1 1/1] backlight: drop EARLY_EVENT_BLANK support
Message-Id: <20190805103600.GF4739@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190725143224.GB31803@ravnborg.org>
 <20190726095016.wsj7jnni5zdh37dl@holly.lan>
 <20190726112724.GB20065@ravnborg.org>
In-Reply-To: <20190726112724.GB20065@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, Gerd Hoffmann <kraxel@redhat.com>, Jingoo Han <jingoohan1@gmail.com>, Peter Rosin <peda@axentia.se>

On Fri, 26 Jul 2019, Sam Ravnborg wrote:

> Hi Daniel.
> 
> On Fri, Jul 26, 2019 at 10:50:16AM +0100, Daniel Thompson wrote:
> > On Thu, Jul 25, 2019 at 04:32:24PM +0200, Sam Ravnborg wrote:
> > > There was no users left - so drop the code to support EARLY_FB_BLANK.
> > 
> > Why are we using a different noun for the subject and description?
> I fat-fingered the description.

> Will fix when I apply - or send out a v2 if requested.

Okay, just apply it then:

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
