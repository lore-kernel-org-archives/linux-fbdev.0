From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Date: Tue, 12 Nov 2013 01:06:45 +0000
Subject: Re: [RESEND PATCH 1/2] fb: reorder the lock sequence to fix potential dead lock
Message-Id: <52817F25.2090808@cn.fujitsu.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <5278C1D9.9030101@cn.fujitsu.com> <5280E2BF.7040602@ti.com>
In-Reply-To: <5280E2BF.7040602@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

Hi Tomi,
On 11/11/2013 09:59 PM, Tomi Valkeinen wrote:

> On 2013-11-05 12:00, Gu Zheng wrote:
>> Following commits:
>> 50e244cc79 fb: rework locking to fix lock ordering on takeover
>> e93a9a8687 fb: Yet another band-aid for fixing lockdep mess
>> 054430e773 fbcon: fix locking harder
>> reworked locking to fix related lock ordering on takeover, and introduced console_lock
>> into fbmem, but it seems that the new lock sequence(fb_info->lock ---> console_lock)
>> is against with the one in console_callback(console_lock ---> fb_info->lock), and leads to
>> a potential dead lock as following:
> 
> <snip>
> 
>> so we reorder the lock sequence the same as it in console_callback() to
>> avoid this issue. And following Tomi's suggestion, fix these similar
>> issues all in fb subsystem.
>>
>> Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
>> ---
>>  drivers/video/fbmem.c            |   50 ++++++++++++++++++++++++-------------
>>  drivers/video/fbsysfs.c          |   19 ++++++++++----
>>  drivers/video/sh_mobile_lcdcfb.c |   10 ++++---
>>  3 files changed, 51 insertions(+), 28 deletions(-)
> 
> I'll apply this for 3.13. It's a bit difficult to verify if the locking
> is now correct, but looks fine to me. And we can revert this easily if
> things break badly.

Thanks very munch.:)

Regards,
Gu

> 
>  Tomi
> 
> 


