From: Andres Salomon <dilinger@queued.net>
Subject: [PATCH 7/15] sstfb: check fb_alloc_cmap return
 value and handle failure properly
Date: Sat, 7 Feb 2009 12:14:57 -0500
Message-ID: <20090207121457.28550bdd@ephemeral>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <dilinger@queued.net>) id 1LVqlh-0001Cc-9Q
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 07 Feb 2009 17:15:01 +0000
Received: from lunge.mit.edu ([18.54.1.69] helo=lunge.queued.net)
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LVqlg-0003IB-20 for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 07 Feb 2009 17:15:01 +0000
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
 drivers/video/sstfb.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/video/sstfb.c b/drivers/video/sstfb.c
index 5b11a00..609d0a5 100644
--- a/drivers/video/sstfb.c
+++ b/drivers/video/sstfb.c
@@ -1421,13 +1421,16 @@ static int __devinit sstfb_probe(struct pci_dev *pdev,
 		goto fail;
 	}
 	
-	fb_alloc_cmap(&info->cmap, 256, 0);
+	if (fb_alloc_cmap(&info->cmap, 256, 0)) {
+		printk(KERN_ERR "sstfb: can't alloc cmap memory.\n");
+		goto fail;
+	}
 
 	/* register fb */
 	info->device = &pdev->dev;
 	if (register_framebuffer(info) < 0) {
 		printk(KERN_ERR "sstfb: can't register framebuffer.\n");
-		goto fail;
+		goto fail_register;
 	}
 
 	sstfb_clear_screen(info);
@@ -1441,8 +1444,9 @@ static int __devinit sstfb_probe(struct pci_dev *pdev,
 
 	return 0;
 
-fail:
+fail_register:
 	fb_dealloc_cmap(&info->cmap);
+fail:
 	iounmap(info->screen_base);
 fail_fb_remap:
 	iounmap(par->mmio_vbase);
-- 
1.5.6.5


------------------------------------------------------------------------------
Create and Deploy Rich Internet Apps outside the browser with Adobe(R)AIR(TM)
software. With Adobe AIR, Ajax developers can use existing skills and code to
build responsive, highly engaging applications that combine the power of local
resources and data with the reach of the web. Download the Adobe AIR SDK and
Ajax docs to start building applications today-http://p.sf.net/sfu/adobe-com
