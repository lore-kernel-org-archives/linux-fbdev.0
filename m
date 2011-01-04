From: Joe Jin <joe.jin@oracle.com>
Date: Tue, 04 Jan 2011 00:34:00 +0000
Subject: Re: [Xen-devel] Re: [patch] xenfb: fix xenfb suspend/resume race
Message-Id: <4D226AF8.1010102@oracle.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20101230125616.GA31537@joejin-pc.cn.oracle.com> <20101230164051.GC24313@dumpdata.com> <4D1D2A2D.80206@oracle.com> <20110103163418.GA14102@dumpdata.com>
In-Reply-To: <20110103163418.GA14102@dumpdata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: jeremy@goop.org, xen-devel@lists.xensource.com, ian.campbell@citrix.com, gurudas.pai@oracle.com, guru.anbalagane@oracle.com, greg.marsden@oracle.com, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On 01/04/11 00:34, Konrad Rzeszutek Wilk wrote:
>>> I am unclear from your description whether the patch fixes
>>> the problem (I would presume so). Or does it take a long time
>>> to hit this race?
>>>
>> Yes, more than 100 migrations. we hit this issue around 3 times.
> 
> OK, so you are still trying to find the culprit.
> 
> Did you look at this patch from Ian:
> 
> https://patchwork.kernel.org/patch/403192/

We have reproduced the issue with the patch.

> 
> ?
>>
>> I dumped vmcore when guest crashed, from vmcore everything
>> looked good, fb_info, xenfb_info and so on.
> 
> And the event channels are correct?
> 
> .. snip..
>> diff --git a/drivers/xen/events.c b/drivers/xen/events.c
>> index ac7b42f..4cfb5e2 100644
>> --- a/drivers/xen/events.c
>> +++ b/drivers/xen/events.c
>> @@ -175,6 +175,8 @@ static struct irq_info *info_for_irq(unsigned irq)
>>  
>>  static unsigned int evtchn_from_irq(unsigned irq)
>>  {
>> +	if (unlikely(irq < 0 || irq >= nr_irqs))
>> +		return 0;
> 
> You could insert a WARN_ON here to see see if you get this during your
> migration process.
> 
> Or use xen_raw_printk in case the guest is hung for good.
> 

Thanks for your advice, will try it.
