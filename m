From: Mark Brown <broonie@kernel.org>
Date: Wed, 01 Oct 2014 12:20:08 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20141001122008.GW4273@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="UJXkkAiHhNbsaLO7"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140829070116.GC13106@ulmo> <20140829141244.GH15297@lukather>
 <20140829143812.GC31264@ulmo> <20140902092508.GR15297@lukather>
 <20140927235601.19023.31593@quantum> <20140929080637.GB12506@ulmo>
 <20140929161101.GS16977@sirena.org.uk>
 <20140930060312.GE29874@ulmo> <20140930180036.GI4273@sirena.org.uk>
 <20141001081443.GC18463@ulmo>
In-Reply-To: <20141001081443.GC18463@ulmo>
To: linux-arm-kernel@lists.infradead.org


--UJXkkAiHhNbsaLO7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 01, 2014 at 10:14:44AM +0200, Thierry Reding wrote:
> On Tue, Sep 30, 2014 at 07:00:36PM +0100, Mark Brown wrote:

> > You may well need to extend the binding in future for an actual driver
> > but from the point of view of what's going into the block it really
> > should just be a case of reading the datasheet and mechanically typing
> > that in.  If we can work out how to say where the framebuffer is we
> > really ought to be able to work this stuff out.

> I agree from a technical point of view. However given the dynamically
> generated nature of the node the problem is more of a logistical nature.
> As we've seen U-Boot is being enabled to add clocks to the simplefb node
> but I'm fairly certain that there's a regulator somewhere that needs to
> be enabled too, be it for powering the display controller, the panel or
> the backlight. I wouldn't even be surprised if there were one for each
> of those. If so simplefb on this board will break when the regulators
> are described in the kernel's DTS.

> If we don't consider this a problem then the whole DT ABI stability
> business is a farce.

I think you're setting constraints on the implementation you want to see
which make it unworkable but I don't think those constraints are needed.
You're starting from the position that the DT needs to be updated without
the bootloader and that the DT must not contain any hint of simplefb as
shipped separately.  That's never going to work well as far as I can see
but doesn't seem like an ABI stability issue, or at least not a
reasonable one.

Either the bootloader needs to be updated along with the DT or the DT
needs to offer the bootloader a stable interface of its own for adding
the description of what it has set up (like a default disabled node
with the FB description, I'm sure other ideas are possible).  Obviously
the goal with the stable ABI is that the DT will be distributed along
with the platform.

> > > Of course as Geert pointed out in another subthread, taking this all the
> > > way means that we have to disable all power management because the
> > > firmware device may be sharing resources with other devices and which
> > > therefore are not unused. That's a pretty strong argument and I don't
> > > have a solution for that. It is only really a problem for cases where
> > > the firmware virtual device isn't taken over by a proper driver at some
> > > point, though.

> > Indeed, and we also run into trouble for things where we actually need
> > to really turn off the resource for some reason (MMC has some needs here
> > for example).

> So if disabling power management wholesale isn't going to be an option,
> what's the alternative? I originally proposed that the clock drivers
> could be modified to not disable clocks that are known to be problematic
> with simplefb. People objected to that because they thought it would be
> impractical to determine which clocks are involved with display across
> various boards.

> Handling this in the clock driver has worked remarkably well for us on
> Tegra, but perhaps that's just because Tegra is an unusually sane design
> to begin with.

It's probably more that you've just not run into the corner cases yet -
if the display is mostly driven from the standard controller on the SoC
you've got a pretty good idea what's going to be happening.

--UJXkkAiHhNbsaLO7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUK/F3AAoJECTWi3JdVIfQwCoH/Amn9ckU7Y4/v8tJkc0yuI/+
CdmGP0y6rDj7eTv6ZwNj2HZtmy6AXW7oNsHjJo/3YA3el8LsWigOhz+KbJrSxyRl
IxfBDZPJdab+kUgZ0QTl/3Rl5GsmR114YbYRAI0d9uPCOg4wTkDtC48thqBlNqw1
2vivnbXUNIaV0m/vNDz2NtAz2oFOmhis0hHpeHYIJ0NXA65piKE9TJy7nMe/aVEz
Mt/LGaZROzhL6aChFP+0h6spglNQ8nDFOqGMNzrKB5xlx4WgQpJr3GEI2siA2Exd
EUoAjf1BDI796EGiRkaNRUvT4gWZqJynJIC3bauaNLsMIsArHnUIuDCL/XeSCak=
=GqzY
-----END PGP SIGNATURE-----

--UJXkkAiHhNbsaLO7--
