From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [RFC 2.6.26-rc3 06/10] gumstix: conversion
	to MFP support and add bluetooth support
Date: Sun, 15 Jun 2008 01:51:20 -0400
Message-ID: <45a44e480806142251x61462e2ft839332de6c2fbe1c@mail.gmail.com>
References: <1213289961-1562-1-git-send-email-jayakumar.lkml@gmail.com>
	<1213289961-1562-7-git-send-email-jayakumar.lkml@gmail.com>
	<4851D4E9.3080008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K7l98-0007fi-Mw for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 14 Jun 2008 22:51:22 -0700
Received: from wf-out-1314.google.com ([209.85.200.174])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K7l97-0005sh-Dm
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 14 Jun 2008 22:51:22 -0700
Received: by wf-out-1314.google.com with SMTP id 27so4730011wfd.4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 14 Jun 2008 22:51:20 -0700 (PDT)
In-Reply-To: <4851D4E9.3080008@gmail.com>
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
To: Eric Miao <eric.y.miao@gmail.com>
Cc: ymiao3@marvell.com, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk

On Thu, Jun 12, 2008 at 10:01 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
> Jaya Kumar wrote:
>
> I'd suggest we use
>
> #if defined(CONFIG_MMC_PXA) || defined(CONFIG_MMC_PXA_MODULE)
>
> so that even when PXA MMCI is built as a module, the platform data
> is still available for later bind. Same below to the BT.

Yup, there are problems with my assumptions there. I see Russell's
point that gpio setup shouldn't depend on whether the driver is
enabled or not. I wasn't sure if all gumstix-F's had MMC and BT on
those gpio's so I tried to hedge that with CONFIG options. It looks
like it is safe to remove the CONFIG so I'll change that over.

>
> The 32KHz oscillator should be on by default, so I'm thinking of:
>
> 1. remove this clock source
>
> or
>
> 2. enable/disable the clk by enable/disable the pin configuration
> (i.e. switch between GPIO12_32KHz and GPIO12_GPIO)

Ok. I'll go read up and try to solve this. I think I put the enable in
there because it initially didn't work on my setup. I saw that the
gumstix bluetooth startup script S30bluetooth was manually tweaking
that using the pxaregs proc_gpio patch.

        echo -n "Starting 32kHz clock..."
        /usr/sbin/pxaregs OSCC_OON 1
        while /usr/sbin/pxaregs OSCC_OOK | tail -n 1 | grep -q -v 1;do
                echo -n '.'
                sleep 1
        done
        echo "Settled"

From the gumstix faq:
http://docwiki.gumstix.org/Frequently_asked_questions/Bluetooth
The new bluetooth module needs a 32Khz clock signal to be fed to the
module from the PXA by setting one of the GPIO lines to a special alt
function mode, and enabling the OSCC on the PXA. This is done properly
by the u-boot in the latest buildroot revisions, (as of Jan 27, 2006)
and double-checked by the latest bluetooth startup scripts in the
buildroot using pxaregs to ensure that the clock is in fact ticking
before attempting to talk to the BT module.

> As said, the 32K timer should really be started on the very begining,
> I'd prefer a some kind of warning here if OSCC_OOK isn't set.

Ok, I'll fix this.

>
>> +
>> +static void clk_32k_disable(struct clk *clk)
>> +{
>> +     OSCC &= ~OSCC_OON;
>> +}
>> +
>
> The 32K timer cannot be disabled once started, until a power-on or
> hardware reset occurs.

Ok, I'll take this out.

Thanks,
jaya

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
