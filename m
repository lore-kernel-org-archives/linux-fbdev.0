From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 29 Jan 2016 11:37:21 +0000
Subject: Re: [PATCH] fbdev: s6e8ax0: avoid unused function warnings
Message-Id: <56AB4EF1.3090404@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="j2d5KqdjVhSPlFLub1Xncu6vIDb9DWKu3"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1453734300-1958304-1-git-send-email-arnd@arndb.de>
In-Reply-To: <1453734300-1958304-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org

--j2d5KqdjVhSPlFLub1Xncu6vIDb9DWKu3
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 25/01/16 17:04, Arnd Bergmann wrote:
> The s6e8ax0 suspend/resume functions are hidden inside of an #ifdef
> when CONFIG_PM is set to avoid unused function warnings, but they
> call some other functions that nothing else calls, and we get warnings
> about those:
>=20
> drivers/video/fbdev/exynos/s6e8ax0.c:449:13: error: 's6e8ax0_sleep_in' =
defined but not used [-Werror=3Dunused-function]
> drivers/video/fbdev/exynos/s6e8ax0.c:485:13: error: 's6e8ax0_display_of=
f' defined but not used [-Werror=3Dunused-function]
>=20
> This marks the PM functions as __maybe_unused so the compiler can
> silently drop them when they are not referenced.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/video/fbdev/exynos/s6e8ax0.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)

Thanks, queued for 4.5 fixes.

 Tomi


--j2d5KqdjVhSPlFLub1Xncu6vIDb9DWKu3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWq07xAAoJEPo9qoy8lh71zFkP/RLL1vO3fOCjlBm4+Yym3HL/
9h+6g0YDYEDS0LpbHJjirnlbX8Nh6ifeMTecpSyZH0PWQisbVtes4ChrB37UQnEi
vL7jo4ze9YDVsljcGsa2GjtWk/R2SFppbMhulY9mBy6zhPEDvjYKYGxGqQ5WFnbV
4r10m4UDb1211K7naDsZydgxUJS1k8MDG5MpZVbP53Im2krrpMgstqhEd61tUEXJ
G6PZ6ffXC9rfWU1/Op2PUZjdQvCkNtjmhV7Plqc3iMd+wHb++0RSYbQfx+njOOMG
3s+djSHBqxOmXR14J16+YtNeedPAxP/A+4Hz49uCKOnGoVw8rCIfUgtN2aQM9dvY
MJ2TRmEwNqLEZKDyPgehFo3siOWHbfP9EHy+dQ9iduBvOEZOdOq03kkfQuDR3Wsp
JqH8Hk0PKnZCGS0fWUEQ8XrzjZ0yeWAXxWpIqKFuw9Qfa0Q9uRejvHdLCelMDiJl
2U62JO+hWLbVqEkzJPRwKrkvRbNFstAOCrR5aIK/xJAjemJ/mwTQeJTixIlZGFIV
h/+iL5jJAbBr2V1kSo58jOMj2IP5NBrxBKxteEntdfCO2k1jxBB3M63nQbfA4tXk
ZKLYY+wSGayNYy2fjwCxYJBHXCCjwWJdsHD/CLz1HQcAJBkxvnQhp3bemBpA7bnn
qZ9Y8wDJ6z13owmzCuF6
=3N6G
-----END PGP SIGNATURE-----

--j2d5KqdjVhSPlFLub1Xncu6vIDb9DWKu3--
