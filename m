From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 26 Nov 2013 14:40:54 +0000
Subject: Re: [PATCH] video: kyro: fix incorrect sizes when copying to userspace
Message-Id: <5294B2F6.5020006@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="bT1B640AquPacLfehlCPT2Etrsq9d5HTa"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1384889136-15516-1-git-send-email-sasha.levin@oracle.com>
In-Reply-To: <1384889136-15516-1-git-send-email-sasha.levin@oracle.com>
To: Sasha Levin <sasha.levin@oracle.com>, plagnioj@jcrosoft.com
Cc: gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

--bT1B640AquPacLfehlCPT2Etrsq9d5HTa
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-11-19 21:25, Sasha Levin wrote:
> kyro would copy u32s and specify sizeof(unsigned long) as the size to c=
opy.
>=20
> This would copy more data than intended and cause memory corruption and=
 might
> leak kernel memory.
>=20
> Signed-off-by: Sasha Levin <sasha.levin@oracle.com>
> ---
>  drivers/video/kyro/fbdev.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/video/kyro/fbdev.c b/drivers/video/kyro/fbdev.c
> index 50c8574..65041e1 100644
> --- a/drivers/video/kyro/fbdev.c
> +++ b/drivers/video/kyro/fbdev.c
> @@ -624,15 +624,15 @@ static int kyrofb_ioctl(struct fb_info *info,
>  			return -EINVAL;
>  		}
>  	case KYRO_IOCTL_UVSTRIDE:
> -		if (copy_to_user(argp, &deviceInfo.ulOverlayUVStride, sizeof(unsigne=
d long)))
> +		if (copy_to_user(argp, &deviceInfo.ulOverlayUVStride, sizeof(deviceI=
nfo.ulOverlayUVStride)))
>  			return -EFAULT;
>  		break;
>  	case KYRO_IOCTL_STRIDE:
> -		if (copy_to_user(argp, &deviceInfo.ulOverlayStride, sizeof(unsigned =
long)))
> +		if (copy_to_user(argp, &deviceInfo.ulOverlayStride, sizeof(deviceInf=
o.ulOverlayStride)))
>  			return -EFAULT;
>  		break;
>  	case KYRO_IOCTL_OVERLAY_OFFSET:
> -		if (copy_to_user(argp, &deviceInfo.ulOverlayOffset, sizeof(unsigned =
long)))
> +		if (copy_to_user(argp, &deviceInfo.ulOverlayOffset, sizeof(deviceInf=
o.ulOverlayOffset)))
>  			return -EFAULT;
>  		break;
>  	}
>=20

Thanks, applied for 3.13 fixes.

 Tomi



--bT1B640AquPacLfehlCPT2Etrsq9d5HTa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSlLL2AAoJEPo9qoy8lh71rmIQAK805LMcDDUCawzRF0wy/2tR
tL/qKOVHixfjybqlXMjEKdU3Wg+Bn3r14I0iHugAY671w4pEYlX8e21l7QrDfmLp
X4Lh3HiYh6PabXo5uueCA66AXvPX9ZD16G6riT6QFJqxUUlL+xtBQ6js/o4mPyKu
Wj66YrYTHE306LnvS4iWx8PkwXsRNaHICEDXIUi3LXyAbOV+h74Cp9I609RlPTpM
WjZGaaQ8SPssTOTDEhLv8gF6LSm3PURQxjXIJVKhV5eVfbeCx2Qb+ha6Zxu9QCVw
q29sft6+BUaYY4NZdegkG5/645t0vuh/Z5Gsw78/q2Q3JIsmfiBnj38Yl6/sxfTF
/EXi5tbt2kdhRI5LQSEl0KrTf22XwQnFoIG5u4Gz1vp5ihRkbP2tWuyx3lbIrFKI
SNbPfm/QgQobGlf6VmCnp5mXt+eF5pEGeu9UOLi0HfjT7vrBInlqWAyrVFQv8hsR
j3yeHxedWkyyTj39csdJ3KgknUDxLm3FsO64t6HwDOK1wfF/VsxsLuprQfubP5in
GF+8RfMA02qYtz8pvP8TQx33eWYJkfzLQI4AwhoWZjSrEyAffDu/Mt14xtZ0NSYx
ktjAe7fArVxERF2jIsNCjc2ETI7noJO67180Zk4KoDZeYfhVIJ3SQ5uxE5Oqfzgj
IfUKPNpoa4uhNBjHjuyw
=OB8A
-----END PGP SIGNATURE-----

--bT1B640AquPacLfehlCPT2Etrsq9d5HTa--
