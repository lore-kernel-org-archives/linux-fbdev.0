From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Fri, 12 Oct 2012 07:21:02 +0000
Subject: Re: [PATCH 1/2 v6] of: add helper to parse display timings
Message-Id: <20121012072102.GA32500@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1349373560-11128-1-git-send-email-s.trumtrar@pengutronix.de>
 <1349373560-11128-2-git-send-email-s.trumtrar@pengutronix.de>
 <1349680065.3227.25.camel@deskari>
 <20121008074921.GB20800@pengutronix.de>
 <20121011193118.GA27599@avionic-0098.mockup.avionic-design.de>
In-Reply-To: <20121011193118.GA27599@avionic-0098.mockup.avionic-design.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, devicetree-discuss@lists.ozlabs.org, Rob Herring <robherring2@gmail.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-media@vger.kernel.org

On Thu, Oct 11, 2012 at 09:31:18PM +0200, Thierry Reding wrote:
> On Mon, Oct 08, 2012 at 09:49:21AM +0200, Steffen Trumtrar wrote:
> > On Mon, Oct 08, 2012 at 10:07:45AM +0300, Tomi Valkeinen wrote:
> > > On Thu, 2012-10-04 at 19:59 +0200, Steffen Trumtrar wrote:
> [...]
> > > > +
> > > > +	disp->num_timings = 0;
> > > > +
> > > > +	for_each_child_of_node(timings_np, entry) {
> > > > +		disp->num_timings++;
> > > > +	}
> > > 
> > > No need for { }
> > > 
> > 
> > Okay.
> 
> Or you could just use of_get_child_count().
> 
> Thierry

Ah, very nice. That's definitely better. Didn't know about that function.

Thanks,
Steffen


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
