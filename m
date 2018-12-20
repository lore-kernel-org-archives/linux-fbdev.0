From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Date: Thu, 20 Dec 2018 12:33:41 +0000
Subject: Re: [PATCH v2 1/4] dt-bindings: display: ssd1307fb: Remove reset-active-low from examples
Message-Id: <20181220123341.GE2188@piout.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1545308005-51559-1-git-send-email-michal.vokac@ysoft.com>
 <1545308005-51559-2-git-send-email-michal.vokac@ysoft.com>
In-Reply-To: <1545308005-51559-2-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>
Cc: Rob Herring <robh+dt@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, Maxime Ripard <maxime.ripard@bootlin.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On 20/12/2018 12:13:54+0000, Vokáč Michal wrote:
> The reset-active-low property has been removed brom the binding a while
> ago. So remove it from the examples as well.
> 
> Fixes: 519b4db ("fbdev: ssd1307fb: Remove reset-active-low from the DT binding document")
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
> Changes from v1:
>  - Add R-by from Rob
> 
>  Documentation/devicetree/bindings/display/ssd1307fb.txt | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/ssd1307fb.txt b/Documentation/devicetree/bindings/display/ssd1307fb.txt
> index 209d931..b67f8ca 100644
> --- a/Documentation/devicetree/bindings/display/ssd1307fb.txt
> +++ b/Documentation/devicetree/bindings/display/ssd1307fb.txt
> @@ -36,7 +36,6 @@ ssd1307: oled@3c {
>          reg = <0x3c>;
>          pwms = <&pwm 4 3000>;
>          reset-gpios = <&gpio2 7>;
> -        reset-active-low;
>  };
>  
>  ssd1306: oled@3c {
> @@ -44,7 +43,6 @@ ssd1306: oled@3c {
>          reg = <0x3c>;
>          pwms = <&pwm 4 3000>;
>          reset-gpios = <&gpio2 7>;
> -        reset-active-low;
>          solomon,com-lrremap;
>          solomon,com-invdir;
>          solomon,com-offset = <32>;
> -- 
> 2.1.4
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
