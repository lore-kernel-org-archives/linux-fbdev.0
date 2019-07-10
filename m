From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Date: Wed, 10 Jul 2019 09:05:27 +0000
Subject: Re: BUG: Staging: fbtft: Switch to the gpio descriptor interface
Message-Id: <907baecff15308988f44220fcb13b28cba742df2.camel@suse.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-toeCVV8ZXwm6tJ3uvhkN"
List-Id: <linux-fbdev.vger.kernel.org>
References: <3ca02376-631b-d159-7070-7c50403126de@electromag.com.au>
In-Reply-To: <3ca02376-631b-d159-7070-7c50403126de@electromag.com.au>
To: Phil Reid <preid@electromag.com.au>, Nishad Kamdar <nishadkamdar@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, thomas.petazzoni@free-electrons.com, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org


--=-toeCVV8ZXwm6tJ3uvhkN
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-07-10 at 16:31 +0800, Phil Reid wrote:
> G'day Nishad,
>=20
> I'm just wondering if the commit
> c440eee1a7a1d0f "Staging: fbtft: Switch to the gpio descriptor interface"
> was tested on anything.
>=20
> I've had to apply the following patch to get my display functioning again=
.
>=20
> in particular the devm_gpiod_get_index using dev->driver->name for the gp=
io
> lookup seems
> wrong.

FYI We've seen the same issue this week in opensuse's bugzilla and was test=
ing
something very similar to the patch below. Phil do you plan on submitting y=
our
fix?=20

Regards,
Nicolas

> Also I've had to invert the polarity of the reset-gpios in the DT file fo=
r the
> display to function.
>=20
> this code:
> 	gpiod_set_value_cansleep(par->gpio.reset, 0);
> 	usleep_range(20, 40);
> 	gpiod_set_value_cansleep(par->gpio.reset, 1);
>=20
> could be read as deasserting the reset line and then asserting it.
> So I've had to specify and active high reset line in the DT.
>=20
> Regards
> Phil
>=20
>=20
>=20
>=20
>=20
> diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/f=
btft-
> core.c
> index 9b07bad..6fe7cb5 100644
> --- a/drivers/staging/fbtft/fbtft-core.c
> +++ b/drivers/staging/fbtft/fbtft-core.c
> @@ -79,18 +79,16 @@ static int fbtft_request_one_gpio(struct fbtft_par *p=
ar,
>   	struct device_node *node =3D dev->of_node;
>   	int ret =3D 0;
>=20
> -	if (of_find_property(node, name, NULL)) {
> -		*gpiop =3D devm_gpiod_get_index(dev, dev->driver->name, index,
> -					      GPIOD_OUT_HIGH);
> -		if (IS_ERR(*gpiop)) {
> -			ret =3D PTR_ERR(*gpiop);
> -			dev_err(dev,
> -				"Failed to request %s GPIO:%d\n", name, ret);
> -			return ret;
> -		}
> -		fbtft_par_dbg(DEBUG_REQUEST_GPIOS, par, "%s: '%s' GPIO\n",
> -			      __func__, name);
> +	*gpiop =3D devm_gpiod_get_index_optional(dev, name, index,
> +				      GPIOD_OUT_HIGH);
> +	if (IS_ERR(*gpiop)) {
> +		ret =3D PTR_ERR(*gpiop);
> +		dev_err(dev,
> +			"Failed to request %s GPIO: (%d)\n", name, ret);
> +		return ret;
>   	}
> +	fbtft_par_dbg(DEBUG_REQUEST_GPIOS, par, "%s: '%s' GPIO\n",
> +		      __func__, name);
>=20
>   	return ret;
>   }
> @@ -103,34 +101,34 @@ static int fbtft_request_gpios_dt(struct fbtft_par =
*par)
>   	if (!par->info->device->of_node)
>   		return -EINVAL;
>=20
> -	ret =3D fbtft_request_one_gpio(par, "reset-gpios", 0, &par->gpio.reset)=
;
> +	ret =3D fbtft_request_one_gpio(par, "reset", 0, &par->gpio.reset);
>   	if (ret)
>   		return ret;
> -	ret =3D fbtft_request_one_gpio(par, "dc-gpios", 0, &par->gpio.dc);
> +	ret =3D fbtft_request_one_gpio(par, "dc", 0, &par->gpio.dc);
>   	if (ret)
>   		return ret;
> -	ret =3D fbtft_request_one_gpio(par, "rd-gpios", 0, &par->gpio.rd);
> +	ret =3D fbtft_request_one_gpio(par, "rd", 0, &par->gpio.rd);
>   	if (ret)
>   		return ret;
> -	ret =3D fbtft_request_one_gpio(par, "wr-gpios", 0, &par->gpio.wr);
> +	ret =3D fbtft_request_one_gpio(par, "wr", 0, &par->gpio.wr);
>   	if (ret)
>   		return ret;
> -	ret =3D fbtft_request_one_gpio(par, "cs-gpios", 0, &par->gpio.cs);
> +	ret =3D fbtft_request_one_gpio(par, "cs", 0, &par->gpio.cs);
>   	if (ret)
>   		return ret;
> -	ret =3D fbtft_request_one_gpio(par, "latch-gpios", 0, &par->gpio.latch)=
;
> +	ret =3D fbtft_request_one_gpio(par, "latch", 0, &par->gpio.latch);
>   	if (ret)
>   		return ret;
>   	for (i =3D 0; i < 16; i++) {
> -		ret =3D fbtft_request_one_gpio(par, "db-gpios", i,
> +		ret =3D fbtft_request_one_gpio(par, "db", i,
>   					     &par->gpio.db[i]);
>   		if (ret)
>   			return ret;
> -		ret =3D fbtft_request_one_gpio(par, "led-gpios", i,
> +		ret =3D fbtft_request_one_gpio(par, "led", i,
>   					     &par->gpio.led[i]);
>   		if (ret)
>   			return ret;
> -		ret =3D fbtft_request_one_gpio(par, "aux-gpios", i,
> +		ret =3D fbtft_request_one_gpio(par, "aux", i,
>   					     &par->gpio.aux[i]);
>   		if (ret)
>   			return ret;
>=20
>=20
>=20
>=20
> _______________________________________________
> devel mailing list
> devel@linuxdriverproject.org
> http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel


--=-toeCVV8ZXwm6tJ3uvhkN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl0lqlcACgkQlfZmHno8
x/4YLQf/UcNaSEgfOKPoYqvY+pDpJtM4zXUjpdz3QTJJw892fcNnOxCbuoPqkjMN
Tnz1iAAtpHL6rzYQkH+X5wjgVUPIx8mtWcwvK8a5hCRyOrja+yjStkbGoCe8hOuO
fwFkjulgxqGmnIp6J2JomCCn0ll8XHGAfzbVwK3+yk0tX9iBRSKOl/7BZUAkxTfP
E1z5zLJeG9rFS+UL8PujKpkZsgBcC18hhdpcNMtfCkXqElDLBrbauMHrGuKISIk/
JDACJ5CY70bZ6RfuK4Soudf3fGQsf4yXnO4gM+FplHu6M3eK+kk9kEjGOi5DNGqR
QRMHA4+tOm7mvnNxUBumv10YZbCyGA==
=vYt2
-----END PGP SIGNATURE-----

--=-toeCVV8ZXwm6tJ3uvhkN--
