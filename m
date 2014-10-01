From: Thierry Reding <thierry.reding@gmail.com>
Date: Wed, 01 Oct 2014 08:17:22 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <20141001081721.GD18463@ulmo>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="sgneBHv3152wZ8jf"
List-Id: <linux-fbdev.vger.kernel.org>
References: <53FF1D6C.6090205@redhat.com> <20140829070116.GC13106@ulmo>
 <20140829141244.GH15297@lukather> <20140829143812.GC31264@ulmo>
 <20140902092508.GR15297@lukather>
 <20140927235601.19023.31593@quantum> <20140929080637.GB12506@ulmo>
 <20140929161101.GS16977@sirena.org.uk>
 <20140930060312.GE29874@ulmo> <20140930180036.GI4273@sirena.org.uk>
In-Reply-To: <20140930180036.GI4273@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org


--sgneBHv3152wZ8jf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2014 at 07:00:36PM +0100, Mark Brown wrote:
> On Tue, Sep 30, 2014 at 08:03:14AM +0200, Thierry Reding wrote:
[...]
> > Of course as Geert pointed out in another subthread, taking this all the
> > way means that we have to disable all power management because the
> > firmware device may be sharing resources with other devices and which
> > therefore are not unused. That's a pretty strong argument and I don't
> > have a solution for that. It is only really a problem for cases where
> > the firmware virtual device isn't taken over by a proper driver at some
> > point, though.
>=20
> Indeed, and we also run into trouble for things where we actually need
> to really turn off the resource for some reason (MMC has some needs here
> for example).

Perhaps an alternative would be to just keep power management going and
hope for the best. This may turn out not to be as much of a problem for
many SoCs or boards as people make it out to be.

Thierry

--sgneBHv3152wZ8jf
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUK7iRAAoJEN0jrNd/PrOhEyQP/Rz9WJzt3eY7iR3Lz95nnlwP
Rg5S9Eacn/y7SBiZ6ePik4hRgFgjlPP/UpU8g/thTI6ISLoUd1KE93Ws0ZutFMDy
hDpqMHwrX+TJsYnO/pccCP4xXcPOtjFyvVzjAQtDuYMWGXF5lQ44INel6mNGWRi6
hIsK4ZIlqhD4Zc7Rne945CtPV+D1bnArIeVmZHlIFynpfhgotDTf5LS6+esOPpuO
Tc8U1Bka5z6E8QelprMFPGT45t+qZpOQLemC5m/tR7ak7eH34j8ngq4JxXqd6HI4
xONZVPtCucpAhj6LP5Zsmu1T2jeLuGsq5PR5kPw/WWdNLUF41LtXHFHsvvYK3uGM
fqR9xdn68F5nQv/aFhww+BCHPhwtacRqnHLSjN42OMBcWWX9yL3zmk4so5jI/iPR
mjnhCi/OqBMsczlkIXVtT9sRds0ESkJYgbkpIFLz7gLoXZZR0iDBHZDwUSLN6k2d
zJOcpZBDf1Z1v3qXngVUt1d2wyX+rPndhT9NjZrOFq/o9SIGOhuiQbu71T8xvTcc
et7XwCwdiEZGC5CuMGB6iOuN7BFzM2OHP9HB8MeZO5i3KDz6SSltJrPAnWUNUeUT
If7qepgFUko3p9OlIR3QO6QnXT9zgdITb7uCoLYD5JHfYAYZTnf//x0y2kCdr4l8
RHzLnqIT1ZhveXKskWKV
=kxjb
-----END PGP SIGNATURE-----

--sgneBHv3152wZ8jf--
