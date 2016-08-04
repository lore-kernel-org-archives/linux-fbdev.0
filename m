From: Chris Wilson <chris@chris-wilson.co.uk>
Date: Thu, 04 Aug 2016 09:57:29 +0000
Subject: Re: [Intel-gfx] [PATCH] backlight: Avoid double fbcon backlight handling
Message-Id: <20160804095729.GN12611@nuc-i3427.alporthouse.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1467286256-8870-1-git-send-email-chris@chris-wilson.co.uk>
 <20160712122119.GR23520@phenom.ffwll.local>
 <87a8gsq540.fsf@intel.com>
 <20160804095027.GB6232@phenom.ffwll.local>
In-Reply-To: <20160804095027.GB6232@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Milo Kim <milo.kim@ti.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, David Airlie <airlied@linux.ie>, nouveau@lists.freedesktop.org, Jon Nettleton <jon.nettleton@gmail.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Thierry Reding <thierry.reding@gmail.com>, Paul Mackerras <paulus@samba.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Daniel Vetter <daniel.vetter@intel.com>, Lee Jones <lee.jones@linaro.org>, Daniel Drake <dsd@laptop.org>, Jens Frederich <jfrederich@gmail.com>, linux-acpi@vger.kernel.org, Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Ben Skeggs <bskeggs@redhat.com>, Zhang Rui <rui.zhang@intel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Michael Hennerich <michael.hennerich@analog.com>, intel-gfx@lists.f

On Thu, Aug 04, 2016 at 11:50:27AM +0200, Daniel Vetter wrote:
> On Thu, Aug 04, 2016 at 12:02:23PM +0300, Jani Nikula wrote:
> > On Tue, 12 Jul 2016, Daniel Vetter <daniel@ffwll.ch> wrote:
> > > On Thu, Jun 30, 2016 at 12:30:56PM +0100, Chris Wilson wrote:
> > >> Backlights controlled by i915.ko and only associated with its connectors
> > >> and also only associated with the intel_drmfb fbcon, controlled by
> > >> i915.ko. In this situation, we already handle adjusting the backlight
> > >> when the fbcon is blanked/unblanked and do not require backlight trying
> > >> to do the same.
> > >> 
> > >> Attempting to register with the fbdev as a client causes lockdep to warn
> > >> about a dependency cycle:
> > >
> > > The fbdev notifier strikes again!
> > >
> > > Last time I looked into this I think the proper solution would be to split
> > > the backlight part from the other fbdev notifier (which is used by fbcon
> > > for reacting to fbdev device reg/unreg events).
> > >
> > > I think that would fix this too, with the added bonus of slightly
> > > untangling the fbcon locking mess. And it's also the one part of
> > > untangling this mess which should be possible without any trouble - I've
> > > simply never done it since entirely getting rid of the fbdev notifier for
> > > fbcon is a lot more work.
> > 
> > So what do we do with this? It fixes a problem upstream. There's no
> > Fixes: to identify the bad commit. Any idea on that? It's either this or
> > we dig out the bad commit (Chris probably knows which one?) and revert.
> 
> The real trouble is the drm_for_each_connector in
> drm_connector_register_all(). This introduced the new depency. The proper
> fix imo is to fix up the connector_list locking, but for 4.8 we could do
> the same hack+comment like we do in unregister_all. It's not the only
> place that's broken anyway, and much less invasive than this here.

You still have the underlying issue of multiple drivers trying to
control the same piece of hardware, causing duplicate work (at best).
-Chris

-- 
Chris Wilson, Intel Open Source Technology Centre
