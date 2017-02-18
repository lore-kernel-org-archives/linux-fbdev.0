From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Sat, 18 Feb 2017 16:31:43 +0000
Subject: Re: [PATCH] backlight: report error on failure
Message-Id: <58A876EF.1040803@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1484774630-4228-1-git-send-email-sudipm.mukherjee@gmail.com> <588FC682.9040503@gmail.com>
In-Reply-To: <588FC682.9040503@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, daniel.thompson@linaro.org

On Monday 30 January 2017 11:04 PM, Sudip Mukherjee wrote:
> On Wednesday 18 January 2017 09:23 PM, Sudip Mukherjee wrote:
>> It is possible to update the backlight power and the brightness using
>> the sysfs and on writing it either returns the count or if the callback
>> function does not exist then returns the error code 'ENXIO'.
>>
>> We have a situation where the userspace client is writing to the sysfs
>> to update the power and since the callback function exists the client
>> receives the return value as count and considers the operation to be
>> successful. That is correct as the write to the sysfs was successful.
>> But there is no way to know if the actual operation was done or not.
>>
>> backlight_update_status() returns the error code if it fails. Pass that
>> to the userspace client who is trying to update the power so that the
>> client knows that the operation failed.
>>
>> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
>> ---
>
> A gentle ping.

Hi Andrew,

Its more than one month now that this patch was submitted. Can you 
please take it through your tree... else it will miss the merge window.

Regards
Sudip

>
>
>>   drivers/video/backlight/backlight.c | 7 +++----
>>   1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/video/backlight/backlight.c
>> b/drivers/video/backlight/backlight.c
>> index 288318a..74b72b5 100644
>> --- a/drivers/video/backlight/backlight.c
>> +++ b/drivers/video/backlight/backlight.c
>> @@ -146,9 +146,9 @@ static ssize_t bl_power_store(struct device *dev,
>> struct device_attribute *attr,
>>           pr_debug("set power to %lu\n", power);
>>           if (bd->props.power != power) {
>>               bd->props.power = power;
>> -            backlight_update_status(bd);
>> +            rc = backlight_update_status(bd);
>>           }
>> -        rc = count;
>> +        rc = rc ? rc : count;
>>       }
>>       mutex_unlock(&bd->ops_lock);
>>
>> @@ -176,8 +176,7 @@ int backlight_device_set_brightness(struct
>> backlight_device *bd,
>>           else {
>>               pr_debug("set brightness to %lu\n", brightness);
>>               bd->props.brightness = brightness;
>> -            backlight_update_status(bd);
>> -            rc = 0;
>> +            rc = backlight_update_status(bd);
>>           }
>>       }
>>       mutex_unlock(&bd->ops_lock);
>>
>

