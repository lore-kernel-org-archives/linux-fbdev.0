From: Lee Jones <lee.jones@linaro.org>
Date: Wed, 08 Feb 2017 12:54:18 +0000
Subject: Re: [PATCH] backlight: report error on failure
Message-Id: <20170208125418.yrt6blzebhglk5vq@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1484774630-4228-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1484774630-4228-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, daniel.thompson@linaro.org
Cc: Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

Cc'ing Daniel Thompson, the new Maintainer.

On Wed, 18 Jan 2017, Sudip Mukherjee wrote:

> It is possible to update the backlight power and the brightness using
> the sysfs and on writing it either returns the count or if the callback
> function does not exist then returns the error code 'ENXIO'.
>=20
> We have a situation where the userspace client is writing to the sysfs
> to update the power and since the callback function exists the client
> receives the return value as count and considers the operation to be
> successful. That is correct as the write to the sysfs was successful.
> But there is no way to know if the actual operation was done or not.
>=20
> backlight_update_status() returns the error code if it fails. Pass that
> to the userspace client who is trying to update the power so that the
> client knows that the operation failed.
>=20
> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
> ---
>  drivers/video/backlight/backlight.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backligh=
t/backlight.c
> index 288318a..74b72b5 100644
> --- a/drivers/video/backlight/backlight.c
> +++ b/drivers/video/backlight/backlight.c
> @@ -146,9 +146,9 @@ static ssize_t bl_power_store(struct device *dev, str=
uct device_attribute *attr,
>  		pr_debug("set power to %lu\n", power);
>  		if (bd->props.power !=3D power) {
>  			bd->props.power =3D power;
> -			backlight_update_status(bd);
> +			rc =3D backlight_update_status(bd);
>  		}
> -		rc =3D count;
> +		rc =3D rc ? rc : count;
>  	}
>  	mutex_unlock(&bd->ops_lock);
> =20
> @@ -176,8 +176,7 @@ int backlight_device_set_brightness(struct backlight_=
device *bd,
>  		else {
>  			pr_debug("set brightness to %lu\n", brightness);
>  			bd->props.brightness =3D brightness;
> -			backlight_update_status(bd);
> -			rc =3D 0;
> +			rc =3D backlight_update_status(bd);
>  		}
>  	}
>  	mutex_unlock(&bd->ops_lock);

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
