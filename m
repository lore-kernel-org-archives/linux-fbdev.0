From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [RFC 2.6.26-rc3 08/10] am200epd: convert to
 shared fb and use gpio api
Date: Mon, 16 Jun 2008 10:35:58 +0800
Message-ID: <4855D18E.5010609@gmail.com>
References: <1213289961-1562-1-git-send-email-jayakumar.lkml@gmail.com>	
	<1213289961-1562-9-git-send-email-jayakumar.lkml@gmail.com>	
	<4851D98A.5000508@gmail.com>
	<45a44e480806142342n7f0be549se6ded1a93d363d65@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K84Zk-0006Vk-Cr for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 15 Jun 2008 19:36:09 -0700
Received: from rv-out-0708.google.com ([209.85.198.250])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K84Zj-00078y-15
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 15 Jun 2008 19:36:08 -0700
Received: by rv-out-0708.google.com with SMTP id f25so4194570rvb.22
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 15 Jun 2008 19:36:06 -0700 (PDT)
In-Reply-To: <45a44e480806142342n7f0be549se6ded1a93d363d65@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: ymiao3@marvell.com, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk

Jaya Kumar wrote:
> On Thu, Jun 12, 2008 at 10:20 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
>> Jaya Kumar wrote:
>>> This patch converts am200epd to use pxafb's fb and to stop performing
>>> direct access to LCDC registers. It now uses the generic GPIO api.
>>>
>> Mmm..., this patch makes the code much cleaner now, see my comments below.
> 
> Thanks :)
> 
>>> +static struct pxafb_mach_info am200_fb_info = {
>>> +     .modes          = &am200_fb_mode_6inch,
>>> +     .num_modes      = 1,
>>> +     .lccr0          = LCCR0_Pas | LCCR0_Sngl | LCCR0_Color,
>>> +     .lccr3          = 0,
>>> +     .lcd_conn       = LCD_TYPE_COLOR_TFT | LCD_PCLK_EDGE_FALL |
>>> +                       LCD_AC_BIAS_FREQ(24),
>> You don't need to specify both lccrX and lcd_conn, the pxafb.c should
>> be smart enough to guess a correct LCCRx setting based on lcd_conn.
> 
> Ok, will fix.
> 
>> Can set_pxa_fb_info() be used here instead of re-allocating a new
>> platform_device with almost same setting as pxa_device_fb?
> 
> Actually, I had tried to do that and ran into problems on driver
> unload. This is because pxa_device_fb is a statically declared struct
> and not allocated using platform_device_alloc. So it is missing a
> bunch of stuff needed for device release. I thought about changing
> set_pxa_fb_info to do alloc instead but it seems too invasive. This
> duplication seems easier.
> 

I saw the device's name being "pxa2xx-fb", so I assume the pxafb.c
will take over the device, while I didn't see the
platform_unregister_device() in your module unload patch, could you
please be more specific on this, and see if we can work out a better
solution.

>>> -     return set_irq_type(IRQ_GPIO(RDY_GPIO_PIN), IRQT_FALLING);
>>> +     ret = set_irq_type(IRQ_GPIO(RDY_GPIO_PIN), IRQT_FALLING);
>> This can be specified in request_irq(), e.g.
>>
>>        request_irq(..., IRQF_DISABLED | IRQF_TRIGGER_FALLING, ...)
>>
>> the rest of the edge configuration work will be automatically done.
> 
> Ok, will fix.
> 
> Thanks,
> jaya


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
