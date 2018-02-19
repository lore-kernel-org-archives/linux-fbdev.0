From: Pavel Machek <pavel@ucw.cz>
Date: Mon, 19 Feb 2018 20:35:19 +0000
Subject: Re: setterm -blank force no longer works after switch to omapdrm
Message-Id: <20180219203519.GA4936@amd>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="SLDf9lqlvOQaIe6s"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180217211927.GC9640@amd>
 <20180219191623.GA2347@amd>
In-Reply-To: <20180219191623.GA2347@amd>
To: tomi.valkeinen@ti.com, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: ivo.g.dimitrov.75@gmail.com, khilman@kernel.org, tony@atomide.com, aaro.koskinen@iki.fi, kernel list <linux-kernel@vger.kernel.org>, sre@kernel.org, martijn@brixit.nl, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>, abcloriens@gmail.com, sakari.ailus@linux.intel.com, pali.rohar@gmail.com, clayton@craftyguy.net, patrikbachan@gmail.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, serge@hallyn.com


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-02-19 20:16:23, Pavel Machek wrote:
> On Sat 2018-02-17 22:19:27, Pavel Machek wrote:
> > Hi!
> >=20
> > I used to have use omap fb driver, and blanking worked as expected. It
> > no longer works with omap drm driver. (Tested on v4.16-rc1, but I
> > believe it is broken in older versions, too.)
> >=20
> > Can you test it on your hw? Any ideas what could be wrong?
> >=20
> > xset dpms force on/off works as expected.
>=20
> next-20180219 seems to work as expected, too.

=2E..because I did not switch to omap drm driver for my next- kernels,
yet. Oops :-).
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqLNQcACgkQMOfwapXb+vI9SACfZ6vnVIsMUqKMakGVK0nzGESv
DcoAniXQgazlplsYJjTSnggTBlGIbjxZ
=Cy4G
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
