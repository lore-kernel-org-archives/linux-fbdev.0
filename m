From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [Linux-fbdev-devel] Generic VESA framebuffer driver and Video card BOOT?
Date: Wed, 20 Oct 2004 21:08:46 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20041020190846.GA21315@elf.ucw.cz>
References: <41740384.5783.12A07B14@localhost> <41763777.26324.1B3B684C@localhost>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S269176AbUJTTNS@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <41763777.26324.1B3B684C@localhost>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kendall Bennett <KendallB@scitechsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

Hi!

> > > Open Firmware may be a 'nicer' solution, but I guarantee that if the 
> > > vendors started supporting that it would be just a bug ridden as any 16-
> > > bit real mode BIOS code. For the Video BIOS the code always works for 
> > > what it is tested for. Some vendors spend more time testing the VBE BIOS 
> > > side of things fully (if they are smart they have licensed our VBETest 
> > > tools for this purpose). Unfortunatley some vendors do not test this 
> > > stuff thoroughly and it has problems. But the same testing issues would 
> > > exist whether the firmware was written as a 16-bit x86 blob or as an Open 
> > > Firmware blob.
> > 
> > Actually that 16-bit x86 blob can access any PC hardware, and that's
> > where the stuff gets hard.
> 
> Yes, but there is only a very small set of PC hardware features you need 
> to implement, and most BIOS'es only look at those things for timing 
> purposes. Unfortunately there is no standard for how BIOS'es do internal 
> timing and delay loops, so we emulate them all (8253 timers, speaker 
> ports and CMOS time/date support ;-).

Hmm, that does not seem that bad. Did you need to emulate interrupt
controller, too? That one seemed most scary to me.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
