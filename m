From: Jesper Juhl <juhl-lkml@dif.dk>
Subject: [PATCH] kill problematic variable from drivers/video/fbmem.c
Date: Thu, 6 Jan 2005 00:50:38 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0501060032150.3492@dragon.hygekrogen.localhost>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262675AbVAEXll@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>


My standard config generated a new warning for me with 2.6.10-bk8 : 

  CC      drivers/video/fbmem.o
drivers/video/fbmem.c: In function `fb_set_var':
drivers/video/fbmem.c:719: warning: ISO C90 forbids mixed declarations and code

Upon investigating I saw that it was the variable 'int err' that caused it 
and I also noticed that we might as well just kill that variable.

I can see 4 reasons to get rid of this variable :

1) it causes a warning.
2) it shadows a variable of the same name in the enclosing scope.
3) it is declared after code in the block, thus causing trouble for C89 
compilers like gcc 2.95.3 that we claim to still support.
4) it is completely unnessesary since we can reuse the 'err' variable 
declared at the start of the function without any trouble.

Patch that kills off the variable below.
Patch has been compile tested and boot tested.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.10-bk8-orig/drivers/video/fbmem.c linux-2.6.10-bk8/drivers/video/fbmem.c
--- linux-2.6.10-bk8-orig/drivers/video/fbmem.c	2005-01-06 00:04:45.000000000 +0100
+++ linux-2.6.10-bk8/drivers/video/fbmem.c	2005-01-06 00:26:15.000000000 +0100
@@ -716,7 +716,6 @@ fb_set_var(struct fb_info *info, struct 
 		if ((var->activate & FB_ACTIVATE_MASK) == FB_ACTIVATE_NOW) {
 			struct fb_videomode mode;
 			info->var = *var;
-			int err = 0;
 
 			if (info->fbops->fb_set_par)
 				info->fbops->fb_set_par(info);




PS. Please keep me on CC.
