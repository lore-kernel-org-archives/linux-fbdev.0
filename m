From: Dmitry <dbaryshkov@gmail.com>
Subject: Re: [RESEND][PATCH 1/2] fbdev: add new TMIO
	framebuffer driver
Date: Sun, 5 Oct 2008 12:09:03 +0400
Message-ID: <bc64b4640810050109g7c24a86bh98bb467d5344775c@mail.gmail.com>
References: <1222763910-22816-1-git-send-email-dbaryshkov@gmail.com>
	<20081003022323.a523a510.akpm@linux-foundation.org>
	<bc64b4640810041441t4e434939k4ff9db2a9dedad06@mail.gmail.com>
	<20081004145813.da36dfdd.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <dbaryshkov@gmail.com>) id 1KmOk1-0005sg-BC
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 05 Oct 2008 08:13:25 +0000
Received: from an-out-0708.google.com ([209.85.132.245])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1KmOfp-00083D-7G for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 05 Oct 2008 08:13:25 +0000
Received: by an-out-0708.google.com with SMTP id b21so125792ana.6
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 05 Oct 2008 01:09:03 -0700 (PDT)
In-Reply-To: <20081004145813.da36dfdd.akpm@linux-foundation.org>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ian Molton <spyro@f2s.com>, Samuel Ortiz <sameo@openedhand.com>, linux-fbdev-devel@lists.sourceforge.net, Andrew W Woodward <akwoodward@juno.com>

2008/10/5 Andrew Morton <akpm@linux-foundation.org>:
> On Sun, 5 Oct 2008 01:41:15 +0400 Dmitry <dbaryshkov@gmail.com> wrote:
>
>> >
>> >> +             info->mode = data->modes;
>> >> +     }
>> >> +
>> >> +
>> >> +     tmio_iowrite16(0x0010, par->lcr + LCR_LCDCCRC);
>> >> +     mdelay(5);
>> >> +     tmio_iowrite16(0x0014, par->lcr + LCR_LCDCCRC); /* STOP_CKP */
>> >> +     mdelay(5);
>> >> +     tmio_iowrite16(0x0015, par->lcr + LCR_LCDCCRC); /* STOP_CKP | SOFT_RESET */
>> >> +     tmio_iowrite16(0xfffa, par->lcr + LCR_VCS);
>> >
>> > I trust that someone who is reasonably familiar with the hardware will
>> > know why all these magical mdelay()s are here.  But even if they are,
>> > some comments explaining them would enhance maintainability.
>>
>> that's just for clocks/reset to happen.
>
> I wasn't asking what it was doing - I was asking whether it should be
> left uncommented.
>
> It's the sort of thing which simply cannot be understood by reading the
> C code alone.

I'll add the comment then.

>
>> >> +#ifdef CONFIG_FB_TMIO_ACCELL
>> >> +static int __must_check
>> >> +tmiofb_acc_wait(struct fb_info *info, unsigned int ccs)
>> >> +{
>> >> +     struct tmiofb_par               *par    = info->par;
>> >> +     if (in_atomic() || par->use_polling) {
>> >
>> > No, use of in_atomic() is almost always wrong.  It returns "false"
>> > inside a spinlocked section when CONFIG_PREEMPT=n.
>> >
>> > I cannot advise you further because (tada) there is no comment
>> > explaining this code to me.  But it will need to be rethought, please.
>>
>> The problem is that code may call fb functions with interrupts disabled.
>> One of examples is suspend/resume path, when console seems to be
>> resumed before interrupts are enabled (this is governed
>> by par->use_polling). I'm not sure that there are no other uses of fb
>> functions in atomic context.
>
> The use of irqs_disabled() is OK (with a comment explaining what it's for!).

I'll have to check then on the HW (will take two or three days).

>> >> +             int i = 0;
>> >> +             while (tmio_ioread16(par->lcr + LCR_CCS) > ccs) {
>> >> +                     udelay(1);
>> >> +                     i++;
>> >> +                     if (i > 10000) {
>> >> +                             printk(KERN_ERR "tmiofb: timeout waiting for %d\n", ccs);
>> >> +                             return -ETIMEDOUT;
>> >> +                     }
>> >> +                     tmiofb_irq(-1, info);
>> >> +             }
>> >> +     } else {
>> >> +             if (!wait_event_interruptible_timeout(par->wait_acc,
>> >> +                             tmio_ioread16(par->lcr + LCR_CCS) <= ccs, 1000)) {
>> >> +                     printk(KERN_ERR "tmiofb: timeout waiting for %d\n", ccs);
>> >> +                     return -ETIMEDOUT;
>> >> +             }
>> >> +     }
>> >> +
>> >> +     return 0;
>> >> +}
>>
>> ...
>>
>> >> +static int __devinit tmiofb_probe(struct platform_device *dev)
>> >> +{
>> >> +     struct mfd_cell                 *cell   = dev->dev.platform_data;
>> >> +     struct tmio_fb_data             *data   = cell->driver_data;
>> >> +     struct resource                 *ccr    = platform_get_resource(dev, IORESOURCE_MEM, 1);
>> >> +     struct resource                 *lcr    = platform_get_resource(dev, IORESOURCE_MEM, 0);
>> >> +     struct resource                 *vram   = platform_get_resource(dev, IORESOURCE_MEM, 2);
>> >> +     int                             irq     = platform_get_irq(dev, 0);
>> >> +     struct fb_info                  *info;
>> >> +     struct tmiofb_par               *par;
>> >> +     int                             retval;
>> >> +
>> >> +     if (data == NULL) {
>> >> +             dev_err(&dev->dev, "NULL platform data!\n");
>> >
>> > Can this happen?
>>
>> Of course, if you pass incorrect data to your TMIO controller chip.
>
> But would that be a programming error in the caller?

Not really. In this case it also signifies that the fb is not
connected. AFAIR Ian proposed solution to specify
which mfd cells should be registered (see drivers/mfd/mfd-core.c), but
it's currently not implemented.
Passing null platform data here allows us to w/a the inability to
register only several cells.

>> This is better than kernel Oops.
>
> Not really.  A kernel oops gets us nice debugging information and
> prompts people to send us bug reports.  That way, bugs get fixed.
>
>



-- 
With best wishes
Dmitry

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
