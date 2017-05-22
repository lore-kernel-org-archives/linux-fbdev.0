From: Lee Jones <lee.jones@linaro.org>
Date: Mon, 22 May 2017 11:10:09 +0000
Subject: Re: [PATCH v5] backlight: report error on failure
Message-Id: <20170522111009.c75vhzfx4wo5ffjp@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1495054507-9988-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1495054507-9988-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>

On Wed, 17 May 2017, Sudip Mukherjee wrote:

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
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
> ---
>=20
> v5: dropped the ternary condition
> v4: ABI comment removed from commit message
> v3: remove rc =3D 0, and update rc with count in else condition.
> v2: update power with old value on failure.
>=20
>  drivers/video/backlight/backlight.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)

Applied, thanks.

> diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backligh=
t/backlight.c
> index 288318a..8049e76 100644
> --- a/drivers/video/backlight/backlight.c
> +++ b/drivers/video/backlight/backlight.c
> @@ -134,7 +134,7 @@ static ssize_t bl_power_store(struct device *dev, str=
uct device_attribute *attr,
>  {
>  	int rc;
>  	struct backlight_device *bd =3D to_backlight_device(dev);
> -	unsigned long power;
> +	unsigned long power, old_power;
> =20
>  	rc =3D kstrtoul(buf, 0, &power);
>  	if (rc)
> @@ -145,10 +145,16 @@ static ssize_t bl_power_store(struct device *dev, s=
truct device_attribute *attr,
>  	if (bd->ops) {
>  		pr_debug("set power to %lu\n", power);
>  		if (bd->props.power !=3D power) {
> +			old_power =3D bd->props.power;
>  			bd->props.power =3D power;
> -			backlight_update_status(bd);
> +			rc =3D backlight_update_status(bd);
> +			if (rc)
> +				bd->props.power =3D old_power;
> +			else
> +				rc =3D count;
> +		} else {
> +			rc =3D count;
>  		}
> -		rc =3D count;
>  	}
>  	mutex_unlock(&bd->ops_lock);
> =20
> @@ -176,8 +182,7 @@ int backlight_device_set_brightness(struct backlight_=
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
