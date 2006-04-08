From: "David S. Miller" <davem@davemloft.net>
Subject: Re: nvidia on sparc32
Date: Sat, 08 Apr 2006 01:27:07 -0700 (PDT)
Message-ID: <20060408.012707.80122971.davem@davemloft.net>
References: <20060408012107.2dc6f594.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FS8mk-0003US-Ar
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 08 Apr 2006 01:27:10 -0700
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net
	([216.27.180.168] helo=sunset.davemloft.net ident=Debian-exim)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1FS8mj-0002uf-5m
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 08 Apr 2006 01:27:10 -0700
In-Reply-To: <20060408012107.2dc6f594.akpm@osdl.org>
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
Content-Type: Text/Plain; charset="us-ascii"
To: akpm@osdl.org
Cc: linux-fbdev-devel@lists.sourceforge.net

From: Andrew Morton <akpm@osdl.org>
Date: Sat, 8 Apr 2006 01:21:07 -0700

> In file included from drivers/video/nvidia/nv_setup.c:50:                       include/video/vga.h:24:21: asm/vga.h: No such file or directory
> 
> Dave, do you think a copy of the sparc64 vga.h will suffice?

Sure, but none of this is ever likely to work.

FWIW, all sparc32 systems with PCI have internal devices only and no
PCI add-in cards, and they'll never see an NVIDIA device.

So it's a different situation than sparc64 where someone could put an
NVIDIA card into a PCI slot and we'd like that to work.

I wish there were an easy way to eliminate nonsense configuration
combinations for a given platform.


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
