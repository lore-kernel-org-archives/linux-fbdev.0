From: James Simmons <jsimmons@infradead.org>
Subject: Re: fbdv/fbcon pending problems
Date: Mon, 23 Feb 2004 22:18:06 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0402232217020.11599-100000@phoenix.infradead.org>
References: <20040223203528.E433@Marvin.DL8BCU.ampr.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AvOWo-0003wy-If
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 23 Feb 2004 14:26:18 -0800
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1AvOOx-00029z-UN
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 23 Feb 2004 14:18:12 -0800
In-Reply-To: <20040223203528.E433@Marvin.DL8BCU.ampr.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thorsten Kranzkowski <dl8bcu@dl8bcu.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel list <linux-kernel@vger.kernel.org>


> Question: Is fbdev supposed to work without BIOS? 

It depends on the driver. Unfortunely most hardware companies will not 
give you info on how to boot a card BIOS-less :-( I do have code for the 
XL ati card to boot BIOS-less but it needs some work.


> 
> I have an ATI Technologies Inc 3D Rage Pro 215GP in an Alpha AXPpci33,
> currently running with MILO as firmware/bootloader. 
> For several reasons I want to change to the original SRM firmware. 
> Unfortunately its intel_cpu/BIOS emulation locks up on the ATI BIOS. With
> the BIOS disabled the SRM succeeds loading the kernel. fbdev seems to
> initialize _something_, i.e. the monitor wakes up ans displays a stable
> repeating pattern of vertical stripes. But it hangs the machine after
> these lines on serial console:
> 
> fb0: ATY Mach64 frame buffer device on PCI
> Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
> 
> Booting the same kernel image (2.6.[13]) with MILO (which has a different
> cpu emulation that succeeds executing the BIOS) works fine with fbdev. 
> 
> Bye,
> Thorsten
> 
> 



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
