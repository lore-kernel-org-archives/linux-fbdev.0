From: Andrew Morton <akpm@osdl.org>
Subject: Re: cirrusfb on sparc32
Date: Tue, 4 Apr 2006 02:27:11 -0700
Message-ID: <20060404022711.5f79a726.akpm@osdl.org>
References: <20060404001627.64cdc3b3.akpm@osdl.org>
	<Pine.LNX.4.62.0604041108240.32622@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FQhpb-0004hy-16
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 04 Apr 2006 02:28:11 -0700
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44)
	id 1FQhpY-0006VB-F1
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 04 Apr 2006 02:28:11 -0700
In-Reply-To: <Pine.LNX.4.62.0604041108240.32622@pademelon.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> On Tue, 4 Apr 2006, Andrew Morton wrote:
> > In file included from drivers/video/cirrusfb.c:69:
> > include/video/vga.h:24:21: asm/vga.h: No such file or directory
> 
> According to linux-2.6.17-rc1/arch/sparc/Kconfig:
> 
> | config PCI
> |         bool "Support for PCI and PS/2 keyboard/mouse"
> |         help
> |           CONFIG_PCI is needed for all JavaStation's (including MrCoffee),
> |           CP-1200, JavaEngine-1, Corona, Red October, and Serengeti SGSC.
> |           All of these platforms are extremely obscure, so say N if unsure.
> 
> And without CONFIG_PCI and CONFIG_ZORRO, no cirrusfb.
> 

I have CONFIG_PCI set.  This was just `make allmodconfig'.

The problem is that sparc has no asm/vga.h.

I don't know why this has suddenly started happening.  Either these drivers
weren't previously enabled on sparc32 builds or they're newly including
video/vga.h.  I'd be suspecting the former.

Either way, sparc32 allmodconfig broke.


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
