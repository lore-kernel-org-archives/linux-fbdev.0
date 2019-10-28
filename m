From: Rob Herring <robh+dt@kernel.org>
Date: Mon, 28 Oct 2019 23:25:56 +0000
Subject: Re: [PATCH v4 1/2] dt-bindings: backlight: lm3630a: add enable_gpios
Message-Id: <CAL_Jsq+zDYifFntHMqmqU4qmsj7_nafN+W7a0Vh+HdwGvVj5TA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190912213257.24147-1-andreas@kemnade.info> <20190912213257.24147-2-andreas@kemnade.info>
In-Reply-To: <20190912213257.24147-2-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>, Mark Rutland <mark.rutland@arm.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel <dri-devel@lists.freedesktop.org>, Linux LED Subsystem <linux-leds@vger.kernel.org>, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>

On Thu, Sep 12, 2019 at 4:33 PM Andreas Kemnade <andreas@kemnade.info> wrote:
>
> add enable-gpios to describe HWEN pin
>
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>

This breaking linux-next now...

> ---
> changes in v2: added example
> changes in v3: added Acked-by
> changes in v4: moved enable-gpios to the right position
>   in the example
>  .../bindings/leds/backlight/lm3630a-backlight.yaml           | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
> index dc129d9a329e..c8470628fe02 100644
> --- a/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
> +++ b/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
> @@ -29,6 +29,10 @@ properties:
>    '#size-cells':
>      const: 0
>
> +  enable-gpios:
> +    description: GPIO to use to enable/disable the backlight (HWEN pin).
> +    maxItems: 1
> +
>  required:
>    - compatible
>    - reg
> @@ -96,6 +100,7 @@ examples:
>          led-controller@38 {
>                  compatible = "ti,lm3630a";
>                  reg = <0x38>;
> +                enable-gpios = <&gpio2 5 GPIO_ACTIVE_HIGH>;

Error: Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.example.dts:24.46-47
syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.example.dt.yaml]
Error 1
scripts/Makefile.lib:314: recipe for target
'Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.example.dt.yaml'
failed

You need the include for the define.

Rob
