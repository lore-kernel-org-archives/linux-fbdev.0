From: Bjorn Andersson <bjorn.andersson@linaro.org>
Date: Tue, 05 Dec 2017 04:35:15 +0000
Subject: Re: [PATCH V1 2/4] qcom: spmi-wled: Add support for short circuit handling
Message-Id: <20171205043515.GE28761@minitux>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1510834717-21765-1-git-send-email-kgunda@codeaurora.org>
 <1510834717-21765-3-git-send-email-kgunda@codeaurora.org>
In-Reply-To: <1510834717-21765-3-git-send-email-kgunda-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kiran Gunda <kgunda-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Daniel Thompson <daniel.thompson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Jacek Anaszewski <jacek.anaszewski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Thu 16 Nov 04:18 PST 2017, Kiran Gunda wrote:

> Handle the short circuit(SC) interrupt and check if the SC interrupt
> is valid. Re-enable the module to check if it goes away. Disable the
> module altogether if the SC event persists.
> 
> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
> ---
>  .../bindings/leds/backlight/qcom-spmi-wled.txt     |  22 ++++
>  drivers/video/backlight/qcom-spmi-wled.c           | 126 ++++++++++++++++++++-
>  2 files changed, 142 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/leds/backlight/qcom-spmi-wled.txt b/Documentation/devicetree/bindings/leds/backlight/qcom-spmi-wled.txt
> index f1ea25b..768608c 100644
> --- a/Documentation/devicetree/bindings/leds/backlight/qcom-spmi-wled.txt
> +++ b/Documentation/devicetree/bindings/leds/backlight/qcom-spmi-wled.txt
> @@ -74,6 +74,26 @@ The PMIC is connected to the host processor via SPMI bus.
>  	Definition: Specify if cabc (content adaptive backlight control) is
>  		    needed.
>  
> +- qcom,ext-pfet-sc-pro-en

Please use readable names, rather than a bunch of abbreviations.

> +	Usage:      optional
> +	Value type: <bool>
> +	Definition: Specify if external PFET control for short circuit
> +		    protection is needed.

What does this mean? At least change the wording to "...protection is
used".

> +
> +- interrupts
> +	Usage:      optional
> +	Value type: <prop encoded array>
> +	Definition: Interrupts associated with WLED. Interrupts can be
> +		    specified as per the encoding listed under
> +		    Documentation/devicetree/bindings/spmi/
> +		    qcom,spmi-pmic-arb.txt.
> +
> +- interrupt-names
> +	Usage:      optional
> +	Value type: <string>
> +	Definition: Interrupt names associated with the interrupts.
> +		    Must be "sc-irq".

This is obviously an irq, so no need to include that in the name. I
would also prefer if you use the name "short" to make this easier to
read.

