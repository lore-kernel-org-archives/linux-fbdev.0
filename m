From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 26 Sep 2013 08:45:56 +0000
Subject: Re: [PATCH] s3fb: fix error return code in s3_pci_probe()
Message-Id: <5243F444.2090608@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="I5oRBgWOv8NKpNBBIQuat8LTFEVi3BNBc"
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAPgLHd_wsqGQ2eSnKY6SzGan0fZLZJWyN03A+_aFmaQ51q73AQ@mail.gmail.com>
In-Reply-To: <CAPgLHd_wsqGQ2eSnKY6SzGan0fZLZJWyN03A+_aFmaQ51q73AQ@mail.gmail.com>
To: linux-fbdev@vger.kernel.org

--I5oRBgWOv8NKpNBBIQuat8LTFEVi3BNBc
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 23/09/13 18:00, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>=20
> Fix to return -EINVAL when virtual vertical size smaller than real
> instead of 0, as done elsewhere in this function. Also remove dup code.=

>=20
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>  drivers/video/s3fb.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
>=20
> diff --git a/drivers/video/s3fb.c b/drivers/video/s3fb.c
> index 47ca86c..d838ba8 100644
> --- a/drivers/video/s3fb.c
> +++ b/drivers/video/s3fb.c
> @@ -1336,14 +1336,7 @@ static int s3_pci_probe(struct pci_dev *dev, con=
st struct pci_device_id *id)
>  			(info->var.bits_per_pixel * info->var.xres_virtual);
>  	if (info->var.yres_virtual < info->var.yres) {
>  		dev_err(info->device, "virtual vertical size smaller than real\n");
> -		goto err_find_mode;
> -	}
> -
> -	/* maximize virtual vertical size for fast scrolling */
> -	info->var.yres_virtual =3D info->fix.smem_len * 8 /
> -			(info->var.bits_per_pixel * info->var.xres_virtual);
> -	if (info->var.yres_virtual < info->var.yres) {
> -		dev_err(info->device, "virtual vertical size smaller than real\n");
> +		rc =3D -EINVAL;
>  		goto err_find_mode;
>  	}
> =20
>=20

Thanks, queuing for 3.12 fixes.

 Tomi



--I5oRBgWOv8NKpNBBIQuat8LTFEVi3BNBc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSQ/REAAoJEPo9qoy8lh71T5UQAKXK4DIkQjJZEB84Jv9kCTWE
9yFVVGr6Oe0jfhEO+O31Kh7sBqVU04BQhVpK+D2JBE83K4NJx8TW9i8ahEy5GRft
uIph8BL6BTa50U5CNbUYapf2gryV8yjMs8MVbL2K/03yIj+g9ImI0xeTFCEPRFzO
DSskOo8HYu93yW312TL89B6bLt4ilS/oV3QqLxmjB1i76TT4/Be1f/Fv+Y8JvTju
uk0x0qAF4UAkPu2XQBlIVS1WUJJupmaQW6PZ8RyDo3TH7rZXIO/kS+Lsy14CvKVI
eRtvYNtenF8pftv3+VbNlYhZsmY17fTtv2G0dcQOyVmQKYZDwDWAQEn91r23U3WU
C4MNKIANn6EL9VVYgJCUeojkzR5eZ31oSscVT7x/FRWDme+4tM9/hFmR0Xu/pYL4
YbAJiPgJaxKhZCez6rBrjwXFJQH8Tk7VUEv4DUUXmUfjwVFR3gkA9hBhLL9O2W7u
emT0ZXbW0EihliVQbgdsBO3Y/NctsS7H4h4CTcjYEQ/vb867dE2BPoBp2a8B36Pb
40K3ePDlQdt/tIkwRV3pMuiWabY7jzVhv20Vtcd5avp0zYMRrzUPe1bPUDIOZ7Rf
9hSKrYwKJvkiIur1MUugSHNtQchOfOjfvHB1SuJvLMY6CB9UvdBu1+sh+GWqd1It
g3PhNglse6H7bfDC7F3/
=g5j/
-----END PGP SIGNATURE-----

--I5oRBgWOv8NKpNBBIQuat8LTFEVi3BNBc--
