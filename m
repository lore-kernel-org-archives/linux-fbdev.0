From: Andres Salomon <dilinger@queued.net>
Subject: [PATCH 11/15] tgafb: fix cmap memory leak
Date: Sat, 7 Feb 2009 12:18:31 -0500
Message-ID: <20090207121831.11c34988@ephemeral>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754859AbZBGRSp@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com


 - fix cmap leak when register_framebuffer fails

Signed-off-by: Andres Salomon <dilinger@debian.org>
---
 drivers/video/tgafb.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/video/tgafb.c b/drivers/video/tgafb.c
index 680642c..a86046f 100644
--- a/drivers/video/tgafb.c
+++ b/drivers/video/tgafb.c
@@ -1663,7 +1663,7 @@ tgafb_register(struct device *dev)
 	if (register_framebuffer(info) < 0) {
 		printk(KERN_ERR "tgafb: Could not register framebuffer\n");
 		ret = -EINVAL;
-		goto err1;
+		goto err2;
 	}
 
 	if (tga_bus_pci) {
@@ -1682,6 +1682,8 @@ tgafb_register(struct device *dev)
 
 	return 0;
 
+ err2:
+	fb_dealloc_cmap(&info->cmap);
  err1:
 	if (mem_base)
 		iounmap(mem_base);
-- 
1.5.6.5
