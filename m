From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: tgafb broken in 2.6test9 compile
Date: Mon, 24 Nov 2003 17:38:52 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0311241110150.14603-100000@waterleaf.sonytel.be>
References: <20031123225306.GC4146@mail.nuclear-dawn.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AOJjm-0008E0-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 24 Nov 2003 08:38:58 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AOJjl-0006I8-Jt
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 24 Nov 2003 08:38:57 -0800
In-Reply-To: <20031123225306.GC4146@mail.nuclear-dawn.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dan Field <danf@nuclear-dawn.com>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Sun, 23 Nov 2003, Dan Field wrote:
> I'm trying to compile 2.6.0test9 and ran into the following error:
> 
> make[1]: `arch/alpha/kernel/asm-offsets.s' is up to date.
>   CHK     include/linux/compile.h
>     CC      drivers/video/tgafb.o
>     drivers/video/tgafb.c:83: `tgafb_pci_unregister' undeclared here
>     (not in a function)
>     drivers/video/tgafb.c:83: initializer element is not constant
>     drivers/video/tgafb.c:83: (near initialization for
>     `tgafb_driver.remove')
>     drivers/video/tgafb.c:84: initializer element is not constant
>     drivers/video/tgafb.c:84: (near initialization for `tgafb_driver')
>     drivers/video/tgafb.c: In function `tgafb_set_par':
>     drivers/video/tgafb.c:233: `color_table' undeclared (first use in
>     this function)
>     drivers/video/tgafb.c:233: (Each undeclared identifier is reported
>     only once
>     drivers/video/tgafb.c:233: for each function it appears in.)
>     drivers/video/tgafb.c:234: `default_red' undeclared (first use in
>     this function)
>     drivers/video/tgafb.c:236: `default_grn' undeclared (first use in
>     this function)
>     drivers/video/tgafb.c:238: `default_blu' undeclared (first use in
>     this function)
>     make[2]: *** [drivers/video/tgafb.o] Error 1
>     make[1]: *** [drivers/video] Error 2
>     make: *** [drivers] Error 2

Tgafb wasn't converted to the new fbdev frame work yet. It should be fixed in
James Simmons' tree:

    http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz
    bk://fbdev.bkbits.net/fbdev-2.5

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
