From: Dan Murphy <dmurphy@ti.com>
Date: Tue, 02 Apr 2019 12:56:55 +0000
Subject: Re: [PATCH v2 2/3] dt-bindings: backlight: add lm3630a bindings
Message-Id: <68229e7f-4749-cde5-f541-793ab614084d@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190401103034.21062-1-masneyb@onstation.org>
 <20190401103034.21062-3-masneyb@onstation.org>
In-Reply-To: <20190401103034.21062-3-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Brian Masney <masneyb@onstation.org>, lee.jones@linaro.org, daniel.thompson@linaro.org, jingoohan1@gmail.com, robh+dt@kernel.org
Cc: jacek.anaszewski@gmail.com, pavel@ucw.cz, mark.rutland@arm.com, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, jonathan@marek.ca

Hello

On 4/1/19 5:30 AM, Brian Masney wrote:
> Add new backlight bindings for the TI LM3630A dual-string white LED.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
>  .../leds/backlight/lm3630a-backlight.yaml     | 112 ++++++++++++++++++
>  1 file changed, 112 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
> 
> diff --git a/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
> new file mode 100644
> index 000000000000..42a8c59d237a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
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
> +  The LM3630A is a current-mode boost converter which supplies the power and
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

No description on the reg here.  Assumed to be the i2c address?

> +  ti,linear-mapping-mode:
> +    description: |
> +      Enable linear mapping mode. If disabled, then it will use exponential
> +      mapping mode in which the ramp up/down appears to have a more uniform
> +      tranisiton to the human eye.

s/tranisiton/transition

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

I have written a few of these drivers that have control bank support to control.  We have
been defining the reg property as the control bank id

reg 0 - Control bank A
reg 1 - Control bank B

Then use the led-sources to define what outputs are associated with which control bank.

This way the hardware can just have CB B enabled without CB A.

something like below would allow just control bank B to be enabled.

led@1 {
	reg = <1>;
	label = "main-lcd";
	default-brightness = <200>;
	max-brightness = <255>;
};

This would connect control bank B to control bank A.  Or just use a flag to denote to connect them
and not use led-sources.  But led-sources is the property of choice.

led@0 {
	reg = <0>;
	led-sources = < 0 1 >;
	label = "main-lcd";
	default-brightness = <200>;
	max-brightness = <255>;
};

And just the presence of 2 child nodes would indicate individual bank control
led@0 {
	reg = <0>;
	label = "main-lcd";
	default-brightness = <200>;
	max-brightness = <255>;
};

led@1 {
	reg = <1>;
	label = "main-keypad";
	default-brightness = <200>;
	max-brightness = <255>;
};

> +    properties:
> +      label:
> +        description: |
> +          The label for this LED. If omitted, the label is taken from the node
> +          name (excluding the unit address). It has to uniquely identify a
> +          device, i.e. no other LED class device can be assigned the same label.
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

label and led-sources are already defined in the common.txt no need to redefine them here.

> +      default-brightness:
> +        description: Default brightness level on boot.
> +        minimum: 0
> +        maximum: 255
> +
> +      max-brightness:
> +        description: Maximum brightness level on boot.

This is not the max brightness on boot.  This is the max brightness that is allowed during runtime.

Dan

> +        minimum: 0
> +        maximum: 255
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        lm3630a_bl@38 {
> +                compatible = "ti,lm3630a";
> +                status = "ok";
> +                reg = <0x38>;
> +
> +                led {
> +                        label = "main-lcd";
> +                        led-sources = <0 1>;
> +                        default-brightness = <200>;
> +                        max-brightness = <255>;
> +                };
> +        };
> +    };
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        lm3630a_bl@38 {
> +                compatible = "ti,lm3630a";
> +                status = "ok";
> +                reg = <0x38>;
> +
> +                led-bank-a {
> +                        led-sources = <0>;
> +                        default-brightness = <150>;
> +                        ti,linear-mapping-mode;
> +                };
> +
> +                led-bank-b {
> +                        led-sources = <1>;
> +                        default-brightness = <225>;
> +                        ti,linear-mapping-mode;
> +                };
> +        };
> +    };
> 


-- 
------------------
Dan Murphy
