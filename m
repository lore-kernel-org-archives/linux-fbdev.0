From: Lee Jones <lee.jones@linaro.org>
Date: Mon, 09 Mar 2015 09:40:50 +0000
Subject: Re: [PATCH v11 4/6] devicetree: Add new SKY81452 backlight binding
Message-Id: <20150309094050.GO3427@x1>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1425019346-4559-1-git-send-email-jack.yoo@skyworksinc.com>
 <1425019346-4559-5-git-send-email-jack.yoo@skyworksinc.com>
In-Reply-To: <1425019346-4559-5-git-send-email-jack.yoo@skyworksinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: gyungoh@gmail.com
Cc: sameo@linux.intel.com, robh+dt@kernel.org, jg1.han@samsung.com, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, trivial@kernel.org, broonie@kernel.org, florian.vaussard@epfl.ch, andrew@lunn.ch, antonynpavlov@gmail.com, hytszk@gmail.com, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, jack.yoo@skyworksinc.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, treding@nvidia.com, p.zabel@pengutronix.de, arno@natisbad.org, kuninori.morimoto.gx@renesas.com

Applied, thanks.

On Fri, 27 Feb 2015, gyungoh@gmail.com wrote:

> From: Gyungoh Yoo <jack.yoo@skyworksinc.com>
>=20
> Signed-off-by: Gyungoh Yoo <jack.yoo@skyworksinc.com>
> Acked-by: Bryan Wu <cooloney@gmail.com>
> ---
> Changes v11:
> Renamed 'skyworks,en-channels' property to led-sources.
> Removed unused property 'skyworks,ovp-level'.
>=20
> Changes v10:
> Nothing
>=20
> Changes v9:
> Nothing
>=20
> Changes v8:
> Renamed property names for backlight with vendor prefix
> Modified gpio-enable property to generic property for GPIO
> Made up the example for backlight DT
>=20
> Changes v7:
> Nothing
>=20
> Changes v6:
> Nothing
>=20
> Changes v5:
> Nothing
>=20
> Changes v4:
> Nothing
>=20
> Changes v3:
> Nothing
>=20
> Changes v2:
> Added reg attribute for I2C slave address
>=20
>  .../video/backlight/sky81452-backlight.txt         | 29 ++++++++++++++++=
++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/video/backlight/sky=
81452-backlight.txt
>=20
> diff --git a/Documentation/devicetree/bindings/video/backlight/sky81452-b=
acklight.txt b/Documentation/devicetree/bindings/video/backlight/sky81452-b=
acklight.txt
> new file mode 100644
> index 0000000..8bf2940
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/video/backlight/sky81452-backligh=
t.txt
> @@ -0,0 +1,29 @@
> +SKY81452-backlight bindings
> +
> +Required properties:
> +- compatible		: Must be "skyworks,sky81452-backlight"
> +
> +Optional properties:
> +- name			: Name of backlight device. Default is 'lcd-backlight'.
> +- gpios			: GPIO to use to EN pin.
> +			See Documentation/devicetree/bindings/gpio/gpio.txt
> +- led-sources		: List of enabled channels from 0 to 5.
> +			See Documentation/devicetree/bindings/leds/common.txt
> +- skyworks,ignore-pwm	: Ignore both PWM input
> +- skyworks,dpwm-mode	: Enable DPWM dimming mode, otherwise Analog dimmin=
g.
> +- skyworks,phase-shift	: Enable phase shift mode
> +- skyworks,short-detection-threshold-volt
> +			: It should be one of 4, 5, 6 and 7V.
> +- skyworks,current-limit-mA
> +			: It should be 2300mA or 2750mA.
> +
> +Example:
> +
> +	backlight {
> +		compatible =3D "skyworks,sky81452-backlight";
> +		name =3D "pwm-backlight";
> +		led-sources =3D <0 1 2 5>;
> +		skyworks,ignore-pwm;
> +		skyworks,phase-shift;
> +		skyworks,current-limit-mA =3D <2300>;
> +	};

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
