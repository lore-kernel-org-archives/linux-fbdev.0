From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 10 Aug 2015 10:32:08 +0000
Subject: Re: [PATCH] drm: Remove two-level menu in Kconfig
Message-Id: <55C87DA8.1010206@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="cqmOFQhEXrxTIqwXmsMq8fHgiF5gI4SNt"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1438963817-9695-1-git-send-email-thierry.reding@gmail.com>
In-Reply-To: <1438963817-9695-1-git-send-email-thierry.reding@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

--cqmOFQhEXrxTIqwXmsMq8fHgiF5gI4SNt
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 07/08/15 19:10, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>=20
> The Direct Rendering Manager Kconfig option is already a separate menu,=

> so remove the extra level to make it easier to navigate.
>=20
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/video/Kconfig | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index 8bf495ffb020..e0606c01e8ac 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -22,9 +22,7 @@ source "drivers/gpu/vga/Kconfig"
>  source "drivers/gpu/host1x/Kconfig"
>  source "drivers/gpu/ipu-v3/Kconfig"
> =20
> -menu "Direct Rendering Manager"
>  source "drivers/gpu/drm/Kconfig"
> -endmenu
> =20
>  menu "Frame buffer Devices"
>  source "drivers/video/fbdev/Kconfig"
>=20

Thanks, queued for 4.3.

 Tomi


--cqmOFQhEXrxTIqwXmsMq8fHgiF5gI4SNt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVyH2oAAoJEPo9qoy8lh71yn0P/AkWQxeuEOOdCKzeUfCMoJoX
uqDdSr0UsdoEJnDGefwH7BOmUd5uk0w2NTnsRGpXb+y6hD7Nbhz8rO2njgcccqD4
JN2cT+WweFtu5hmb4Uk/B27SdN7G0v6C/jXN0JcBHZ3hE3veOlguA32FxAeapGvW
nCljVr1UPtGOJ/eDsRklNmhOAl4arB94DhQNMz4JrjbphoMlIEyttJ97nOy5ZjmG
3519veMjGXCBFYSpmsQHpbRp9Oy0/NSqdnBXNsz5V6nSLmeu/jnsQRwdDdGkxzs1
JUWmX2Fd9kwRodpxUiwA3plJZ9ZuCowOduAkIKUklL30Te7b2xAm9kLG/sUBICwo
z2SypRXrR/biR9aHx/7zdgxdHowj18U7ysuuMqZ7CAGh+hgmjoSadlV7TyBPPeoT
581ynznbD6hur2cv9J+O2uL6cj9S7ykY7HHRU2XE1aJBMlcEhwJgUUfOq5erftj/
zebLeeiTP7jq+Wb/oeOIVLAXSU73ncZn0GAglZ1Ec5cncehA3c3bDgg78UAuWGSc
F7+uvzQczeO39ZUr3r/ydkkKwhETGC2OecFWf5YqZhS+/ty2IgnlbOWsPTBeZqkh
BRGPk5ZPYzr6dWQP4BGgAP9DpkFF+uas5YA2m4K4EvKkDYm9WNeJxfcbHYwJ8jaC
4489D6zqgNMLZQSveIjQ
=FTSY
-----END PGP SIGNATURE-----

--cqmOFQhEXrxTIqwXmsMq8fHgiF5gI4SNt--
