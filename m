From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [RFC 2.6.26-rc3 06/10] gumstix: conversion
	to MFP support and add bluetooth support
Date: Sun, 15 Jun 2008 01:54:54 -0400
Message-ID: <45a44e480806142254r36548995kfd75a09251e4e46e@mail.gmail.com>
References: <1213289961-1562-1-git-send-email-jayakumar.lkml@gmail.com>
	<1213289961-1562-7-git-send-email-jayakumar.lkml@gmail.com>
	<20080613074250.GF20702@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K7lCa-0007wA-3n for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 14 Jun 2008 22:54:56 -0700
Received: from wa-out-1112.google.com ([209.85.146.181])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K7lCY-00027k-TU
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 14 Jun 2008 22:54:56 -0700
Received: by wa-out-1112.google.com with SMTP id j5so4209535wah.18
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 14 Jun 2008 22:54:54 -0700 (PDT)
In-Reply-To: <20080613074250.GF20702@flint.arm.linux.org.uk>
Content-Disposition: inline
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
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: ymiao3@marvell.com, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk

On Fri, Jun 13, 2008 at 3:42 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Jun 12, 2008 at 12:59:17PM -0400, Jaya Kumar wrote:
>> +static unsigned long gumstix_pin_config[] __initdata = {
>> +#ifdef CONFIG_BT
>
> Should GPIO configurations depend on whether the driver support's built
> in or not?  Surely the hardware is there irrespective of the kernel's
> configuration - especially if these are built as a module.

You are right. I wasn't sure if all gumstix-F's had the same gpio
setup so I tried to hedge that with config options. But it looks safe
to remove that so I'll take them out.

>
>>  static struct clk pxa25x_clks[] = {
>> +     {
>> +             .name           = "CLK_32K",
>> +             .ops            = &clk_32k_ops,
>> +             .rate           = 32000,
>
> Most 32kHz clocks are 32768Hz not 32000Hz.  Are you sure this is correct?
>

You are right, that should be 32768. I'll fix that.

Thanks,
jaya

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
