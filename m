From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Date: Wed, 10 Jul 2019 09:37:23 +0000
Subject: Re: BUG: Staging: fbtft: Switch to the gpio descriptor interface
Message-Id: <d4c5575eef7645b4e326327de870166e8f105b01.camel@suse.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-fwIHiX9YTQNKRwa1QRvp"
List-Id: <linux-fbdev.vger.kernel.org>
References: <3ca02376-631b-d159-7070-7c50403126de@electromag.com.au>
 <907baecff15308988f44220fcb13b28cba742df2.camel@suse.de>
 <34678cc1-7d65-813a-c037-cfae4d2728f6@electromag.com.au>
In-Reply-To: <34678cc1-7d65-813a-c037-cfae4d2728f6@electromag.com.au>
To: Phil Reid <preid@electromag.com.au>, Nishad Kamdar <nishadkamdar@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, thomas.petazzoni@free-electrons.com, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org


--=-fwIHiX9YTQNKRwa1QRvp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-07-10 at 17:27 +0800, Phil Reid wrote:
> On 10/07/2019 17:05, Nicolas Saenz Julienne wrote:
> > On Wed, 2019-07-10 at 16:31 +0800, Phil Reid wrote:
> > > G'day Nishad,
> > >=20
> > > I'm just wondering if the commit
> > > c440eee1a7a1d0f "Staging: fbtft: Switch to the gpio descriptor interf=
ace"
> > > was tested on anything.
> > >=20
> > > I've had to apply the following patch to get my display functioning a=
gain.
> > >=20
> > > in particular the devm_gpiod_get_index using dev->driver->name for th=
e
> > > gpio
> > > lookup seems
> > > wrong.
> >=20
> > FYI We've seen the same issue this week in opensuse's bugzilla and was
> > testing
> > something very similar to the patch below. Phil do you plan on submitti=
ng
> > your
> > fix?
> >=20
>=20
> Yes I can submit a patch tomorrow.
>=20
> I just wasn't sure if it was working for anyone.

Please CC me and I'll give it a test :).

