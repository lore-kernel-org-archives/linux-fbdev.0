From: Lee Jones <lee.jones@linaro.org>
Date: Thu, 18 Dec 2014 08:30:36 +0000
Subject: Re: [PATCH v10 4/6] devicetree: backlight: Add new SKY81452 backlight binding
Message-Id: <20141218083036.GR13885@x1>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1418881671-3495-1-git-send-email-jack.yoo@skyworksinc.com>
 <1418881671-3495-5-git-send-email-jack.yoo@skyworksinc.com>
In-Reply-To: <1418881671-3495-5-git-send-email-jack.yoo@skyworksinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: gyungoh@gmail.com
Cc: sameo@linux.intel.com, grant.likely@linaro.org, robh+dt@kernel.org, jg1.han@samsung.com, cooloney@gmail.com, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, trivial@kernel.org, akpm@linux-foundation.org, jic23@kernel.org, thomas.petazzoni@free-electrons.com, ktsai@capellamicro.com, hs@denx.de, stwiss.opensource@diasemi.com, matti.vaittinen@nsn.com, broonie@kernel.org, jason@lakedaemon.net, heiko@sntech.de, shawn.guo@freescale.com, florian.vaussard@epfl.ch, andrew@lunn.ch, antonynpavlov@gmail.com, hytszk@gmail.com, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, jack.yoo@skyworksinc.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org

DT Ack please.

> From: Gyungoh Yoo <jack.yoo@skyworksinc.com>
>=20
> Signed-off-by: Gyungoh Yoo <jack.yoo@skyworksinc.com>
> Acked-by: Bryan Wu <cooloney@gmail.com>
> ---

[...]

> Changes v8:
> Renamed property names for backlight with vendor prefix
> Modified gpio-enable property to generic property for GPIO
> Made up the example for backlight DT

[...]

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
> index 0000000..8daebf5
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
> +- skyworks,en-channels	: Enable mask for current sink channel 1 to 6.
> +- skyworks,ignore-pwm	: Ignore both PWM input
> +- skyworks,dpwm-mode	: Enable DPWM dimming mode, otherwise Analog dimmin=
g.
> +- skyworks,phase-shift	: Enable phase shift mode
> +- skyworks,ovp-level	: Over-voltage protection level.
> +			Should be between 14 or 28V.
> +- skyworks,short-detection-threshold	: It should be one of 4, 5, 6 and 7=
V.
> +- skyworks,current-limit	: It should be 2300mA or 2750mA.

These need a DT Ack (if they are still alive).

> +Example:
> +
> +	backlight {
> +		compatible =3D "skyworks,sky81452-backlight";
> +		name =3D "pwm-backlight";
> +		skyworks,en-channels =3D <0x3f>;
> +		skyworks,ignore-pwm;
> +		skyworks,phase-shift;
> +		skyworks,ovp-level =3D <20>;
> +		skyworks,current-limit =3D <2300>;
> +	};

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
