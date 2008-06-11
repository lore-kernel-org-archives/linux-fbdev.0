From: John Summerfield <reluctanthacker@js.id.au>
Subject: Intelfb, Q965 etc etc
Date: Thu, 12 Jun 2008 00:45:15 +0800
Message-ID: <4850011B.6030202@js.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K6TRv-0000c3-ST for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 11 Jun 2008 09:45:32 -0700
Received: from dsl-58-6-192-22.wa.westnet.com.au ([58.6.192.22] helo=js.id.au)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K6TRr-0003Xa-Ro
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 11 Jun 2008 09:45:25 -0700
Received: from ns.demo.lan (unknown [192.168.4.10])
	by js.id.au (Postfix) with ESMTP id 7B4FA3B0003
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 12 Jun 2008 00:45:16 +0800 (WST)
Received: from [192.168.9.131] (Numbat.demo.lan [192.168.9.131])
	by ns.demo.lan (Postfix) with ESMTP id 16762478D62
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 12 Jun 2008 00:45:16 +0800 (WST)
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
To: linux-fbdev-devel@lists.sourceforge.net

I have an HP DC7700 on which I wish to run SL5, a RHEL clone and xen. I
also wish to have framebuffer support whilst XEN is running.

I can do that with an IBM Thinkcentre with this video:
21:16 [summer@numbat ~]$ lspci -v -s 00:02.0
00:02.0 VGA compatible controller: Intel Corporation 82865G Integrated
Graphics Controller (rev 02) (prog-if 00 [VGA])
         Subsystem: IBM Unknown device 0285
         Flags: bus master, fast devsel, latency 0, IRQ 17
         Memory at f0000000 (32-bit, prefetchable) [size=128M]
         Memory at e8000000 (32-bit, non-prefetchable) [size=512K]
         I/O ports at 1800 [size=8]
         Capabilities: <access denied>

21:17 [summer@numbat ~]$

I simply modprobe intelfb and all works well, despite nasturtiums cast
on this list.

I've noticed that intelfb does not support the graphics on my HP box:
[summer@bobtail ~]$ lspci -v -s 00:02.0
00:02.0 VGA compatible controller: Intel Corporation 82Q963/Q965
Integrated Graphics Controller (rev 02) (prog-if 00 [VGA])
         Subsystem: Hewlett-Packard Company Unknown device 2801
         Flags: bus master, fast devsel, latency 0, IRQ 21
         Memory at f0400000 (32-bit, non-prefetchable) [size=1M]
         Memory at e0000000 (64-bit, prefetchable) [size=256M]
         I/O ports at 1100 [size=8]
         Capabilities: <access denied>

[summer@bobtail ~]$

I don't know much at all about these things, but it seemed a fair bet
that a '945G driver might work, so I did some hacking on intelfb and
I've booted.

The good news is that "modprobe intelfb" doesn't hang the system; the
screen goes powersaving, which given the gas supply here (Thankyou
Apache), is probably a good thing.

fbset finds a framebuffer driver and all seems well, better than it
should be:-) Except for the blank screen.

Time to call for help I think. But first:
http://sourceforge.net/mailarchive/forum.php?thread_name=4815EEB4.2060509%40frugalware.org&forum_name=linux-fbdev-devel 


says that intelfb isn't really being maintained, and that clever souls
are working on a replacement.

Now, that _was_ about six weeks ago.

vesafb (which I discovered cannot be compiled as a module) drives it
fine with standard (not XEN) kernels.

I have a similar system running F9 and it's fine _but_ it's so long
since I had a working kernel-xen in Fedora that I don't recall whether I
had XEN and framebuffer.

Since I wish to run SL5, I really should stay with 2.6.18 kernels.

Before I post the copious kernel messages I have and the patch for
others' perusal, what does the list recommend?





-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
