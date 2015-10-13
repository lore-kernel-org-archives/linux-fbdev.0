From: Lee Jones <lee.jones@linaro.org>
Date: Tue, 13 Oct 2015 08:42:48 +0000
Subject: Re: [PATCHv4 3/3] devicetree: Add led-backlight binding
Message-Id: <20151013084248.GA32409@x1>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1443605522-1118-1-git-send-email-tomi.valkeinen@ti.com>
 <1443605522-1118-4-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1443605522-1118-4-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Jacek Anaszewski <j.anaszewski@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, linux-leds@vger.kernel.org, linux-fbdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, devicetree@vger.kernel.org

On Wed, 30 Sep 2015, Tomi Valkeinen wrote:

> Add DT binding for led-backlight.
>=20
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: devicetree@vger.kernel.org
> ---
>  .../bindings/video/backlight/led-backlight.txt     | 30 ++++++++++++++++=
++++++
>  1 file changed, 30 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/video/backlight/led=
-backlight.txt
>=20
> diff --git a/Documentation/devicetree/bindings/video/backlight/led-backli=
ght.txt b/Documentation/devicetree/bindings/video/backlight/led-backlight.t=
xt
> new file mode 100644
> index 000000000000..d4621d7414bc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/video/backlight/led-backlight.txt
> @@ -0,0 +1,30 @@
> +led-backlight bindings

Make this look like a heading, rather than just another binding.

I would expect to see "LED Backlight Bindings" or similar.

> +Required properties:
> +  - compatible: "led-backlight"
> +  - leds: phandle to a led OF node [0]

s/phandle/Phandle/

s/led/LED/

s/[0]/(See: ../leds/common.txt)

> +  - brightness-levels: Array of distinct LED brightness levels. These
> +      are in the range from 0 to 255, passed to the LED class driver.
> +  - default-brightness-level: the default brightness level (index into t=
he

s/the/The/

> +      array defined by the "brightness-levels" property)

Tab this out, so:

- compatible			: "led-backlight"
- leds				: phandle to a led OF node [0]
- brightness-levels		: Array of distinct LED brightness levels. These
				  are in the range from 0 to 255, passed to the LED class driver.
- default-brightness-level	: the default brightness level (index into the
				  array defined by the "brightness-levels" property)

Etc.

> +Optional properties:
> +  - power-supply: regulator for supply voltage

s/regulator/Regulator/

> +  - enable-gpios: contains a single GPIO specifier for the GPIO which en=
ables

s/contains/Contains/

> +                  and disables the backlight (see GPIO binding[1])

s/[1]/(See: ../gpio/gpio.txt)

> +[0]: Documentation/devicetree/bindings/leds/common.txt
> +[1]: Documentation/devicetree/bindings/gpio/gpio.txt

Remove these.

> +Example:
> +
> +	backlight {
> +		compatible =3D "led-backlight";
> +		leds =3D <&backlight_led>;
> +
> +		brightness-levels =3D <0 4 8 16 32 64 128 255>;
> +		default-brightness-level =3D <6>;
> +
> +		power-supply =3D <&vdd_bl_reg>;
> +		enable-gpios =3D <&gpio 58 0>;
> +	};

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
