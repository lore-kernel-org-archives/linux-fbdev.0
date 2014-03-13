From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Thu, 13 Mar 2014 12:01:37 +0000
Subject: Re: [PATCH v5 1/2] video: ARM CLCD: Add DT support
Message-Id: <20140313120136.GN21483@n2100.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1394036606-17784-1-git-send-email-pawel.moll@arm.com>
 <53184C2E.3000807@ti.com> <1394119431.4160.84.camel@hornet>
 <5319AF00.5030602@ti.com> <1394453382.3853.6.camel@hornet>
 <531DAEB9.3020502@ti.com>
In-Reply-To: <531DAEB9.3020502@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Mar 10, 2014 at 02:23:21PM +0200, Tomi Valkeinen wrote:
> On 10/03/14 14:09, Pawel Moll wrote:
> 
> >> Note that the same DT bindings you add here should also work for the DRM
> >> driver in the future. So, in fact, the question is extended to: will the
> >> fbdev 
> > 
> > No, I don't think so. It's a end of line for it, I believe. From my
> > personal point of view the main goal is to fill the last gap between DT
> > and non-DT support on one of the Versatile Express boards - CLCD works
> > fine when booted with ATAGs, doesn't work when booted with DT. It looks
> > bad.
> 
> The DT describes the hardware, and there should be only one description
> of it, no matter what the used SW is. I see compatible = "arm,pl111" in
> the dts. PL111 is the LCD controller, right? What will the DRM driver
> use, then, if the "arm,pl111" DT data is designed to work only for the
> fbdev?

If we could move forward with things like DT bindings for DRM (which
seems impossible) then we might be able to move forward with a proper
DT implementation for componentised video systems which would solve
this as you'd have the pl111 as just a CRTC component in a larger
subsystem representation which included things like encoders and
connectors - even for something as simple as the Versatile Express
boards.

These boards have a DVI connector which offers analogue (and probably
digital) output.  Previous boards like Versatile and Integrator have
offered VGA output and a connector for various LCD panels (sometimes
the connected LCD panel is identified via a set of GPIOs.)

So, going ahead with some bindings which include stuff like timing
information in a pl111 node seems wrong and boxes us in if we're going
to start representing connectors as well - as the timing should be part
of the panel node or similar.

So basically all movement on display subsystem DT representations is
now blocked because no one can agree how they should be represented in
a decent way.

Maybe board files were much better than this frigging DT crap.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
