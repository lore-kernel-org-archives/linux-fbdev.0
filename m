From: Lee Jones <lee.jones@linaro.org>
Date: Tue, 05 May 2015 08:28:20 +0000
Subject: Re: [PATCH 3/4] video: fbdev: mxsfb: Constify platform_device_id
Message-Id: <20150505082820.GW4047@x1>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1430494721-30793-1-git-send-email-k.kozlowski.k@gmail.com>
 <1430494721-30793-3-git-send-email-k.kozlowski.k@gmail.com>
In-Reply-To: <1430494721-30793-3-git-send-email-k.kozlowski.k@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Sat, 02 May 2015, Krzysztof Kozlowski wrote:

> The platform_device_id is not modified by the driver and core uses it as
> const.
>=20
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
> ---
>  drivers/video/fbdev/mxsfb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

> diff --git a/drivers/video/fbdev/mxsfb.c b/drivers/video/fbdev/mxsfb.c
> index f8ac4a452f26..497971c82bb1 100644
> --- a/drivers/video/fbdev/mxsfb.c
> +++ b/drivers/video/fbdev/mxsfb.c
> @@ -814,7 +814,7 @@ static void mxsfb_free_videomem(struct mxsfb_info *ho=
st)
>  	free_pages_exact(fb_info->screen_base, fb_info->fix.smem_len);
>  }
> =20
> -static struct platform_device_id mxsfb_devtype[] =3D {
> +static const struct platform_device_id mxsfb_devtype[] =3D {
>  	{
>  		.name =3D "imx23-fb",
>  		.driver_data =3D MXSFB_V3,

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
