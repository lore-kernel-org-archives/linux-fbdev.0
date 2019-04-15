From: Dan Murphy <dmurphy@ti.com>
Date: Mon, 15 Apr 2019 12:10:04 +0000
Subject: Re: [PATCH v3 2/3] dt-bindings: backlight: add lm3630a bindings
Message-Id: <051b5306-9dab-6249-9e41-b815dce1f2e2@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190415072905.2861-1-masneyb@onstation.org>
 <20190415072905.2861-3-masneyb@onstation.org>
In-Reply-To: <20190415072905.2861-3-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Brian Masney <masneyb@onstation.org>, lee.jones@linaro.org, daniel.thompson@linaro.org, jingoohan1@gmail.com, robh+dt@kernel.org
Cc: jacek.anaszewski@gmail.com, pavel@ucw.cz, mark.rutland@arm.com, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, jonathan@marek.ca

Brian
On 4/15/19 2:29 AM, Brian Masney wrote:
> Add new backlight bindings for the TI LM3630A dual-string white LED.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
> Rob: Since the common bindings aren't converted to the new JSON schema
> yet, I'm not sure how to do led-sources here. I would expect that we'd
> have the uint32-array on the common binding once it exists. I had to
> add it here to keep 'make dt_binding_check' happy. I left the
> description off though for that property since that'll come from common
> once its converted.
> 
> Changes since v2:
> - Update description of max-brightness
> - Add description for reg
> - Correct typo: s/tranisiton/transition
> - Remove label from bindings since this isn't on backlight_properties
> - add reg to control banks
> - add additionalProperties
> 
>  .../leds/backlight/lm3630a-backlight.yaml     | 124 ++++++++++++++++++
>  1 file changed, 124 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
> 
> diff --git a/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
> new file mode 100644
> index 000000000000..cccd43c02732
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
> @@ -0,0 +1,124 @@
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
> +    description: The I2C address of the device
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
> +        description: Control Bank
> +        maxItems: 1
> +        minimum: 0
> +        maximum: 1
> +
> +      led-sources:
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
> +                compatible = "ti,lm3630a";
> +                status = "ok";
> +                reg = <0x38>;
> +
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                led@0 {
> +                        reg = <0>;
> +                        led-sources = <0 1>;
> +                        default-brightness = <200>;
> +                        max-brightness = <255>;
> +                };
> +        };
> +    };
> +  - |

I noticed we are missing "label".  It is defined as optional and it is hard coded in the driver
but wondering if there is a need to add it.


Dan
<snip>