> +
>  Example:
>  
>  qcom-wled@d800 {
> @@ -82,6 +102,8 @@ qcom-wled@d800 {
>  	reg-names = "qcom-wled-ctrl-base", "qcom-wled-sink-base";
>  	label = "backlight";
>  
> +	interrupts = <0x3 0xd8 0x2 IRQ_TYPE_EDGE_RISING>;

We tend to write these on the form <decimal, hex, decimal, enum>, please
follow this.

> +	interrupt-names = "sc-irq";
>  	qcom,fs-current-limit = <25000>;
>  	qcom,current-boost-limit = <970>;
>  	qcom,switching-freq = <800>;
> diff --git a/drivers/video/backlight/qcom-spmi-wled.c b/drivers/video/backlight/qcom-spmi-wled.c
> index 14c3adc..7dbaaa7 100644
> --- a/drivers/video/backlight/qcom-spmi-wled.c
> +++ b/drivers/video/backlight/qcom-spmi-wled.c
> @@ -11,6 +11,9 @@
>   * GNU General Public License for more details.
>   */
>  
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/ktime.h>
>  #include <linux/kernel.h>
>  #include <linux/backlight.h>
>  #include <linux/module.h>
> @@ -23,7 +26,13 @@
>  #define QCOM_WLED_DEFAULT_BRIGHTNESS		2048
>  #define  QCOM_WLED_MAX_BRIGHTNESS		4095
>  
> +#define QCOM_WLED_SC_DLY_MS			20
> +#define QCOM_WLED_SC_CNT_MAX			5
> +#define QCOM_WLED_SC_RESET_CNT_DLY_US		1000000

With times of this ballpark you can just use jiffies, with this just
being HZ.

> +
>  /* WLED control registers */
> +#define QCOM_WLED_CTRL_FAULT_STATUS		0x08
> +
>  #define QCOM_WLED_CTRL_MOD_ENABLE		0x46
>  #define  QCOM_WLED_CTRL_MOD_EN_MASK		BIT(7)
>  #define  QCOM_WLED_CTRL_MODULE_EN_SHIFT		7
> @@ -37,6 +46,15 @@
>  #define QCOM_WLED_CTRL_ILIM			0x4e
>  #define  QCOM_WLED_CTRL_ILIM_MASK		GENMASK(2, 0)
>  
> +#define QCOM_WLED_CTRL_SHORT_PROTECT		0x5e
> +#define  QCOM_WLED_CTRL_SHORT_EN_MASK		BIT(7)
> +
> +#define QCOM_WLED_CTRL_SEC_ACCESS		0xd0
> +#define  QCOM_WLED_CTRL_SEC_UNLOCK		0xa5
> +
> +#define QCOM_WLED_CTRL_TEST1			0xe2
> +#define  QCOM_WLED_EXT_FET_DTEST2		0x09
> +
>  /* WLED sink registers */
>  #define QCOM_WLED_SINK_CURR_SINK_EN		0x46
>  #define  QCOM_WLED_SINK_CURR_SINK_MASK		GENMASK(7, 4)
> @@ -71,19 +89,23 @@ struct qcom_wled_config {
>  	u32 switch_freq;
>  	u32 fs_current;
>  	u32 string_cfg;
> +	int sc_irq;

Keep data parsed directly from DT in the config and move this to
qcom_wled.

>  	bool en_cabc;
> +	bool ext_pfet_sc_pro_en;

This name is long and hard to parse. "external_pfet" would be much
easier to read.

>  };
>  
>  struct qcom_wled {
>  	const char *name;
>  	struct platform_device *pdev;
>  	struct regmap *regmap;
> +	struct mutex lock;
> +	struct qcom_wled_config cfg;
> +	ktime_t last_sc_event_time;
>  	u16 sink_addr;
>  	u16 ctrl_addr;
>  	u32 brightness;
> +	u32 sc_count;
>  	bool prev_state;
> -
> -	struct qcom_wled_config cfg;

Moving this seems unnecessary.

>  };
>  
>  static int qcom_wled_module_enable(struct qcom_wled *wled, int val)
> @@ -157,25 +179,26 @@ static int qcom_wled_update_status(struct backlight_device *bl)
>  	    bl->props.state & BL_CORE_FBBLANK)
>  		brightness = 0;
>  
> +	mutex_lock(&wled->lock);

Is this lock necessary?

> +static irqreturn_t qcom_wled_sc_irq_handler(int irq, void *_wled)
> +{
> +	struct qcom_wled *wled = _wled;
> +	int rc;
> +	u32 val;
> +	s64 elapsed_time;
> +
> +	rc = regmap_read(wled->regmap,
> +		wled->ctrl_addr + QCOM_WLED_CTRL_FAULT_STATUS, &val);
> +	if (rc < 0) {
> +		pr_err("Error in reading WLED_FAULT_STATUS rc=%d\n", rc);
> +		return IRQ_HANDLED;
> +	}
> +
> +	wled->sc_count++;
> +	pr_err("WLED short circuit detected %d times fault_status=%x\n",
> +		wled->sc_count, val);

Who will read this and is it worth the extra read of FAULT_STATUS just
to produce this print?

> +	mutex_lock(&wled->lock);
> +	rc = qcom_wled_module_enable(wled, false);
> +	if (rc < 0) {
> +		pr_err("wled disable failed rc:%d\n", rc);
> +		goto unlock_mutex;
> +	}
> +
> +	elapsed_time = ktime_us_delta(ktime_get(),
> +				wled->last_sc_event_time);
> +	if (elapsed_time > QCOM_WLED_SC_RESET_CNT_DLY_US) {
> +		wled->sc_count = 0;
> +	} else if (wled->sc_count > QCOM_WLED_SC_CNT_MAX) {

This isn't really "else elapsed_time was more than DLY_US". Split this
into:

if (elapsed_time > xyz)
	wled->sc_count = 0;

if (wled->sc_count > QCOM_WLED_SC_CNT_MAX)
	...

> +		pr_err("SC trigged %d times, disabling WLED forever!\n",

"forever" as in "until someone turns it on again"?

> +			wled->sc_count);
> +		goto unlock_mutex;
> +	}
> +
> +	wled->last_sc_event_time = ktime_get();
> +
> +	msleep(QCOM_WLED_SC_DLY_MS);
> +	rc = qcom_wled_module_enable(wled, true);
> +	if (rc < 0)
> +		pr_err("wled enable failed rc:%d\n", rc);
> +
> +unlock_mutex:
> +	mutex_unlock(&wled->lock);
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static int qcom_wled_setup(struct qcom_wled *wled)
>  {
>  	int rc, temp, i;
>  	u8 sink_en = 0;
>  	u8 string_cfg = wled->cfg.string_cfg;
> +	int sc_irq = wled->cfg.sc_irq;
>  
>  	rc = regmap_update_bits(wled->regmap,
>  			wled->ctrl_addr + QCOM_WLED_CTRL_OVP,
> @@ -261,6 +334,39 @@ static int qcom_wled_setup(struct qcom_wled *wled)
>  		return rc;
>  	}
>  
> +	if (sc_irq >= 0) {

I think things will be cleaner if you let qcom_wled_setup() configure
the hardware based on the wled->cfg (as is done to this point) and then
deal with the interrupts in a separate code path from the probe
function.

> +		rc = devm_request_threaded_irq(&wled->pdev->dev, sc_irq,
> +				NULL, qcom_wled_sc_irq_handler, IRQF_ONESHOT,
> +				"qcom_wled_sc_irq", wled);
> +		if (rc < 0) {
> +			pr_err("Unable to request sc(%d) IRQ(err:%d)\n",
> +				sc_irq, rc);

sc_irq is just a number without meaning, no need to print it.

> +			return rc;
> +		}
> +
> +		rc = regmap_update_bits(wled->regmap,
> +				wled->ctrl_addr + QCOM_WLED_CTRL_SHORT_PROTECT,
> +				QCOM_WLED_CTRL_SHORT_EN_MASK,
> +				QCOM_WLED_CTRL_SHORT_EN_MASK);
> +		if (rc < 0)
> +			return rc;
> +
> +		if (wled->cfg.ext_pfet_sc_pro_en) {
> +			/* unlock the secure access regisetr */

Spelling of register, and this operation does "Unlock the secure
register access" it doesn't unlock the secure access register.

> +			rc = regmap_write(wled->regmap, wled->ctrl_addr +
> +					QCOM_WLED_CTRL_SEC_ACCESS,
> +					QCOM_WLED_CTRL_SEC_UNLOCK);
> +			if (rc < 0)
> +				return rc;
> +
> +			rc = regmap_write(wled->regmap,
> +					wled->ctrl_addr + QCOM_WLED_CTRL_TEST1,
> +					QCOM_WLED_EXT_FET_DTEST2);

What is the relationship between DTEST2 and the external FET?

> +			if (rc < 0)
> +				return rc;
> +		}
> +	}
> +
>  	return 0;
>  }
>  
> @@ -271,6 +377,7 @@ static int qcom_wled_setup(struct qcom_wled *wled)
>  	.switch_freq = 11,
>  	.string_cfg = 0xf,
>  	.en_cabc = 0,
> +	.ext_pfet_sc_pro_en = 1,
>  };
>  
>  struct qcom_wled_var_cfg {
> @@ -376,6 +483,7 @@ static int qcom_wled_configure(struct qcom_wled *wled, struct device *dev)
>  		bool *val_ptr;
>  	} bool_opts[] = {
>  		{ "qcom,en-cabc", &cfg->en_cabc, },
> +		{ "qcom,ext-pfet-sc-pro", &cfg->ext_pfet_sc_pro_en, },
>  	};
>  
>  	prop_addr = of_get_address(dev->of_node, 0, NULL, NULL);
> @@ -427,6 +535,10 @@ static int qcom_wled_configure(struct qcom_wled *wled, struct device *dev)
>  			*bool_opts[i].val_ptr = true;
>  	}
>  
> +	wled->cfg.sc_irq = platform_get_irq_byname(wled->pdev, "sc-irq");
> +	if (wled->cfg.sc_irq < 0)
> +		dev_dbg(&wled->pdev->dev, "sc irq is not used\n");
> +

Move this to qcom_wled_probe() or into its own code path, together with
the rest of the sc_irq initialization.

And as you're not enabling or disabling it you can store it in a local
variable.

>  	return 0;
>  }
>  

Regards,
Bjorn
