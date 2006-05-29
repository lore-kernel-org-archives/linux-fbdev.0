From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Twister savagefb doesn't sync
Date: Mon, 29 May 2006 08:13:52 +0800
Message-ID: <447A3CC0.9060403@gmail.com>
References: <44698356.80806@iit.demokritos.gr> <447359B8.7020304@iit.demokritos.gr> <447381E9.4060705@gmail.com> <447803FC.8050009@iit.demokritos.gr> <44781B3A.5030406@gmail.com> <44781BFB.5020708@gmail.com> <447994A8.30600@iit.demokritos.gr>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FkVOa-0002Mp-F3
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 28 May 2006 17:14:08 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FkVOa-0004IE-Dj
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 28 May 2006 17:14:08 -0700
Received: from py-out-1112.google.com ([64.233.166.179])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FkVOZ-0003nu-PM
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 28 May 2006 17:14:08 -0700
Received: by py-out-1112.google.com with SMTP id b29so144923pya
        for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 28 May 2006 17:14:02 -0700 (PDT)
In-Reply-To: <447994A8.30600@iit.demokritos.gr>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: vasvir@iit.demokritos.gr
Cc: linux-fbdev-devel@lists.sourceforge.net

Vassilis Virvilis wrote:
> Antonino A. Daplas wrote:
> 
>>
>> lspci -v -d 5333:8d04
>>
> OK I have done a lot of tests. First my device is
> 5333:8d01 and the non-prefetchable memory is at ec000000
> so we have
> 
> #define PCI_ID        0x8d01  /* put the PCI id of the device here */
> #define PCI_PBASE     0xec000000  /* put the start address of the PCI
> resource here */
> 
> Ok. I tried both X (with use bios), and SDL testsprite in 640x480,
> 800x600, 1024x768 at
> 8, 16, 24 bpp.
> 
> testsprite is a SDL demo that accepts the following options
> (-width, -height, -bpp). I made both sets of tests in a medion TFT 18
> screen and in an
> EIZO F520 CRT.
> 
> All X modes are working.
> SDL works for 1024x768 bpp=* in CRT and TFT
> SDL work in 800x600 bpp={16, 24} (not 8bpp) only in TFT and __not in CRT__
> 
> I am attaching the output of savagedump for all modes, for both monitors
> (#36),
> just for future reference.
> 
> I will try to understand the differences but the registers are too many
> and without
> documentation it is a bit hopeless I am afraid. Or is there

Too many differences since the timings for the 2 modes are also different.
If you can match the timings, as shown by fbset and xvidtune, this should
minimize the variation.

> documentation somewhere publicly
> available?

There are no docs.

> 
> Is there any way to replay the working set of registers to get the
> correct mode settings?

savagefb does save the initial registers and reuses part of them when setting
the mode, so if you can boot with vga= parameter that matches the initial mode
of savagefb, it might help. Try this:

video=savagefb:1024x768-16@60 vga=0x317

Tony


-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