>=20
>=20
>=20
> > > Also I've had to invert the polarity of the reset-gpios in the DT fil=
e for
> > > the
> > > display to function.
> > >=20
> > > this code:
> > > 	gpiod_set_value_cansleep(par->gpio.reset, 0);
> > > 	usleep_range(20, 40);
> > > 	gpiod_set_value_cansleep(par->gpio.reset, 1);
> > >=20
> > > could be read as deasserting the reset line and then asserting it.
> > > So I've had to specify and active high reset line in the DT.
> > >=20
> > > Regards
> > > Phil
> > >=20
> > >=20
> > >=20
> > >=20
> > >=20
> > > diff --git a/drivers/staging/fbtft/fbtft-core.c
> > > b/drivers/staging/fbtft/fbtft-
> > > core.c
> > > index 9b07bad..6fe7cb5 100644
> > > --- a/drivers/staging/fbtft/fbtft-core.c
> > > +++ b/drivers/staging/fbtft/fbtft-core.c
> > > @@ -79,18 +79,16 @@ static int fbtft_request_one_gpio(struct fbtft_pa=
r
> > > *par,
> > >    	struct device_node *node =3D dev->of_node;
> > >    	int ret =3D 0;
> > >=20
> > > -	if (of_find_property(node, name, NULL)) {
> > > -		*gpiop =3D devm_gpiod_get_index(dev, dev->driver->name, index,
> > > -					      GPIOD_OUT_HIGH);
> > > -		if (IS_ERR(*gpiop)) {
> > > -			ret =3D PTR_ERR(*gpiop);
> > > -			dev_err(dev,
> > > -				"Failed to request %s GPIO:%d\n", name, ret);
> > > -			return ret;
> > > -		}
> > > -		fbtft_par_dbg(DEBUG_REQUEST_GPIOS, par, "%s: '%s' GPIO\n",
> > > -			      __func__, name);
> > > +	*gpiop =3D devm_gpiod_get_index_optional(dev, name, index,
> > > +				      GPIOD_OUT_HIGH);
> > > +	if (IS_ERR(*gpiop)) {
> > > +		ret =3D PTR_ERR(*gpiop);
> > > +		dev_err(dev,
> > > +			"Failed to request %s GPIO: (%d)\n", name, ret);
> > > +		return ret;
> > >    	}
> > > +	fbtft_par_dbg(DEBUG_REQUEST_GPIOS, par, "%s: '%s' GPIO\n",
> > > +		      __func__, name);
> > >=20
> > >    	return ret;
> > >    }
> > > @@ -103,34 +101,34 @@ static int fbtft_request_gpios_dt(struct fbtft_=
par
> > > *par)
> > >    	if (!par->info->device->of_node)
> > >    		return -EINVAL;
> > >=20
> > > -	ret =3D fbtft_request_one_gpio(par, "reset-gpios", 0, &par->gpio.re=
set);
> > > +	ret =3D fbtft_request_one_gpio(par, "reset", 0, &par->gpio.reset);
> > >    	if (ret)
> > >    		return ret;
> > > -	ret =3D fbtft_request_one_gpio(par, "dc-gpios", 0, &par->gpio.dc);
> > > +	ret =3D fbtft_request_one_gpio(par, "dc", 0, &par->gpio.dc);
> > >    	if (ret)
> > >    		return ret;
> > > -	ret =3D fbtft_request_one_gpio(par, "rd-gpios", 0, &par->gpio.rd);
> > > +	ret =3D fbtft_request_one_gpio(par, "rd", 0, &par->gpio.rd);
> > >    	if (ret)
> > >    		return ret;
> > > -	ret =3D fbtft_request_one_gpio(par, "wr-gpios", 0, &par->gpio.wr);
> > > +	ret =3D fbtft_request_one_gpio(par, "wr", 0, &par->gpio.wr);
> > >    	if (ret)
> > >    		return ret;
> > > -	ret =3D fbtft_request_one_gpio(par, "cs-gpios", 0, &par->gpio.cs);
> > > +	ret =3D fbtft_request_one_gpio(par, "cs", 0, &par->gpio.cs);
> > >    	if (ret)
> > >    		return ret;
> > > -	ret =3D fbtft_request_one_gpio(par, "latch-gpios", 0, &par->gpio.la=
tch);
> > > +	ret =3D fbtft_request_one_gpio(par, "latch", 0, &par->gpio.latch);
> > >    	if (ret)
> > >    		return ret;
> > >    	for (i =3D 0; i < 16; i++) {
> > > -		ret =3D fbtft_request_one_gpio(par, "db-gpios", i,
> > > +		ret =3D fbtft_request_one_gpio(par, "db", i,
> > >    					     &par->gpio.db[i]);
> > >    		if (ret)
> > >    			return ret;
> > > -		ret =3D fbtft_request_one_gpio(par, "led-gpios", i,
> > > +		ret =3D fbtft_request_one_gpio(par, "led", i,
> > >    					     &par->gpio.led[i]);
> > >    		if (ret)
> > >    			return ret;
> > > -		ret =3D fbtft_request_one_gpio(par, "aux-gpios", i,
> > > +		ret =3D fbtft_request_one_gpio(par, "aux", i,
> > >    					     &par->gpio.aux[i]);
> > >    		if (ret)
> > >    			return ret;
> > >=20
> > >=20
> > >=20
>=20
>=20


--=-fwIHiX9YTQNKRwa1QRvp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl0lsdMACgkQlfZmHno8
x/5GSwgAqpLjjTIx5boagZCKlSJeJvR8ZMbv5XQNdGx/xYk2UQy1nSKhuCWufSwL
Krh0DOypliZqYDA+9RSdp0HiITXjEmiYdn/rNiFNeGmw1bNE5ji5LJkIKGOOAsgE
tTdK4hn1aZ/se0J0a8p1IJiGk7Jd0nvPV+nrOOoxJABxJhWc+2WbkPjcXTKS+x0u
6YMz9jYtmRZ3m3xW3dwaESycmpS5mpnzSdu7N73TWupqlhvsmsKmRc6S3iMU+xhv
seKdwnP3klZo9bLEH86ghFysYkmRktDbtsnoeLOMR3GL6d5hNE9JLhRdg/YiOFiY
uzs5gFDJATG9Ds5yQ/sc05j39xrA6w==
=GIWa
-----END PGP SIGNATURE-----

--=-fwIHiX9YTQNKRwa1QRvp--
