From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 26 Aug 2014 11:30:39 +0000
Subject: Re: [patch] video: of: display_timing: double free on error
Message-Id: <53FC6FDF.6000506@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="s6lbsModbiSIjjkxNXRgBHUNdi4cOVoTr"
List-Id: <linux-fbdev.vger.kernel.org>
To: linux-fbdev@vger.kernel.org

--s6lbsModbiSIjjkxNXRgBHUNdi4cOVoTr
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 11/07/14 12:21, Dan Carpenter wrote:
> The display_timings_release() function frees "disp" and we free it
> again on the next line.
>=20
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>=20
> diff --git a/drivers/video/of_display_timing.c b/drivers/video/of_displ=
ay_timing.c
> index 987edf1..5c098d5 100644
> --- a/drivers/video/of_display_timing.c
> +++ b/drivers/video/of_display_timing.c
> @@ -236,6 +236,7 @@ timingfail:
>  	if (native_mode)
>  		of_node_put(native_mode);
>  	display_timings_release(disp);
> +	disp =3D NULL;
>  entryfail:
>  	kfree(disp);
>  dispfail:
>=20

Thanks, queued for 3.17 fbdev fixes.

The code looks a bit messy to me, though. I'm not fond of "kalloc here,
kfree there" style.

Maybe this would be slightly cleaner, if display_timings_release() would
accept NULL parameter. Then the code above could just use
display_timings_release(), and there'd be no need for kfree.

In any case, that's stuff for an other patch. This one is fine fix for 3.=
17.

 Tomi



--s6lbsModbiSIjjkxNXRgBHUNdi4cOVoTr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT/G/fAAoJEPo9qoy8lh71dRkP/AgK/bSmLTXrA6e4GLrdQf59
Kmzom5czAfMgfEaMZx8JO8qgKE0PaPAEDyPK4T2qSXRMksgbG5+MAXc2qwfts9vs
bYJ5dnndbhxNVAWFbsryFJoT+CBleyHOUFEipdEitdgSnCKHp790+Xqp8OxH0LDI
V/kAU150RguTIky3wtt9+xaMoDzbTRPmhDBT3TwLY4JqtBb8vcY3TI5xqMwD1fQS
wWSm/boG8Qpd/+cbzRSYnkwqooXJY2AnI8tZr3/uuhMqVW6z93hxDeGxpMCeYXDY
4tyyroiEwCRQNvcxB5OA2u25z5WR61T95WLOSkrMj6NgTXR4nxeiEh0HEeP/JFiz
n+vkbQFq3yMWekRicXBnrj56/NG4wf5kAn5orBGvWT55FPWWA7gtEI0nvhSn4Oj1
TRHSQdu8O+vUQdIXmjSKWb8DAVMTTE+B71sA364HPAQlDqFzM3RT4+NDVeYKXzWY
W1V1jDAenI9U3DQc//Jr7jmSTeLa1795h6udQgrWuMhtYs+JWijNF7PLvVR83LHv
zdCeSbfgpF9PCyjM5vs8oQcUmTazb9f7cs1L+vAJNlwu1djO4NxgawXWE0XQwQyW
ayqL3CHNGQcaZDO2nqiZYFNEcm+ZSvDap3TwI6vfih5raowrE193FyvLpZYUVzsg
j54M4WCHw5NajuMBDC5m
=bGeL
-----END PGP SIGNATURE-----

--s6lbsModbiSIjjkxNXRgBHUNdi4cOVoTr--
