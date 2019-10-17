From: kgunda@codeaurora.org
Date: Thu, 17 Oct 2019 13:21:15 +0000
Subject: Re: [PATCH V7 6/6] backlight: qcom-wled: Add auto string detection logic
Message-Id: <689831a9d7561f51cdb7ea0a1760d472@codeaurora.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1571220826-7740-1-git-send-email-kgunda@codeaurora.org>
 <1571220826-7740-7-git-send-email-kgunda@codeaurora.org>
 <20191017122653.GO4365@dell>
In-Reply-To: <20191017122653.GO4365@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lee Jones <lee.jones@linaro.org>
Cc: bjorn.andersson@linaro.org, jingoohan1@gmail.com, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, daniel.thompson@linaro.org, jacek.anaszewski@gmail.com, pavel@ucw.cz, robh+dt@kernel.org, mark.rutland@arm.com, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org, linux-fbdev@vger.kernel.org

On 2019-10-17 17:56, Lee Jones wrote:
> On Wed, 16 Oct 2019, Kiran Gunda wrote:
> 
>> The auto string detection algorithm checks if the current WLED
>> sink configuration is valid. It tries enabling every sink and
>> checks if the OVP fault is observed. Based on this information
>> it detects and enables the valid sink configuration.
>> Auto calibration will be triggered when the OVP fault interrupts
>> are seen frequently thereby it tries to fix the sink configuration.
>> 
>> The auto-detection also kicks in when the connected LED string
>> of the display-backlight malfunctions (because of damage) and
>> requires the damaged string to be turned off to prevent the
>> complete panel and/or board from being damaged.
>> 
>> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
>> ---
>>  drivers/video/backlight/qcom-wled.c | 410 
>> +++++++++++++++++++++++++++++++++++-
>>  1 file changed, 404 insertions(+), 6 deletions(-)
>> 
>> diff --git a/drivers/video/backlight/qcom-wled.c 
>> b/drivers/video/backlight/qcom-wled.c
>> index b5b125c..ff7c409 100644
>> --- a/drivers/video/backlight/qcom-wled.c
>> +++ b/drivers/video/backlight/qcom-wled.c
> 
> 
> [...]
> 
>> +	/* iterate through the strings one by one */
> 
> Please use proper English in comments (less a full stop).
> 
> In this case, just s/iterate/Iterate/.
> 
Sorry for that ! will fix it in next series.
>> +	for (i = 0; i < wled->cfg.num_strings; i++) {
>> +		sink_test = BIT((WLED4_SINK_REG_CURR_SINK_SHFT + i));
>> +
>> +		/* Enable feedback control */
>> +		rc = regmap_write(wled->regmap, wled->ctrl_addr +
>> +				  WLED3_CTRL_REG_FEEDBACK_CONTROL, i + 1);
>> +		if (rc < 0) {
>> +			dev_err(wled->dev, "Failed to enable feedback for SINK %d rc = 
>> %d\n",
>> +				i + 1, rc);
>> +			goto failed_detect;
>> +		}
>> +
>> +		/* enable the sink */
> 
> Here too.  And everywhere else.
> 
Will fix it in next series.
>> +		rc = regmap_write(wled->regmap, wled->sink_addr +
>> +				  WLED4_SINK_REG_CURR_SINK, sink_test);
>> +		if (rc < 0) {
>> +			dev_err(wled->dev, "Failed to configure SINK %d rc=%d\n",
>> +				i + 1, rc);
>> +			goto failed_detect;
>> +		}
>> +
>> +		/* Enable the module */
>> +		rc = regmap_update_bits(wled->regmap, wled->ctrl_addr +
>> +					WLED3_CTRL_REG_MOD_EN,
>> +					WLED3_CTRL_REG_MOD_EN_MASK,
>> +					WLED3_CTRL_REG_MOD_EN_MASK);
>> +		if (rc < 0) {
>> +			dev_err(wled->dev, "Failed to enable WLED module rc=%d\n",
>> +				rc);
>> +			goto failed_detect;
>> +		}
>> +
>> +		usleep_range(WLED_SOFT_START_DLY_US,
>> +			     WLED_SOFT_START_DLY_US + 1000);
>> +
>> +		rc = regmap_read(wled->regmap, wled->ctrl_addr +
>> +				 WLED3_CTRL_REG_INT_RT_STS, &int_sts);
>> +		if (rc < 0) {
>> +			dev_err(wled->dev, "Error in reading WLED3_CTRL_INT_RT_STS 
>> rc=%d\n",
>> +				rc);
>> +			goto failed_detect;
>> +		}
>> +
>> +		if (int_sts & WLED3_CTRL_REG_OVP_FAULT_STATUS)
>> +			dev_dbg(wled->dev, "WLED OVP fault detected with SINK %d\n",
>> +				i + 1);
> 
> I haven't reviewed the whole patch, but this caught my eye.
> 
> I think this should be upgraded to dev_warn().
> 
Thought of keeping these messages silent, Because the string 
configuration will be corrected in this
and informing it at end of the auto string detection.
>> +		else
>> +			sink_valid |= sink_test;
>> +
>> +		/* Disable the module */
>> +		rc = regmap_update_bits(wled->regmap,
>> +					wled->ctrl_addr + WLED3_CTRL_REG_MOD_EN,
>> +					WLED3_CTRL_REG_MOD_EN_MASK, 0);
>> +		if (rc < 0) {
>> +			dev_err(wled->dev, "Failed to disable WLED module rc=%d\n",
>> +				rc);
>> +			goto failed_detect;
>> +		}
>> +	}
>> +
>> +	if (!sink_valid) {
>> +		dev_err(wled->dev, "No valid WLED sinks found\n");
>> +		wled->disabled_by_short = true;
>> +		goto failed_detect;
>> +	}
>> +
>> +	if (sink_valid = sink_config) {
>> +		dev_dbg(wled->dev, "WLED auto-detection complete, sink-config=%x 
>> OK!\n",
>> +			sink_config);
> 
> Does this really need to be placed in the kernel log?
> 
Ok. This can be removed. I will remove it in next series.
>> +	} else {
>> +		dev_warn(wled->dev, "New WLED string configuration found %x\n",
>> +			 sink_valid);
> 
> Why would the user care about this?  Is it not normal?
> 
Actually, it comes here if the user provided string configuration in the 
device tree is in-correct.
That's why just informing the user about the right string configuration, 
after the auto string detection.
>> +		sink_config = sink_valid;
>> +	}
> 
> [...]
> 
>> +static irqreturn_t wled_ovp_irq_handler(int irq, void *_wled)
>> +{
>> +	struct wled *wled = _wled;
>> +	int rc;
>> +	u32 int_sts, fault_sts;
>> +
>> +	rc = regmap_read(wled->regmap,
>> +			 wled->ctrl_addr + WLED3_CTRL_REG_INT_RT_STS, &int_sts);
>> +	if (rc < 0) {
>> +		dev_err(wled->dev, "Error in reading WLED3_INT_RT_STS rc=%d\n",
>> +			rc);
>> +		return IRQ_HANDLED;
>> +	}
>> +
>> +	rc = regmap_read(wled->regmap, wled->ctrl_addr +
>> +			 WLED3_CTRL_REG_FAULT_STATUS, &fault_sts);
>> +	if (rc < 0) {
>> +		dev_err(wled->dev, "Error in reading WLED_FAULT_STATUS rc=%d\n",
>> +			rc);
>> +		return IRQ_HANDLED;
>> +	}
>> +
>> +	if (fault_sts &
>> +		(WLED3_CTRL_REG_OVP_FAULT_BIT | WLED3_CTRL_REG_ILIM_FAULT_BIT))
> 
> Break the line at the '|'.
> 
Will do it next series.
>> +		dev_dbg(wled->dev, "WLED OVP fault detected, int_sts=%x fault_sts= 
>> %x\n",
>> +			int_sts, fault_sts);
> 
> dev_warn().
> 
As said above, wanted to keep these messages silent and inform the right 
string
configuration at the end of string detection.
>> +	if (fault_sts & WLED3_CTRL_REG_OVP_FAULT_BIT) {
>> +		mutex_lock(&wled->lock);
>> +		disable_irq_nosync(wled->ovp_irq);
>> +
>> +		if (wled_auto_detection_required(wled))
>> +			wled_auto_string_detection(wled);
>> +
>> +		enable_irq(wled->ovp_irq);
>> +
>> +		mutex_unlock(&wled->lock);
>> +	}
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>>  static int wled3_setup(struct wled *wled)
>>  {
>>  	u16 addr;
>> @@ -435,8 +775,10 @@ static int wled4_setup(struct wled *wled)
>>  		sink_en |= 1 << temp;
>>  	}
>> 
>> -	if (sink_cfg = sink_en)
>> -		return 0;
>> +	if (sink_cfg = sink_en) {
>> +		rc = wled_auto_detection_at_init(wled);
>> +		return rc;
>> +	}
>> 
>>  	rc = regmap_update_bits(wled->regmap,
>>  				wled->sink_addr + WLED4_SINK_REG_CURR_SINK,
>> @@ -499,7 +841,9 @@ static int wled4_setup(struct wled *wled)
>>  		return rc;
>>  	}
>> 
>> -	return 0;
>> +	rc = wled_auto_detection_at_init(wled);
>> +
>> +	return rc;
>>  }
>> 
>>  static const struct wled_config wled4_config_defaults = {
>> @@ -510,6 +854,7 @@ static int wled4_setup(struct wled *wled)
>>  	.switch_freq = 11,
>>  	.cabc = false,
>>  	.external_pfet = false,
>> +	.auto_detection_enabled = false,
>>  };
>> 
>>  static const u32 wled3_boost_i_limit_values[] = {
>> @@ -676,6 +1021,7 @@ static int wled_configure(struct wled *wled, int 
>> version)
>>  		{ "qcom,ext-gen", &cfg->ext_gen, },
>>  		{ "qcom,cabc", &cfg->cabc, },
>>  		{ "qcom,external-pfet", &cfg->external_pfet, },
>> +		{ "qcom,auto-string-detection", &cfg->auto_detection_enabled, },
>>  	};
>> 
>>  	prop_addr = of_get_address(dev->of_node, 0, NULL, NULL);
>> @@ -796,6 +1142,40 @@ static int wled_configure_short_irq(struct wled 
>> *wled,
>>  	return rc;
>>  }
>> 
>> +static int wled_configure_ovp_irq(struct wled *wled,
>> +				  struct platform_device *pdev)
>> +{
>> +	int rc;
>> +	u32 val;
>> +
>> +	wled->ovp_irq = platform_get_irq_byname(pdev, "ovp");
>> +	if (wled->ovp_irq < 0) {
>> +		dev_dbg(&pdev->dev, "ovp irq is not used\n");
> 
> I assume this is optional.  What happens if no IRQ is provided?
> 
Here OVP IRQ is used to detect the wrong string detection. If it is not
provided the auto string detection logic won't work.

> If, for instance, polling mode is enabled, maybe something like this
> would be better?
> 
>       dev_warn(&pdev->dev, "No IRQ found, falling back to polling 
> mode\n");
