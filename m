From: "Marijn Kruisselbrink" <marijnk@gmx.co.uk>
Subject: [PATCH] fix for drivers/video/logo/Makefile
Date: Mon, 31 Mar 2003 20:22:10 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <HJEOKOJLKINBOCDGFDOOOEPECEAA.marijnk@gmx.co.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, James Simmons <jsimmons@infradead.org>
Cc: torvalds@transmeta.com

The fb-logo *.c files are not deleted on a make clean; this patch fixes
this.

Marijn Kruisselbrink

diff -urN linux-2.5.66/drivers/video/logo/Makefile
linux/drivers/video/logo/Makefile
--- linux-2.5.66/drivers/video/logo/Makefile	Mon Mar 31 16:37:09 2003
+++ linux/drivers/video/logo/Makefile	Mon Mar 31 17:06:29 2003
@@ -25,3 +25,6 @@
 $(obj)/%_gray256.c:	$(src)/%_gray256.pgm
 		$(objtree)/scripts/pnmtologo -t gray256 -n $*_gray256 -o $@ $<

+
+# Files generated that shall be removed upon make clean
+clean-files := *_mono.c *_vga16.c *_clut224.c *_gray256.c
