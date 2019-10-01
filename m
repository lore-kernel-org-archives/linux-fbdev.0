From: Dan Murphy <dmurphy@ti.com>
Date: Tue, 01 Oct 2019 15:03:13 +0000
Subject: Re: [PATCH V6 1/8] backlight: qcom-wled: Rename pm8941-wled.c to qcom-wled.c
Message-Id: <3cbc14db-9d6d-f60f-eb92-4b4d80d3774d@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1569825553-26039-1-git-send-email-kgunda@codeaurora.org>
 <1569825553-26039-2-git-send-email-kgunda@codeaurora.org>
In-Reply-To: <1569825553-26039-2-git-send-email-kgunda@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kiran Gunda <kgunda@codeaurora.org>, bjorn.andersson@linaro.org, jingoohan1@gmail.com, lee.jones@linaro.org, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, daniel.thompson@linaro.org, jacek.anaszewski@gmail.com, pavel@ucw.cz, robh+dt@kernel.org, mark.rutland@arm.com, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>, linux-fbdev@vger.kernel.org, linux-arm-msm@vger.kernel.org

Kiran

On 9/30/19 1:39 AM, Kiran Gunda wrote:
> pm8941-wled.c driver is supporting the WLED peripheral
> on pm8941. Rename it to qcom-wled.c so that it can support
> WLED on multiple PMICs.
>
> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Acked-by: Rob Herring <robh@kernel.org>
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> ---
>   .../bindings/leds/backlight/{pm8941-wled.txt => qcom-wled.txt}    | 2 +-

Instead of renaming this file would it be more maintainable to indicate 
in the pm8941-wled.txt

to reference the qcom-wled.txt file for complete description?

I will let Rob comment on maintainability.

Dan

>   drivers/video/backlight/Kconfig                                   | 8 ++++----
>   drivers/video/backlight/Makefile                                  | 2 +-
>   drivers/video/backlight/{pm8941-wled.c => qcom-wled.c}            | 0
>   4 files changed, 6 insertions(+), 6 deletions(-)
>   rename Documentation/devicetree/bindings/leds/backlight/{pm8941-wled.txt => qcom-wled.txt} (95%)
>   rename drivers/video/backlight/{pm8941-wled.c => qcom-wled.c} (100%)
>
> diff --git a/Documentation/devicetree/bindings/leds/backlight/pm8941-wled.txt b/Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt
> similarity index 95%
> rename from Documentation/devicetree/bindings/leds/backlight/pm8941-wled.txt
> rename to Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt
> index e5b294d..fb39e32 100644
> --- a/Documentation/devicetree/bindings/leds/backlight/pm8941-wled.txt
> +++ b/Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt
> @@ -1,4 +1,4 @@
> -Binding for Qualcomm PM8941 WLED driver
> +Binding for Qualcomm Technologies, Inc. WLED driver
>   
>   Required properties:
>   - compatible: should be "qcom,pm8941-wled"
> diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
> index 8b081d6..6ff3176 100644
> --- a/drivers/video/backlight/Kconfig
> +++ b/drivers/video/backlight/Kconfig
> @@ -284,12 +284,12 @@ config BACKLIGHT_TOSA
>   	  If you have an Sharp SL-6000 Zaurus say Y to enable a driver
>   	  for its backlight
>   
> -config BACKLIGHT_PM8941_WLED
> -	tristate "Qualcomm PM8941 WLED Driver"
> +config BACKLIGHT_QCOM_WLED
> +	tristate "Qualcomm PMIC WLED Driver"
>   	select REGMAP
>   	help
> -	  If you have the Qualcomm PM8941, say Y to enable a driver for the
> -	  WLED block.
> +	  If you have the Qualcomm PMIC, say Y to enable a driver for the
> +	  WLED block. Currently it supports PM8941 and PMI8998.
>   
>   config BACKLIGHT_SAHARA
>   	tristate "Tabletkiosk Sahara Touch-iT Backlight Driver"
> diff --git a/drivers/video/backlight/Makefile b/drivers/video/backlight/Makefile
> index 63c507c..6f87770 100644
> --- a/drivers/video/backlight/Makefile
> +++ b/drivers/video/backlight/Makefile
> @@ -48,8 +48,8 @@ obj-$(CONFIG_BACKLIGHT_OMAP1)		+= omap1_bl.o
>   obj-$(CONFIG_BACKLIGHT_OT200)		+= ot200_bl.o
>   obj-$(CONFIG_BACKLIGHT_PANDORA)		+= pandora_bl.o
>   obj-$(CONFIG_BACKLIGHT_PCF50633)	+= pcf50633-backlight.o
> -obj-$(CONFIG_BACKLIGHT_PM8941_WLED)	+= pm8941-wled.o
>   obj-$(CONFIG_BACKLIGHT_PWM)		+= pwm_bl.o
> +obj-$(CONFIG_BACKLIGHT_QCOM_WLED)	+= qcom-wled.o
>   obj-$(CONFIG_BACKLIGHT_SAHARA)		+= kb3886_bl.o
>   obj-$(CONFIG_BACKLIGHT_SKY81452)	+= sky81452-backlight.o
>   obj-$(CONFIG_BACKLIGHT_TOSA)		+= tosa_bl.o
> diff --git a/drivers/video/backlight/pm8941-wled.c b/drivers/video/backlight/qcom-wled.c
> similarity index 100%
> rename from drivers/video/backlight/pm8941-wled.c
> rename to drivers/video/backlight/qcom-wled.c
