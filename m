From: kgunda@codeaurora.org
Date: Mon, 11 Dec 2017 09:43:39 +0000
Subject: Re: [PATCH V1 3/4] qcom: spmi-wled: Add support for OVP interrupt handling
Message-Id: <7b20cca3fe0785e5683275a6f93e8cc4@codeaurora.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1510834717-21765-1-git-send-email-kgunda@codeaurora.org>
 <1510834717-21765-4-git-send-email-kgunda@codeaurora.org>
 <20171205044523.GF28761@minitux>
In-Reply-To: <20171205044523.GF28761@minitux>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org

On 2017-12-05 10:15, Bjorn Andersson wrote:
> On Thu 16 Nov 04:18 PST 2017, Kiran Gunda wrote:
> 
>> WLED peripheral has over voltage protection(OVP) circuitry and the OVP
>> fault is notified through an interrupt. Though this fault condition 
>> rising
>> is due to an incorrect hardware configuration is mitigated in the 
>> hardware,
>> it still needs to be detected and handled. Add support for it.
>> 
>> When WLED module is enabled, keep OVP fault interrupt disabled for 10 
>> ms to
>> account for soft start delay.
>> 
>> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
>> ---
>>  .../bindings/leds/backlight/qcom-spmi-wled.txt     |  7 +-
>>  drivers/video/backlight/qcom-spmi-wled.c           | 83 
>> ++++++++++++++++++++++
>>  2 files changed, 87 insertions(+), 3 deletions(-)
>> 
>> diff --git 
>> a/Documentation/devicetree/bindings/leds/backlight/qcom-spmi-wled.txt 
>> b/Documentation/devicetree/bindings/leds/backlight/qcom-spmi-wled.txt
>> index 768608c..d39ee93 100644
>> --- 
>> a/Documentation/devicetree/bindings/leds/backlight/qcom-spmi-wled.txt
>> +++ 
>> b/Documentation/devicetree/bindings/leds/backlight/qcom-spmi-wled.txt
>> @@ -92,7 +92,7 @@ The PMIC is connected to the host processor via SPMI 
>> bus.
>>  	Usage:      optional
>>  	Value type: <string>
>>  	Definition: Interrupt names associated with the interrupts.
>> -		    Must be "sc-irq".
>> +		    Currently supported interrupts are "sc-irq" and "ovp-irq".
>> 
> 
> As before, we know this is an IRQ, so omit the -irq from the name.
> 
> [..]
Sure. Will change it in the next series.
>> diff --git a/drivers/video/backlight/qcom-spmi-wled.c 
>> b/drivers/video/backlight/qcom-spmi-wled.c
> [..]
>> @@ -115,6 +123,28 @@ static int qcom_wled_module_enable(struct 
>> qcom_wled *wled, int val)
>>  	rc = regmap_update_bits(wled->regmap, wled->ctrl_addr +
>>  			QCOM_WLED_CTRL_MOD_ENABLE, QCOM_WLED_CTRL_MOD_EN_MASK,
>>  			val << QCOM_WLED_CTRL_MODULE_EN_SHIFT);
>> +	if (rc < 0)
>> +		return rc;
>> +	/*
>> +	 * Wait for at least 10ms before enabling OVP fault interrupt after
>> +	 * enabling the module so that soft start is completed. Keep the OVP
>> +	 * interrupt disabled when the module is disabled.
>> +	 */
>> +	if (val) {
>> +		usleep_range(QCOM_WLED_SOFT_START_DLY_US,
>> +				QCOM_WLED_SOFT_START_DLY_US + 1000);
> 
> This is sleeping in the brightness/enable code path, can you
> schedule_delayed_work() instead to not block this code path
> unnecessarily?
> 
Sure. Will change it in the next series.
>> +
>> +		if (wled->cfg.ovp_irq > 0 && wled->ovp_irq_disabled) {
>> +			enable_irq(wled->cfg.ovp_irq);
>> +			wled->ovp_irq_disabled = false;
>> +		}
>> +	} else {
>> +		if (wled->cfg.ovp_irq > 0 && !wled->ovp_irq_disabled) {
>> +			disable_irq(wled->cfg.ovp_irq);
>> +			wled->ovp_irq_disabled = true;
>> +		}
>> +	}
>> +
>>  	return rc;
>>  }
>> 
>> @@ -264,12 +294,42 @@ static irqreturn_t qcom_wled_sc_irq_handler(int 
>> irq, void *_wled)
>>  	return IRQ_HANDLED;
>>  }
>> 
>> +static irqreturn_t qcom_wled_ovp_irq_handler(int irq, void *_wled)
>> +{
>> +	struct qcom_wled *wled = _wled;
>> +	int rc;
>> +	u32 int_sts, fault_sts;
>> +
>> +	rc = regmap_read(wled->regmap,
>> +			wled->ctrl_addr + QCOM_WLED_CTRL_INT_RT_STS, &int_sts);
>> +	if (rc < 0) {
>> +		pr_err("Error in reading WLED_INT_RT_STS rc=%d\n", rc);
>> +		return IRQ_HANDLED;
>> +	}
>> +
>> +	rc = regmap_read(wled->regmap, wled->ctrl_addr +
>> +			QCOM_WLED_CTRL_FAULT_STATUS, &fault_sts);
>> +	if (rc < 0) {
>> +		pr_err("Error in reading WLED_FAULT_STATUS rc=%d\n", rc);
>> +		return IRQ_HANDLED;
>> +	}
>> +
>> +	if (fault_sts &
>> +		(QCOM_WLED_CTRL_OVP_FAULT_BIT | QCOM_WLED_CTRL_ILIM_FAULT_BIT))
>> +		pr_err("WLED OVP fault detected, int_sts=%x fault_sts= %x\n",
>> +			int_sts, fault_sts);
> 
> All this function does is print things to the log. When is this
> information consumed and by whom? dev_dbg() instead?
> 
Sure. Will change it in the next series.
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>>  static int qcom_wled_setup(struct qcom_wled *wled)
>>  {
>>  	int rc, temp, i;
>>  	u8 sink_en = 0;
>> +	u32 val;
>>  	u8 string_cfg = wled->cfg.string_cfg;
>>  	int sc_irq = wled->cfg.sc_irq;
>> +	int ovp_irq = wled->cfg.ovp_irq;
>> 
>>  	rc = regmap_update_bits(wled->regmap,
>>  			wled->ctrl_addr + QCOM_WLED_CTRL_OVP,
>> @@ -367,6 +427,25 @@ static int qcom_wled_setup(struct qcom_wled 
>> *wled)
>>  		}
>>  	}
>> 
>> +	if (ovp_irq >= 0) {
> 
> As with the previous patch.
> 
> [..]
Sure. Will change it in the next series.
>> @@ -539,6 +618,10 @@ static int qcom_wled_configure(struct qcom_wled 
>> *wled, struct device *dev)
> [..]
>> +	wled->cfg.ovp_irq = platform_get_irq_byname(wled->pdev, "ovp-irq");
>> +	if (wled->cfg.ovp_irq < 0)
>> +		dev_dbg(&wled->pdev->dev, "ovp irq is not used\n");
>> +
> 
> Regards,
> Bjorn
