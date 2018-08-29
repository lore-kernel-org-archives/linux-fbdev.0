From: kgunda@codeaurora.org
Date: Wed, 29 Aug 2018 07:22:24 +0000
Subject: Re: [PATCH V5 5/8] backlight: qcom-wled: Restructure the driver for WLED3
Message-Id: <bcd99b19d4a7586ba47c05b8b5bd2bcf@codeaurora.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1535106467-17843-1-git-send-email-kgunda@codeaurora.org>
 <1535106467-17843-6-git-send-email-kgunda@codeaurora.org>
 <20180827100939.GG31905@amd>
In-Reply-To: <20180827100939.GG31905@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pavel Machek <pavel@ucw.cz>
Cc: bjorn.andersson@linaro.org, jingoohan1@gmail.com, lee.jones@linaro.org, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, daniel.thompson@linaro.org, jacek.anaszewski@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-arm-msm@vger.kernel.org

On 2018-08-27 15:39, Pavel Machek wrote:
> On Fri 2018-08-24 15:57:44, Kiran Gunda wrote:
>> Restructure the driver to add the support for new WLED
>> peripherals.
>> 
>> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
>> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
>> ---
>> Changes from V3:
>>     - This is the new patch after splitting the
>>       "backlight: qcom-wled: Add support for WLED4 peripheral" patch
>>       to seperate the WLED3 specific restructure.
>> 
>> Changes from V4:
>>     - Initialize wled->cfg.enabled_strings to 0,1,2,3.
>>     - Replaced the WLED3 macro with 3.
>> 
>>  drivers/video/backlight/qcom-wled.c | 395 
>> ++++++++++++++++++++++--------------
>>  1 file changed, 245 insertions(+), 150 deletions(-)
>> 
>> diff --git a/drivers/video/backlight/qcom-wled.c 
>> b/drivers/video/backlight/qcom-wled.c
>> index 3cd6e75..a746bec 100644
>> --- a/drivers/video/backlight/qcom-wled.c
>> +++ b/drivers/video/backlight/qcom-wled.c
>> @@ -15,59 +15,71 @@
>>  #include <linux/module.h>
>>  #include <linux/of.h>
>>  #include <linux/of_device.h>
>> +#include <linux/of_address.h>
>>  #include <linux/regmap.h>
>> 
>>  /* From DT binding */
>> +#define WLED_MAX_STRINGS				4
>> +
>>  #define WLED_DEFAULT_BRIGHTNESS				2048
>> 
>> -#define WLED3_SINK_REG_BRIGHT_MAX			0xFFF
>> -#define WLED3_CTRL_REG_VAL_BASE				0x40
>> +#define WLED_SINK_REG_BRIGHT_MAX			0xFFF
> 
> Stop this, no. In previous patch you renamed from ABC123_ to WLED3_,
> now you are renaming back to WLED?
> 
> Stop messing with the names. I'd actually prefer you to stick with
> original driver name, and just add note that this now supports more
> hardware.
> 
> But yes, _one_ rename is okay. I guess. But renaming it twice in one
> series is not acceptable.
> 
ok. I will stop renaming from WLED3 to WLED in this patch. I did it 
because these registers
are common for both WLED3 and WLED4 and Bjorn also suggested the same. 
Anyways I will stop
this renaming in this patch from WLED3 to WLED.

>> @@ -365,6 +433,15 @@ static int wled_configure(struct wled *wled, 
>> struct device *dev)
>> 
>>  	cfg->num_strings = cfg->num_strings + 1;
>> 
>> +	string_len = of_property_count_elems_of_size(dev->of_node,
>> +						     "qcom,enabled-strings",
>> +						     sizeof(u32));
>> +	if (string_len > 0)
>> +		rc = of_property_read_u32_array(dev->of_node,
>> +						"qcom,enabled-strings",
>> +						wled->cfg.enabled_strings,
>> +						sizeof(u32));
>> +
>>  	return 0;
>>  }
> 
> rc is assigned but never used.
Will address it next series.
> 									Pavel
