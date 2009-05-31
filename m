From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] fbdev: use framebuffer_relase for
 freeing fb_info structures
Date: Sun, 31 May 2009 16:18:08 +0200
Message-ID: <20090531161808.af09b248.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1MAlkv-0000af-Ez
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 31 May 2009 14:11:21 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MAlks-0001TK-Q9 for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 31 May 2009 14:11:21 +0000
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@linux-foundation.org>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Use the framebuffer_relase() for freeing fb_info structures
allocated with framebuffer_alloc().

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

This is just a clean up. The patch does not fix any existing bugs. 
It is not for the 2.6.30 release.

 drivers/video/offb.c         |    2 +-
 drivers/video/pm2fb.c        |    2 +-
 drivers/video/sis/sis_main.c |    4 ++--
 drivers/video/stifb.c        |    2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/video/offb.c b/drivers/video/offb.c
index bb915a4..4d8c54c 100644
--- a/drivers/video/offb.c
+++ b/drivers/video/offb.c
@@ -493,7 +493,7 @@ static void __init offb_init_fb(const char *name, const char *full_name,
 		iounmap(par->cmap_adr);
 		par->cmap_adr = NULL;
 		iounmap(info->screen_base);
-		kfree(info);
+		framebuffer_release(info);
 		release_mem_region(res_start, res_size);
 		return;
 	}
diff --git a/drivers/video/pm2fb.c b/drivers/video/pm2fb.c
index c6dd924..36436ee 100644
--- a/drivers/video/pm2fb.c
+++ b/drivers/video/pm2fb.c
@@ -1748,7 +1748,7 @@ static void __devexit pm2fb_remove(struct pci_dev *pdev)
 	pci_set_drvdata(pdev, NULL);
 	fb_dealloc_cmap(&info->cmap);
 	kfree(info->pixmap.addr);
-	kfree(info);
+	framebuffer_release(info);
 }
 
 static struct pci_device_id pm2fb_id_table[] = {
diff --git a/drivers/video/sis/sis_main.c b/drivers/video/sis/sis_main.c
index 7e17ee9..7072d19 100644
--- a/drivers/video/sis/sis_main.c
+++ b/drivers/video/sis/sis_main.c
@@ -5928,7 +5928,7 @@ sisfb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		if(pci_enable_device(pdev)) {
 			if(ivideo->nbridge) pci_dev_put(ivideo->nbridge);
 			pci_set_drvdata(pdev, NULL);
-			kfree(sis_fb_info);
+			framebuffer_release(sis_fb_info);
 			return -EIO;
 		}
 	}
@@ -6134,7 +6134,7 @@ error_3:	vfree(ivideo->bios_abase);
 		pci_set_drvdata(pdev, NULL);
 		if(!ivideo->sisvga_enabled)
 			pci_disable_device(pdev);
-		kfree(sis_fb_info);
+		framebuffer_release(sis_fb_info);
 		return ret;
 	}
 
diff --git a/drivers/video/stifb.c b/drivers/video/stifb.c
index eabaad7..d25c75c 100644
--- a/drivers/video/stifb.c
+++ b/drivers/video/stifb.c
@@ -1380,7 +1380,7 @@ stifb_cleanup(void)
 				if (info->screen_base)
 					iounmap(info->screen_base);
 		        fb_dealloc_cmap(&info->cmap);
-		        kfree(info); 
+		        framebuffer_release(info); 
 		}
 		sti->info = NULL;
 	}
-- 
1.6.0.3


----------------------------------------------------------------------
Apartamenty z widokiem na morze!
Sprawdz >>> http://link.interia.pl/f21a4


------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT 
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp as they present alongside digital heavyweights like Barbarian 
Group, R/GA, & Big Spaceship. http://p.sf.net/sfu/creativitycat-com 
