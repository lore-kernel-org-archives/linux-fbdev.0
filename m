From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Fri, 28 Feb 2014 16:27:52 +0000
Subject: Re: [PATCH 0/9] Doc/DT: DT bindings for various display components
Message-Id: <20140228162752.GU21483@n2100.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1393590016-9361-1-git-send-email-tomi.valkeinen-l0cyMroinI0@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Andrzej Hajda <a.hajda-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

On Fri, Feb 28, 2014 at 02:20:07PM +0200, Tomi Valkeinen wrote:
> Shortly about the display components in the series, in the order of probable
> public interest:
> 
> * Analog TV, DVI and HDMI Connectors represent a respective connector on the
>   board. They don't do much, but they do mark the end of the video pipeline (from
>   the board's pov), and they should also in the future offer ways to handle
>   things like the +5V pin on DVI and HDMI connector and HPD pin.

The big thing which concerns me is that we're using very generic
compatible strings here - has anyone done any searches to see whether
there are any existing standards for this kind of stuff already?

Even if none can be found, if we're going to create something like
this, it should probably become a public standard not just for Linux.

If we're not willing to do that, I'd suggest prefixing the compatible
strings with "linux," as a "company" identifier so that there's no
chance that we may hit some major problem caused by a conflicting
implementation in the future.

We could alternatively take the view that Linux will only ever be used
with Linux specific DT files, but I think that's a rather broken
approach given what DT is supposed to be.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
