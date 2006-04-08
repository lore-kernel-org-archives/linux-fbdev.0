From: Andrew Morton <akpm@osdl.org>
Subject: Re: nvidia on sparc32
Date: Sat, 8 Apr 2006 01:39:17 -0700
Message-ID: <20060408013917.00bd96ee.akpm@osdl.org>
References: <20060408012107.2dc6f594.akpm@osdl.org>
	<20060408.012707.80122971.davem@davemloft.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FS8zm-0004mq-U6
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 08 Apr 2006 01:40:38 -0700
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44)
	id 1FS8zl-0000Mx-OR
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 08 Apr 2006 01:40:39 -0700
In-Reply-To: <20060408.012707.80122971.davem@davemloft.net>
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
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-fbdev-devel@lists.sourceforge.net

"David S. Miller" <davem@davemloft.net> wrote:
>
> From: Andrew Morton <akpm@osdl.org>
> Date: Sat, 8 Apr 2006 01:21:07 -0700
> 
> > In file included from drivers/video/nvidia/nv_setup.c:50:                       include/video/vga.h:24:21: asm/vga.h: No such file or directory
> > 
> > Dave, do you think a copy of the sparc64 vga.h will suffice?
> 
> Sure, but none of this is ever likely to work.
> 
> FWIW, all sparc32 systems with PCI have internal devices only and no
> PCI add-in cards, and they'll never see an NVIDIA device.
> 
> So it's a different situation than sparc64 where someone could put an
> NVIDIA card into a PCI slot and we'd like that to work.
> 
> I wish there were an easy way to eliminate nonsense configuration
> combinations for a given platform.

hm, OK, thanks.  Given that it all compiles with the borrowed vga.h, I
guess the simplest thing to do is to run with that - it fixes allmodconfig,
avoids mucking up the Kconfig files and gives us wide compile coverage.

What thinkest thou?


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
