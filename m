From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 24 Apr 2019 01:52:51 +0000
Subject: Re: [PATCH v5 2/3] dt-bindings: backlight: add lm3630a bindings
Message-Id: <CAL_JsqLZqA=cKLo3Jw7fizt06ytADL8YbhhRKS=mLo05hAaf2A@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190418151143.26068-1-masneyb@onstation.org> <20190418151143.26068-3-masneyb@onstation.org>
In-Reply-To: <20190418151143.26068-3-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Brian Masney <masneyb@onstation.org>
Cc: Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Mark Rutland <mark.rutland@arm.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel <dri-devel@lists.freedesktop.org>, Linux LED Subsystem <linux-leds@vger.kernel.org>, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>, Jonathan Marek <jonathan@marek.ca>

On Thu, Apr 18, 2019 at 10:12 AM Brian Masney <masneyb@onstation.org> wrote:
>
> Add new backlight bindings for the TI LM3630A dual-string white LED.
>
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
> Changes since v4:
> - Drop $ref from led-sources
> - Drop description from reg of i2c address
> - Expand description of reg for the control bank
> - Drop status from examples
>
> Changes since v3:
> - Add label. I didn't add a description for it since that'll come from
>   the common properties once its converted.
>
> Changes since v2:
> - Update description of max-brightness
> - Add description for reg
> - Correct typo: s/tranisiton/transition
> - add reg to control banks
> - add additionalProperties
>
>  .../leds/backlight/lm3630a-backlight.yaml     | 129 ++++++++++++++++++
>  1 file changed, 129 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
>
> diff --git a/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
> new file mode 100644
> index 000000000000..e754df569365
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
> @@ -0,0 +1,129 @@
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
> +  ti,linear-mapping-mode:
> +    description: |
> +      Enable linear mapping mode. If disabled, then it will use exponential
> +      mapping mode in which the ramp up/down appears to have a more uniform
> +      transition to the human eye.
> +    type: boolean
> +
> +required:
> +  - compatible
> +  - reg
> +
> +patternProperties:
> +  "^led@[01]$":
> +    type: object
> +    description: |
> +      Properties for a string of connected LEDs.
> +
> +    properties:
> +      reg:
> +        description: |
> +          The control bank that is used to program the two current sinks. The
> +          LM3630A has two control banks (A and B) and are represented as 0 or 1
> +          in this property. The two current sinks can be controlled
> +          independently with both banks, or bank A can be configured to control
> +          both sinks with the led-sources property.
> +        maxItems: 1
> +        minimum: 0
> +        maximum: 1
> +
> +      label:
> +        maxItems: 1
> +
> +      led-sources:
> +        allOf:
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
> +        description: Maximum brightness that is allowed during runtime.
> +        minimum: 0
> +        maximum: 255
> +
> +    required:
> +      - reg
> +
> +    additionalProperties: false
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        lm3630a_bl@38 {

Still needs:

led-controller@38

> +                compatible = "ti,lm3630a";
> +                reg = <0x38>;
> +
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                led@0 {
> +                        reg = <0>;
> +                        led-sources = <0 1>;
> +                        label = "lcd-backlight";
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

And here.

With those fixed:

Reviewed-by: Rob Herring <robh@kernel.org>
