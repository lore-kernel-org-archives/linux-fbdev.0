From: Andres Salomon <dilinger@queued.net>
Subject: [PATCH 10/15] sunxvr500: fix cmap memory leaks
Date: Sat, 7 Feb 2009 12:15:40 -0500
Message-ID: <20090207121540.0e618d0f@ephemeral>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <dilinger@queued.net>) id 1LVqmP-0001tn-35
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 07 Feb 2009 17:15:45 +0000
Received: from lunge.mit.edu ([18.54.1.69] helo=lunge.queued.net)
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LVqmN-0007Cr-PU for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 07 Feb 2009 17:15:45 +0000
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
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, adaplas@gmail.comj


 - fix cmap leak in removal path
 - fix cmap leak when register_framebuffer fails

Signed-off-by: Andres Salomon <dilinger@debian.org>
---
 drivers/video/sunxvr500.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/video/sunxvr500.c b/drivers/video/sunxvr500.c
index c2ba51b..18b9507 100644
--- a/drivers/video/sunxvr500.c
+++ b/drivers/video/sunxvr500.c
@@ -349,11 +349,14 @@ static int __devinit e3d_pci_register(struct pci_dev *pdev,
 	if (err < 0) {
 		printk(KERN_ERR "e3d: Could not register framebuffer %s\n",
 		       pci_name(pdev));
-		goto err_unmap_fb;
+		goto err_free_cmap;
 	}
 
 	return 0;
 
+err_free_cmap:
+	fb_dealloc_cmap(&info->cmap);
+
 err_unmap_fb:
 	iounmap(ep->fb_base);
 
@@ -389,6 +392,7 @@ static void __devexit e3d_pci_unregister(struct pci_dev *pdev)
 	pci_release_region(pdev, 0);
 	pci_release_region(pdev, 1);
 
+	fb_dealloc_cmap(&info->cmap);
         framebuffer_release(info);
 
 	pci_disable_device(pdev);
-- 
1.5.6.5


------------------------------------------------------------------------------
Create and Deploy Rich Internet Apps outside the browser with Adobe(R)AIR(TM)
software. With Adobe AIR, Ajax developers can use existing skills and code to
build responsive, highly engaging applications that combine the power of local
resources and data with the reach of the web. Download the Adobe AIR SDK and
Ajax docs to start building applications today-http://p.sf.net/sfu/adobe-com
