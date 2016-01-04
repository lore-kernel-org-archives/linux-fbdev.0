From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Date: Mon, 04 Jan 2016 15:20:42 +0000
Subject: Re: [PATCH] backlight: pwm: free pwm requested by legacy API on error path
Message-Id: <568A8DCA.6010301@mentor.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1434292334-22312-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <20150921232338.GG11284@x1>
In-Reply-To: <20150921232338.GG11284@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lee Jones <lee.jones@linaro.org>
Cc: Jingoo Han <jg1.han@samsung.com>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org

Hi Lee,

On 22.09.2015 02:23, Lee Jones wrote:
> On Sun, 14 Jun 2015, Vladimir Zapolskiy wrote:
> 
>> If pwm is requested by legacy pwm_request() and if the following
>> backlight_device_register() call fails, add pwm_free() clean-up.
>>
>> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
>> ---
>>  drivers/video/backlight/pwm_bl.c | 2 ++
>>  1 file changed, 2 insertions(+)
> 
> Applied, thanks.
> 

I've just encountered that this change is not present in v4.4-rc, also it is
not in yours for-backlight-next branch, could you please double check the
status of the change?

Thank you in advance.

Best wishes,
Vladimir

>> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
>> index 9991cdb..a691247 100644
>> --- a/drivers/video/backlight/pwm_bl.c
>> +++ b/drivers/video/backlight/pwm_bl.c
>> @@ -307,6 +307,8 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>>  	if (IS_ERR(bl)) {
>>  		dev_err(&pdev->dev, "failed to register backlight\n");
>>  		ret = PTR_ERR(bl);
>> +		if (pb->legacy)
>> +			pwm_free(pb->pwm);
>>  		goto err_alloc;
>>  	}
>>  
> 

