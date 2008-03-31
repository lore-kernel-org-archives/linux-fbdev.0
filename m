From: Adrian Bunk <bunk@kernel.org>
Subject: [2.6.25 patch] arch/x86/video/fbdev.c: add MODULE_LICENSE
Date: Mon, 31 Mar 2008 12:07:36 +0300
Message-ID: <20080331090736.GD28445@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756092AbYCaJII@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tglx@linutronix.de, adaplas@gmail.com
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>

This patch adds the missing MODULE_LICENSE("GPL").

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---
745c0b8d5884386442d4765cae6330bfe7d459b2 diff --git a/arch/x86/video/fbdev.c b/arch/x86/video/fbdev.c
index 48fb38d..3cf2e9b 100644
--- a/arch/x86/video/fbdev.c
+++ b/arch/x86/video/fbdev.c
@@ -30,3 +30,5 @@ int fb_is_primary_device(struct fb_info *info)
 	return retval;
 }
 EXPORT_SYMBOL(fb_is_primary_device);
+
+MODULE_LICENSE("GPL");
