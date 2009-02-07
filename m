From: Andres Salomon <dilinger@queued.net>
Subject: [PATCH 8/15] stifb: check fb_alloc_cmap return
 value and handle failure properly
Date: Sat, 7 Feb 2009 12:15:06 -0500
Message-ID: <20090207121506.427d1cd8@ephemeral>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <dilinger@queued.net>) id 1LVqlq-00036Q-G2
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 07 Feb 2009 17:15:10 +0000
Received: from lunge.mit.edu ([18.54.1.69] helo=lunge.queued.net)
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LVqlp-0003KU-3f for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 07 Feb 2009 17:15:10 +0000
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@linux-foundation.org>, j
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, adaplas@gmail.com


Signed-off-by: Andres Salomon <dilinger@debian.org>
---
 drivers/video/stifb.c |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/video/stifb.c b/drivers/video/stifb.c
index 1664814..eabaad7 100644
--- a/drivers/video/stifb.c
+++ b/drivers/video/stifb.c
@@ -1262,24 +1262,25 @@ static int __init stifb_init_fb(struct sti_struct *sti, int bpp_pref)
 	info->flags = FBINFO_DEFAULT;
 	info->pseudo_palette = &fb->pseudo_palette;
 
-	/* This has to been done !!! */
-	fb_alloc_cmap(&info->cmap, NR_PALETTE, 0);
+	/* This has to be done !!! */
+	if (fb_alloc_cmap(&info->cmap, NR_PALETTE, 0))
+		goto out_err1;
 	stifb_init_display(fb);
 
 	if (!request_mem_region(fix->smem_start, fix->smem_len, "stifb fb")) {
 		printk(KERN_ERR "stifb: cannot reserve fb region 0x%04lx-0x%04lx\n",
 				fix->smem_start, fix->smem_start+fix->smem_len);
-		goto out_err1;
+		goto out_err2;
 	}
 		
 	if (!request_mem_region(fix->mmio_start, fix->mmio_len, "stifb mmio")) {
 		printk(KERN_ERR "stifb: cannot reserve sti mmio region 0x%04lx-0x%04lx\n",
 				fix->mmio_start, fix->mmio_start+fix->mmio_len);
-		goto out_err2;
+		goto out_err3;
 	}
 
 	if (register_framebuffer(&fb->info) < 0)
-		goto out_err3;
+		goto out_err4;
 
 	sti->info = info; /* save for unregister_framebuffer() */
 
@@ -1297,13 +1298,14 @@ static int __init stifb_init_fb(struct sti_struct *sti, int bpp_pref)
 	return 0;
 
 
-out_err3:
+out_err4:
 	release_mem_region(fix->mmio_start, fix->mmio_len);
-out_err2:
+out_err3:
 	release_mem_region(fix->smem_start, fix->smem_len);
+out_err2:
+	fb_dealloc_cmap(&info->cmap);
 out_err1:
 	iounmap(info->screen_base);
-	fb_dealloc_cmap(&info->cmap);
 out_err0:
 	kfree(fb);
 	return -ENXIO;
-- 
1.5.6.5


------------------------------------------------------------------------------
Create and Deploy Rich Internet Apps outside the browser with Adobe(R)AIR(TM)
software. With Adobe AIR, Ajax developers can use existing skills and code to
build responsive, highly engaging applications that combine the power of local
resources and data with the reach of the web. Download the Adobe AIR SDK and
Ajax docs to start building applications today-http://p.sf.net/sfu/adobe-com
