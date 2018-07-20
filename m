From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Fri, 20 Jul 2018 14:07:17 +0000
Subject: Re: [PATCH V4 7/8] backlight: qcom-wled: add support for short circuit handling
Message-Id: <1a708fea-0759-fcd0-d169-a36e21c31c28@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1531131741-19971-1-git-send-email-kgunda@codeaurora.org>
 <1531131741-19971-8-git-send-email-kgunda@codeaurora.org>
In-Reply-To: <1531131741-19971-8-git-send-email-kgunda@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kiran Gunda <kgunda@codeaurora.org>, bjorn.andersson@linaro.org, jingoohan1@gmail.com, lee.jones@linaro.org, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, jacek.anaszewski@gmail.com, pavel@ucw.cz, robh+dt@kernel.org, mark.rutland@arm.com, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org

On 09/07/18 11:22, Kiran Gunda wrote:
> Handle the short circuit interrupt and check if the short circuit
> interrupt is valid. Re-enable the module to check if it goes
> away. Disable the module altogether if the short circuit event
> persists.
> 
> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> Changes from V3:
> 	- Added Reviewed by tag.
> 	- Addressed minor comments from Vinod
> 
>   drivers/video/backlight/qcom-wled.c | 132 ++++++++++++++++++++++++++++++++++--
>   1 file changed, 128 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
> index 362d254..a14f1a6 100644
> --- a/drivers/video/backlight/qcom-wled.c
> +++ b/drivers/video/backlight/qcom-wled.c
> @@ -10,6 +10,9 @@
>    * GNU General Public License for more details.
>    */
>   
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/ktime.h>
>   #include <linux/kernel.h>
>   #include <linux/backlight.h>
>   #include <linux/module.h>
> @@ -64,6 +67,16 @@
>   #define WLED3_SINK_REG_STR_CABC(n)			(0x66 + (n * 0x10))
>   #define  WLED3_SINK_REG_STR_CABC_MASK			BIT(7)
>   
> +/* WLED4 specific control registers */
> +#define WLED4_CTRL_REG_SHORT_PROTECT			0x5e
> +#define  WLED4_CTRL_REG_SHORT_EN_MASK			BIT(7)
> +
> +#define WLED4_CTRL_REG_SEC_ACCESS			0xd0
> +#define  WLED4_CTRL_REG_SEC_UNLOCK			0xa5
> +
> +#define WLED4_CTRL_REG_TEST1				0xe2
> +#define  WLED4_CTRL_REG_TEST1_EXT_FET_DTEST2		0x09
> +
>   /* WLED4 specific sink registers */
>   #define WLED4_SINK_REG_CURR_SINK			0x46
>   #define  WLED4_SINK_REG_CURR_SINK_MASK			GENMASK(7, 4)
> @@ -113,17 +126,23 @@ struct wled_config {
>   	bool cs_out_en;
>   	bool ext_gen;
>   	bool cabc;
> +	bool external_pfet;
>   };
>   
>   struct wled {
>   	const char *name;
>   	struct device *dev;
>   	struct regmap *regmap;
> +	struct mutex lock;	/* Lock to avoid race from thread irq handler */
> +	ktime_t last_short_event;
>   	u16 ctrl_addr;
>   	u16 sink_addr;
>   	u16 max_string_count;
>   	u32 brightness;
>   	u32 max_brightness;
> +	u32 short_count;
> +	bool disabled_by_short;
> +	bool has_short_detect;
>   
>   	struct wled_config cfg;
>   	int (*wled_set_brightness)(struct wled *wled, u16 brightness);
> @@ -174,6 +193,9 @@ static int wled_module_enable(struct wled *wled, int val)
>   {
>   	int rc;
>   
> +	if (wled->disabled_by_short)
> +		return -EFAULT;

EFAULT means bad address (memory fault). Perhaps EIO or maybe even 
something more exotic like ENXIO might be more appropriate?


> +
>   	rc = regmap_update_bits(wled->regmap, wled->ctrl_addr +
>   				WLED_CTRL_REG_MOD_EN,
>   				WLED_CTRL_REG_MOD_EN_MASK,
> @@ -210,18 +232,19 @@ static int wled_update_status(struct backlight_device *bl)
>   	    bl->props.state & BL_CORE_FBBLANK)
>   		brightness = 0;
>   
> +	mutex_lock(&wled->lock);
>   	if (brightness) {
>   		rc = wled->wled_set_brightness(wled, brightness);
>   		if (rc < 0) {
>   			dev_err(wled->dev, "wled failed to set brightness rc:%d\n",
>   				rc);
> -			return rc;
> +			goto unlock_mutex;
>   		}
>   
>   		rc = wled_sync_toggle(wled);
>   		if (rc < 0) {
>   			dev_err(wled->dev, "wled sync failed rc:%d\n", rc);
> -			return rc;
> +			goto unlock_mutex;
>   		}
>   	}
>   
> @@ -229,15 +252,61 @@ static int wled_update_status(struct backlight_device *bl)
>   		rc = wled_module_enable(wled, !!brightness);
>   		if (rc < 0) {
>   			dev_err(wled->dev, "wled enable failed rc:%d\n", rc);
> -			return rc;
> +			goto unlock_mutex;
>   		}
>   	}
>   
>   	wled->brightness = brightness;
>   
> +unlock_mutex:
> +	mutex_unlock(&wled->lock);
> +
>   	return rc;
>   }
>   
> +#define WLED_SHORT_DLY_MS			20
> +#define WLED_SHORT_CNT_MAX			5
> +#define WLED_SHORT_RESET_CNT_DLY_US		USEC_PER_SEC
> +
> +static irqreturn_t wled_short_irq_handler(int irq, void *_wled)
> +{
> +	struct wled *wled = _wled;
> +	int rc;
> +	s64 elapsed_time;
> +
> +	wled->short_count++;
> +	mutex_lock(&wled->lock);
> +	rc = wled_module_enable(wled, false);
> +	if (rc < 0) {
> +		dev_err(wled->dev, "wled disable failed rc:%d\n", rc);
> +		goto unlock_mutex;
> +	}
> +
> +	elapsed_time = ktime_us_delta(ktime_get(),
> +				      wled->last_short_event);
> +	if (elapsed_time > WLED_SHORT_RESET_CNT_DLY_US)
> +		wled->short_count = 0;

Shouldn't this reset to 1 (e.g. we have just seen a short).


Daniel.
