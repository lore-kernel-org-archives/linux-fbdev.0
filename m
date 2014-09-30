From: Mark Brown <broonie@kernel.org>
Date: Tue, 30 Sep 2014 18:00:36 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140930180036.GI4273@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="K1SnTjlYS/YgcDEx"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140827141632.GB32243@ulmo> <53FF1D6C.6090205@redhat.com>
 <20140829070116.GC13106@ulmo> <20140829141244.GH15297@lukather>
 <20140829143812.GC31264@ulmo> <20140902092508.GR15297@lukather>
 <20140927235601.19023.31593@quantum> <20140929080637.GB12506@ulmo>
 <20140929161101.GS16977@sirena.org.uk>
 <20140930060312.GE29874@ulmo>
In-Reply-To: <20140930060312.GE29874@ulmo>
To: linux-arm-kernel@lists.infradead.org


--K1SnTjlYS/YgcDEx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 30, 2014 at 08:03:14AM +0200, Thierry Reding wrote:
> On Mon, Sep 29, 2014 at 05:11:01PM +0100, Mark Brown wrote:

> > Not really thought this through fully yet but would having phandles to
> > the relevant devices do the job?  Kind of lines up with Grant's idea of
> > having dummy drivers.

> One of the arguments that came up during the discussion of the sunxi
> patches is that simplefb is going to be used precisely because there is
> no real driver for the display part of the SoC yet and nobody knows what
> the binding will look like. So there's nothing to point at currently and
> for the same reason having a dummy driver won't work. There's simply no
> definition of what resources are needed.

You may well need to extend the binding in future for an actual driver
but from the point of view of what's going into the block it really
should just be a case of reading the datasheet and mechanically typing
that in.  If we can work out how to say where the framebuffer is we
really ought to be able to work this stuff out.

> > > There may be also resets involved. Fortunately the reset framework is
> > > minimalistic enough not to care about asserting all unused resets at
> > > late_initcall. And other things like power domains may also need to be
> > > kept on.

> > We might want to do that in the future, though it's not always the case
> > that reset is the lowest power state.

> That proves my point. If we ever decide to assert resets by default
> we'll have yet another subsystem that can potentially break existing
> DTs.

OTOH given the level of breakage that's like to introduce we might just
decide not to do that...

> In the end it brings us back to the very fundamental principles of DT
> that's been causing so much pain. For things to work properly and in a
> stable way you have to get the bindings right and complete from the
> start. That is, it needs to describe every aspect of the hardware block
> and all links to other components.

Or we ned to introduce things in a conservative fashion which does cope
with backwards compatibility; it's definitely more work but it is
doable.

> > One thing that makes me a bit nervous about this approach in the context
> > of the regulator API is the frequency with which one finds shared
> > supplies.  I'm not sure if it's actually a big problem in practice but
> > it makes me worry a bit.  We could probably just do something like make
> > refcounting down to zero not actually disable anything for standard
> > regulators to deal with it which might be an idea anyway in the context
> > of this sort of dodge.

> Yes, that's sort of how I expected clk_ignore_unused to work. The way I
> understood it, it would cause all unused clocks to be ignored (that is
> stay enabled if they are).

> Of course as Geert pointed out in another subthread, taking this all the
> way means that we have to disable all power management because the
> firmware device may be sharing resources with other devices and which
> therefore are not unused. That's a pretty strong argument and I don't
> have a solution for that. It is only really a problem for cases where
> the firmware virtual device isn't taken over by a proper driver at some
> point, though.

Indeed, and we also run into trouble for things where we actually need
to really turn off the resource for some reason (MMC has some needs here
for example).

--K1SnTjlYS/YgcDEx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUKu/EAAoJECTWi3JdVIfQ7VgH/2hvGbQOMjfhnDtLA6lLV4j8
Kc9Ff4/iThIAjxrzKx1Fumv0ZavQ8OID9xl0VXE7XV1lFMnIXtiRUHQ6Or5DeuCI
fozDWm3egLK6QIaHc//ledvoPxJLa1DF/as3hD8FiIUTK9xDuOBZtmETpewIyyFP
EcXl/Du/AJa2pwFn04C5N6pgfy1w/LPxWYfwhWavAZTaT0l3NrkmM3gFt0y9C7rM
fjOHEvHMxmMvTRSbs4EQHFovwwStRsfARz+UC/75a2/I2juZQu3BTQzO2iyYzddK
XR6H983zeFHp7BqZVjh/ZRlMGdVrRmTHnXNNpvyX/PxcFyGe4BHkL+BbbZfbGZE=
=+0ja
-----END PGP SIGNATURE-----

--K1SnTjlYS/YgcDEx--
