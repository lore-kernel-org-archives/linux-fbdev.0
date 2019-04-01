From: Pavel Machek <pavel@ucw.cz>
Date: Mon, 01 Apr 2019 21:39:26 +0000
Subject: Re: [PATCH v2 2/3] dt-bindings: backlight: add lm3630a bindings
Message-Id: <20190401213926.GD14681@amd>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="0/kgSOzhNoDC5T3a"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190401103034.21062-1-masneyb@onstation.org>
 <20190401103034.21062-3-masneyb@onstation.org>
In-Reply-To: <20190401103034.21062-3-masneyb@onstation.org>
To: Brian Masney <masneyb@onstation.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, daniel.thompson@linaro.org, jonathan@marek.ca, b.zolnierkie@samsung.com, jingoohan1@gmail.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, robh+dt@kernel.org, jacek.anaszewski@gmail.com, linux-fbdev@vger.kernel.org, lee.jones@linaro.org, linux-leds@vger.kernel.org, dmurphy@ti.com


--0/kgSOzhNoDC5T3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2019-04-01 06:30:33, Brian Masney wrote:
> Add new backlight bindings for the TI LM3630A dual-string white LED.
>=20
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
>  .../leds/backlight/lm3630a-backlight.yaml     | 112
++++++++++++++++++

What is that? Is it future of all the bindings?

Up to device tree people, I guess, but...

								Pavel


>  1 file changed, 112 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/backlight/lm36=
30a-backlight.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/leds/backlight/lm3630a-bac=
klight.yaml b/Documentation/devicetree/bindings/leds/backlight/lm3630a-back=
light.yaml
> new file mode 100644
> index 000000000000..42a8c59d237a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.=
yaml
> @@ -0,0 +1,112 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/backlight/lm3630a-backlight.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI LM3630A High-Efficiency Dual-String White LED
> +
> +maintainers:
> +  - Lee Jones <lee.jones@linaro.org>
> +  - Daniel Thompson <daniel.thompson@linaro.org>
> +  - Jingoo Han <jingoohan1@gmail.com>
> +
> +description: |
> +  The LM3630A is a current-mode boost converter which supplies the power=
 and
> +  controls the current in up to two strings of 10 LEDs per string.
> +  https://www.ti.com/product/LM3630A
> +
> +properties:
> +  compatible:
> +    const: ti,lm3630a
> +
> +  reg:
> +    maxItems: 1
> +
> +  ti,linear-mapping-mode:
> +    description: |
> +      Enable linear mapping mode. If disabled, then it will use exponent=
ial
> +      mapping mode in which the ramp up/down appears to have a more unif=
orm
> +      tranisiton to the human eye.
> +    type: boolean
> +
> +required:
> +  - compatible
> +  - reg
> +
> +patternProperties:
> +  "^led*$":
> +    type: object
> +    description: |
> +      Properties for a string of connected LEDs.
> +
> +    properties:
> +      label:
> +        description: |
> +          The label for this LED. If omitted, the label is taken from th=
e node
> +          name (excluding the unit address). It has to uniquely identify=
 a
> +          device, i.e. no other LED class device can be assigned the sam=
e label.
> +
> +      led-sources:
> +        description: |
> +          List of device current outputs the LED is connected to.
> +        allOf:
> +          - $ref: /schemas/types.yaml#/definitions/uint32-array
> +          - minItems: 1
> +            maxItems: 2
> +            items:
> +              minimum: 0
> +              maximum: 1
> +
> +      default-brightness:
> +        description: Default brightness level on boot.
> +        minimum: 0
> +        maximum: 255
> +
> +      max-brightness:
> +        description: Maximum brightness level on boot.
> +        minimum: 0
> +        maximum: 255
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        lm3630a_bl@38 {
> +                compatible =3D "ti,lm3630a";
> +                status =3D "ok";
> +                reg =3D <0x38>;
> +
> +                led {
> +                        label =3D "main-lcd";
> +                        led-sources =3D <0 1>;
> +                        default-brightness =3D <200>;
> +                        max-brightness =3D <255>;
> +                };
> +        };
> +    };
> +  - |
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        lm3630a_bl@38 {
> +                compatible =3D "ti,lm3630a";
> +                status =3D "ok";
> +                reg =3D <0x38>;
> +
> +                led-bank-a {
> +                        led-sources =3D <0>;
> +                        default-brightness =3D <150>;
> +                        ti,linear-mapping-mode;
> +                };
> +
> +                led-bank-b {
> +                        led-sources =3D <1>;
> +                        default-brightness =3D <225>;
> +                        ti,linear-mapping-mode;
> +                };
> +        };
> +    };

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--0/kgSOzhNoDC5T3a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyihQ4ACgkQMOfwapXb+vIfoQCfcCWyn261+00n1ZKQWmnRY17y
TXgAmwTgIztadic89rxpKLptExhxP5If
=/ISU
-----END PGP SIGNATURE-----

--0/kgSOzhNoDC5T3a--
