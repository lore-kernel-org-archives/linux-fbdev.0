From: Dan Field <danf@nuclear-dawn.com>
Subject: tgafb broken in 2.6test9 compile
Date: Sun, 23 Nov 2003 22:53:06 +0000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20031123225306.GC4146@mail.nuclear-dawn.com>
Reply-To: Dan Field <danf@nuclear-dawn.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AO377-0001OP-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 23 Nov 2003 14:53:57 -0800
Received: from robotron.nuclear-dawn.com ([81.5.155.172])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AO377-0002Fr-0N
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 23 Nov 2003 14:53:57 -0800
Received: from danf by robotron.nuclear-dawn.com with local (Exim 3.36 #1 (Debian))
	id 1AO36J-00016l-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 23 Nov 2003 22:53:07 +0000
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net

Hi.

I'm trying to compile 2.6.0test9 and ran into the following error:

make[1]: `arch/alpha/kernel/asm-offsets.s' is up to date.
  CHK     include/linux/compile.h
    CC      drivers/video/tgafb.o
    drivers/video/tgafb.c:83: `tgafb_pci_unregister' undeclared here
    (not in a function)
    drivers/video/tgafb.c:83: initializer element is not constant
    drivers/video/tgafb.c:83: (near initialization for
    `tgafb_driver.remove')
    drivers/video/tgafb.c:84: initializer element is not constant
    drivers/video/tgafb.c:84: (near initialization for `tgafb_driver')
    drivers/video/tgafb.c: In function `tgafb_set_par':
    drivers/video/tgafb.c:233: `color_table' undeclared (first use in
    this function)
    drivers/video/tgafb.c:233: (Each undeclared identifier is reported
    only once
    drivers/video/tgafb.c:233: for each function it appears in.)
    drivers/video/tgafb.c:234: `default_red' undeclared (first use in
    this function)
    drivers/video/tgafb.c:236: `default_grn' undeclared (first use in
    this function)
    drivers/video/tgafb.c:238: `default_blu' undeclared (first use in
    this function)
    make[2]: *** [drivers/video/tgafb.o] Error 1
    make[1]: *** [drivers/video] Error 2
    make: *** [drivers] Error 2
    


I tried adding #include <linux/selection.h> as pointed out at the
following URL

http://www.ussg.iu.edu/hypermail/linux/kernel/0309.2/0027.html

but then got this:

make[1]: `arch/alpha/kernel/asm-offsets.s' is up to date.
  CHK     include/linux/compile.h
    CC      drivers/video/tgafb.o
    drivers/video/tgafb.c:84: `tgafb_pci_unregister' undeclared here
    (not in a function)
    drivers/video/tgafb.c:84: initializer element is not constant
    drivers/video/tgafb.c:84: (near initialization for
    `tgafb_driver.remove')
    drivers/video/tgafb.c:85: initializer element is not constant
    drivers/video/tgafb.c:85: (near initialization for `tgafb_driver')
    make[2]: *** [drivers/video/tgafb.o] Error 1
    make[1]: *** [drivers/video] Error 2
    make: *** [drivers] Error 2
    
-- 
Dan Field <danf@nuclear-dawn.com>

http://www.nuclear-dawn.com/ - Drunk on the Lawn in a Nuclear Dawn


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
