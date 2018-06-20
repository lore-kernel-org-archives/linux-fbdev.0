From: kgunda@codeaurora.org
Date: Wed, 20 Jun 2018 11:15:05 +0000
Subject: Re: [PATCH V3 6/7] backlight: qcom-wled: add support for short circuit handling
Message-Id: <830ec51a6ea0cb9bcf8981cda86975cc@codeaurora.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1529406822-15379-1-git-send-email-kgunda@codeaurora.org>
 <1529406822-15379-7-git-send-email-kgunda@codeaurora.org>
 <20180620054722.GH13316@vkoul-mobl>
In-Reply-To: <20180620054722.GH13316@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vinod <vkoul@kernel.org>
Cc: bjorn.andersson@linaro.org, jingoohan1@gmail.com, lee.jones@linaro.org, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, Daniel Thompson <daniel.thompson@linaro.org>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-leds@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org

On 2018-06-20 11:17, Vinod wrote:
> On 19-06-18, 16:43, Kiran Gunda wrote:
> 
>>  struct wled {
>>  	const char *name;
>>  	struct device *dev;
>>  	struct regmap *regmap;
>> +	struct mutex lock;	/* Lock to avoid race from ISR */
> 
> the comment is wrong as you avoid race with thread handler and not the
> main ISR. The ISR runs in atomic context so you cant use a mutex but 
> you
> may do so with a thread handler
> 
Will fix the comment in the next series.
>> +#define WLED_SHORT_DLY_MS			20
>> +#define WLED_SHORT_CNT_MAX			5
>> +#define WLED_SHORT_RESET_CNT_DLY_US		USEC_PER_SEC
> 
> an empty line after defines would be better
> 
Will add it in the next series.
>> +static int wled_configure_short_irq(struct wled *wled,
>> +				    struct platform_device *pdev)
>> +{
>> +	int rc = 0, short_irq;
> 
> superfluous initialization of rc
Will remove the initialization in next series.
