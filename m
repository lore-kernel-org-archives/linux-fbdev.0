From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Fri, 02 Aug 2013 08:28:56 +0000
Subject: Re: [PATCHv3 3/3] fb: backlight: HX8357: Add HX8369 support
Message-Id: <20130802082856.GQ2911@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="IpljlC28XhFjURzf"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1375346437-18991-1-git-send-email-maxime.ripard@free-electrons.com>
 <1375346437-18991-4-git-send-email-maxime.ripard@free-electrons.com>
 <51FA56FF.8090308@ti.com>
In-Reply-To: <51FA56FF.8090308@ti.com>
To: linux-arm-kernel@lists.infradead.org


--IpljlC28XhFjURzf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Tomi,

On Thu, Aug 01, 2013 at 03:39:27PM +0300, Tomi Valkeinen wrote:
> Hi,
>=20
> On 01/08/13 11:40, Maxime Ripard wrote:
> > From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> >=20
> > Add support for the Himax HX8369 controller as it is quite similar to t=
he
> > hx8357.
> >=20
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > Acked-by: Jingoo Han <jg1.han@samsung.com>
> > ---
> >  drivers/video/backlight/hx8357.c | 219 +++++++++++++++++++++++++++++++=
+++++---
> >  1 file changed, 204 insertions(+), 15 deletions(-)
>=20
> I don't have comments about this patch as such, but hx8357.c in general:
>=20
> - The commands used look like MIPI DCS commands. We have defined those
> in include/video/mipi_display.h.

Aaah, yes indeed. Thanks for pointing that out.

> - The command arrays could be const

True.

> - I don't like command arrays. Rather than having array for
> "HX8357_SET_COLUMN_ADDRESS, 0x00, 0x00, 0x01, 0x3f,", I'd much more like
> a function hx8357_set_column_address(int x1, int x2) or such.

Hmm, Ok.

> - Looking at the driver makes me think it resembles very much the panel
> driver(s) we have for OMAP. If only CDF was ready... ;)
>=20
> Those said, I don't see a problem with applying this. We could clean up
> later those things mentioned above, but maybe it's better to do that
> when moving to CDF.

Yes, CDF would be really great for this :)

Alexandre and I will try to find some time to do the cleanups you
requested.

> For this and the two other patches:
>=20
> Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>=20
> I can apply these to my 3.12-fbdev branch some day soon, if
> Jean-Christophe hasn't come back yet (I'd normally rather deal only with
> trivial patches, and leave the rest to Jean-Christophe).

Great, thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--IpljlC28XhFjURzf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR+23IAAoJEBx+YmzsjxAg0y4QAI5oJqQwRKnlmtXTcYpfsOXt
opHNC4gGQxEaaFea+HcECtBGwzWa0Q1L9DxmXT7p5v4biiof6G59tmx5WXJy6anm
zeCcCwbB6q9aMt6Vz+fHyuQX4MV7bCE6IXCyQnlXn+awZmnEVd3ANDOz8qEC6mEj
WbIgl/ScGXF2rqdkVtJfTG03rJdWY1e6y36JLyCeXzJOjFfVPb04321w9beLpYp1
8cwQy0P8ubMwtq75jqJ/Nv/+O9qbY8xiEUlGWMTz1EWE4XzRACe+P+tpiXpq6rdZ
yy9G2SgRewiOIcXac6Mi6DZpZ0eHlIVPYX7IHRf3XQoyQ3U/nqUcn7YChrVWXaVs
nlfg9BP4j+gpUIIdNqOnppscAWCcpJXgqUP7lsdB9S7ltxpzPgIirgaObT23TeTD
Pco4pxhHVyvOyIDqswAg/2Zo3u5sia13PFoVcFZPF5CsQuYupeRSiuTorFkRdyhK
Gsgo5jBa0cHDfF5LNRlchG5qmSjVeEURIe2z+6p7zIkhwGWJEl31Nn67S+07Xqd7
kH9eLl618RVTOH8XdqUVvhvaIXsrk5t3Z9iSi6GvB9umtjmKXU7EAP3phgmH37EC
E6Nm0WD9e/by3sv3ogERihRppuKiAG3j5M84KihSJYyyjFl4vlNwtoY+H/+T8bOK
YCnIF50pmpVvqSHDwNTK
=kCFA
-----END PGP SIGNATURE-----

--IpljlC28XhFjURzf--
