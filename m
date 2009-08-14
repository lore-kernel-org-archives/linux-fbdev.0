From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Subject: Re: [Bugme-new] [Bug 13976] New: viafb + vmalloc
Date: Fri, 14 Aug 2009 10:49:43 +0200
Message-ID: <4A852527.7040705@gmx.de>
References: <bug-13976-10286@http.bugzilla.kernel.org/>
	<20090813123622.624240c7.akpm@linux-foundation.org>
	<4A84849A.3000807@gmx.de>
	<FE2B7370-64DF-43D4-B0E3-C65EB1AD1986@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <FlorianSchandinat@gmx.de>) id 1MbsTt-0002Ss-CC
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 14 Aug 2009 08:49:49 +0000
Received: from mail.gmx.net ([213.165.64.20])
	by 3b2kzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1MbsTj-00084S-TT for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 14 Aug 2009 08:49:49 +0000
In-Reply-To: <FE2B7370-64DF-43D4-B0E3-C65EB1AD1986@gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Roman Sergeev <sungeneral@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, bugzilla-daemon@bugzilla.kernel.org, Joseph Chan <JosephChan@via.com.tw>, Scott Fang <ScottFang@viatech.com.cn>, bugme-daemon@bugzilla.kernel.org, Andrew Morton <akpm@linux-foundation.org>

Roman Sergeev schrieb:
> 01:00.0 VGA compatible controller: VIA Technologies, Inc. P4M900 [Chrome 
> 9 HC] (rev 01)
> with shadow ram (total 2Gb, but system see 1768Mb... maybe 280Mb)

This makes sense:
2 GB physical RAM
- 256 MB used as shared memory video RAM
= 1792 MB available
I don't know where the other memory is lost but the video memory size 
seems to be detected correctly.

> after modprobe viafb don't die, they going to new state
> viafb 75212 1 - Loading 0xef642000

I don't know if I get you right here:
After "modprobe viafb viafb_accel=0" the module does no longer crash? 
But I don't know what state you are talking about. Is the module usable? 
(i.e. does "modprobe fbcon" give you a working framebuffer console?) Or 
can you otherwise post a new log?

An alternative to disabling the hardware acceleration might be to 
increase vmalloc=260M to a value greater than 256+16 MB, like 
vmalloc=300MB or so.

Okay, I think I have a deeper understanding now:
- the driver tries to remap 256 MB (video framebuffer) and 16 MB (MMIO 
registers)
- the free region is per default only 128 MB and is only on systems with 
significant less physical RAM than kernel virtual memory space bigger

So in addition to handle the second ioremap failure (for which I have 
already a patch prepared) one of the following might be nice
- add/reuse module/boot parameter to limit the available video memory size
- automatically try to remap smaller parts of the video memory if the 
first ioremap fails
- after having checked the code again I think it uses very rarely the 
remapped video memory. If I didn't miss a big thing after having my 
recent patches applied there might be 2-3 places left that use a few 
kilobytes of it. Nothing that justifies permanently remapping the whole 
bunch. If no one speaks against it I'll try to replace this big remap 
with one or two small ones. Though this might take a while.

Any comments?


Regards,

Florian Tobias Schandinat

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
