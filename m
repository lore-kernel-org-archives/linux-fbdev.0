From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=  <u.kleine-koenig@pengutronix.de>
Date: Wed, 26 Jun 2019 08:58:27 +0000
Subject: Re: [PATCH] backlight: pwm_bl: Set pin to sleep state when powered down
Message-Id: <20190626085827.fija4kfzb5uhwosi@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190522163428.7078-1-paul@crapouillou.net>
 <5b0f8bb3-e7b0-52c1-1f2f-9709992b76fc@linaro.org>
 <20190621135608.GB11839@ulmo>
 <20190624112844.fmwbfpdxjkst3u7r@holly.lan>
 <20190625093839.GB1516@ulmo>
In-Reply-To: <20190625093839.GB1516@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>, od@zcrc.me, kernel@pengutronix.de, Lee Jones <lee.jones@linaro.org>

On Tue, Jun 25, 2019 at 11:38:39AM +0200, Thierry Reding wrote:
> On Mon, Jun 24, 2019 at 12:28:44PM +0100, Daniel Thompson wrote:
> > [...] although given pwm-backlight is essentially a wrapper driver
> > round a PWM I wondered why the pinctrl was on the backlight node
> > (rather than the PWM node).
>=20
> I agree with this. We're defining the pin control state for the PWM pin,
> so in my opinion it should be the PWM driver that controls it.
>=20
> One reason why I think this is important is if we ever end up with a
> device that requires pins from two different controllers to be
> configured at runtime, then how would we model that? Since pin control
> states cannot be aggregated, so you'd have to have multiple "default"
> states, each for the pins that they control.

I thought you can do:

	pinctrl-names =3D "default";
	pinctrl-0 =3D <&pinctrl_in_first_pincontroller>, <&pinctrl_in_another_cont=
roller>;

if two (or more) controllers are involved.
=20
> On the other hand if we associate the pin control states with each of
> the resources that need those states, then when those resources are
> controlled, they will automatically know how to deal with the states.
> The top-level device (i.e. backlight) doesn't need to concern itself
> with those details.

So the options are:

 a) put "active" and "inactive" pinctrls into the pwm-node, and nothing
    related to the involved PWM pins in the consumer

 b) put the PWM pin config in the consumer's "default" pinctrl (and
    maybe leave it out int "init" if you want smooth taking over).

(Or maybe use "enabled" and "disabled" in a) to match the pwm_states
.enabled?)

The advantages I see in b) over a) are:

 - "default" and "init" are a known pinctrl concept that most people
   should have understood.

 - You have all pinctrl config for the backlight in a single place.

 - none of the involved driver must explicitly handle pinctrl stuff

You presume that b) being commonly done is a sign of "our device trees
and kernel subsystems still maturing". But maybe it's only that the
capabilities provided by pinctrl subsystem without extra effort is good
enough?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
