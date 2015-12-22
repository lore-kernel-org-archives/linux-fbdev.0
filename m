From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 22 Dec 2015 08:56:07 +0000
Subject: Re: [PATCH 3/5] fbdev: omap2: panel-dpi: drop assignment to local variable
Message-Id: <56791027.2040305@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="XuqWQwvKlSSFvvwMbepI004OtMLmRQVsA"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1449753107-11410-3-git-send-email-uwe@kleine-koenig.org>
In-Reply-To: <1449753107-11410-3-git-send-email-uwe@kleine-koenig.org>
To: linux-fbdev@vger.kernel.org

--XuqWQwvKlSSFvvwMbepI004OtMLmRQVsA
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On 20/12/15 12:31, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> On Wed, Dec 16, 2015 at 07:29:17PM +0200, Tomi Valkeinen wrote:
>> On 10/12/15 15:11, Uwe Kleine-K=C3=B6nig wrote:
>>> From: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>>>
>>> The variable gpio is only used to store the return value of
>>> devm_gpiod_get_optional just to assign it to a member of the driver
>>> data.
>>>
>>> Get rid of this local variable and assign to driver data directly.
>>>
>>> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>=

>>> ---
>>>  drivers/video/fbdev/omap2/displays-new/panel-dpi.c | 10 ++++------
>>>  1 file changed, 4 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/video/fbdev/omap2/displays-new/panel-dpi.c b/dri=
vers/video/fbdev/omap2/displays-new/panel-dpi.c
>>> index e780fd4f8b46..1216341a0d19 100644
>>> --- a/drivers/video/fbdev/omap2/displays-new/panel-dpi.c
>>> +++ b/drivers/video/fbdev/omap2/displays-new/panel-dpi.c
>>> @@ -205,13 +205,11 @@ static int panel_dpi_probe_of(struct platform_d=
evice *pdev)
>>>  	int r;
>>>  	struct display_timing timing;
>>>  	struct videomode vm;
>>> -	struct gpio_desc *gpio;
>>> =20
>>> -	gpio =3D devm_gpiod_get_optional(&pdev->dev, "enable", GPIOD_OUT_LO=
W);
>>> -	if (IS_ERR(gpio))
>>> -		return PTR_ERR(gpio);
>>> -
>>> -	ddata->enable_gpio =3D gpio;
>>> +	ddata->enable_gpio =3D devm_gpiod_get_optional(&pdev->dev,
>>> +						     "enable", GPIOD_OUT_LOW);
>>> +	if (IS_ERR(ddata->enable_gpio))
>>> +		return PTR_ERR(ddata->enable_gpio);
>>> =20
>>>  	ddata->backlight_gpio =3D -ENOENT;
>>
>> I usually try to avoid writing bad values to fields. Here
>> ddata->enable_gpio may get an error ptr. It probably doesn't matter as=

>> we bail out right away, but still. If devm_gpiod_get_optional's return=

>> value would be NULL or valid gpio_desc*, then it'd be fine.
>=20
> this is probably a matter of taste but still I don't see why people
> don't like writing to structs immediately.

I don't have a problem with writing to struct immediately. My point was
that I don't like writing invalid values to "long term storage".

What's "invalid" is of course up to the case, but here I think it's
quite clear that 'ddata->enable_gpio' should either be a valid gpiod or
NULL.

Generally, I also like to work on a resource/object in local variables
until it's "ready", and only then push it to the public storage. In my
experience that style results in less possibilities for bugs and confusio=
n.

> With the local variable you might have
>=20
> 	gpio =3D -ESOMETHING
>=20
> and
>=20
> 	ddata->enable_gpio =3D NULL;
>=20
> In the case that the error is handled correctly it doesn't matter if th=
e
> value was written to the struct or not (if you accept a little
> performance penalty for writing the value actually to memory maybe). So=

> the motivation is the consideration that the error might not be handled=

> correctly after a later patch, right? But when ddata->enable_gpio is a
> negative error code this probably results in a crash already during
> development of the faulty patch, while when the struct's member isn't
> assigned it probably doesn't.

Yes, my motivation is that later patches may change the behavior, and
keeping a valid value in 'data->enable_gpio' may make future patches
simpler and prevent problems.

I think it's quite common to do cleanups later, using the values in the
long term storage. Here it might mean setting enable-gpio to 0, or if
devm_* was not used, freeing the gpio, and that would result in using an
error ptr as a pointer to gpiod.

And it's quite common to later change error handling slightly so that
instead of failing, the driver continues if it doesn't actually require
the resource that it failed to get.

