From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH] atmel_lcdfb: Correct fifo size for
	some products
Date: Mon, 08 Jun 2009 17:36:20 +0200
Message-ID: <4A2D2FF4.1010304@atmel.com>
References: <4A0D452A.4000805@atmel.com>
	<20090528003526.542d306e.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <nicolas.ferre@atmel.com>) id 1MDgtv-0005Oh-VO
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 08 Jun 2009 15:36:43 +0000
Received: from mail.atmel.fr ([81.80.104.162] helo=atmel-es2.atmel.fr)
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MDgtu-0000zv-EC for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 08 Jun 2009 15:36:43 +0000
In-Reply-To: <20090528003526.542d306e.akpm@linux-foundation.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>
Cc: Andrew Victor <avictor.za@gmail.com>, linux-fbdev-devel@lists.sourceforge.net, Haavard Skinnemoen <hskinnemoen@atmel.com>

Andrew Morton :
> On Fri, 15 May 2009 12:34:18 +0200 Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
> 
>> Remove wrong fifo size definition for some AT91 products.
>>
>> Due to a misunderstanding of some AT91 datasheets, a fifo size of 2048 (words)
>> has been introduced by mistake. In fact, all products (AT91/AT32) are sharing
>> the same fifo size of 512 words.
>>
> 
> Changelog fails to describe the impact of the bug, so people who are
> working out which kernel versions it should be ported into don't know
> what to do.
> 
> Furthermore, people who are hitting a bug in this driver in older
> kernel versions will have difficulty working out whether this patch
> might fix their bug.

Ok, you are right, I will try to add some information.

In fact, if you mis-configure the fifo watermark making it too high you
end without the capacity of issuing burst transfers on the internal AHB
bus. This will decrease overall system performance as the LCD will ask
for data as soon as the fifo will have one byte available (not efficient
single accesses).

>> Can we consider this fix for .30-final ?
> 
> Sure, but for what reason?
> 
> What about 2.6.29.x, 2.6.28.x, earlier?

Indeed, should be valuable to extend this correction to stable kernel
series. I added Greg to the loop for this purpose.

>> --- a/drivers/video/atmel_lcdfb.c
>> +++ b/drivers/video/atmel_lcdfb.c
>> @@ -29,14 +29,8 @@
>>  
>>  /* configurable parameters */
>>  #define ATMEL_LCDC_CVAL_DEFAULT		0xc8
>> -#define ATMEL_LCDC_DMA_BURST_LEN	8
>> -
>> -#if defined(CONFIG_ARCH_AT91SAM9263) || defined(CONFIG_ARCH_AT91CAP9) || \
>> -	defined(CONFIG_ARCH_AT91SAM9RL)
>> -#define ATMEL_LCDC_FIFO_SIZE		2048
>> -#else
>> -#define ATMEL_LCDC_FIFO_SIZE		512
>> -#endif
>> +#define ATMEL_LCDC_DMA_BURST_LEN	8	/* words */
>> +#define ATMEL_LCDC_FIFO_SIZE		512	/* words */
>>  
>>  #if defined(CONFIG_ARCH_AT91)
>>  #define	ATMEL_LCDFB_FBINFO_DEFAULT	(FBINFO_DEFAULT \

Thanks to have taken immediately this patch into account ; even before
my late explanation ;-)

Best regards,
-- 
Nicolas Ferre


------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
