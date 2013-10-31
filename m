From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Date: Thu, 31 Oct 2013 01:17:05 +0000
Subject: Re: [RFC PATCH RESEND] fb: reorder the lock sequence to fix a potential lockdep
Message-Id: <5271AF91.4090109@cn.fujitsu.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <526DFDA8.7010806@cn.fujitsu.com> <5270EB85.1030103@ti.com>
In-Reply-To: <5270EB85.1030103@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

Hi Tomi,

On 10/30/2013 07:20 PM, Tomi Valkeinen wrote:

> Hi,
> 
> On 2013-10-28 08:01, Gu Zheng wrote:
>> Following commits:
>> 50e244cc79 fb: rework locking to fix lock ordering on takeover
>> e93a9a8687 fb: Yet another band-aid for fixing lockdep mess
>> 054430e773 fbcon: fix locking harder
>>
>> reworked locking to fix related lock ordering on takeover, and introduced console_lock
>> into fbmem, but it seems that the new lock sequence(fb_info->lock ---> console_lock)
>> is against with the one in console_callback(console_lock ---> fb_info->lock), and leads to
>> a potential deadlock as following:
> 
> A quick grep shows that there are other places than fbmem.c which use
> lock_fb_info and console_lock, for example drivers/video/sh_mobile_lcdcfb.c.

Yes, thanks for your reminder, I'll fix them all in the next version.

Regards,
Gu

> 
>  Tomi
> 
> 