Of course, patches for both can and should be written correctly so that
both local and direct write to struct work correctly.

> This convinces me that writing to the struct is actually a good thing.
>=20
> Additionally even though the line length of=20
>=20
> 	gpio =3D devm_gpiod_get_optional(&pdev->dev, "enable", GPIOD_OUT_LOW);=

> 	if (IS_ERR(gpio))
> 		return PTR_ERR(gpio);
>=20
> 	ddata->enable_gpio =3D gpio;
>=20
> is shorter (which is good), with my approach of doing:
>=20
> 	ddata->enable_gpio =3D devm_gpiod_get_optional(&pdev->dev,
> 						     "enable", GPIOD_OUT_LOW);
> 	if (IS_ERR(ddata->enable_gpio))
> 		return PTR_ERR(ddata->enable_gpio);

No big diff here, but I can easily imagine this turning in some future
patch into:

ddata->enable_gpio =3D devm_gpiod_get_optional(&pdev->dev,
					     "enable", GPIOD_OUT_LOW);
if (IS_ERR(ddata->enable_gpio)) {
	r =3D PTR_ERR(data->enable_gpio);
	ddata->enable_gpio =3D NULL;
	return r;
}

> apart from saving an assignment also "enable_gpio" and "enable" are
> nearer to each other which IMHO makes it easier to see that the
> assignment is correct which outweighs the longer lines. This argument
> even gets more important when reset_gpio is added in patch 4 when the
> situation looks as follows:
>=20
> 	gpio =3D devm_gpiod_get_optional(... "enable" ...);
> 	if (IS_ERR(gpio))
> 		...
> 	ddata->enable_gpio =3D gpio;
>=20
> 	gpio =3D devm_gpiod_get_optional(... "reset" ...);
> 	if (IS_ERR(gpio))
> 		...
> 	ddata->reset_gpio =3D gpio;

It is, of course, possible to use more exactly named locals instead of a
single 'gpio'.

> vs.
>=20
> 	ddata->enable_gpio =3D devm_gpiod_get_optional(... "enable" ...);
> 	if (IS_ERR(ddata->enable_gpio))
> 		...
>=20
> 	ddata->reset_gpio =3D devm_gpiod_get_optional(... "reset" ...);
> 	if (IS_ERR(ddata->reset_gpio))
> 		...
>=20
> I like my approach better, but if you don't agree, I don't care enough
> to argue (more).

I don't agree, but I don't care too much either =3D). Both ways are valid=
,
and they can always be changed later if the driver changes enough to
require that change.

 Tomi


--XuqWQwvKlSSFvvwMbepI004OtMLmRQVsA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWeRAnAAoJEPo9qoy8lh71ytMQAKEP4r7BzLd43iJPfSTbeXz3
c5b7NYl+gMzrWlZh0/YA0W6IQgAiAeNUv+qkd/5cBQ+0iljN41LsP3lBpeA8fiEQ
ydkMvt72NgI6L4RVz2pEqSTZFbbQMomChAv8LAZaqr1KHuKDNiGnsJNhSMohV5n3
ifg4doqJXROHYM8dXUnuDhBZ7TEYuGLuQE1ema2d4Koiseg4Hm97SnfDdKBHkp4i
DVn42+g003zPrbb+ENua23wG6HnoArsK2/qc4GIxWEPWfpEonh1/elUWRfTVkJmt
WSeDw7C+Yoxd+RCQ6Ezsi4l/HPvmrDgSNuB1QXC+1AR/tNQsDHF69BF0EKL7fld/
zAYcROPa+f0CkK73lt+PePRa7l3cusoUKrwCJxoXn6dj9QORlpzMZlw21QGsAlKg
exGRKJbObyMgvpoNnGU+U+8xaJW5MoAmwYfi3vG7we0aeUPC5P1Mi0bf5D8tEWB0
Uj6JKcXYJjuF4wzQpBi+ChRY5tqyZBo8quw1jXIzfq8fiRRjsMe2Qzy/dlzgCUqH
HC9T1TC/kWSfBzYZBQfcnX76K3fFJuJ1UbXbxIWLNwIfyqDnwwYY7xnuiVHrf/iT
h+Y68ODL4q71UDL+XXk0YNxkO7jY6/FMsv0zt1Y3CcaSTwwrE7RJpJqGhD/fuRYQ
Wxl0ogOEiB1jyZ1NxRUs
=SRZX
-----END PGP SIGNATURE-----

--XuqWQwvKlSSFvvwMbepI004OtMLmRQVsA--
