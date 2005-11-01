From: Adrian Bunk <bunk@stusta.de>
Subject: [RFC: 2.6 patch] i386: EXPORT_SYMBOL(screen_info) even #ifndef CONFIG_VT
Date: Tue, 1 Nov 2005 16:22:08 +0100
Message-ID: <20051101152207.GT8009@stusta.de>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750863AbVKAPWQ@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net

The folllowing modules require screen_info but don't depend
on CONFIG_VT:
- vga16fb.ko
- intelfb.ko


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

Is this patch OK or should the drivers depend on VT?

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
