From: Andrew Walrond <andrew@walrond.org>
Subject: [PATCH: 2.6.10-rc2] fbdev: Fix rivafb breakage (typo introduced by cset 1.2563)
Date: Thu, 18 Nov 2004 12:39:18 +0000
Message-ID: <200411181239.18093.andrew@walrond.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262754AbUKRMjc@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, linux-kernel@vger.kernel.org

Fix typo introduced during changes to use NV_ macros,
which caused screen corruption when using rivafb

signed-off-by: Andrew Walrond <andrew@walrond.org>


diff -Nru a/drivers/video/riva/riva_hw.c b/drivers/video/riva/riva_hw.c
--- a/drivers/video/riva/riva_hw.c      2004-11-18 12:32:15 +00:00
+++ b/drivers/video/riva/riva_hw.c      2004-11-18 12:32:15 +00:00
@@ -1556,7 +1556,7 @@
         NV_WR32(chip->PGRAPH, 0x0000085C, state->pitch3);
         NV_WR32(chip->PGRAPH, 0x00000860, state->pitch3);
         NV_WR32(chip->PGRAPH, 0x00000864, state->pitch3);
-        NV_WR32(chip->PGRAPH, 0x000009A, NV_RD32(chip->PFB, 0x00000200));
+        NV_WR32(chip->PGRAPH, 0x000009A4, NV_RD32(chip->PFB, 0x00000200));
         NV_WR32(chip->PGRAPH, 0x000009A8, NV_RD32(chip->PFB, 0x00000204));
         }
             if(chip->twoHeads) {
