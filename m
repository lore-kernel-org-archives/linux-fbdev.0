From: Mike Turquette <mturquette@ti.com>
Date: Thu, 12 Jul 2012 17:10:16 +0000
Subject: Re: Device tree binding for DVFS table
Message-Id: <20120712171016.GL2772@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4FFD77FE.8050206@nvidia.com> <4FFD87BD.2030206@gmail.com>
 <20120711144449.GA23654@sirena.org.uk>
 <20120711200402.GC2772@gmail.com>
 <20120712141001.GE9437@tbergstrom-lnx.Nvidia.com>
In-Reply-To: <20120712141001.GE9437@tbergstrom-lnx.Nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 20120712-17:10, Peter De Schrijver wrote:
> On Wed, Jul 11, 2012 at 10:04:02PM +0200, Mike Turquette wrote:
> > On 20120711-15:44, Mark Brown wrote:
> > > On Wed, Jul 11, 2012 at 09:03:41AM -0500, Rob Herring wrote:
> > > 
> > > > I'd expect a single property with freq/volt pairs or 2 properties for
> > > > freq and voltage where there is a 1:1 relationship (freq N uses voltage N).
> > > 
> > > I strongly agree - the current proposal is very hard to read due to the
> > > separation between the voltage and frequency values.  Some devices do
> > > also need to scale multiple rails together, especially when this gets
> > > used for I/O devices.
> > > 
> > > I'd also expect to see a range of voltages for each frequency rather
> > > than a specific voltage; usually things are at least characterised with
> > > a specified tolerance.
> > 
> > Not only should we support multiple voltage rails but also multiple
> > clocks.  For some devices a DVFS transition is composed of scaling
> > multiple clock rates together.  So some sort of clock identifier
> > (phandle?) is needed as well.  (forgive my ignorance on the phandle
> > part, as I am a DT noob)
> 
> I would say this constraint should be expressed in a seperate DT node. In
> short I think we have 3 things to model:
> 

Peter,

I agree with your observations in general, but I think some specificity
is needed:

> + frequency/voltage relationships

We should be clear that the voltage does NOT belong to the clock, but to
the device/module/IP block that consumes that clock.  This is an
important detail since it means that a clock does not have a
corresponding table of voltages (e.g. one table per clock), but instead
a device has a table of voltages corresponding to each clock.

This is very necessary when a single clock drives multiple devices which
are driven by separate voltage rails.

> + power rail constraints (eg voltage difference limit between 2 rails)

This should come from regulator DT data and not anything DVFS-specific,
correct?

> + clock constraints (eg. clock x frequency must be a fixed ratio of clock y
>   frequency)

Yeah, after sending my email above yesterday I instantly regretted it.
It is true that *functional* clock dependencies are really the purview
of the device driver.  E.g. for Device X to operate at FAST_SPEED, scale
functional_clk up to 200MHz and l3_ddr_clk up to 100MHz.  On OMAP our
display subsystem block also has clock ratio rules that must be honored,
but it just open-coded.

It is possible to model those in DT if we really want, but shouldn't be
a priority for these dvfs-specific bindings.

Regards,
Mike

> 
> Cheers,
> 
> Peter.
