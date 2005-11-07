From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] drivers/video/vgastate.c: kill dead code
Date: Mon, 7 Nov 2005 22:19:08 +0100
Message-ID: <20051107211908.GE3847@stusta.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EZEOY-0005Fs-PC
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Nov 2005 13:19:14 -0800
Received: from emailhub.stusta.mhn.de ([141.84.69.5] helo=mailout.stusta.mhn.de)
	by mail.sourceforge.net with smtp (Exim 4.44)
	id 1EZEOY-0000G2-6Y
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Nov 2005 13:19:14 -0800
Content-Disposition: inline
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
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

This patch kills some dead code.


Signed-off-by: Adrian Bunk <bunk@stusta.de>
Acked by: Antonino Daplas <adaplas@pol.net>

---

This patch was already sent on:
- 1 Nov 2005

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
 



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
