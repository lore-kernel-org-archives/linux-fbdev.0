From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 24 Nov 2015 11:00:46 +0000
Subject: Re: [PATCH v5 0/2] simplefb: Add regulator handling support
Message-Id: <5654435E.3060202@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="ncefJ31MsxRgxs7D4FUpbuCAAmhD2aQfu"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1447734663-19189-1-git-send-email-wens@csie.org>
In-Reply-To: <1447734663-19189-1-git-send-email-wens-jdAy2FN1RRM@public.gmane.org>
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--ncefJ31MsxRgxs7D4FUpbuCAAmhD2aQfu
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 17/11/15 06:31, Chen-Yu Tsai wrote:
> Hi everyone,
>=20
> This is v5 of the simplefb regulator support series. This series adds
> regulator claiming and enabling support for simplefb.
>=20
> Hans, I dropped your Reviewed-by tag from patch 2 since v4.
>=20
> Changes since v5:
>   - Rebased onto v4.4-rc1
>   - Dropped dts patches (merged)
>=20
> Changes since v4:
>   - Fixed inverted logic when testing the property name.
>   - Fixed regulator supply name string copy length off by 1.
>   - Added real world user, MSI Primo 81 dts patches.
>=20
> Changes since v3:
>   - Dropped extra "if" which is always true, leftover from v1.
>   - Updated commit message of patch 1
>=20
> Sometimes the simplefb display output path consits of external conversi=
on
> chips and/or LCD drivers and backlights. These devices normally have
> GPIOs to turn them on and/or bring them out of reset, and regulators
> supplying power to them.
>=20
> While the kernel does not touch unclaimed GPIOs, the regulator core
> happily disables unused regulators. Thus we need simplefb to claim
> and enable the regulators used throughout the display pipeline.
>=20
> The binding supports any named regulator supplies under its device
> node. The driver will look through its properties, and claim any
> regulators by matching "*-supply", as Mark suggested.
>=20
> I've not done a generic helper in the regulator core yet, instead doing=

> the regulator property handling in the simplefb code for now.
>=20
>=20
> Patch 1 adds the regulator properties to the DT binding.
>=20
> Patch 2 adds code to the simplefb driver to claim and enable regulators=
=2E
>=20
> Regards
> ChenYu
>=20
>=20
> Chen-Yu Tsai (2):
>   dt-bindings: simplefb: Support regulator supply properties
>   simplefb: Claim and enable regulators
>=20
>  .../bindings/display/simple-framebuffer.txt        |  13 ++-
>  drivers/video/fbdev/simplefb.c                     | 120 +++++++++++++=
+++++++-
>  2 files changed, 128 insertions(+), 5 deletions(-)
>=20

Thanks, queued for 4.5.

 Tomi


--ncefJ31MsxRgxs7D4FUpbuCAAmhD2aQfu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWVENeAAoJEPo9qoy8lh71InYP/0OIXfv8cD6E165wbCWE3PQZ
wHNkY0a4tqswUOonj4MC6nqIwDCgbaXxTptmWTXsjCxhGf9ZYpeddva2Qx6t8k+q
mj+tQRu47teqC47mDTtJS2MMi0TMtH8mTMB4nrELVJzcdPMP9oBD0Gw1PnzQLzLS
RRhDSNUtgKT0cAwJnQNndr1r4KcCuFjgNsHx6sPlHE+NdFDdggCN7yJ1P+fP8Ctl
trJ8oYZZKNkURq4LN10+TcJ+5vPGymMz4m/3TgNOqvcCMcGdWTDUqSl1aBDrjxNd
1tsgK9i2NoYRObh5G/NTiu0mcEbJb/Xy/FvJaj+EtYyDg6czRAHkBZoyz+sAUY7S
a5w18k4NYJQfnj88pLco74DxGaJoT9ZfTmQOFrqDVQVAn36FsovkUBUIKnnxVgwo
ANzguaegf+B+GwRel1WWAvqqmCkehwOrkjbo8lY05opzx993+zyWPC0ItWEmEsCy
sTmWY0Hqitj+ZSkjHxfzQbVMDj4G77t4kL+Gl+Lfl9aPf1CrWrN8DERneERZUPUa
6NE2phyyll4cL9LJXOoynSpk/X/n7npf/ZRCz021XufAn5gNmvqA4sTIHempBJeP
0NVFmdTsPUriZa1cRzs7aPn1dCV6OlLp/M6adyyL+chAqZTCkoFiVFUpVY7NYAHC
Zfm8nxaDLAi1hcSxNvME
=rVCv
-----END PGP SIGNATURE-----

--ncefJ31MsxRgxs7D4FUpbuCAAmhD2aQfu--
