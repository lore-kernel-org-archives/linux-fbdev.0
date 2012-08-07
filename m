From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 07 Aug 2012 14:20:18 +0000
Subject: Re: [RFC 13/17] OMAPDSS: SDI: Create a function to set timings
Message-Id: <1344349218.7216.80.camel@lappyti>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-uTPa5sUn8LwjekkEO23w"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1343817088-29645-1-git-send-email-archit@ti.com>
	 <1343817088-29645-14-git-send-email-archit@ti.com>
In-Reply-To: <1343817088-29645-14-git-send-email-archit@ti.com>
To: Archit Taneja <archit@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, sumit.semwal@ti.com, rob@ti.com


--=-uTPa5sUn8LwjekkEO23w
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-08-01 at 16:01 +0530, Archit Taneja wrote:
> Create function omapdss_sdi_set_timings(), this can be used by a SDI pane=
l
> driver without disabling/enabling the SDI interface. This is similar to t=
he
> set_timings op of the DPI interface driver. It calls sdi_set_mode() which=
 only
> configures the DISPC timings and DSS/DISPC clock dividers.

I don't think this works, as the SDI PLL uses pclk-free, and if pclk
changes, PLL lock probably breaks.

OMAP3430 TRM explains the sequence how to configure settings on the fly,
but that's not very simple. Just turning the output off and on is much
easier.

 Tomi


--=-uTPa5sUn8LwjekkEO23w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQISQiAAoJEPo9qoy8lh71WncP/1s9cFLrtaqI5cGoqB/NTtvL
MskeBEKBgYlNx4EmqJGhFXPJnGtItK7O7gK3gStPkKiv0PBafPWEdU3mNLAI4F6T
SYE7p0Ey4Tf2duyBUypxT9ey2ZDnhxaB1sEK443qMGZOhnCLEneTBIwUMzTrEJBD
nbZxJ06/HXwDJ4OoZPbv+E8INahsS7UWGYySmqt+prLh5PCvX7ZIZjl7fM5iEk5Z
iwyQRnBtDgh67wmilXI2IJEoJeDN662s9Z3IDD3YhyjQ2RLDaagZvera7PngHOpY
Z89EeDjeL3zXK2aEsPGCsGgdm38gkjKOgIxK/zuaQGLDEC93g8ceItwwwr6dSIk4
MuB1wa90vOkjveIyOVxp9yhBCzV2qbrN/MlsZMv8KTV1BnPEAw4z9NdadM5Uq47z
wHTmJhU84xg7NrzYmFZefQVykijL5HESooK8zBZIq8xOnoPHeeHqOEuSZt8jyXO5
tb6ydYXS7ywFUkc5+ytCN7E/Eq9WMhn2hDHWDqmIexpjhYpDYv1glc12ouv0Qq/L
SBjJjJCQo2iRvWWwvTwFCJzUuUBFdNftOJnjVEdjDDN/QvGiWgQ5RhLwL9fU3Tzx
pIjiawP4Sxv7FGFCZslSloGARLx8u29/4cRRHPD2D+5fRKCYOLK9i0HRnJ+MPYT0
B4uJGTqs1sx3EvsfGXyI
=pczE
-----END PGP SIGNATURE-----

--=-uTPa5sUn8LwjekkEO23w--

