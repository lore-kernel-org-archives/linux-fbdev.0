From: Mike Turquette <mturquette@ti.com>
Date: Fri, 13 Jul 2012 17:25:32 +0000
Subject: Re: Device tree binding for DVFS table
Message-Id: <20120713172532.GN2772@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4FFD77FE.8050206@nvidia.com> <4FFD87BD.2030206@gmail.com>
 <20120711144449.GA23654@sirena.org.uk>
 <20120711200402.GC2772@gmail.com>
 <20120712141001.GE9437@tbergstrom-lnx.Nvidia.com>
 <20120712171016.GL2772@gmail.com>
 <20120713103408.GF9437@tbergstrom-lnx.Nvidia.com>
In-Reply-To: <20120713103408.GF9437@tbergstrom-lnx.Nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 20120713-13:34, Peter De Schrijver wrote:
> Hi Mike,
> 
> > 
> > Peter,
> > 
> > I agree with your observations in general, but I think some specificity
> > is needed:
> > 
> > > + frequency/voltage relationships
> > 
> > We should be clear that the voltage does NOT belong to the clock, but to
> > the device/module/IP block that consumes that clock.  This is an
> > important detail since it means that a clock does not have a
> > corresponding table of voltages (e.g. one table per clock), but instead
> > a device has a table of voltages corresponding to each clock.
> > 
> 
> Or the other way around, a table of clock frequencies, 1 for each voltage.
> 

ACK

You said what I meant to say.  Some previous iterations of an
omap-specific dvfs api tried to use voltage as the unique key for
accessing frequency/voltage tables, and that can get really ugly for a
variety of reasons.  Plus device drivers typically request performance
in Hertz (e.g. clk_set_rate), so exposing a voltage-centric interface to
them is generally useless.

The OPP library does some of this right (drivers/base/power/opp.c).  It
keeps a list of tables on a per-device bases, which is a big step in the
right direction.  Unfortunately it is lacking in other areas, such as
not specifying which clock corresponds to the to table.  Thus a device
can only have one table and that table does not encode any information
about which clock to use (which is important for devices that use a mux
to change rate).  The dvfs DT bindings should not repeat those mistakes.

> > This is very necessary when a single clock drives multiple devices which
> > are driven by separate voltage rails.
> > 
> 
> Ah ok. How does this work in practice? A device can only run at a given clock
> rate if all the rails are at a certain voltage?
> 

More like an adjustable rate clock higher up the tree affects the rate
of multiple devices downstream, and those devices happen to be on
separate rails.  Either way I think that the design should account for
this possibility.

Regards,
Mike

> > > + power rail constraints (eg voltage difference limit between 2 rails)
> > 
> > This should come from regulator DT data and not anything DVFS-specific,
> > correct?
> > 
> 
> That's true. I think it can even be open-coded as this is a SoC internal
> thing. All boards using this SoC will have the same limits, so I see little
> reason to move this info to DT.
> 
> > > + clock constraints (eg. clock x frequency must be a fixed ratio of clock y
> > >   frequency)
> > 
> > Yeah, after sending my email above yesterday I instantly regretted it.
> > It is true that *functional* clock dependencies are really the purview
> > of the device driver.  E.g. for Device X to operate at FAST_SPEED, scale
> > functional_clk up to 200MHz and l3_ddr_clk up to 100MHz.  On OMAP our
> > display subsystem block also has clock ratio rules that must be honored,
> > but it just open-coded.
> > 
> > It is possible to model those in DT if we really want, but shouldn't be
> > a priority for these dvfs-specific bindings.
> > 
> 
> Agreed.
> 
> Cheers,
> 
> Peter.
