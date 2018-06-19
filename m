From: Bjorn Andersson <bjorn.andersson@linaro.org>
Date: Tue, 19 Jun 2018 23:11:26 +0000
Subject: Re: [PATCH V3 4/7] backlight: qcom-wled: Rename PM8941* to WLED3
Message-Id: <20180619231126.GH15126@tuxbook-pro>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1529406822-15379-1-git-send-email-kgunda@codeaurora.org>
 <1529406822-15379-5-git-send-email-kgunda@codeaurora.org>
In-Reply-To: <1529406822-15379-5-git-send-email-kgunda@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kiran Gunda <kgunda@codeaurora.org>
Cc: jingoohan1@gmail.com, lee.jones@linaro.org, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, Daniel Thompson <daniel.thompson@linaro.org>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-leds@vger.kernel.org

On Tue 19 Jun 04:13 PDT 2018, Kiran Gunda wrote:

> Rename the PM8941* references as WLED3 to make the
> driver generic and have WLED support for other PMICs.
> 

Looks good, just three minor comments below.

> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
> ---
>  drivers/video/backlight/qcom-wled.c | 248 ++++++++++++++++++------------------
>  1 file changed, 125 insertions(+), 123 deletions(-)
> 
> diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
> index 0b6d219..812f3cb 100644
> --- a/drivers/video/backlight/qcom-wled.c
> +++ b/drivers/video/backlight/qcom-wled.c
> @@ -18,77 +18,79 @@
>  #include <linux/regmap.h>
>  
>  /* From DT binding */
> -#define PM8941_WLED_DEFAULT_BRIGHTNESS		2048
> +#define WLED_DEFAULT_BRIGHTNESS				2048
>  
> -#define PM8941_WLED_REG_VAL_BASE		0x40
> -#define  PM8941_WLED_REG_VAL_MAX		0xFFF
> +#define WLED3_SINK_REG_BRIGHT_MAX			0xFFF
> +#define WLED3_CTRL_REG_VAL_BASE				0x40
>  
> -#define PM8941_WLED_REG_MOD_EN			0x46
> -#define  PM8941_WLED_REG_MOD_EN_BIT		BIT(7)
> -#define  PM8941_WLED_REG_MOD_EN_MASK		BIT(7)
> +/* WLED3 control registers */
> +#define WLED3_CTRL_REG_MOD_EN				0x46
> +#define  WLED3_CTRL_REG_MOD_EN_BIT			BIT(7)
> +#define  WLED3_CTRL_REG_MOD_EN_MASK			BIT(7)
>  
> -#define PM8941_WLED_REG_SYNC			0x47

These are in address order, any reason why WLED3_SINK_REG_SYNC moved
down?

> -#define  PM8941_WLED_REG_SYNC_MASK		0x07
> -#define  PM8941_WLED_REG_SYNC_LED1		BIT(0)
> -#define  PM8941_WLED_REG_SYNC_LED2		BIT(1)
> -#define  PM8941_WLED_REG_SYNC_LED3		BIT(2)
> -#define  PM8941_WLED_REG_SYNC_ALL		0x07
> -#define  PM8941_WLED_REG_SYNC_CLEAR		0x00
> +#define WLED3_CTRL_REG_FREQ				0x4c
> +#define  WLED3_CTRL_REG_FREQ_MASK			0x0f
>  
> -#define PM8941_WLED_REG_FREQ			0x4c
> -#define  PM8941_WLED_REG_FREQ_MASK		0x0f
> +#define WLED3_CTRL_REG_OVP				0x4d
> +#define  WLED3_CTRL_REG_OVP_MASK			0x03
>  
> -#define PM8941_WLED_REG_OVP			0x4d
> -#define  PM8941_WLED_REG_OVP_MASK		0x03
> +#define WLED3_CTRL_REG_ILIMIT				0x4e
> +#define  WLED3_CTRL_REG_ILIMIT_MASK			0x07
>  
> -#define PM8941_WLED_REG_BOOST			0x4e
> -#define  PM8941_WLED_REG_BOOST_MASK		0x07
> +/* WLED3 sink registers */
> +#define WLED3_SINK_REG_SYNC				0x47
> +#define  WLED3_SINK_REG_SYNC_MASK			0x07
> +#define  WLED3_SINK_REG_SYNC_LED1			BIT(0)
> +#define  WLED3_SINK_REG_SYNC_LED2			BIT(1)
> +#define  WLED3_SINK_REG_SYNC_LED3			BIT(2)
> +#define  WLED3_SINK_REG_SYNC_ALL			0x07
> +#define  WLED3_SINK_REG_SYNC_CLEAR			0x00
>  
[..]
> -struct pm8941_wled_config {
> -	u32 i_boost_limit;
> +struct wled_config {
> +	u32 boost_i_limit;
>  	u32 ovp;
>  	u32 switch_freq;
>  	u32 num_strings;
> -	u32 i_limit;
> +	u32 string_i_limit;

Changing the members in this struct seems unrelated.

>  	bool cs_out_en;
>  	bool ext_gen;
>  	bool cabc_en;
>  };
>  
[..]
> -MODULE_DESCRIPTION("pm8941 wled driver");
> +MODULE_DESCRIPTION("qcom wled driver");

I would prefer if this was "Qualcomm WLED driver".

>  MODULE_LICENSE("GPL v2");

Regards,
Bjorn
