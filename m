From: Joonyoung Shim <jy0922.shim@samsung.com>
Date: Tue, 22 Nov 2011 00:58:46 +0000
Subject: Re: [PATCH] video: Fix return value of fb_notifier_call_chain
Message-Id: <4ECAF3C6.4010507@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1321858524-19368-1-git-send-email-jy0922.shim@samsung.com>
 <4ECAD9F0.9050508@gmx.de>
In-Reply-To: <4ECAD9F0.9050508@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

11/22/2011 08:08 AM, Florian Tobias Schandinat 쓴 글:
> On 11/21/2011 06:55 AM, Joonyoung Shim wrote:
>> The return value of blocking_notifier_call_chain isn't errno value, it
>> is just notify return value. The ret of fb_notifier_call_chain should is
>> restored to error value from notify return value using
>> notifier_to_errno().
> If I'm not wrong this patch would rather break things than fix them. As I
> understand the notifier_calls would be required to encode the return value with
> notifier_from_errno. This does not happen at the moment for fb clients, for
> example fbcon_event_notify in drivers/video/console/fbcon.c, so this patch would
> screw up the return values, I think.

OK, but it is wrong to return error value than notify value many
callback of fb notify clients and some fb notify clients returns notify
value, please see sh_mobile_lcdc_notify() and sh_hdmi_notify().

We should use only one, notify value or error value, i think it's right
to use notify value.

Thanks.

>
> Best regards,
>
> Florian Tobias Schandinat
>
>> Signed-off-by: Joonyoung Shim<jy0922.shim@samsung.com>
>> ---
>>   drivers/video/fb_notify.c |    4 +++-
>>   1 files changed, 3 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/video/fb_notify.c b/drivers/video/fb_notify.c
>> index 74c2da5..49a64a3 100644
>> --- a/drivers/video/fb_notify.c
>> +++ b/drivers/video/fb_notify.c
>> @@ -42,6 +42,8 @@ EXPORT_SYMBOL(fb_unregister_client);
>>    */
>>   int fb_notifier_call_chain(unsigned long val, void *v)
>>   {
>> -	return blocking_notifier_call_chain(&fb_notifier_list, val, v);
>> +	int ret = blocking_notifier_call_chain(&fb_notifier_list, val, v);
>> +
>> +	return notifier_to_errno(ret);
>>   }
>>   EXPORT_SYMBOL_GPL(fb_notifier_call_chain);
>

