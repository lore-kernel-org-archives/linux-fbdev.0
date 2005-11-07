From: Adrian Bunk <bunk@stusta.de>
Subject: [RFC: 2.6 patch] i386: EXPORT_SYMBOL(screen_info) even #ifndef CONFIG_VT
Date: Mon, 7 Nov 2005 22:19:06 +0100
Message-ID: <20051107211906.GD3847@stusta.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EZEOW-0005Fk-NR
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Nov 2005 13:19:12 -0800
Received: from mailout.stusta.mhn.de ([141.84.69.5])
	by mail.sourceforge.net with smtp (Exim 4.44)
	id 1EZEOW-0007gt-45
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Nov 2005 13:19:12 -0800
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
Cc: linux-kernel@vger.kernel.org, adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net

The folllowing modules require screen_info but don't depend
on CONFIG_VT:
- vga16fb.ko
- intelfb.ko

This patch was already ACK'ed by Antonino A. Daplas.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 1 Nov 2005

--- linux-2.6.14-rc5-mm1-modular-2.95/arch/i386/kernel/setup.c.old	2005-11-01 16:10:52.000000000 +0100
+++ linux-2.6.14-rc5-mm1-modular-2.95/arch/i386/kernel/setup.c	2005-11-01 16:11:25.000000000 +0100
@@ -129,9 +129,7 @@
 EXPORT_SYMBOL(drive_info);
 #endif
 struct screen_info screen_info;
-#ifdef CONFIG_VT
 EXPORT_SYMBOL(screen_info);
-#endif
 struct apm_info apm_info;
 EXPORT_SYMBOL(apm_info);
 struct sys_desc_table_struct {



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
