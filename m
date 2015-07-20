From: Thierry Reding <thierry.reding@gmail.com>
Date: Mon, 20 Jul 2015 09:01:24 +0000
Subject: Re: [RFC PATCH 10/15] pwm: add the PWM initial state retrieval infra
Message-Id: <20150720090123.GM29614@ulmo>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="vdqwC0msT4ilQ2it"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
 <1435738921-25027-11-git-send-email-boris.brezillon@free-electrons.com>
In-Reply-To: <1435738921-25027-11-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org


--vdqwC0msT4ilQ2it
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 01, 2015 at 10:21:56AM +0200, Boris Brezillon wrote:
> Add a ->init_state() function to the pwm_ops struct to let PWM drivers
> initialize the PWM state attached to a PWM device.
>=20
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  drivers/pwm/core.c  | 3 +++
>  include/linux/pwm.h | 2 ++
>  2 files changed, 5 insertions(+)
>=20
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 3e830ce..30631f5 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -264,6 +264,9 @@ int pwmchip_add_with_polarity(struct pwm_chip *chip,
>  		pwm->hwpwm =3D i;
>  		pwm_set_default_polarity(pwm, polarity);
> =20
> +		if (chip->ops->init_state)
> +			chip->ops->init_state(chip, pwm);
> +
>  		radix_tree_insert(&pwm_tree, pwm->pwm, pwm);
>  	}
> =20
> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> index 0f36a06..b47244a 100644
> --- a/include/linux/pwm.h
> +++ b/include/linux/pwm.h
> @@ -177,6 +177,8 @@ struct pwm_ops {
>  					  struct pwm_device *pwm);
>  	void			(*disable)(struct pwm_chip *chip,
>  					   struct pwm_device *pwm);
> +	void			(*init_state)(struct pwm_chip *chip,
> +					      struct pwm_device *pwm);

I think I'd call this reset_state. init has this connotation of setting
a set of default values. For reset it's clearer in my opinion that it's
resetting to the hardware state.

Thierry

--vdqwC0msT4ilQ2it
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVrLjjAAoJEN0jrNd/PrOh70oP/2eC7ASpBYsdTym+38qp3vtz
A/gsBVFu3yef15/1wAUXHz14v5QUtkmqAi2TklcdP1Ofcsusd41yIBx5o4nAOL5w
8Tb5WOyq93+qQ+3jgCH3TYiFg3gD5QD8yGKHRPb9FK5iT9o+fdCtv/M06ocz8fW8
vBxmRbTfWXdSEe9znonXiIaDTqLPYSobkBhxjC2JnVOx7WCxDO/+x8LR9TVyTLRo
5nYBxzlz9MzIfZYx/4jdGL0ncVD0Ps3TEmBX7SMg/WwHXaPHb3iyH8eFw+o5ix5O
9UbNKXiwFM8NNxx4wmdc/F7KYbqXM0trM7ABjdhVVVC0D236dGI9ZOtNVusVZLlc
xHZzaPHPKLuo7MrakUv66TNcQBDWrOc4HSxTqD3YoJPBRF9NVQTqqnOT0B74lcE/
yHvLmOcKdPXEUinsblAhPFejwGXEI45KPmA8oSXhZX98l13vzqhmvfQviSMVYfak
jy4MAlrZikBSijmBGKDlH88ckdjRZBTWFh3gHOSFTqbH01Q5J84w1Q5UXmcSm/sE
BVyt12G/cJLn8chveC9LIzQcnnsS0D4n/orxof5lktUxpHN5iaJEt0e07oyCnBwo
UeJA4g31Rp3UlojmkpJEm+DS4ZAXPne8XYjOm+3al7Z14dQpUAx9+/yOJrv5JGvs
1IQRPsZbnDT35cMmtVtk
=qUiJ
-----END PGP SIGNATURE-----

--vdqwC0msT4ilQ2it--
