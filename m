From: Mark Brown <broonie@kernel.org>
Date: Tue, 23 Jul 2013 19:31:05 +0000
Subject: Re: [PATCH 01/15] drivers: phy: add generic PHY framework
Message-Id: <20130723193105.GP9858@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="8lT/blNmSiRvUClR"
List-Id: <linux-fbdev.vger.kernel.org>
References: <Pine.LNX.4.44L0.1307231017290.1304-100000@iolanthe.rowland.org>
 <51EE9EC0.6060905@ti.com> <20130723161846.GD2486@kroah.com>
 <1446965.6APW5ZgLBW@amdc1227> <20130723173710.GB28284@kroah.com>
 <20130723174456.GM9858@sirena.org.uk>
 <20130723180110.GA8688@kroah.com>
In-Reply-To: <20130723180110.GA8688@kroah.com>
To: linux-arm-kernel@lists.infradead.org


--8lT/blNmSiRvUClR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2013 at 11:01:10AM -0700, Greg KH wrote:
> On Tue, Jul 23, 2013 at 06:44:56PM +0100, Mark Brown wrote:

> > What are the problems you are seeing with doing things with lookups?

> You don't "know" the id of the device you are looking up, due to
> multiple devices being in the system (dynamic ids, look back earlier in
> this thread for details about that.)

I got copied in very late so don't have most of the thread I'm afraid,=20
I did try looking at web archives but didn't see a clear problem
statement.  In any case this is why the APIs doing lookups do the
lookups in the context of the requesting device - devices ask for
whatever name they use locally.

> > Having to write platform data for everything gets old fast and the code
> > duplication is pretty tedious...

> Adding a single pointer is "tedious"?  Where is the "name" that you are
> going to lookup going to come from?  That code doesn't write itself...

It's adding platform data in the first place that gets tedious - and of
course there's also DT and ACPI to worry about, it's not just a case of
platform data and then you're done.  Pushing the lookup into library
code means that drivers don't have to worry about any of this stuff.

For most of the APIs doing this there is a clear and unambiguous name in
the hardware that can be used (and for hardware process reasons is
unlikely to get changed).  The major exception to this is the clock API
since it is relatively rare to have clear, segregated IP level
information for IPs baked into larger chips.  The other APIs tend to be
establishing chip to chip links.

--8lT/blNmSiRvUClR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR7tn2AAoJELSic+t+oim9Lt8P/0Dr/y8rOX+c7njkBOSuJ7B1
6yi2fPPSUkKrUhOfZa5A0uxUEt8uwmS1UC2Pr8uQTkB2fUPYQlX5RKk0pIhA67cE
KskF4dEVJNR7Nbgxon+pgL4foEUG8wXM4AF+aeo4ySUyBmOxfqpZoK1qjTP1/6CF
wR9cdaQAFLVNbNcHFEhSJFST1WjoSe+irYwHVtgYWkIBz+qxkEm/LHPgBibexzOu
EhCb5gFEu0mDL4kb4UI2fVv/+3yEaa8uztspHRrsfTmQUbdW4o0D4ABTowt6XqAT
Sk9fsjG0Cch71XKNi5SlJB3JAAvgyQo7lT5pWZGRh/VCDzjnHtsl/eG2Gw7SvlPm
BttItQrUDBtYi9zkv1helwmpkEYDo+VB8zNJi1YylVTawUGUrWNcT7K9PopPi9U6
9ARkE+CdqZ+KQp2y9l7sEEuT9U6dHFP8PtQhpCyOmzW8CNSPsGuUGsIdVuXzBlnU
70AQsNLDeiER4avfEWBseWI76w70LHZr0HnwJm4CgVtlcNcLJ0bXI5bVr+TPZS2u
YaXVg8pAcaClc7USC+pJVDkQEubM7u/PwZw/AOiyx9WIWVhtmnheNM+SBs3KjVOR
YXN6/jf8T+tOa3TvP7MYenPxf6APJxtiuAenpTWffBJ7HBPhTbQb0ubHuE6fjJ4x
NxsYGz7vNFP7+uV99BsF
=Tgf5
-----END PGP SIGNATURE-----

--8lT/blNmSiRvUClR--
