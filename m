From: Rob Herring <robherring2@gmail.com>
Date: Wed, 04 Feb 2015 15:11:22 +0000
Subject: Re: [PATCH v10 4/6] devicetree: Add new SKY81452 backlight binding
Message-Id: <CAL_JsqJHvpmBY4RDBWFA3RqQ9h_Yf25iSFxQe9oTNdSPybi87g@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1421994515-3070-1-git-send-email-jack.yoo@skyworksinc.com> <1421994515-3070-5-git-send-email-jack.yoo@skyworksinc.com>
In-Reply-To: <1421994515-3070-5-git-send-email-jack.yoo@skyworksinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: gyungoh@gmail.com
Cc: Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Jingoo Han <jg1.han@samsung.com>, Bryan Wu <cooloney@gmail.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Jiri Kosina <trivial@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Jonathan Cameron <jic23@kernel.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, ktsai@capellamicro.com, hs@denx.de, "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>, matti.vaittinen@nsn.com, Mark Brown <broonie@kernel.org>, Jason Cooper <jason@lakedaemon.net>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Shawn Guo <shawn.guo@freescale.com>, Florian Vaussard <florian.vaussard@epfl.ch>, Andrew Lunn <andrew@l>

On Fri, Jan 23, 2015 at 12:28 AM,  <gyungoh@gmail.com> wrote:
> From: Gyungoh Yoo <jack.yoo@skyworksinc.com>
>
> Signed-off-by: Gyungoh Yoo <jack.yoo@skyworksinc.com>
> Acked-by: Bryan Wu <cooloney@gmail.com>
> ---
> Changes v10:
> Nothing
>
> Changes v9:
> Nothing
>
> Changes v8:
> Renamed property names for backlight with vendor prefix
> Modified gpio-enable property to generic property for GPIO
> Made up the example for backlight DT
>
> Changes v7:
> Nothing
>
> Changes v6:
> Nothing
>
> Changes v5:
> Nothing
>
> Changes v4:
> Nothing
>
> Changes v3:
> Nothing
>
> Changes v2:
> Added reg attribute for I2C slave address

You did? Where is it?

>  .../video/backlight/sky81452-backlight.txt         | 29 ++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/video/backlight/sky81452-backlight.txt
>
> diff --git a/Documentation/devicetree/bindings/video/backlight/sky81452-backlight.txt b/Documentation/devicetree/bindings/video/backlight/sky81452-backlight.txt
> new file mode 100644
> index 0000000..8daebf5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/video/backlight/sky81452-backlight.txt
> @@ -0,0 +1,29 @@
> +SKY81452-backlight bindings
> +
> +Required properties:
> +- compatible           : Must be "skyworks,sky81452-backlight"
> +
> +Optional properties:
> +- name                 : Name of backlight device. Default is 'lcd-backlight'.
> +- gpios                        : GPIO to use to EN pin.
> +                       See Documentation/devicetree/bindings/gpio/gpio.txt
> +- skyworks,en-channels : Enable mask for current sink channel 1 to 6.

Does led-sources property being added in 3.20 work for this?

> +- skyworks,ignore-pwm  : Ignore both PWM input
> +- skyworks,dpwm-mode   : Enable DPWM dimming mode, otherwise Analog dimming.
> +- skyworks,phase-shift : Enable phase shift mode
> +- skyworks,ovp-level   : Over-voltage protection level.
> +                       Should be between 14 or 28V.

Please append units (-volt)

> +- skyworks,short-detection-threshold   : It should be one of 4, 5, 6 and 7V.

Please append units (-volt)

> +- skyworks,current-limit       : It should be 2300mA or 2750mA.

Please append units (-mA)

> +
> +Example:
> +
> +       backlight {
> +               compatible = "skyworks,sky81452-backlight";
> +               name = "pwm-backlight";
> +               skyworks,en-channels = <0x3f>;
> +               skyworks,ignore-pwm;
> +               skyworks,phase-shift;
> +               skyworks,ovp-level = <20>;
> +               skyworks,current-limit = <2300>;
> +       };
> --
> 1.9.1
>
