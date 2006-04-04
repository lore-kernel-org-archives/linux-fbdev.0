From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: cirrusfb on sparc32
Date: Tue, 4 Apr 2006 11:09:46 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0604041108240.32622@pademelon.sonytel.be>
References: <20060404001627.64cdc3b3.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FQhXu-0002I9-OC
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 04 Apr 2006 02:09:54 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FQhXs-0000fS-IT
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 04 Apr 2006 02:09:54 -0700
In-Reply-To: <20060404001627.64cdc3b3.akpm@osdl.org>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 4 Apr 2006, Andrew Morton wrote:
> In file included from drivers/video/cirrusfb.c:69:
> include/video/vga.h:24:21: asm/vga.h: No such file or directory

According to linux-2.6.17-rc1/arch/sparc/Kconfig:

| config PCI
|         bool "Support for PCI and PS/2 keyboard/mouse"
|         help
|           CONFIG_PCI is needed for all JavaStation's (including MrCoffee),
|           CP-1200, JavaEngine-1, Corona, Red October, and Serengeti SGSC.
|           All of these platforms are extremely obscure, so say N if unsure.

And without CONFIG_PCI and CONFIG_ZORRO, no cirrusfb.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
