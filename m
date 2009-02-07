From: Andres Salomon <dilinger@queued.net>
Subject: [PATCH 13/15] amba-clcd: fix cmap memory leaks
Date: Sat, 7 Feb 2009 12:18:48 -0500
Message-ID: <20090207121848.536b136d@ephemeral>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <dilinger@queued.net>) id 1LVqpQ-0003HU-Ai
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 07 Feb 2009 17:18:52 +0000
Received: from lunge.mit.edu ([18.54.1.69] helo=lunge.queued.net)
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LVqpP-00025K-3w for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 07 Feb 2009 17:18:52 +0000
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, adaplas@gmail.com


 - fix cmap leak in removal path
 - fix cmap leak when register_framebuffer fails

Signed-off-by: Andres Salomon <dilinger@debian.org>
---
 drivers/video/amba-clcd.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/drivers/video/amba-clcd.c b/drivers/video/amba-clcd.c
index 4e046fe..61050ab 100644
--- a/drivers/video/amba-clcd.c
+++ b/drivers/video/amba-clcd.c
@@ -408,7 +408,9 @@ static int clcdfb_register(struct clcd_fb *fb)
 	/*
 	 * Allocate colourmap.
 	 */
-	fb_alloc_cmap(&fb->fb.cmap, 256, 0);
+	ret = fb_alloc_cmap(&fb->fb.cmap, 256, 0);
+	if (ret)
+		goto unmap;
 
 	/*
 	 * Ensure interrupts are disabled.
@@ -426,6 +428,8 @@ static int clcdfb_register(struct clcd_fb *fb)
 
 	printk(KERN_ERR "CLCD: cannot register framebuffer (%d)\n", ret);
 
+	fb_dealloc_cmap(&fb->fb.cmap);
+ unmap:
 	iounmap(fb->regs);
  free_clk:
 	clk_put(fb->clk);
@@ -485,6 +489,8 @@ static int clcdfb_remove(struct amba_device *dev)
 
 	clcdfb_disable(fb);
 	unregister_framebuffer(&fb->fb);
+	if (fb->fb.cmap.len)
+		fb_dealloc_cmap(&fb->fb.cmap);
 	iounmap(fb->regs);
 	clk_put(fb->clk);
 
-- 
1.5.6.5


------------------------------------------------------------------------------
Create and Deploy Rich Internet Apps outside the browser with Adobe(R)AIR(TM)
software. With Adobe AIR, Ajax developers can use existing skills and code to
build responsive, highly engaging applications that combine the power of local
resources and data with the reach of the web. Download the Adobe AIR SDK and
Ajax docs to start building applications today-http://p.sf.net/sfu/adobe-com
