From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 19 Mar 2014 13:31:49 +0000
Subject: Re: [PATCH v2] lcd: Provide dummy functions if CONFIG_LCD_CLASS_DEVICE is not set
Message-Id: <53299C45.1030300@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="qASo9VRgQtw4utdgFEFgBACRwfnEBXUEc"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1394795353-1931-1-git-send-email-shc_work@mail.ru>
In-Reply-To: <1394795353-1931-1-git-send-email-shc_work@mail.ru>
To: linux-fbdev@vger.kernel.org

--qASo9VRgQtw4utdgFEFgBACRwfnEBXUEc
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

On 14/03/14 13:09, Alexander Shiyan wrote:
> Provide dummy functions for LCD register()/unregister() if
> CONFIG_LCD_CLASS_DEVICE is not set.
> This allows us to use the LCD class as an optional.
>=20
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  include/linux/lcd.h | 37 ++++++++++++++++++++++++++++++-------
>  1 file changed, 30 insertions(+), 7 deletions(-)

I'm still not convinced about this. Isn't it simpler to just
select/depend on LCD_CLASS_DEVICE? The lcd.c is a bit less than 9 kB, so
it's not like you're adding a huge amount of code into the kernel even
if the driver doesn't happen to use it for a particular display.

 Tomi



--qASo9VRgQtw4utdgFEFgBACRwfnEBXUEc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTKZxFAAoJEPo9qoy8lh71q7cP/jCz7wswrjOVhUMZjwWRWgLj
VLUty5X2jEJTUU7QzHFczkKJ2FIwJ4eM5bt/DwSw0D6NSpK5/sOFRnM23/PrAE5K
Z7+Mwq1yuxTIzxAf9sbXpEXM+xJPV0jbuGnxGrPZQ6aU7QiYeNaYGISnZImkGLDU
orpfZ3/Y0uzBoTE9LhfeaRpBnkiy47BsHBu3K96b3Cg3L4TUURkUWNX/LqJKPXHn
85zQ6FfCwzdgtrOv4CWYBHTIQVkfTOyDE6XEVav9ZDIEU/KNcs3Stj8LfSNPwqZu
7Rgq7tf5lzX5xzqd0AdcNAyPZyFPKUpfsdr7zID2pupcTXCxhwXEIoV5To1gAHw2
YM8MbNTkEIVgUxx4nPPvFCwCSBA+yubRY7/G3+bnYuZNeciyXnNzRaMAXxOEpc6n
lwXQrWC3ECxqr/IXxKFvDzhhckxtOCjD+ACL7p4BOK5MGh4roKBjKX7jUUtCkIaL
D6b0z4uMTWt+bWWPKNJ42tWTJCYUjSVS6PsozAS35ZFKM18VqStGK7M59DdM/rEt
OTIqx2wCiiMd5PP96pgdjSkd2D14v1/aZNV5gO4UtdcHGWrLlLIKCd2nIIe2Rzpn
MAnNWcd+KxBukkUu+0tfMa/d+daMOgrqmfOoFxgppl38BBkselELbjFYtb5d3+IA
wcVKzz0x54Y4R1kT50+i
=3s2n
-----END PGP SIGNATURE-----

--qASo9VRgQtw4utdgFEFgBACRwfnEBXUEc--
