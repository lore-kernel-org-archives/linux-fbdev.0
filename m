From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 20 Feb 2015 12:16:27 +0000
Subject: Re: [PATCH] video: fbdev: make of_device_id array const
Message-Id: <54E7259B.7080101@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="tvm83ImpAqdHieXjBSVXLhbLDvQ46H9Pt"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423479747-17899-1-git-send-email-sanjeev_sharma@mentor.com>
In-Reply-To: <1423479747-17899-1-git-send-email-sanjeev_sharma@mentor.com>
To: linux-arm-kernel@lists.infradead.org

--tvm83ImpAqdHieXjBSVXLhbLDvQ46H9Pt
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 09/02/15 13:02, Sanjeev Sharma wrote:
> Make of_device_id array const.
>=20
> Signed-off-by: Sanjeev Sharma <Sanjeev_Sharma@mentor.com>
> ---
>  drivers/video/fbdev/imxfb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
> index 3b6a3c8..84d1d29 100644
> --- a/drivers/video/fbdev/imxfb.c
> +++ b/drivers/video/fbdev/imxfb.c
> @@ -183,7 +183,7 @@ static struct platform_device_id imxfb_devtype[] =3D=
 {
>  };
>  MODULE_DEVICE_TABLE(platform, imxfb_devtype);
> =20
> -static struct of_device_id imxfb_of_dev_id[] =3D {
> +static const struct of_device_id imxfb_of_dev_id[] =3D {
>  	{
>  		.compatible =3D "fsl,imx1-fb",
>  		.data =3D &imxfb_devtype[IMX1_FB],
>=20

Thanks, queued for 3.21.

 Tomi



--tvm83ImpAqdHieXjBSVXLhbLDvQ46H9Pt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU5yWbAAoJEPo9qoy8lh71O34QAJmRVOdP/HQnmlKwqqmX6tjG
gYgY8pidyjkKSorYM6nEzeX5NMSB18RYHWQzSYIjDZWuaODNmXdBRbtMDico05A2
ZlK7gEUCecktF8ly2ZvYQRZJEBwKH68i8W0k0ChSVqQa/MHhQ7Z1xYJVm9SMzq2m
1grJiKOC2wjX0GqySVPLK0S9YkFhAf+DSW1KtzgCAm5EdeTsTv+RbuX79HEgqXDc
S5TBHNW46lpLkU0c5XGlHb1R+JHhRKClt3ddKm4CcVqcJ7NVNRIxiAw+IfyyYi0Z
Gy1l+Vwsg8lmB1lZ7NnvQpuLQ7LDcj5OnkCim1mJOQi+7dIDPiG6WFzKj/ncJzbY
qDLhoHafxemNQKMwPI2LJAQuNTjuXF4S5BTpGokRmHcnHzy8mj6Qdq5kXih8qWhw
1RuKUWhh9H3eFdAe2PADkxnZVBorSc2LHFFvfu9tDzonQgot1rAcr+/tGJ2JOpcm
GDRITOmKwu6H3h+sT6vI23wKBJUdQbbt7cApaGub6aSs0ERIUMP/P6VzsLzaoeX3
CkAvSHV609n56N26WPzxq9ha01xZsYYv7eMCXgIZj4BNdGeVD1bzpv4tMHxYwf6Y
oR8JL/23L1wrnFly6p+BdNR7JpWIxlmlRmEKGGHKsSElAJg/EsRyyaEJgKuTl0yN
/AyCT8j4oXLKC4MlVe3H
=bJ+8
-----END PGP SIGNATURE-----

--tvm83ImpAqdHieXjBSVXLhbLDvQ46H9Pt--
