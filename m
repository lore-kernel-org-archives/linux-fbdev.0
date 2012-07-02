From: Alexander Holler <holler@ahsoftware.de>
Date: Mon, 02 Jul 2012 21:25:17 +0000
Subject: Re: [PATCH] video/smscufx: fix line counting in fb_write
Message-Id: <4FF211BD.8060203@ahsoftware.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1334959867-3719-1-git-send-email-holler@ahsoftware.de> <4F92995B.6030805@ahsoftware.de> <4FAFAD7B.6090207@gmx.de>
In-Reply-To: <4FAFAD7B.6090207@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

Hi Florian,

sorry for the late answer.

Am 13.05.2012 14:47, schrieb Florian Tobias Schandinat:
> Hi Alexander,
>
> On 04/21/2012 11:26 AM, Alexander Holler wrote:
>> Hello,
>>
>> as for the patch for udlfb, I forgot to mention that this is a candidate
>> for all stable trees 3.2 and above.
>>
>> Btw., the address of the maintainer doesn't seem to be valid anymore.
>
> it is better to cc me on patches to the framebuffer subsystem for such
> cases. I don't have much free time so it's rare that I come around to
> dig in the mailing list.
>
>>
>> Regards,
>>
>> Alexander
>>
>> Am 21.04.2012 00:11, schrieb Alexander Holler:
>>> Line 0 and 1 were both written to line 0 (on the display) and all
>>> subsequent
>>> lines had an offset of -1. The result was that the last line on the
>>> display
>>> was never overwritten by writes to /dev/fbN.
>>>
>>> The origin of this bug seems to have been udlfb.
>>>
>>> Signed-off-by: Alexander Holler<holler@ahsoftware.de>
>>
>> Cc: stable@vger.kernel.org
>
> Patch looks good to me but can be made simpler.
>
>>
>>> ---
>>>    drivers/video/smscufx.c |    2 +-
>>>    1 files changed, 1 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/drivers/video/smscufx.c b/drivers/video/smscufx.c
>>> index ccbfef5..1e1e2d2 100644
>>> --- a/drivers/video/smscufx.c
>>> +++ b/drivers/video/smscufx.c
>>> @@ -904,7 +904,7 @@ static ssize_t ufx_ops_write(struct fb_info *info,
>>> const char __user *buf,
>>>        result = fb_sys_write(info, buf, count, ppos);
>>>
>>>        if (result>  0) {
>>> -        int start = max((int)(offset / info->fix.line_length) - 1, 0);
>>> +        int start = max((int)(offset / info->fix.line_length), 0);
>
> the cast to int as well as the max is superfluous without the -1 as the
> value can no longer be negative.

I had that impression too, but I wanted to change as less as possible, 
so I didn't had the need to check types and (their) sizes for possible 
overflows or such. I was lazy and just wanted to fix that one bug. ;)

>
>>>            int lines = min((u32)((result / info->fix.line_length) + 1),
>>>                    (u32)info->var.yres);
>>>

Regards,

Alexander
