From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Date: Thu, 20 Dec 2018 12:34:12 +0000
Subject: Re: [PATCH v2 3/4] ARM: dts: imx28-cfa10036: Fix the reset gpio signal polarity
Message-Id: <20181220123412.GG2188@piout.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1545308005-51559-1-git-send-email-michal.vokac@ysoft.com>
 <1545308005-51559-4-git-send-email-michal.vokac@ysoft.com>
In-Reply-To: <1545308005-51559-4-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>
Cc: Rob Herring <robh+dt@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, Maxime Ripard <maxime.ripard@bootlin.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On 20/12/2018 12:13:56+0000, Vokáč Michal wrote:
> The reset signal of the SSD1306 OLED display is actually active-low.
> Adapt the DT to reflect the real world.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
> Changes from v1:
>  - Add R-by from Rob
> 
>  arch/arm/boot/dts/imx28-cfa10036.dts | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx28-cfa10036.dts b/arch/arm/boot/dts/imx28-cfa10036.dts
> index 8337ca2..d6eca31 100644
> --- a/arch/arm/boot/dts/imx28-cfa10036.dts
> +++ b/arch/arm/boot/dts/imx28-cfa10036.dts
> @@ -11,6 +11,7 @@
>  
>  /dts-v1/;
>  #include "imx28.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
>  
>  / {
>  	model = "Crystalfontz CFA-10036 Board";
> @@ -95,7 +96,7 @@
>  					pinctrl-names = "default";
>  					pinctrl-0 = <&ssd1306_cfa10036>;
>  					reg = <0x3c>;
> -					reset-gpios = <&gpio2 7 0>;
> +					reset-gpios = <&gpio2 7 GPIO_ACTIVE_LOW>;
>  					solomon,height = <32>;
>  					solomon,width = <128>;
>  					solomon,page-offset = <0>;
> -- 
> 2.1.4
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
