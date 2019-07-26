From: Paul Cercueil <paul@crapouillou.net>
Date: Fri, 26 Jul 2019 00:09:41 +0000
Subject: Re: [PATCH 02/11] MIPS: qi_lb60: Migrate to devicetree
Message-Id: <1564099781.1699.0@crapouillou.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190725220215.460-1-paul@crapouillou.net>
        <20190725220215.460-3-paul@crapouillou.net>
        <20190725234735.h7qmtt26qpkjw3n6@pburton-laptop>
In-Reply-To: <20190725234735.h7qmtt26qpkjw3n6@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Paul Burton <paul.burton@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Vinod Koul <vkoul@kernel.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee.jones@linaro.org>, Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Sebastian Reichel <sre@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, od@zcrc.me, devicetree@vger.kernel.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-mtd@lists.infradead.org, linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org



Le jeu. 25 juil. 2019 =E0 19:47, Paul Burton <paul.burton@mips.com> a=20
=E9crit :
> Hi Paul,
>=20
> On Thu, Jul 25, 2019 at 06:02:06PM -0400, Paul Cercueil wrote:
>>  Move all the platform data to devicetree.
>=20
> Nice! :)
>=20
>>  The only bit dropped is the PWM beeper, which requires the PWM=20
>> driver
>>  to be updated. I figured it's okay to remove it here since it's=20
>> really
>>  a non-critical device, and it'll be re-introduced soon enough.
>=20
> OK, I can see that being a price worth paying. Though it's possible to
> include the binding at least for that in this series I'd be even
> happier. Actually I see we already have
>=20
>   Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt
>=20
> in mainline - what needs to change with it?

The PWM driver will be updated to use the TCU clocks and the regmap=20
provided
by the TCU driver. The PWM node will be a sub-node of the TCU one.

Additionally, there is this[1] ongoing discussion about PWM which makes
me uneasy about how to write the binding. So I'd rather not rush it,
because once the devicetree is written, it's ABI.

[1]: https://lkml.org/lkml/2019/5/22/607


>>  +	spi {
>>  +		compatible =3D "spi-gpio";
>>  +		#address-cells =3D <1>;
>>  +		#size-cells =3D <0>;
>>  +
>>  +		sck-gpios =3D <&gpc 23 GPIO_ACTIVE_HIGH>;
>>  +		mosi-gpios =3D <&gpc 22 GPIO_ACTIVE_HIGH>;
>>  +		cs-gpios =3D <&gpc 21 GPIO_ACTIVE_LOW>;
>>  +		num-chipselects =3D <1>;
>>  +
>>  +		spi@0 {
>>  +			compatible =3D "ili8960";
>=20
> Should this be "ilitek,ili8960"?
>=20
> Is there a binding & driver for this submitted somewhere? If not then=20
> do
> we need this at all? It doesn't look like the existing platform data
> would actually lead to a driver being loaded so I'm wondering if we=20
> can
> just drop this until such a driver (or at least a documented DT=20
> binding)
> exists.

I can drop it. There is no driver for it, and I'm not even sure the LB60
has a ILI8960 in the first place.


> Thanks,
>     Paul
