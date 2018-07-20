From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Fri, 20 Jul 2018 13:23:17 +0000
Subject: Re: [PATCH V4 4/8] backlight: qcom-wled: Rename PM8941* to WLED3
Message-Id: <9aff8c23-7c72-eaee-9d59-424cd34be4ac@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1531131741-19971-1-git-send-email-kgunda@codeaurora.org>
 <1531131741-19971-5-git-send-email-kgunda@codeaurora.org>
In-Reply-To: <1531131741-19971-5-git-send-email-kgunda@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kiran Gunda <kgunda@codeaurora.org>, bjorn.andersson@linaro.org, jingoohan1@gmail.com, lee.jones@linaro.org, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, jacek.anaszewski@gmail.com, pavel@ucw.cz, robh+dt@kernel.org, mark.rutland@arm.com, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org

On 09/07/18 11:22, Kiran Gunda wrote:
> Rename the PM8941* references as WLED3 to make the
> driver generic and have WLED support for other PMICs.
> 
> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
> ---
> Changes from V3:
> 	- Changed the MODULE_DESCRIPTION
> 	
>   drivers/video/backlight/qcom-wled.c | 248 ++++++++++++++++++------------------
>   1 file changed, 125 insertions(+), 123 deletions(-)
> 
> diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
> index 0b6d219..3cd6e75 100644
> --- a/drivers/video/backlight/qcom-wled.c
> +++ b/drivers/video/backlight/qcom-wled.c
> @@ -18,77 +18,79 @@
>   #include <linux/regmap.h>
>   
>   /* From DT binding */
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
> -#define PM8941_WLED_REG_SINK			0x4f
> -#define  PM8941_WLED_REG_SINK_MASK		0xe0
> -#define  PM8941_WLED_REG_SINK_SHFT		0x05
> +#define WLED3_SINK_REG_CURR_SINK			0x4f
> +#define  WLED3_SINK_REG_CURR_SINK_MASK			0xe0
> +#define  WLED3_SINK_REG_CURR_SINK_SHFT			0x05
>   
> -/* Per-'string' registers below */
> -#define PM8941_WLED_REG_STR_OFFSET		0x10
> +/* WLED3 per-'string' registers below */
> +#define WLED3_SINK_REG_STR_OFFSET			0x10
>   
> -#define PM8941_WLED_REG_STR_MOD_EN_BASE		0x60
> -#define  PM8941_WLED_REG_STR_MOD_MASK		BIT(7)
> -#define  PM8941_WLED_REG_STR_MOD_EN		BIT(7)
> +#define WLED3_SINK_REG_STR_MOD_EN_BASE			0x60
> +#define  WLED3_SINK_REG_STR_MOD_MASK			BIT(7)
> +#define  WLED3_SINK_REG_STR_MOD_EN			BIT(7)
>   
> -#define PM8941_WLED_REG_STR_SCALE_BASE		0x62
> -#define  PM8941_WLED_REG_STR_SCALE_MASK		0x1f
> +#define WLED3_SINK_REG_STR_FULL_SCALE_CURR		0x62
> +#define  WLED3_SINK_REG_STR_FULL_SCALE_CURR_MASK	0x1f
>   
> -#define PM8941_WLED_REG_STR_MOD_SRC_BASE	0x63
> -#define  PM8941_WLED_REG_STR_MOD_SRC_MASK	0x01
> -#define  PM8941_WLED_REG_STR_MOD_SRC_INT	0x00
> -#define  PM8941_WLED_REG_STR_MOD_SRC_EXT	0x01
> +#define WLED3_SINK_REG_STR_MOD_SRC_BASE			0x63
> +#define  WLED3_SINK_REG_STR_MOD_SRC_MASK		0x01
> +#define  WLED3_SINK_REG_STR_MOD_SRC_INT			0x00
> +#define  WLED3_SINK_REG_STR_MOD_SRC_EXT			0x01
>   
> -#define PM8941_WLED_REG_STR_CABC_BASE		0x66
> -#define  PM8941_WLED_REG_STR_CABC_MASK		BIT(7)
> -#define  PM8941_WLED_REG_STR_CABC_EN		BIT(7)
> +#define WLED3_SINK_REG_STR_CABC_BASE			0x66
> +#define  WLED3_SINK_REG_STR_CABC_MASK			BIT(7)
> +#define  WLED3_SINK_REG_STR_CABC_EN			BIT(7)
>   
> -struct pm8941_wled_config {
> -	u32 i_boost_limit;
> +struct wled_config {
> +	u32 boost_i_limit;
>   	u32 ovp;
>   	u32 switch_freq;
>   	u32 num_strings;
> -	u32 i_limit;
> +	u32 string_i_limit;

This patch implements a grand renaming and I have no objections to 
including change for boost_i_limit and string_i_limit in it. I'd prefer 
it to be mentioned in the patch header though.

Once that is done:

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
