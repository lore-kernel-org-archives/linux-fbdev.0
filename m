From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Wed, 08 Nov 2017 10:48:01 +0000
Subject: Re: [PATCH 0/2] backlight: pwm_bl: prevent backlight flicker when switching PWM on
Message-Id: <cec1af21-8a6d-f9f3-eaf0-197ba68d87ee@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1509022186-19636-1-git-send-email-LW@KARO-electronics.de>
 <1509022186-19636-2-git-send-email-LW@KARO-electronics.de>
In-Reply-To: <1509022186-19636-2-git-send-email-LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Lothar_Wa=c3=9fmann?= <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Jacek Anaszewski <jacek.anaszewski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>

On 26/10/17 13:49, Lothar Wa=C3=9Fmann wrote:
> These patches implement some measures to prevent backlight flicker
> when the backlight is being switched on for a display with an active
> low brightness control pin.
> GIT: [PATCH 1/2] backlight: pwm_bl: Enable PWM before switching regulator
> GIT: [PATCH 2/2] backlight: pwm_bl: add configurable delay between

Other than hoisting the pwm_enable() even earlier in the setup sequence=20
this patchset seems to have a significant overlap with Enric's recent=20
posting:

   https://lkml.org/lkml/2017/7/21/211

Any chance of a shared view on this, especially on the DT bindings?



Daniel.
