From: Dan Murphy <dmurphy@ti.com>
Date: Thu, 12 Sep 2019 11:39:50 +0000
Subject: Re: [PATCH v3 1/2] dt-bindings: backlight: lm3630a: add enable_gpios
Message-Id: <ff410d6c-e1e8-7c96-e8f7-0a0deb816f6a@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190911172106.12843-1-andreas@kemnade.info>
 <20190911172106.12843-2-andreas@kemnade.info>
In-Reply-To: <20190911172106.12843-2-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andreas Kemnade <andreas@kemnade.info>, lee.jones@linaro.org, daniel.thompson@linaro.org, jingoohan1@gmail.com, jacek.anaszewski@gmail.com, pavel@ucw.cz, robh+dt@kernel.org, mark.rutland@arm.com, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, "H. Nikolaus Schaller" <hns@goldelico.com>

Andreas

On 9/11/19 12:21 PM, Andreas Kemnade wrote:
> add enable-gpios to describe HWEN pin
>
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
> changes in v2: added example
> changes in v3: added Acked-by
>   .../bindings/leds/backlight/lm3630a-backlight.yaml           | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
> index dc129d9a329e..1fa83feffe16 100644
> --- a/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
> +++ b/Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
> @@ -29,6 +29,10 @@ properties:
>     '#size-cells':
>       const: 0
>   
> +  enable-gpios:
> +    description: GPIO to use to enable/disable the backlight (HWEN pin).
> +    maxItems: 1
> +
>   required:
>     - compatible
>     - reg
> @@ -92,6 +96,7 @@ examples:
>       i2c {
>           #address-cells = <1>;
>           #size-cells = <0>;
> +        enable-gpios = <&gpio2 5 GPIO_ACTIVE_HIGH>;
>   
>           led-controller@38 {
>                   compatible = "ti,lm3630a";

Looks good to me

Reviewed-by: Dan Murphy <dmurphy@ti.com>
