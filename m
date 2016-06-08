From: Rob Herring <robh@kernel.org>
Date: Wed, 08 Jun 2016 20:06:43 +0000
Subject: Re: [PATCHv2] backlight: pwm_bl: disable PWM when 'duty_cycle' is zero
Message-Id: <20160608200643.GA13510@rob-hp-laptop>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1465294429-8570-1-git-send-email-LW@KARO-electronics.de>
In-Reply-To: <1465294429-8570-1-git-send-email-LW@KARO-electronics.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Marcel Ziswiler <marcel.ziswiler@toradex.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, devicetree@vger.kernel.org

On Tue, Jun 07, 2016 at 12:13:49PM +0200, Lothar Wa=DFmann wrote:
> 'brightness' is usually an index into a table of duty_cycle values,
> where the value at index 0 may well be non-zero
> (tegra30-apalis-eval.dts and tegra30-colibri-eval-v3.dts are real-life
> examples).
> Thus brightness =3D 0 does not necessarily mean that the PWM output
> will be inactive.
> Check for 'duty_cycle =3D 0' rather than 'brightness =3D 0' to decide
> whether to disable the PWM.
>=20
> Signed-off-by: Lothar Wa=DFmann <LW@KARO-electronics.de>
> ---
> Changes wrt. v1:
>   - update binding docs to reflect the change
>=20
>  .../devicetree/bindings/leds/backlight/pwm-backlight.txt         | 9 +++=
+++---
>  drivers/video/backlight/pwm_bl.c                                 | 4 ++--
>  2 files changed, 8 insertions(+), 5 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
