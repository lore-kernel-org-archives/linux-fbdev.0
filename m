From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 26 Jun 2013 08:07:37 +0000
Subject: Re: [PATCH 12/23] video: da8xx-fb: fix 24bpp raster configuration
Message-Id: <51CAA149.4000708@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----enig2FEKTOPJTGCUJHDHFAQVP"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1372170171-9561-13-git-send-email-detheridge@ti.com>
In-Reply-To: <1372170171-9561-13-git-send-email-detheridge@ti.com>
To: linux-fbdev@vger.kernel.org

------enig2FEKTOPJTGCUJHDHFAQVP
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 25/06/13 17:22, Darren Etheridge wrote:
> From: Manjunathappa, Prakash <prakash.pm@ti.com>
>=20
> Set only LCD_V2_TFT_24BPP_MODE bit for 24bpp and LCD_V2_TFT_24BPP_UNPAC=
K
> bit along with LCD_V2_TFT_24BPP_MODE for 32bpp configuration.
>=20
> Patch is tested on am335x-evm for 24bpp and da850-evm for 16bpp
> configurations.
>=20
> Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> Signed-off-by: Darren Etheridge <detheridge@ti.com>
> ---
>  drivers/video/da8xx-fb.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
> index 35a33ca..7f92f37 100644
> --- a/drivers/video/da8xx-fb.c
> +++ b/drivers/video/da8xx-fb.c
> @@ -550,10 +550,10 @@ static int lcd_cfg_frame_buffer(struct da8xx_fb_p=
ar *par, u32 width, u32 height,
>  	case 4:
>  	case 16:
>  		break;
> -	case 24:
> -		reg |=3D LCD_V2_TFT_24BPP_MODE;
>  	case 32:
>  		reg |=3D LCD_V2_TFT_24BPP_UNPACK;
> +	case 24:
> +		reg |=3D LCD_V2_TFT_24BPP_MODE;
>  		break;
> =20

I'd suggest not to use fall-through here. It just makes the code more
difficult to read and more error prone.

 Tomi



------enig2FEKTOPJTGCUJHDHFAQVP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRyqFJAAoJEPo9qoy8lh715ywQAJWIsvgC1swUFxEjVL/0GWtC
Y1gXvnsyS51efry0Qp5VhFJBO5aDrE7juIgisXdYYe+whaunzlhSKmiTk39Mhn9+
B4fS7HBl3TSMP1voSWDtXSEhjHTNJWL/Bn9VWPeenwqMrkUUX4vMrjV+DSOxCn8z
0raBQxBVJ9hanWUsU2U3k2EO6MqmQMMomQTp9V9gkUaRt6fzI2MwX0pwCvdGBzZR
DgelWDJfahaZZF7krf0mbsqoSML9HLCC04J6WUx2URWSPwVtF7LcsHDViJ5OG7+S
gNWAT4F9PYJ0iP5RD2bOvEjcrxTB5XgYXnktT29eTCSo36w23aL+6LxeSmgk4XQ/
2vTm8LO2IydJQEz+DZ8E3a0wrkf5Fy4tc4DS+Z6FVlgh39KTcEX7YRgAUhL+tWnt
peJ8kj1jMr2P7Q1ocLC5TY0jWq+wgOnPRNWVMFWssFYGYrz1gU0SPEQxIVfomtDL
fKnmyGJF9dPm/QvqfIKmTrZPIPMeXiK/ogH6eV2Q1xcHvremJcq2sKy+4ij6PpFA
W4b1vBmmlhYrrQWKQTQxGCfuiGwliQgCmVDudsgjU1K/aWMkoZJMQRHr4WfaUuTu
Tf7av2F/4oHrX5wxDjZw28m01JgDoPq0jFuRrwlysQsQyuPLkz8oiPlFc3pQbTEB
42cdfKHhyYCvgJsJV7EB
=dX30
-----END PGP SIGNATURE-----

------enig2FEKTOPJTGCUJHDHFAQVP--
