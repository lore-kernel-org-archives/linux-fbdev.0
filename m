From: Tony Lindgren <tony@atomide.com>
Date: Tue, 17 Dec 2013 15:30:02 +0000
Subject: Re: [PATCHv2 01/27] ARM: OMAP: remove DSS DT hack
Message-Id: <20131217153001.GN12324@atomide.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1387205794-32246-1-git-send-email-tomi.valkeinen@ti.com>
 <1387205794-32246-2-git-send-email-tomi.valkeinen@ti.com>
 <20131216184157.GA26293@atomide.com>
 <52AFF31C.6010100@ti.com>
In-Reply-To: <52AFF31C.6010100@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [131216 22:47]:
> On 2013-12-16 20:41, Tony Lindgren wrote:
> > * Tomi Valkeinen <tomi.valkeinen@ti.com> [131216 06:59]:
> >> As a temporary solution to enable DSS for selected boards when booting
> >> with DT, a hack was added to board-generic.c in
> >> 63d5fc0c2f748e20f38a0a0ec1c8494bddf5c288 (OMAP: board-generic: enable
> >> DSS for panda & sdp boards).
> >>
> >> We're now adding proper DT support, so the hack can be removed.
> > 
> > I guess this patch should be merged later on after we have the DT support
> > working?
> 
> I'll move this patch also to the end of the series.
> 
> "Merged later" sounds like you mean this could be merged in a separate
> series. I think this and the other removal can be in this series, they
> just need to be at the end.

Well yeah let's keep those separate still as at least Russell needed
some more time with the legacy booting. The point we can drop the
legacy booting for omap3 may still need to wait a bit, maybe even
until v3.15 to keep things working.

Regards,

Tony
