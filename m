From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 24 Sep 2015 10:54:13 +0000
Subject: Re: [PATCH] ocfb: remove incorrect __iomem annotation
Message-Id: <5603D655.1050504@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="RD6xpGI5jmwBcQUs0N3Lfkih8IoQ9elae"
List-Id: <linux-fbdev.vger.kernel.org>
To: linux-fbdev@vger.kernel.org

--RD6xpGI5jmwBcQUs0N3Lfkih8IoQ9elae
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 17/08/15 11:10, Christoph Hellwig wrote:
> Make sparse happy:

Well, I think someone will anyway be unhappy:

- memset_io() is used to clear fb_virt.

- fb_virt is assigned to fbdev->info.screen_base.

I don't know if it's better or worse to have the __iomem in ocfb.c...

 Tomi


--RD6xpGI5jmwBcQUs0N3Lfkih8IoQ9elae
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWA9ZVAAoJEPo9qoy8lh71AgMP/3jS+iIU1WemWilUAcK4y5Lt
hBGcvLViBrbH6RWtBBKNuqFh4GOSYlt+AbYdsSh18EeoGzwB/1e0cPgHeXZ8XaOw
ynVSgUFSUo+3qeJYl1yzHhppiSXUKA5xxQnfWG+s0YFeLFziIeyzZwxAMaVauLcC
oJ9rS8CbBdo4WQInDS31SVSnMZ+a1tpHoOqNwYyJbc5RlKpZ+36yTHtTzP8KCuhR
DArWVJPAx9LGTt5JX4k0HK0hvakQ68elkTps7dtkRbFLVVIsUBleyxUJDCKJK1pP
57AOas8+TKgr2qXKzhtUaIhQr2x/PpFJqS9omwCxc0dsbD8iI2KNWcZp1wY+PNiQ
ZZ6g35a6zzMh20gsXC4ZNQiusOM7FHZFnG7FY6JOzT2XtL2z89nN7Irt09wBTXQV
HX+zNfRbW7RmVBr/+NSa3FMoLQNrQ65KSS0sf7Z0lWKejsx4ZSVr1HOKtSvvxWVy
rAARiVrJagDfga+KSd5PtdnGxhNokpaSn/iqXepy4DaYBrcXzFSKhkTe9q/YnyF0
CJ6djPYyK5O7KRQiDR6Tz7UkKs1x+RcO/9NjyxOzfd3VROVdOAEvEd9p0B2DjXcp
mIfHuHshySvese9wY7C5mkv/jBTB6stwzFs5XqOmPWh9vRJAWnrEzKICoRcSLnyX
tYkrGvFBTnlQkgLk9glO
=2Xi4
-----END PGP SIGNATURE-----

--RD6xpGI5jmwBcQUs0N3Lfkih8IoQ9elae--
