From: Simon Glass <sjg@chromium.org>
Date: Thu, 12 Jul 2012 09:37:33 +0000
Subject: Re: [RFC][PATCH V2 3/3] tegra: add pwm backlight device tree nodes
Message-Id: <CAPnjgZ1QbjE+-tr0c01K2feUdEE2wMBfR=bKpTxnyDOJbY8+1Q@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1341814105-20690-1-git-send-email-acourbot@nvidia.com>
	<1341814105-20690-4-git-send-email-acourbot@nvidia.com>
In-Reply-To: <1341814105-20690-4-git-send-email-acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org

Hi Alex,

On Mon, Jul 9, 2012 at 8:08 AM, Alexandre Courbot <acourbot@nvidia.com> wrote:
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
>  arch/arm/boot/dts/tegra20-ventana.dts | 31 +++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/tegra20.dtsi        |  2 +-
>  2 files changed, 32 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/tegra20-ventana.dts b/arch/arm/boot/dts/tegra20-ventana.dts
> index be90544..c67d9e1 100644
> --- a/arch/arm/boot/dts/tegra20-ventana.dts
> +++ b/arch/arm/boot/dts/tegra20-ventana.dts
> @@ -317,6 +317,37 @@
>                 bus-width = <8>;
>         };
>

I would like to do something similar in U-Boot for Tegra, although
perhaps not right away. For now I will go with something considerably
simpler! But if this is merged into the kernel we will move to it in
U-Boot. Anyway here are my comments:

> +       backlight {
> +               compatible = "pwm-backlight";
> +               brightness-levels = <0 16 32 48 64 80 96 112 128 144 160 176 192 208 224 240 255>;

We seem to have a lot of these - should we move to a range and step size?

> +               default-brightness-level = <12>;
> +
> +               pwms = <&pwm 2 5000000>;
> +               pwm-names = "backlight";
> +               power-supply = <&backlight_reg>;
> +               enable-gpios = <&gpio 28 0>;
> +
> +               power-on-sequence = "REGULATOR", "power", <1>,
> +                                   "DELAY", <10>,
> +                                   "PWM", "backlight", <1>,
> +                                   "GPIO", "enable", <1>;

So the names REGULATOR, DELAY, etc. here are looked up through some
existing mechanism? In general I am not a big fan of mixing strings
and numbers in a property. Maybe something like:

power_on_sequence {
   step@0 {
      phandle = <&backlight_reg>;
      enable = <1>;
      post-delay = <10>;
   }
   step@1 {
      phandle = <&pwm 2 5000000>;
   }
   step@2 {
      phandle = <&gpio 28 0>;
      enable = <1>;
   }

> +               power-off-sequence = "GPIO", "enable", <0>,
> +                                    "PWM", "backlight", <0>,
> +                                    "DELAY", <10>,
> +                                    "REGULATOR", "power", <0>;
> +       };
> +
> +       backlight_reg: fixedregulator@176 {
> +               compatible = "regulator-fixed";
> +               regulator-name = "backlight_regulator";
> +               regulator-min-microvolt = <1800000>;
> +               regulator-max-microvolt = <1800000>;
> +               gpio = <&gpio 176 0>;
> +               startup-delay-us = <0>;
> +               enable-active-high;
> +               regulator-boot-off;
> +       };
> +
>         sound {
>                 compatible = "nvidia,tegra-audio-wm8903-ventana",
>                              "nvidia,tegra-audio-wm8903";
> diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
> index 405d167..67a6cd9 100644
> --- a/arch/arm/boot/dts/tegra20.dtsi
> +++ b/arch/arm/boot/dts/tegra20.dtsi
> @@ -123,7 +123,7 @@
>                 status = "disabled";
>         };
>
> -       pwm {
> +       pwm: pwm {
>                 compatible = "nvidia,tegra20-pwm";
>                 reg = <0x7000a000 0x100>;
>                 #pwm-cells = <2>;
> --
> 1.7.11.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Regards,
Simon
