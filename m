From: kgunda@codeaurora.org
Date: Thu, 16 Aug 2018 05:45:18 +0000
Subject: Re: [PATCH V4 8/8] backlight: qcom-wled: Add auto string detection logic
Message-Id: <bfc20fc54fcb3bc91ce13b353f73039e@codeaurora.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1531131741-19971-1-git-send-email-kgunda@codeaurora.org>
 <1531131741-19971-9-git-send-email-kgunda@codeaurora.org>
 <20180807063229.GE23866@tuxbook-pro>
In-Reply-To: <20180807063229.GE23866@tuxbook-pro>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: jingoohan1@gmail.com, lee.jones@linaro.org, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, daniel.thompson@linaro.org, jacek.anaszewski@gmail.com, pavel@ucw.cz, robh+dt@kernel.org, mark.rutland@arm.com, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org

On 2018-08-07 12:02, Bjorn Andersson wrote:
> On Mon 09 Jul 03:22 PDT 2018, Kiran Gunda wrote:
>> diff --git a/drivers/video/backlight/qcom-wled.c 
>> b/drivers/video/backlight/qcom-wled.c
> [..]
>> @@ -189,6 +206,15 @@ static int wled4_set_brightness(struct wled 
>> *wled, u16 brightness)
>>  	return 0;
>>  }
>> 
>> +static void wled_ovp_work(struct work_struct *work)
>> +{
>> +	struct wled *wled = container_of(work,
>> +					 struct wled, ovp_work.work);
>> +
>> +	if (wled->ovp_irq > 0)
>> +		enable_irq(wled->ovp_irq);
>> +}
>> +
>>  static int wled_module_enable(struct wled *wled, int val)
>>  {
>>  	int rc;
>> @@ -200,7 +226,18 @@ static int wled_module_enable(struct wled *wled, 
>> int val)
>>  				WLED_CTRL_REG_MOD_EN,
>>  				WLED_CTRL_REG_MOD_EN_MASK,
>>  				val << WLED_CTRL_REG_MOD_EN_SHIFT);
>> -	return rc;
>> +	if (rc < 0)
>> +		return rc;
>> +
>> +	if (val) {
>> +		schedule_delayed_work(&wled->ovp_work, WLED_SOFT_START_DLY_US);
> 
> schedule_delayed_work() takes a delay in jiffies, not micro seconds.
> 
I will address it in the next series.
>> +	} else {
>> +		cancel_delayed_work_sync(&wled->ovp_work);
> 
> If we get here within WLED_SOFT_START_DLY_US of a module enable we have
> yet to execute the enable_irq() in the delayed worker, which should 
> mean
> that the irq is unbalanced from then on.
> 
> I believe you can check the return value of cancel_delayed_work_sync()
> being true to know if wled_ovp_work() was yet to execute.
> 
Ok. I will address it in next series.
>> +		if (wled->ovp_irq > 0)
>> +			disable_irq(wled->ovp_irq);
>> +	}
>> +
>> +	return 0;
>>  }
>> 
> 
> Regards,
> Bjorn
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
