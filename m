From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 04 May 2015 10:52:21 +0000
Subject: Re: [PATCHv2,RESEND] framebuffer: don't link fb_devio into kernel image unconditionally
Message-Id: <55474F65.2050000@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="IPEX4O5H5RBt1Mogv25VACpXiRj2cK1LL"
List-Id: <linux-fbdev.vger.kernel.org>
To: linux-fbdev@vger.kernel.org

--IPEX4O5H5RBt1Mogv25VACpXiRj2cK1LL
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 28/04/15 14:17, Harald Geyer wrote:
> CONFIG_FB_DEFERRED_IO is defined as bool while CONFIG_FB is defined as
> tristate. Currently fb_defio.o is linked into the kernel image even if
> CONFIG_FB=3Dm.
>=20
> I fix this by updating the Makefile to link fb_defio.o into fb.o and th=
us
> go into one place with the other core framebuffer code.
>=20
> Signed-off-by: Harald Geyer <harald@ccbib.org>
> ---
> Resending as I didn't get any reply in six weeks.
>=20

Thanks, queuing for 4.2 fbdev.

 Tomi



--IPEX4O5H5RBt1Mogv25VACpXiRj2cK1LL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJVR09lAAoJEPo9qoy8lh71tIIP/0dHYJWDmMk2UDkT2EBW7M35
vtD042I7em+aLl/weahZqHvf8ai4l5rRcfT+1ZYOicRrk8k/UNgksUCNKTiePMu1
if8qsh1jvt/ZFE8851U4BNHJtvnCyH8idY+9obdoZWA//2cbgabJBlnayeqARL5Q
Xu+huOkLV2w+9GLGNM3H+Az5Z1+qNcmy3/cC9VIjEfqla/5j8VuYDjQ6xrXR1T+3
xTrPAeqm3c0Vf2JrydBIK8R1DMOX6b5pivFx4m18im06h2QP/skzJDtym3jfGvLl
ocDCCXXMfe5+Wcl6tDnz9wq5q2z+INWD3uimgSEgxrfUzR5NtUk4V2q9RO0npSXL
yzgfJ0Xrg/wRLwksTyFQTAsRT0FlBlDhQg+PyLykPi5QZ+GBo51IS0PJUrN9bQb0
NrcwVoZYWaETfTzh5FWn0+/NlDutNAX5Og4CVL2Huc8RpRmqwAbKecaIOmQJiLAZ
FeGDvi2p7hsX2FCUxSF02YwPYilSPBc7T0s78jFDU59tXKgDDP8ZPLYwKbcSQdEL
dCTX0OUYNryxH/lX+Lk7GoxyjoFKO/drvO2s3IUVJb9G7GjkHGpRIMrENreneJQi
g0e6pKadr0PgXUqHAVo76A63/G5Y1MO9znSQIOwbjwNjlDsZjb3dPC8QzuU7LdIL
31N/o/APTu3aSygE8fv4
=JAUV
-----END PGP SIGNATURE-----

--IPEX4O5H5RBt1Mogv25VACpXiRj2cK1LL--
