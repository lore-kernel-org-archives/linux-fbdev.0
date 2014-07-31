From: Thierry Reding <thierry.reding@gmail.com>
Date: Thu, 31 Jul 2014 11:54:31 +0000
Subject: Re: [RFC] pwm-backlight: Allow backlight to remain disabled on boot
Message-Id: <20140731115429.GA12627@ulmo>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="EVF5PPMfhYS0aIcm"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1406806970-12561-1-git-send-email-thierry.reding@gmail.com>
In-Reply-To: <1406806970-12561-1-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2014 at 01:42:50PM +0200, Thierry Reding wrote:
[...]
> @@ -317,6 +319,12 @@ static int pwm_backlight_probe(struct platform_devic=
e *pdev)
>  	}
> =20
>  	bl->props.brightness =3D data->dft_brightness;
> +
> +	if (data->boot_off)
> +		bl->props.power =3D FB_BLANK_POWERDOWN;
> +	else
> +		bl->props.power =3D FB_BLANK_UNBLANK;
> +
>  	backlight_update_status(bl);

Looking at this again, perhaps a more sensible thing to do would be to
not call backlight_update_status() in the first place. For example if
the board defines that backlight should be kept off at boot, but the
bootloader had already enabled it, then this would effectively turn off
the backlight again.

I think it's safe to assume that if the bootloader sets up the backlight
then it would also set up the display. Therefore not touching the
backlight state at all at probe time seems like the safest default.

Of course that doesn't help people who use some dumb framebuffer driver
and therefore nothing explicitly enables the backlight. So it would
still be changing behaviour for people for whom the bootloader doesn't
set up the backlight at all and who therefore rely on the kernel to turn
it on.

We could perhaps alleviate that pain a little by making this dependent
on whether or not the board is booted using DT on the assumption that
anything that uses DT would be "modern" enough to provide a means to
automatically enable the backlight at the right moment.

Thierry

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT2i51AAoJEN0jrNd/PrOhqOsP/3lKe0zwoqXz7QbmZA7GQfmV
KYLIXLvFutXVgY46HoQ2gCtO0ohL069pG+Yp6T+AMhIiEiaP08IZpB5OrgvGdVXv
0K3IAYO8Ed6YCcjP6T6lT1dlf3xdU3zfB3p6dOZXydDNygmeumT5d/vAVojW2DcX
+l9v4UNEbRM8RZJekNpWmE55hguO2EeSGBX3peZUVhta42YlUdk5nipVmNJV9Wh4
AsOSofOBrroyWA8JC7nmun6gCLkp2RsASUUyganCVbIKfRs+d9XQC76ghhZYIok1
6XxACHTMsAOgwGN1+UoclF/QXOF7MHNrqH3TYr8PcTsryLFjmKG+xFcUeame6+VP
pQ70xBq+70G8d5oKiusVfnf2JbafMloob7/+WiUGIP/x5ZpDQS0EcnbD2FMoJ6LB
EcrnksJWWVvoO7U50LRBLxy+vQxG7elpeluwRk+X6ksXIqhSftYUb68lvoewKFiG
KuiWueuLwjTogbsdzkYQYxDKeNxcUQ6xdgPm0/l3gXuLTOCwlCVz5ahnUMTf1eaV
vuZNKm6oLkMEH/koJtCK/l72vTrpcAIz60x/Hxn/RgiGKdGEwT8pM4BOoEp9xpP2
EGuhB97tuqL1uYlFCTclepXL5/PtZIpyDOoOemnJcDPIftSSwz9LfPSn+F1mrPha
gB9X+y8LItqD35zMWzCI
=cfJo
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
