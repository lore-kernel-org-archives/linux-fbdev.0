From: Jacek Anaszewski <j.anaszewski@samsung.com>
Date: Tue, 25 Aug 2015 13:39:24 +0000
Subject: Re: [PATCH 3/3] devicetree: Add led-backlight binding
Message-Id: <55DC700C.4030802@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1440502442-19531-1-git-send-email-tomi.valkeinen@ti.com>
 <1440502442-19531-4-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1440502442-19531-4-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, linux-leds@vger.kernel.org, linux-fbdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>

Hi Tomi,

On 08/25/2015 01:34 PM, Tomi Valkeinen wrote:
> Add DT binding for led-backlight.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>   .../bindings/video/backlight/led-backlight.txt     | 30 ++++++++++++++++++++++
>   1 file changed, 30 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/video/backlight/led-backlight.txt
>
> diff --git a/Documentation/devicetree/bindings/video/backlight/led-backlight.txt b/Documentation/devicetree/bindings/video/backlight/led-backlight.txt
> new file mode 100644
> index 000000000000..fb77051ac230
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/video/backlight/led-backlight.txt
> @@ -0,0 +1,30 @@
> +led-backlight bindings
> +
> +Required properties:
> +  - compatible: "led-backlight"
> +  - leds: phandle to a led OF node [0]
> +  - brightness-levels: Array of distinct LED brightness levels. These
> +      are in the range from 0 to 255, passed to the LED class driver.
> +  - default-brightness-level: the default brightness level (index into the
> +      array defined by the "brightness-levels" property)
> +  - power-supply: regulator for supply voltage
> +
> +Optional properties:
> +  - enable-gpios: contains a single GPIO specifier for the GPIO which enables
> +                  and disables the backlight (see GPIO binding[1])
> +
> +[0]: Documentation/devicetree/bindings/leds/common.txt
> +[1]: Documentation/devicetree/bindings/gpio/gpio.txt
> +
> +Example:
> +
> +	backlight {
> +		compatible = "led-backlight";
> +		leds = <&backlight_led>;
> +
> +		brightness-levels = <0 4 8 16 32 64 128 255>;

brightness level is not a suitable unit for describing LED brightness
in a Device Tree, as it is not a physical unit. We have led-max-microamp
property for this, expressed in microamperes, please refer to [0] from
linux-next.

> +		default-brightness-level = <6>;

This also should be microamperes.

> +		power-supply = <&vdd_bl_reg>;
> +		enable-gpios = <&gpio 58 0>;
> +	};
>


-- 
Best Regards,
Jacek Anaszewski
