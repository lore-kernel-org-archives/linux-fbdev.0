From: "Bender aka Sergei S." <bender.rodriguez@open.by>
Subject: Re: [Bugme-new] [Bug 12712] New: s2disk hangs
	with nvidiafb
Date: Mon, 23 Feb 2009 10:24:55 +0200
Message-ID: <120778075.20090223102455@open.by>
References: <web-46440394@post.open.by>
	<20090222150504.a77dc9b3.krzysztof.h1@poczta.fm>
Reply-To: Bender <bender.rodriguez@open.by>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <bender.rodriguez@open.by>) id 1LbW6f-00083W-Hm
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 23 Feb 2009 08:24:05 +0000
Received: from mail.open.by ([193.232.92.17] helo=post.open.by)
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LbW6a-0002a3-Iy for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 23 Feb 2009 08:24:05 +0000
In-Reply-To: <20090222150504.a77dc9b3.krzysztof.h1@poczta.fm>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net, bugme-daemon@bugzilla.kernel.org

On Sunday, February 22, 2009, 4:05:04 PM, Krzysztof wrote:

> On Sun, 22 Feb 2009 12:47:11 +0200
> "Sergei S." <bender.rodriguez@open.by> wrote:

>> Hello.
>> 
>> By the way.
>> 
>> [drivers/video/vesafb.c
>> static int __init vesafb_probe(struct platform_device *dev)]
>> 
>>       if (!request_mem_region(vesafb_fix.smem_start, size_total, "vesafb")) {
>>               printk(KERN_WARNING
>>                      "vesafb: cannot reserve video memory at 0x%lx\n",
>>                       vesafb_fix.smem_start);
>>               /* We cannot make this fatal. Sometimes this comes from magic
>>                  spaces our resource handlers simply don't know about */
>>       }
>> 
>> Is there any reason not to make vesafb request_mem_region fail fatal?
>> 
>> In case we already have framebuffer at 0xc0000000 and framebuffer_alloc failed -
>> we'll release non-vesafb memory region.
>> 
>>       info = framebuffer_alloc(sizeof(u32) * 256, &dev->dev);
>>       if (!info) {
>>               release_mem_region(vesafb_fix.smem_start, size_total);
>>               return -ENOMEM;
>>       }
>> 
>> 
>> So, what do you think about the idea to check num_registered_fb when request_mem_region 
>> fails?


Hello.

> I am not sure. Each request is done by a driver and it is assigned to it. Someone
> with more knowledge should clear this doubts. I suppose if a driver does not
>  request a resource releasing it should be void.

I think we should do some work at request_mem_region instead of simple
printk KERN_WARNING (I may be wrong).


And what about:
> In case we already have framebuffer at 0xc0000000 and framebuffer_alloc failed -
> we'll release non-vesafb memory region.
>
>       info = framebuffer_alloc(sizeof(u32) * 256, &dev->dev);
>       if (!info) {
>               release_mem_region(vesafb_fix.smem_start, size_total);
>               return -ENOMEM;
>       }

IMHO at least we should have some bit showing that
request_mem_region(vesafb_fix.smem_start, size_total, "vesafb")
was successful. Just to call release_mem_region is not correct since
we can release nvidiafb's (etc.) memory region.


> Your case is more simple - nvidiafb does not suspend/resume correctly. This
> is easy to check - if only the nvidiafb is selected the s2disk does not work.

Well, it's not so simple, I guess. Looks like s2disk works with
nvidiafb built with "Lots of debug messages" and doesn't work
otherwise.

Before hibernation we create virtual console and make switch to it (am
I right?). I'm not sure, but it seems I have problems in switching to
virtual console (or even earlier).
I'll try to figure out.


> This is probably not a regression - you can check if your older kernel
> works with only the nvidiafb selected.
I've tested 2.6.27.11. It seems a bit senseless to test kernels earlier than 2.6.27
(it can be difficult to find out the problem).


> Unfortunately, I have no card to reproduce this and I don't know what
> is wrong with the nvidiafb suspend/resume functions.

> I hope someone will help you.

Thanks.


Best regards,
Sergey


> Kind regards,
> Krzysztof


------------------------------------------------------------------------------
Open Source Business Conference (OSBC), March 24-25, 2009, San Francisco, CA
-OSBC tackles the biggest issue in open source: Open Sourcing the Enterprise
-Strategies to boost innovation and cut costs with open source participation
-Receive a $600 discount off the registration fee with the source code: SFAD
http://p.sf.net/sfu/XcvMzF8H
