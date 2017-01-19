From: Paul Cercueil <paul@crapouillou.net>
Date: Thu, 19 Jan 2017 11:19:36 +0000
Subject: Re: [PATCH 00/13] Ingenic JZ4740 / JZ4780 pinctrl driver
Message-Id: <27071da2f01d48141e8ac3dfaa13255d@mail.crapouillou.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170117231421.16310-1-paul@crapouillou.net>
 <20170118071530.GA18989@ulmo.ba.sec>
In-Reply-To: <20170118071530.GA18989@ulmo.ba.sec>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Ulf Hansson <ulf.hansson@linaro.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Maarten ter Huurne <maarten@treewalker.org>, Lars-Peter Clausen <lars@metafoo.de>, Paul Burton <paul.burton@imgtec.com>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, james.hogan@imgtec.com

Le 2017-01-18 08:15, Thierry Reding a =C3=A9crit :

> On Wed, Jan 18, 2017 at 12:14:08AM +0100, Paul Cercueil wrote:
> [...]
>=20
>> One problem still unresolved: the pinctrl framework does not allow us=20
>> to configure each pin on demand (someone please prove me wrong), when=20
>> the various PWM channels are requested or released. For instance, the=20
>> PWM channels can be configured from sysfs, which would require all PWM=20
>> pins to be configured properly beforehand for the PWM function,=20
>> eventually causing conflicts with other platform or board drivers.
>=20
> Still catching up on a lot of email, so I haven't gone through the
> entire series. But I don't think the above is true.
>=20
> My understanding is that you can have separate pin groups for each
> pin (provided the hardware supports that) and then control each of
> these groups dynamically at runtime.
>=20
> That is you could have the PWM driver's ->request() and ->free()
> call into the pinctrl framework to select the correct pinmux
> configuration as necessary.

Thanks for the feedback.

The problem with pinctrl and PWM, is that the pinctrl API works by=20
"states".
A default state, sleep state, and basically any custom state that the=20
devicetree
provides. This works well until you need to control individually each=20
pin; with
8 pins, you would need 2^8 states, each one corresponding to a given=20
configuration.

-Paul
