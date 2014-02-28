From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Fri, 28 Feb 2014 16:23:27 +0000
Subject: Re: [PATCH 3/9] Doc/DT: Add DT binding documentation for DVI Connector
Message-Id: <20140228162327.GT21483@n2100.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com> <1393590016-9361-4-git-send-email-tomi.valkeinen@ti.com> <20140228155937.GQ21483@n2100.arm.linux.org.uk> <5310B567.7040605@ti.com>
In-Reply-To: <5310B567.7040605-l0cyMroinI0@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Andrzej Hajda <a.hajda-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

On Fri, Feb 28, 2014 at 06:12:23PM +0200, Tomi Valkeinen wrote:
> On 28/02/14 17:59, Russell King - ARM Linux wrote:
> 
> >> +dvi0: connector@0 {
> >> +	compatible = "dvi-connector";
> >> +	label = "dvi";
> >> +
> >> +	i2c-bus = <&i2c3>;
> >> +
> >> +	dvi_connector_in: endpoint {
> >> +		remote-endpoint = <&tfp410_out>;
> >> +	};
> >> +};
> > 
> > This looks far too simplistic.  There are different classes of DVI
> > connector - there is:
> > 
> > DVI A - analogue only
> > DVI D - digital only (single and dual link)
> > DVI I - both (single and dual digital link)
> > 
> > DRM at least makes a distinction between these three classes, and this
> > disctinction is part of the user API.  How would a display system know
> > which kind of DVI connector is wired up on the board from this DT
> > description?
> 
> Yes, I think that's a valid change. But do we also need to specify
> single/dual link, in addition to the three types?

I would argue that as it's a difference in physical hardware, then it
should be described in DT, even if we don't use it.  The reasoning is
that although we may not use it today, we may need to use it in the
future, and as we're describing what the hardware actually is - and
even in this case what pins may be present or missing on the connector,
it's unlikely to be problematical (the only problem is when someone
omits it...)

> I guess the compatible string is the easiest way for differentation, at
> least for the three main types, i.e. "dvi-d-connector" etc.
> 
> "dvi-d-1l-connector" and "dvi-d-2l-connector" for the single/dual link?
> That looks a bit funny.

I think that starts getting a tad messy:

	dvi-a-connector
	dvi-d-1l-connector
	dvi-d-2l-connector
	dvi-i-1l-connector
	dvi-i-2l-connector

That's rather a lot of compatible strings.  Another possibility is:

	compatible = "dvi-connector";
	analog;
	digital;
	single-link;
	dual-link;

I'm debating whether "-signalling" should be on the 2nd and 3rd (or...
-signaling depending on how you prefer to spell that word.)  At least
one of "analog" and/or "digital" must be specified, and if "digital"
is specified, then exactly one of "single-link" or "dual-link" should
be specified.

So, this would mean we end up with:

	compatible = "dvi-connector";
	analog;
	digital;
	dual-link;

for a DVI-I dual-link connector.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
