From: Andrew Morton <akpm@osdl.org>
Subject: atyfb on sparc32
Date: Sat, 8 Apr 2006 01:09:25 -0700
Message-ID: <20060408010925.3b1ee060.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FS8Wp-0001nZ-8L
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 08 Apr 2006 01:10:43 -0700
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44)
	id 1FS8Wo-0001xm-RU
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 08 Apr 2006 01:10:43 -0700
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k388AftH025997
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 8 Apr 2006 01:10:42 -0700
Received: from bix (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id k388AeXB024766
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 8 Apr 2006 01:10:41 -0700
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
To: linux-fbdev-devel@lists.sourceforge.net

drivers/video/aty/atyfb_base.c: In function `atyfb_ioctl':
drivers/video/aty/atyfb_base.c:1752: error: `FBTYPE_PCI_GENERIC' undeclared (first use in this function)
drivers/video/aty/atyfb_base.c:1752: error: (Each undeclared identifier is reported only once
drivers/video/aty/atyfb_base.c:1752: error: for each function it appears in.)
drivers/video/aty/atyfb_base.c: In function `atyfb_mmap':
drivers/video/aty/atyfb_base.c:1869: warning: integer constant is too large for "unsigned long" type
drivers/video/aty/atyfb_base.c: In function `atyfb_setup_sparc':
drivers/video/aty/atyfb_base.c:2893: error: `_PAGE_CACHE' undeclared (first use in this function)
drivers/video/aty/atyfb_base.c:2894: error: `_PAGE_E' undeclared (first use in this function)
drivers/video/aty/atyfb_base.c:2907: error: `_PAGE_IE' undeclared (first use in this function)
drivers/video/aty/atyfb_base.c: In function `atyfb_pci_probe':
drivers/video/aty/atyfb_base.c:3466: warning: integer constant is too large for "unsigned long" type
drivers/video/aty/atyfb_base.c:3466: warning: large integer implicitly truncated to unsigned type
drivers/video/aty/atyfb_base.c:3469: error: `_PAGE_CACHE' undeclared (first use in this function)
drivers/video/aty/atyfb_base.c:3470: error: `_PAGE_E' undeclared (first use in this function)


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
