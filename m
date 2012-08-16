From: Stephen Warren <swarren@wwwdotorg.org>
Date: Thu, 16 Aug 2012 18:45:30 +0000
Subject: Re: [PATCH v4 3/3] tegra: add pwm backlight device tree nodes
Message-Id: <502D3FCA.6030708@wwwdotorg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1345097337-24170-1-git-send-email-acourbot@nvidia.com>
 <1345097337-24170-4-git-send-email-acourbot@nvidia.com>
In-Reply-To: <1345097337-24170-4-git-send-email-acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Anton Vorontsov <cbou-JGs/UdohzUI@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org

On 08/16/2012 12:08 AM, Alexandre Courbot wrote:

> +++ b/arch/arm/boot/dts/tegra20-ventana.dts

> +	backlight_reg: fixedregulator@176 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "backlight_regulator";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		gpio = <&gpio 176 0>;
> +		startup-delay-us = <0>;
> +		enable-active-high;
> +		regulator-boot-off;
> +	};

Rather than add that as a separate node at the top-level, I think just
add another sub-node to the "regulators" node. Oh, in fact it's already
there in next-20120816; you just need to add a label.

> +++ b/arch/arm/boot/dts/tegra20.dtsi

> -	pwm {
> +	pwm: pwm {
>  		compatible = "nvidia,tegra20-pwm";
>  		reg = <0x7000a000 0x100>;

It's pretty trivial I know, but I'd almost be tempted to make that a
separate patch so that it could be cherry-picked somewhere without a
tegra20-ventana.dts. But, perhaps that's silly.
