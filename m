From: Rob Herring <robh@kernel.org>
Date: Fri, 27 Oct 2017 14:38:11 +0000
Subject: Re: [PATCH 2/2] backlight: pwm_bl: add configurable delay between re-enabling PWM and switching back
Message-Id: <20171027140307.x7mtgvy5py7l5nqf@rob-hp-laptop>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1509022186-19636-1-git-send-email-LW@KARO-electronics.de>
 <1509022186-19636-4-git-send-email-LW@KARO-electronics.de>
In-Reply-To: <1509022186-19636-4-git-send-email-LW@KARO-electronics.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Thompson <daniel.thompson@linaro.org>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Pavel Machek <pavel@ucw.cz>, Richard Purdie <rpurdie@rpsys.net>, Thierry Reding <thierry.reding@gmail.com>, devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, linux-pwm@vger.kernel.org

On Thu, Oct 26, 2017 at 02:49:46PM +0200, Lothar Wa=DFmann wrote:
> When switching the backlight on, the LCD may need some time to adjust
> to the configured PWM duty cycle. Add a configurable delay between
> configuring the PWM and enabling the backlight regulator to account
> for this.
>=20
> Signed-off-by: Lothar Wa=DFmann <LW@KARO-electronics.de>
> ---
>  .../bindings/leds/backlight/pwm-backlight.txt      |  4 ++++
>  drivers/video/backlight/pwm_bl.c                   | 22 ++++++++++++++++=
+++---
>  2 files changed, 23 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/leds/backlight/pwm-backlig=
ht.txt b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
> index 764db86..95594c3 100644
> --- a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
> +++ b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
> @@ -17,6 +17,10 @@ Optional properties:
>                 "pwms" property (see PWM binding[0])
>    - enable-gpios: contains a single GPIO specifier for the GPIO which en=
ables
>                    and disables the backlight (see GPIO binding[1])
> +  - turn-on-delay-ms: delay in milliseconds between configuring the PWM
> +		  and switching PWM on. This may be required to eliminate
> +		  flicker when switching the PWM on after it has been
> +		  disabled.

The subject talks about turning on the backlight regulator, but this=20
only talks about the PWM.

> =20
>  [0]: Documentation/devicetree/bindings/pwm/pwm.txt
>  [1]: Documentation/devicetree/bindings/gpio/gpio.txt
