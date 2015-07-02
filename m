From: Boris Brezillon <boris.brezillon@free-electrons.com>
Date: Thu, 02 Jul 2015 13:01:41 +0000
Subject: Re: [RFC PATCH 16/15] pwm: add informations about polarity, duty cycle and period to debugfs
Message-Id: <20150702150141.5018a791@bbrezillon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
 <3365087.n2eEES60JK@diego>
In-Reply-To: <3365087.n2eEES60JK@diego>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Wed, 01 Jul 2015 23:50:46 +0200
Heiko St=C3=BCbner <heiko@sntech.de> wrote:

> The pwm-states make it possible to also output the polarity, duty cycle
> and period information in the debugfs pwm summary-outout.
> This makes it easier to gather overview information about pwms without
> needing to walk through the sysfs attributes of every pwm.
>=20
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
> might be nice to have too ;-)

Yes.

>=20
>  drivers/pwm/core.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 6dafd8e..79037a2 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -951,9 +951,18 @@ static void pwm_dbg_show(struct pwm_chip *chip, stru=
ct seq_file *s)
>  		if (test_bit(PWMF_REQUESTED, &pwm->flags))
>  			seq_puts(s, " requested");
> =20
> -		if (pwm_is_enabled(pwm))
> +		if (pwm_is_enabled(pwm)) {
>  			seq_puts(s, " enabled");
> =20
> +			seq_printf(s, " period:%uns",
> +				   pwm_get_period(pwm));
> +			seq_printf(s, " duty:%uns",
> +				   pwm_get_duty_cycle(pwm));
> +			seq_printf(s, " polarity:%s",
> +				   pwm_get_polarity(pwm) ? "inverse"
> +							 : "normal");

I would print those values even if the PWM is not enabled.



--=20
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
