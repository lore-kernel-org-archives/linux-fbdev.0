From: Bill Davidsen <davidsen@tmr.com>
Subject: Re: radeonfb: corrupted screen on bootup
Date: Thu, 29 Jun 2006 11:08:16 -0400
Message-ID: <44A3ECE0.10104@tmr.com>
References: <200606282118.27750.mb@bu3sch.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750773AbWF2PFr@vger.kernel.org>
In-Reply-To: <200606282118.27750.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Michael Buesch <mb@bu3sch.de>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

Michael Buesch wrote:
> Hi,
> 
> I have a weird error with my PowerBook G4, which
> has a radeon card. I am using radeonfb.

I had a similar problem, and solved it by using the "wrong" (aty128fb) 
module which makes me happy. Booted working 5-6 times now, which is a 
few weeks since I run for long periods.

> After bootup, the screen sometimes looks like it is melting.
> I made a video to show you what is going on:
> http://bu3sch.de/misc/after_boot.avi  (6.1 MB)
> 
> It does only happen sometimes. I could not find
> a way to reproduce it.
> If I start X after boot with a melting screen, X is also
> melting:
> http://bu3sch.de/misc/after_x_switch.avi  (6.6 MB)
> 
> But here comes the interresting part:
> If I switch back into the console, the screen becomes
> normal again and I can continue to work as usual.
> 
> I am suspecting some initialization routine bug.
> It never happened when booting into OSX.
> 
> In X I use the "radeon" driver.

-- 
Bill Davidsen <davidsen@tmr.com>
   Obscure bug of 2004: BASH BUFFER OVERFLOW - if bash is being run by a
normal user and is setuid root, with the "vi" line edit mode selected,
and the character set is "big5," an off-by-one errors occurs during
wildcard (glob) expansion.
