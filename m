From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 12712] New: s2disk hangs
	with nvidiafb
Date: Sun, 15 Feb 2009 11:17:20 -0800
Message-ID: <20090215111720.6860a225.akpm@linux-foundation.org>
References: <bug-12712-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <akpm@linux-foundation.org>) id 1LYmUa-0004Fs-JL
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 15 Feb 2009 19:17:28 +0000
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1LYmUY-0008HJ-22
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 15 Feb 2009 19:17:28 +0000
In-Reply-To: <bug-12712-10286@http.bugzilla.kernel.org/>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: bender.rodriguez@open.by
Cc: linux-fbdev-devel@lists.sourceforge.net, bugme-daemon@bugzilla.kernel.org


(switched to email.  Please respond via emailed reply-to-all, not via the
bugzilla web interface).

On Sun, 15 Feb 2009 09:41:11 -0800 (PST) bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=12712
> 
>            Summary: s2disk hangs with nvidiafb
>            Product: Drivers
>            Version: 2.5
>      KernelVersion: 2.6.29-rc5
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: high
>           Priority: P1
>          Component: Video(AGP)
>         AssignedTo: airlied@linux.ie
>         ReportedBy: bender.rodriguez@open.by

This is an fbdev problem, I guess.  I'll reassign the report.

> 
> Latest working kernel version:2.6.29-rc5
> Earliest failing kernel version:not tested

I assume what you mean here is that 2.6.29-rc5 fails, and that you're
not aware of any earlier kernel version which did not fail.


> Distribution:debian lenny
> Hardware Environment:asus f3jc
> Software Environment:
> Problem Description: s2disk hangs before switching to console ("s2disk:
> Snapshotting system" message ->REISUB) with nvidiafb.
> 
> Device Drivers -> Graphics support -> Support for frame buffer devices -> [*]
> nVidia Framebuffer Support
> dmesg.0 | grep buf
> [    1.658735] Console: switching to colour frame buffer device 160x50
> [    1.659929] nvidiafb: PCI nVidia NV1d framebuffer (64MB @ 0xC0000000)
> [    1.660386] vesafb: framebuffer at 0xc0000000, mapped to 0xfd180000, using
> 6144k, total 131072k
> [    1.660825] fb1: VESA VGA frame buffer device
> 
> hangs.
> 
> Device Drivers -> Graphics support -> Support for frame buffer devices -> []
> nVidia Framebuffer Support
> 
> dmesg | grep buf
> [    0.802424] vesafb: framebuffer at 0xc0000000, mapped to 0xf8080000, using
> 6144k, total 131072k
> [    0.862236] Console: switching to colour frame buffer device 128x48
> [    0.922487] fb0: VESA VGA frame buffer device
> 
> in this case everything works OK.
> 


------------------------------------------------------------------------------
Open Source Business Conference (OSBC), March 24-25, 2009, San Francisco, CA
-OSBC tackles the biggest issue in open source: Open Sourcing the Enterprise
-Strategies to boost innovation and cut costs with open source participation
-Receive a $600 discount off the registration fee with the source code: SFAD
http://p.sf.net/sfu/XcvMzF8H
