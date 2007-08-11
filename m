From: Michal Januszewski <spock@gentoo.org>
Subject: [PATCH 3/7] uvesafb: fix a typo in a warning
Date: Sat, 11 Aug 2007 16:40:13 +0200
Message-ID: <20070811144013.GD13632@spock.one.pl>
Reply-To: spock@gentoo.org
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761460AbXHKOkt@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org

Replace "vesafb" with "uvesafb" in a kernel warning message.

Signed-off-by: Michal Januszewski <spock@gentoo.org>
---
diff --git a/drivers/video/uvesafb.c b/drivers/video/uvesafb.c
--- a/drivers/video/uvesafb.c
+++ b/drivers/video/uvesafb.c
@@ -408,7 +412,7 @@ static void uvesafb_vbe_state_restore(struct uvesafb_par *par, u8 *state_buf)
 
 	err = uvesafb_exec(task);
 	if (err || (task->t.regs.eax & 0xffff) != 0x004f)
-		printk(KERN_WARNING "vesafb: VBE state restore call "
+		printk(KERN_WARNING "uvesafb: VBE state restore call "
 				"failed (eax=0x%x, err=%d)\n",
 				task->t.regs.eax, err);
 
