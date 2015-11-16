From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 16 Nov 2015 17:00:05 +0000
Subject: Re: [PATCH v4 04/24] hwmon: pwm-fan: use pwm_get_xxx() helpers where appropriate
Message-Id: <564A0B95.6010603@roeck-us.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1447664207-24370-1-git-send-email-boris.brezillon@free-electrons.com>
 <1447664207-24370-5-git-send-email-boris.brezillon@free-electrons.com>
 <5649FD5B.3000208@roeck-us.net> <20151116175322.48dba6f9@bbrezillon>
In-Reply-To: <20151116175322.48dba6f9@bbrezillon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 11/16/2015 08:53 AM, Boris Brezillon wrote:
> On Mon, 16 Nov 2015 07:59:23 -0800
> Guenter Roeck <linux@roeck-us.net> wrote:
>
>> On 11/16/2015 12:56 AM, Boris Brezillon wrote:
>>> Use pwm_get_xxx() helpers instead of directly accessing the pwm->xxx field.
>>> Doing that will ease adaptation of the PWM framework to support atomic
>>> update.
>>>
>>> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
>>> ---
>>> Patch generated with the following coccinelle script:
>>>
>>> --->8---
>>> virtual patch
>>>
>>> @@
>>> struct pwm_device *p;
>>> expression e;
>>> @@
>>> (
>>> -(p)->polarity = e;
>>> +pwm_set_polarity((p), e);
>>> |
>>> -(p)->polarity
>>> +pwm_get_polarity((p))
>>
>> s/((p))/(p)/
>>
>>> |
>>> -(p)->period = e;
>>> +pwm_set_period((p), e);
>>> |
>>> -(p)->period
>>> +pwm_get_period((p))
>>
>> s/((p))/(p)/
>>
>>> |
>>> -(p)->duty_cycle = e;
>>> +pwm_set_duty_cycle((p), e);
>>
>> The (p) seems unnecessary here.
>
> I don't get this one. You mean I should drop one the parenthesis around
> p, right?
>

Same as above - s/(p)/p/. It should never be necessary to write
	pwm_set_duty_cycle((p), e)
since
	pwm_set_duty_cycle(p, e)
should be the same.

On the other side, I did not see this expression used in any of the patches,
though maybe I missed it.

Thanks,
Guenter

