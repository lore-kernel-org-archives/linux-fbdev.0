From: Andres Salomon <dilinger@queued.net>
Subject: [PATCH 14/15] amifb: check fb_alloc_cmap return
 value and handle failure properly
Date: Sat, 7 Feb 2009 12:18:57 -0500
Message-ID: <20090207121857.6bc5d5bc@ephemeral>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <dilinger@queued.net>) id 1LVqpZ-0001Lc-9L
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 07 Feb 2009 17:19:01 +0000
Received: from lunge.mit.edu ([18.54.1.69] helo=lunge.queued.net)
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LVqpX-0004zA-Ts for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 07 Feb 2009 17:19:01 +0000
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


Signed-off-by: Andres Salomon <dilinger@debian.org>
---
 drivers/video/amifb.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/video/amifb.c b/drivers/video/amifb.c
index 100f236..82bedd7 100644
--- a/drivers/video/amifb.c
+++ b/drivers/video/amifb.c
@@ -2437,7 +2437,9 @@ default_chipset:
 		goto amifb_error;
 	}
 
-	fb_alloc_cmap(&fb_info.cmap, 1<<fb_info.var.bits_per_pixel, 0);
+	err = fb_alloc_cmap(&fb_info.cmap, 1<<fb_info.var.bits_per_pixel, 0);
+	if (err)
+		goto amifb_error;
 
 	if (register_framebuffer(&fb_info) < 0) {
 		err = -EINVAL;
@@ -2456,7 +2458,8 @@ amifb_error:
 
 static void amifb_deinit(void)
 {
-	fb_dealloc_cmap(&fb_info.cmap);
+	if (fb_info.cmap.len)
+		fb_dealloc_cmap(&fb_info.cmap);
 	chipfree();
 	if (videomemory)
 		iounmap((void*)videomemory);
-- 
1.5.6.5


------------------------------------------------------------------------------
Create and Deploy Rich Internet Apps outside the browser with Adobe(R)AIR(TM)
software. With Adobe AIR, Ajax developers can use existing skills and code to
build responsive, highly engaging applications that combine the power of local
resources and data with the reach of the web. Download the Adobe AIR SDK and
Ajax docs to start building applications today-http://p.sf.net/sfu/adobe-com
