From: Thierry Reding <thierry.reding@avionic-design.de>
Date: Mon, 09 Jul 2012 05:10:01 +0000
Subject: Re: [PATCH] pwm_backlight: pass correct brightness to callback
Message-Id: <20120709051001.GA10108@avionic-0098.mockup.avionic-design.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="uAKRQypu60I7Lcqm"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1341807700-7103-1-git-send-email-acourbot@nvidia.com>
In-Reply-To: <1341807700-7103-1-git-send-email-acourbot@nvidia.com>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 09, 2012 at 01:21:40PM +0900, Alexandre Courbot wrote:
> pwm_backlight_update_status calls two callbacks before and after
> applying the new PWM settings. However, the brightness scale is
> completely changed in between if brightness levels are used. This patch
> ensures that both callbacks are passed brightness values of the same
> meaning.
>=20
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
>  drivers/video/backlight/pwm_bl.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)

I had to actually read this patch a number of times and then realized I
was completely missing the context. Looking at the whole function makes
it more obvious what you mean.

However I think it'd be much clearer if we just passed the value of
bl->props.brightness into the callbacks, that way we can avoid the
additional variable.

Thierry

>=20
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/p=
wm_bl.c
> index 057389d..dd4d24d 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -39,6 +39,7 @@ static int pwm_backlight_update_status(struct backlight=
_device *bl)
>  {
>  	struct pwm_bl_data *pb =3D dev_get_drvdata(&bl->dev);
>  	int brightness =3D bl->props.brightness;
> +	int pwm_brightness;
>  	int max =3D bl->props.max_brightness;
> =20
>  	if (bl->props.power !=3D FB_BLANK_UNBLANK)
> @@ -55,13 +56,14 @@ static int pwm_backlight_update_status(struct backlig=
ht_device *bl)
>  		pwm_disable(pb->pwm);
>  	} else {
>  		if (pb->levels) {
> -			brightness =3D pb->levels[brightness];
> +			pwm_brightness =3D pb->levels[brightness];
>  			max =3D pb->levels[max];
> -		}
> +		} else
> +			pwm_brightness =3D brightness;
> =20
> -		brightness =3D pb->lth_brightness +
> -			(brightness * (pb->period - pb->lth_brightness) / max);
> -		pwm_config(pb->pwm, brightness, pb->period);
> +		pwm_brightness =3D pb->lth_brightness +
> +		     (pwm_brightness * (pb->period - pb->lth_brightness) / max);
> +		pwm_config(pb->pwm, pwm_brightness, pb->period);
>  		pwm_enable(pb->pwm);
>  	}
> =20
> --=20
> 1.7.11.1
>=20
>=20

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJP+mepAAoJEN0jrNd/PrOh5IwQAJ0A/Vpj0P8F3hzTv7OQZncL
T/wwaZ3Cis4n6Yo4ObHD/gzwDG5yos1bK5nc1pxnf/0bEhbWLip8IWjYvzJKV7LU
ahxdL+Jm938ulKPcXfe8WQqSJ9N0w4hEf4whFPapkpKuC1BQb3Vaf2aX5JN1AZYI
mE/Ms+0FvuH4qV1TgK8qEOeXmyEcdAf590+uL0DyWpIOQz+XySRx809ZJw3iapmN
zZsDCv/X8AtWjEQPV/cU2VzMgplPQZVuzLyT9XkFtfdJu6y3llQv4ENvsyrwNyJ+
Z7s6NNataG8gHm8Roi7kXKq1uvUwamG6u6Wi4hA0jEqzon+gekBmI1lg9Jbeuy6k
3ce/zW62VCeK7OllDoiwc5mjkqTxeD5oiTkyIICbBD0N/iY69ed8M5ZbR94TL39H
2vjfjL2MkCKRSmb0Khs46u6/Cwsy5b471JHYTI4ZxjtgcbVWgLq0SJqtaP3+/LDz
6NlHf4EhXib41OWgNpabUOuhZlSifdBavtCyA88yWqf3bLVEi3gYe3DZROV8hxE8
mSX2BmtRJoQAfgczIgESDbbTcRpKkFVoG6qm2xne/+4PdHpV7AczLLgQl6oaDyqo
FPHCs8oCtRICZNUNbzkdhiC9YlbDGX7fn27u6FjAcBrZlIujOyn1kMcGtAkydXTV
DfhxmhsiGjttXnh/ZDuQ
=tmeL
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
