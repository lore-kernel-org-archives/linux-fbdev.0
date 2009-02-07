From: Andres Salomon <dilinger@queued.net>
Subject: [PATCH 12/15] 68328fb: fix cmap memory leaks
Date: Sat, 7 Feb 2009 12:18:40 -0500
Message-ID: <20090207121840.5138cb3d@ephemeral>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <dilinger@queued.net>) id 1LVqpI-0003G4-7E
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 07 Feb 2009 17:18:44 +0000
Received: from lunge.mit.edu ([18.54.1.69] helo=lunge.queued.net)
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LVqpG-00021e-WF for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 07 Feb 2009 17:18:44 +0000
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
 - check return value of fb_alloc_cmap

Signed-off-by: Andres Salomon <dilinger@debian.org>
---
 drivers/video/68328fb.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/video/68328fb.c b/drivers/video/68328fb.c
index 7f907fb..0b17824 100644
--- a/drivers/video/68328fb.c
+++ b/drivers/video/68328fb.c
@@ -471,9 +471,11 @@ int __init mc68x328fb_init(void)
 	fb_info.pseudo_palette = &mc68x328fb_pseudo_palette;
 	fb_info.flags = FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN;
 
-	fb_alloc_cmap(&fb_info.cmap, 256, 0);
+	if (fb_alloc_cmap(&fb_info.cmap, 256, 0))
+		return -ENOMEM;
 
 	if (register_framebuffer(&fb_info) < 0) {
+		fb_dealloc_cmap(&fb_info.cmap);
 		return -EINVAL;
 	}
 
@@ -494,6 +496,7 @@ module_init(mc68x328fb_init);
 static void __exit mc68x328fb_cleanup(void)
 {
 	unregister_framebuffer(&fb_info);
+	fb_dealloc_cmap(&fb_info.cmap);
 }
 
 module_exit(mc68x328fb_cleanup);
-- 
1.5.6.5


------------------------------------------------------------------------------
Create and Deploy Rich Internet Apps outside the browser with Adobe(R)AIR(TM)
software. With Adobe AIR, Ajax developers can use existing skills and code to
build responsive, highly engaging applications that combine the power of local
resources and data with the reach of the web. Download the Adobe AIR SDK and
Ajax docs to start building applications today-http://p.sf.net/sfu/adobe-com
