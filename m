From: Mark Brown <broonie@kernel.org>
Date: Tue, 26 Aug 2014 11:33:40 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20140826113340.GL17528@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="RT1a6fpNJryl9koL"
List-Id: <linux-fbdev.vger.kernel.org>
References: <53FB3E7F.4000503@redhat.com>
 <20140825141600.GA14763@ulmo.nvidia.com>
 <53FB46FF.1010208@redhat.com>
 <20140825145303.GC14763@ulmo.nvidia.com>
 <20140825150705.GB15297@lukather> <20140826082626.GE17263@ulmo>
 <20140826090035.GB17528@sirena.org.uk>
 <20140826091853.GI17263@ulmo>
 <20140826100612.GH17528@sirena.org.uk>
 <20140826105451.GD31124@ulmo>
In-Reply-To: <20140826105451.GD31124@ulmo>
To: linux-arm-kernel@lists.infradead.org


--RT1a6fpNJryl9koL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 26, 2014 at 12:55:06PM +0200, Thierry Reding wrote:
> On Tue, Aug 26, 2014 at 11:06:12AM +0100, Mark Brown wrote:
> > On Tue, Aug 26, 2014 at 11:18:54AM +0200, Thierry Reding wrote:
> > > On Tue, Aug 26, 2014 at 10:00:35AM +0100, Mark Brown wrote:

> > > > We can't assume that the "proper" setup is that the supply should be
> > > > left on.

> > > Right, we can't assume it, but if we're given appropriate hints I think
> > > it's fair to keep resources set up by firmware untouched.

> > I really can't see any sensible way to do that in an OS neutral thing
> > like DT.

> It should be possible to simply define a property for this that the
> firmware can add to the device tree.

> There are other subsystems for example where we don't touch resources
> unless they are explicitly accessed. GPIO and pinmux are two examples of
> those. The reason is precisely so that we don't undo anything that the
> firmware already set up and that may be needed during boot.

GPIOs and pinmuxes are quite different in both how they get set up (you
don't typically have their configuration set in ROM and shoehorned into
the board which is what we're dealing with for a lot of PMICs) and in
the consequences of leaving them alone.

I really don't think defining a custom property to work around a timing
issue in a particular OS startup sequence is the best way forwards here
- we should solve our startup sequencing issue rather than layer on
hacks, otherwise we're adding fragility and work to the system.  The
flag would need to be explicitly added and then it means we're stuck
with the behaviour even if the system gets smarter.

> Before booting the kernel it will modify the DTB and insert a node that
> contains information about the framebuffer that was set up. The node
> contains properties that define the resolution, the format and the
> physical address of the framebuffer memory. An in-kernel driver will
> then be able to use that information very early in the boot process to
> show the console (to replace the serial console that's usually not
> available on consumer devices). Later on when a real driver can be
> loaded it should take over the resources from simplefb and remove it.

OK, so this is not meaningfully different to just loading the driver
normally - it's exactly the same scenario.

--RT1a6fpNJryl9koL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT/HCRAAoJELSic+t+oim9BqYP/Rz8ZdWe08nce3PlHZqaI1Db
LX1rSke2nQlbL9QBVVKyJoGed7CJQG1RcahUXGFtCa3fnMV6OLe+ww36Bjd0+gyc
TZZzzYXqa+26twlcFYMDrtx/2ejIqISUhlKrJ7Fg2YGe80o6nENE0cdhqjcqOfA5
sgmTspt1l98HqswFn2aMjYC8ZQZ8OZcg05OHmEXlHvJB9WPmmCChr6bc61WNB0D7
1HkcYQSvEUMy0PAFdTg3AfFWqXvu/gO8cu0Zuj4UjCElt8Z2sjSAipi2N8AsIu29
hB9Iq5mvFG1v7zR6nQiDHYJkWPpoxSIg3ldJCUH1nZw3U9XNMPuxvMUM2TARshDe
MpBKv/S7XHDdRSMrekJURB6KjyZ02ihPNQUJSFVdA4fiILWHkhZiyDY7oS1BKczN
yjdod+HAFGdiCnKqjK1qnXkmhD7HCYmbnNucXz//z+9CYEOaaX6mgq2x1WHQ4VIW
d7/bBEaxYXxPOf/8XUHaA5ORI7f0HgCKjODjS+pL5POA3I2vNbMuugHDy5ta3kMi
5H67KBMv3yQqAin+8ZWn01wjIWLGrvP9B/TTCgzQbF/xNcD+9ZOH/98KMgIA5CGw
zUnCbQaCM0ftDTviru/q6iE8sBnLEjsSYQhRBJfh2t66OSxLakDra+j/4m0mEIvz
M4jUmsUyDC37mn8wX1P5
=7JI0
-----END PGP SIGNATURE-----

--RT1a6fpNJryl9koL--
