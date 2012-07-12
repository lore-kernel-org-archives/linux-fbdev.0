From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Thu, 12 Jul 2012 17:15:29 +0000
Subject: Re: Device tree binding for DVFS table
Message-Id: <20120712171528.GK7256@opensource.wolfsonmicro.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="y96v7rNg6HAoELs5"
List-Id: <linux-fbdev.vger.kernel.org>
References: <4FFD77FE.8050206@nvidia.com> <4FFD87BD.2030206@gmail.com>
 <20120711144449.GA23654@sirena.org.uk>
 <20120711200402.GC2772@gmail.com>
 <20120712141001.GE9437@tbergstrom-lnx.Nvidia.com>
 <20120712171016.GL2772@gmail.com>
In-Reply-To: <20120712171016.GL2772@gmail.com>
To: linux-arm-kernel@lists.infradead.org


--y96v7rNg6HAoELs5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 12, 2012 at 10:10:16AM -0700, Mike Turquette wrote:
> On 20120712-17:10, Peter De Schrijver wrote:

> > + power rail constraints (eg voltage difference limit between 2 rails)

> This should come from regulator DT data and not anything DVFS-specific,
> correct?

Currently the regulator API will only constrain individual rails (and
shortly likely parent/child relationships).  It will not do anything to
constrain between different rails, this has been left to the consumers.
For this stuff it may still make sense to do that if we've got a set of
operating points defined which apply over multiple inputs (like clock
and frequency) - we'll naturally impose these constraints by virtue of
selecting the operating point.

> > + clock constraints (eg. clock x frequency must be a fixed ratio of clock y
> >   frequency)

> Yeah, after sending my email above yesterday I instantly regretted it.
> It is true that *functional* clock dependencies are really the purview
> of the device driver.  E.g. for Device X to operate at FAST_SPEED, scale
> functional_clk up to 200MHz and l3_ddr_clk up to 100MHz.  On OMAP our
> display subsystem block also has clock ratio rules that must be honored,
> but it just open-coded.

This is similar to the regulator thing.

--y96v7rNg6HAoELs5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP/wYpAAoJEBus8iNuMP3dCR4QAILHgfQVyOW8jXMqu0q5u6Pf
pnbs55YwIkzR0YtJVGvhoyv5Oq/G6M3t0fx6l5qUjAUwkZUN5oyOxijScwETR6D4
2LgK1DGjDigv9U92SgBTRqDyweC1HJitOUUqbUlFH86EMNgPG6ku59kus+yEq7OO
6MUXn6fH0JHBFxb7jwGs+UEtr+GQxJMbdZW9rkRzuXE7e4zaEML3Y01PGw+I0MbH
F3RHpLeno68M+iJuTwl09mDxTHsPIZswJUstuP0ivYuP4J84iuNg1rz4JLT/1Qg4
13U6oCZ5ebYLB9RwMo0wjh8W4XUreLIsEuiBe1wRzou+duogJOLzVOe44QsJRZ/r
PkJDK70yIyoHzqizzXFRDN1JzFgDcVGy9wtLsOIA2GtESPrmKwPZg1n1XTnMxhJ2
6PS54rjAOZh9ggWSUttngxudShZIEuL0UC/epeP0RY3daHjpbkgiVfuHnbBwIi1f
HWMHkJPBYYn9WU8V7lQ+SAS2l5x4wVKnC192rQqyephq54X52ZF5xHXYkrx8py3c
9Vik1xthllQJ1pN1TPGHM40agxiX1upoV4OY8ArcyUFZHBeZqwHLGm3S16Tl5sJb
cDhLSu/Jt1+44u4QDm84Le6ZwhYatf8tbVTplYqCaNVX/v07fwZQ45VXmwC5XKEx
zfwvty6n86JlRLAZDT9r
=q/FI
-----END PGP SIGNATURE-----

--y96v7rNg6HAoELs5--
