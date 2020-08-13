From: Luca Ceresoli <luca@lucaceresoli.net>
Date: Thu, 13 Aug 2020 10:31:28 +0000
Subject: Re: [PATCH] dt-bindings: Whitespace clean-ups in schema files
Message-Id: <d5808e9c-07fe-1c28-b9a6-a16abe9df458@lucaceresoli.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200812203618.2656699-1-robh@kernel.org>
In-Reply-To: <20200812203618.2656699-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Cc: linux-hwmon@vger.kernel.org, linux-rtc@vger.kernel.org, linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org, linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, linux-mmc@vger.kernel.org, linux-usb@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-spi@vger.kernel.org, linux-gpio@vger.kernel.org, netdev@vger.kernel.org, linux-mtd@lists.infradead.org, linux-i2c@vger.kernel.org, linux-serial@vger.kernel.org, linux-input@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org

Hi Rob,

On 12/08/20 22:36, Rob Herring wrote:
> Clean-up incorrect indentation, extra spaces, long lines, and missing
> EOF newline in schema files. Most of the clean-ups are for list
> indentation which should always be 2 spaces more than the preceding
> keyword.
> 
> Found with yamllint (which I plan to integrate into the checks).

[...]

> diff --git a/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml b/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml
> index 3d4e1685cc55..28c6461b9a9a 100644
> --- a/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml
> +++ b/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml
> @@ -95,10 +95,10 @@ allOf:
>        # Devices without builtin crystal
>        properties:
>          clock-names:
> -            minItems: 1
> -            maxItems: 2
> -            items:
> -              enum: [ xin, clkin ]
> +          minItems: 1
> +          maxItems: 2
> +          items:
> +            enum: [ xin, clkin ]
>          clocks:
>            minItems: 1
>            maxItems: 2

Thanks for noticing, LGTM.

[...]

> diff --git a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml
> index d7dac16a3960..36dc7b56a453 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml
> +++ b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml
> @@ -33,8 +33,8 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/uint32
>  
>    touchscreen-min-pressure:
> -    description: minimum pressure on the touchscreen to be achieved in order for the
> -                 touchscreen driver to report a touch event.
> +    description: minimum pressure on the touchscreen to be achieved in order
> +      for the touchscreen driver to report a touch event.

Out of personal taste, I find the original layout more pleasant and
readable. This third option is also good, especially for long descriptions:

  description:
    minimum pressure on the touchscreen to be achieved in order for the
    touchscreen driver to report a touch event.

At first glance yamllint seems to support exactly these two by default:

> With indentation: {spaces: 4, check-multi-line-strings: true}
> 
> the following code snippet would PASS:
> 
> Blaise Pascal:
>     Je vous écris une longue lettre parce que
>     je n'ai pas le temps d'en écrire une courte.
> 
> the following code snippet would PASS:
> 
> Blaise Pascal: Je vous écris une longue lettre parce que
>                je n'ai pas le temps d'en écrire une courte.
> 
> the following code snippet would FAIL:
> 
> Blaise Pascal: Je vous écris une longue lettre parce que
>   je n'ai pas le temps d'en écrire une courte.
> 
(https://yamllint.readthedocs.io/en/stable/rules.html#module-yamllint.rules.indentation)


-- 
Luca
