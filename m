From: Thierry Reding <thierry.reding@avionic-design.de>
Date: Tue, 31 Jul 2012 09:13:24 +0000
Subject: Re: [RFC][PATCH v3 1/3] runtime interpreted power sequences
Message-Id: <20120731091324.GA15557@avionic-0098.adnet.avionic-design.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="vkogqOf2sHV7VnPd"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1343390750-3642-1-git-send-email-acourbot@nvidia.com>
 <1343390750-3642-2-git-send-email-acourbot@nvidia.com>
 <CAPnjgZ0H2xrJcL-ytMaX11iYrrhCg7LEM00u_NgEaveM4gHMPw@mail.gmail.com>
 <50179933.9090501@nvidia.com>
In-Reply-To: <50179933.9090501-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
To: Alex Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 31, 2012 at 05:37:07PM +0900, Alex Courbot wrote:
> Hi Simon,
>=20
> On 07/30/2012 08:00 PM, Simon Glass wrote:
> >For the delay, I think milliseconds is reasonable. I suppose there is
> >no reasonable need for microseconds?
>=20
> I don't see any need for microseconds myself - anybody sees use for
> finer-grained delays?
>=20
> Btw, I noticed I was using mdelay instead of msleep - caught and fixed th=
at.

You might want to take a look at Documentation/timers/timers-howto.txt.
msleep() isn't very accurate for periods shorter than 20 ms.

> >>+Device tree
> >>+-----------
> >>+All the same, power sequences can be encoded as device tree nodes. The=
 following
> >>+properties and nodes are equivalent to the platform data defined previ=
ously:
> >>+
> >>+               power-supply =3D <&mydevice_reg>;
> >>+               enable-gpio =3D <&gpio 6 0>;
> >>+
> >>+               power-on-sequence {
> >>+                       regulator@0 {
> >>+                               id =3D "power";
> >
> >Is there a reason not to put the phandle here, like:
> >
> >                                    id =3D <&mydevice_reg>;
> >
> >(or maybe 'device' instead of id?)
>=20
> There is one reason, but it might be a bad one. On Tegra, PWM
> phandle uses an extra cell to encode the duty-cycle the PWM should
> have when we call get_pwm().

This is not only the case on Tegra, but it is the default unless a
driver specifically overrides it. The second cell specifies the index of
the PWM device within the PWM chip. The third cell doesn't specify the
duty cycle but the period of the PWM.

> This makes it possible to address the
> same PWM with different phandles (and different duty cycles),

How so? A phandle will always refer to a PWM chip. Paired with the
second cell, of_pwm_request() will resolve that into the correct PWM
device.

> which
> causes an issue to know whether a PWM is already used in a sequence
> (potentially resulting in multiple get_pwm calls on the same PWM,
> and also opens the door to ambiguities in behavior (what is the
> correct duty-cycle to use if several different values are passed?)

You can't request a PWM multiple times. The second call well return
-EBUSY, or rather ERR_PTR(-EBUSY).

Thierry

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQF6G0AAoJEN0jrNd/PrOhMyUQAJfxn3CN8jL9eOfJvuydRKbI
qtkNVM0Nf64njMM7HJeluKRH49Uz3hyCIQizb1yGO+M/Hw7dcWVOtod98RkVYj6V
SdQPslaFZ8dLbkvgk096HK3W4yFQDWfBKjSxOyhkZbMpW0X0UPCH8oIJjIvnDjU6
L+h14m32KM05G34fkWX1HEd0ZxQKFH6C26JG4NCoZAwUUyrnpzlpB3r6dW6vCcIq
h0oLjpSKpbjW/A+4i8eHddVU1BCIF6uVz66xYxV5Bk+LyYOxo5xgC641WK9hqVUt
HN9jjZFNVVEUHRCAKUFsXDl1xTd0MLnnCSqdtwaKWOIEY85GnN9qdmcoqAniU9os
J4AU1MlOQH28pwqXpOqE2I3qtziRc58JTkW1byu6i+3KXHv9BtM6asAg7q368Bas
ZVQXL1rG9RXAqnExfsIKp4/FGACNLcMRBs20U0pAmvxRWWvqBJU3Qgmhd/E6gZvo
JTv6bS0lkCQVoXLExtLkX8fNyQQ/Qjuv5Si7FqJKXeaRTeTomc7HevLi1FCmOCL2
LbGgY3psQtLHIpVILJ5HuYklO3qDYhN7S2wamymOBHLnvkr4+FwTjLEI6ssi31SA
J+JgYwWDrf4uDFcJHzUfievMPHAare/iwtkkNanZQgqPtwH0t5CdAmqFxoYLeGzx
AQggMaS+7U+NoQMl1L7m
=rfpZ
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
