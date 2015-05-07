From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 07 May 2015 10:55:35 +0000
Subject: Re: [PATCHv6 05/10] ARM: mxs: fix in tree users of ssd1306
Message-Id: <554B44A7.1090007@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="UIqh2e3kFv94PFpFEUHQsNCJM7FbVox9N"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de> <1427826436-21783-1-git-send-email-niederp@physik.uni-kl.de> <1427826436-21783-6-git-send-email-niederp@physik.uni-kl.de>
In-Reply-To: <1427826436-21783-6-git-send-email-niederp@physik.uni-kl.de>
To: =?UTF-8?B?VGhvbWFzIE5pZWRlcnByw7xt?= <niederp@physik.uni-kl.de>, maxime.ripard@free-electrons.com, shawn.guo@linaro.org, Sascha Hauer <kernel@pengutronix.de>
Cc: plagnioj@jcrosoft.com, robh+dt@kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

--UIqh2e3kFv94PFpFEUHQsNCJM7FbVox9N
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On 31/03/15 21:27, Thomas Niederpr=C3=BCm wrote:
> This patch updates the in tree-users of the SSD1306 controller for usin=
g
> the newly introduced DT properties.
>=20
> Signed-off-by: Thomas Niederpr=C3=BCm <niederp@physik.uni-kl.de>
> ---
>  arch/arm/boot/dts/imx28-cfa10036.dts | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/imx28-cfa10036.dts b/arch/arm/boot/dts/i=
mx28-cfa10036.dts
> index b04b6b8..570aa33 100644
> --- a/arch/arm/boot/dts/imx28-cfa10036.dts
> +++ b/arch/arm/boot/dts/imx28-cfa10036.dts
> @@ -99,6 +99,9 @@
>  					solomon,height =3D <32>;
>  					solomon,width =3D <128>;
>  					solomon,page-offset =3D <0>;
> +					solomon,com-lrremap;
> +					solomon,com-invdir;
> +					solomon,com-offset =3D <32>;
>  				};
>  			};

Should this patch be merged separately via proper tree? I can take the
rest of the patches via fbdev tree. I can, of course, take this via
fbdev also, if I get an ack.

 Tomi


--UIqh2e3kFv94PFpFEUHQsNCJM7FbVox9N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVS0SnAAoJEPo9qoy8lh71tXQP/RbLeSUf6Z0YUVzxMOeAggUf
0LAHRjfHfSga1RxZ9fc/OR1UJzw12q1maG009bqryTHsIxZDhfh8f0iWVr96M+d5
2rzXWX2cbLKjuBD7VRKRCHpgp8M2qontENFNsMlI9MASRyXQwYgM+KbGWhYkL6hc
PqLDJpHkpyZJetg6Ryvpk8n6BNOavYNAbWiifhQrDqdr0cC9GV2iFjKN5zEqDG1b
Zugu4s2UNBUA5f2JTfVKVUX8/ZzUvsMULrt/w/bm9Ytuvt/Bl/lYRUkbIvEhIZey
RpEjLnWslJJvmyaa+Ro4UoialT/bSA7FpAsx2YapAMI+cvYinJR2H9z0/in+EKux
tDbswnsT5eJKaTrs8UW7ty+mJvCqucKaSdKSsFci8E56E9YgB3pqrm/cwvGSwCk0
NTGegsUKcDRHc6l0KtRUnALCQMYo5gVUy/WNb/9Ko7vL9D7n+rj354sWcMFsIstS
Y0vTymyApFcmSaiwmar0O67KeUQOsBKJkob7BMsCwQXilDyj3i4Z7nR9sKYG9Qc1
ch1xmsh3eM1c8M/YpSAERcBbNaOlzlD+IvW35cWHdFvVx8bJE4nPVxC+CFymct4e
x8PKhE6g/ruu00JivgVx6XHUvBYXw7ThgwQ3hGdzfvrXHVM8xiJBqNtL23JEpRul
Wkb8OBexv98dQDLt/2qo
=S2D3
-----END PGP SIGNATURE-----

--UIqh2e3kFv94PFpFEUHQsNCJM7FbVox9N--
