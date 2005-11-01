From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] drivers/video/vgastate.c: kill dead code
Date: Tue, 1 Nov 2005 21:54:06 +0100
Message-ID: <20051101205406.GA8009@stusta.de>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751182AbVKAUyL@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

This patch kills some dead code.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.14-rc5-mm1-full/drivers/video/vgastate.c.old	2005-11-01 20:40:29.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/drivers/video/vgastate.c	2005-11-01 20:40:37.000000000 +0100
@@ -485,11 +485,6 @@
 	return 0;
 }
 
-#ifdef MODULE
-int init_module(void) { return 0; };
-void cleanup_module(void) {};
-#endif
-
 EXPORT_SYMBOL(save_vga);
 EXPORT_SYMBOL(restore_vga);
 
