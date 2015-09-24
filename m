From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 24 Sep 2015 11:31:52 +0000
Subject: Re: [PATCH v2] fbdev: omap2: connector-dvi: use of_get_i2c_adapter_by_node interface
Message-Id: <5603DF28.1000309@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="VbSATIctgIht5B8FmoH9FG9kGkLTXHKqT"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1442322753-32043-1-git-send-email-vladimir_zapolskiy@mentor.com>
In-Reply-To: <1442322753-32043-1-git-send-email-vladimir_zapolskiy@mentor.com>
To: linux-fbdev@vger.kernel.org

--VbSATIctgIht5B8FmoH9FG9kGkLTXHKqT
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 15/09/15 16:12, Vladimir Zapolskiy wrote:
> This change is needed to properly lock I2C bus driver, which serves DDC=
=2E
>=20
> Prior to this change i2c_put_adapter() is misused, which may lead to
> an overflow over zero of I2C bus driver user counter.
>=20
> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> ---
> Changes from v1 to v2:
> - none, v1 is http://lists.infradead.org/pipermail/linux-arm-kernel/201=
5-July/354990.html
>=20
> The original series http://lists.infradead.org/pipermail/linux-arm-kern=
el/2015-July/354982.html
> is separated to i2c, dri and fbdev parts, at the moment i2c part
> with new of_get_i2c_adapter_by_node() interface has been applied.
>=20
>  drivers/video/fbdev/omap2/displays-new/connector-dvi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/video/fbdev/omap2/displays-new/connector-dvi.c b/d=
rivers/video/fbdev/omap2/displays-new/connector-dvi.c
> index a8ce920..d811e6d 100644
> --- a/drivers/video/fbdev/omap2/displays-new/connector-dvi.c
> +++ b/drivers/video/fbdev/omap2/displays-new/connector-dvi.c
> @@ -294,7 +294,7 @@ static int dvic_probe_of(struct platform_device *pd=
ev)
> =20
>  	adapter_node =3D of_parse_phandle(node, "ddc-i2c-bus", 0);
>  	if (adapter_node) {
> -		adapter =3D of_find_i2c_adapter_by_node(adapter_node);
> +		adapter =3D of_get_i2c_adapter_by_node(adapter_node);
>  		if (adapter =3D=3D NULL) {
>  			dev_err(&pdev->dev, "failed to parse ddc-i2c-bus\n");
>  			omap_dss_put_device(ddata->in);
>=20

Thanks, queued for 4.3 fixes.

 Tomi


--VbSATIctgIht5B8FmoH9FG9kGkLTXHKqT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWA98oAAoJEPo9qoy8lh71BqIQAJXccqnzgQpX04d2pQ9gV/lr
9j1LII0tfgqkf75cnmh1TTkx9uMVdVCJ6aOISQZ3vbS+QQUU0oAVAi1AUeZhktlX
ToeSeIWCKtdmpD5EryzUCUemRaG35AcWJoCqCQLGTqt0xMB2cnAhHZOy1C30MyqN
4543SejYr5z9o7mKFH2BiuxOumaeLa1RRc+inoN13PVxg1ALEkCKKm9SGKJzfvcR
tPtoHlQImlNtDAjmwLn8THnSHNTVr0CozB4Q9g4/MSImWftHUM2RC39ih09IeEJD
LpF511XnlSxgqyLJaQ8JGS4FyMTNZvwpvmQ0xjINi6ihSzFe5eKZJ6Nluidv8Qe+
XDCk96xu7qtv3QkMG8L3KvIrp3dCbftLa809mpBHWPynNLQbDwvYyb+ZpTN2EBXP
qwY+OW2I/lVZwq1gA6MtDkl7UQoUshxHymmOHl6ChwAmzvPGPStpoV4ajbCk3HwF
P2XpfFt0nQqQkiC4GWN1cma6nvIPMfRtscWulyAFX9ROyAcNIhZo+gwqLjGDJHFv
0C6UbRXih3VBHB+XalvnJRULK8m32PBhHDQGhjLvEEmFEx+k8tBsWvwZMZUVX6ou
IMFP6DWqUg42nm2Z5TJnUUUoN4SYutu9rumlAAhuDa69Zd/XBTo9ddZUIpInhuGf
FEF6iTedyb40nc8+9jPz
=xVIK
-----END PGP SIGNATURE-----

--VbSATIctgIht5B8FmoH9FG9kGkLTXHKqT--
