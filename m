From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Date: Fri, 10 Nov 2017 11:22:15 +0000
Subject: Re: [PATCH 0/2] backlight: pwm_bl: prevent backlight flicker when switching PWM on
Message-Id: <8682e9c4-518d-5dce-55c5-c221dddd5fd6@collabora.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1509022186-19636-1-git-send-email-LW@KARO-electronics.de>
 <1509022186-19636-2-git-send-email-LW@KARO-electronics.de>
 <cec1af21-8a6d-f9f3-eaf0-197ba68d87ee@linaro.org>
In-Reply-To: <cec1af21-8a6d-f9f3-eaf0-197ba68d87ee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Daniel Thompson <daniel.thompson@linaro.org>, =?UTF-8?Q?Lothar_Wa=c3=9fmann?= <LW@KARO-electronics.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Pavel Machek <pavel@ucw.cz>, Richard Purdie <rpurdie@rpsys.net>, Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, linux-pwm@vger.kernel.org

Hi all,

On 08/11/17 11:48, Daniel Thompson wrote:
> On 26/10/17 13:49, Lothar Wa=C3=9Fmann wrote:
>> These patches implement some measures to prevent backlight flicker
>> when the backlight is being switched on for a display with an active
>> low brightness control pin.
>> GIT: [PATCH 1/2] backlight: pwm_bl: Enable PWM before switching regulator
>> GIT: [PATCH 2/2] backlight: pwm_bl: add configurable delay between
>=20
> Other than hoisting the pwm_enable() even earlier in the setup sequence t=
his
> patchset seems to have a significant overlap with Enric's recent posting:
>=20
>   https://lkml.org/lkml/2017/7/21/211
>=20
> Any chance of a shared view on this, especially on the DT bindings?
>=20

The DT binding were discussed some time ago for the patch series I sent, th=
ough
there isn't a final ack from DT maintainer.

Lothar, the series I sent have been reviewed and acked, can you test if the
series fixes the problem for you too?

Thanks,
 Enric

>=20
>=20
> Daniel.
