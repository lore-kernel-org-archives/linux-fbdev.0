From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 5/7] nvidiafb: Delete i2c bus on driver unload
Date: Sun, 20 Mar 2005 21:09:33 +0800
Message-ID: <200503202109.33049.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DD0Ci-0001GC-Tf
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 20 Mar 2005 05:10:52 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DD0Ci-0007nE-6a
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 20 Mar 2005 05:10:52 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 56F39FB9738
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 20 Mar 2005 13:10:45 +0000 (UTC)
Content-Disposition: inline
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

The driver nvidiafb fails to delete the i2c bus on load failure or
unload.  Fix

From: Antonino Daplas <adaplas@pol.net>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 nv_i2c.c   |    2 --
 nv_of.c    |    1 +
 nv_proto.h |    2 ++
 nvidia.c   |    6 ++++--
 4 files changed, 7 insertions(+), 4 deletions(-)

diff -Nru a/drivers/video/nvidia/nv_i2c.c b/drivers/video/nvidia/nv_i2c.c
--- a/drivers/video/nvidia/nv_i2c.c	2005-03-12 23:25:10 +08:00
+++ b/drivers/video/nvidia/nv_i2c.c	2005-03-18 21:06:28 +08:00
@@ -146,7 +146,6 @@
 	nvidia_setup_i2c_bus(&par->chan[2], "BUS3");
 }
 
-#if 0
 void nvidia_delete_i2c_busses(struct nvidia_par *par)
 {
 	if (par->chan[0].par)
@@ -162,7 +161,6 @@
 	par->chan[2].par = NULL;
 
 }
-#endif  /*  0  */
 
 static u8 *nvidia_do_probe_i2c_edid(struct nvidia_i2c_chan *chan)
 {
diff -Nru a/drivers/video/nvidia/nv_of.c b/drivers/video/nvidia/nv_of.c
--- a/drivers/video/nvidia/nv_of.c	2005-03-12 23:25:11 +08:00
+++ b/drivers/video/nvidia/nv_of.c	2005-03-18 21:06:28 +08:00
@@ -28,6 +28,7 @@
 #include "nv_proto.h"
 
 void nvidia_create_i2c_busses(struct nvidia_par *par) {}
+void nvidia_delete_i2c_busses(struct nvidia_par *par) {}
 
 int nvidia_probe_i2c_connector(struct nvidia_par *par, int conn, u8 **out_edid)
 {
diff -Nru a/drivers/video/nvidia/nv_proto.h b/drivers/video/nvidia/nv_proto.h
--- a/drivers/video/nvidia/nv_proto.h	2005-03-12 23:25:12 +08:00
+++ b/drivers/video/nvidia/nv_proto.h	2005-03-18 21:06:28 +08:00
@@ -33,10 +33,12 @@
 /* in nvidia-i2c.c */
 #if defined(CONFIG_FB_NVIDIA_I2C) || defined (CONFIG_PPC_OF)
 void nvidia_create_i2c_busses(struct nvidia_par *par);
+void nvidia_delete_i2c_busses(struct nvidia_par *par);
 int nvidia_probe_i2c_connector(struct nvidia_par *par, int conn,
 			       u8 ** out_edid);
 #else
 #define nvidia_create_i2c_busses(...)
+#define nvidia_delete_i2c_busses(...)
 #define nvidia_probe_i2c_connector(p, c, edid) \
 do {                                           \
 	*(edid) = NULL;                        \
diff -Nru a/drivers/video/nvidia/nvidia.c b/drivers/video/nvidia/nvidia.c
--- a/drivers/video/nvidia/nvidia.c	2005-03-15 18:42:12 +08:00
+++ b/drivers/video/nvidia/nvidia.c	2005-03-18 21:22:39 +08:00
@@ -1566,8 +1566,9 @@
 
       err_out_iounmap_fb:
 	iounmap(info->screen_base);
-      err_out_free_base1:
 	fb_destroy_modedb(info->monspecs.modedb);
+	nvidia_delete_i2c_busses(par);
+      err_out_free_base1:
 	iounmap(par->REGS);
       err_out_free_base0:
 	pci_release_regions(pd);
@@ -1597,9 +1598,10 @@
 			 info->fix.smem_len);
 #endif				/* CONFIG_MTRR */
 
+	iounmap(info->screen_base);
 	fb_destroy_modedb(info->monspecs.modedb);
+	nvidia_delete_i2c_busses(par);
 	iounmap(par->REGS);
-	iounmap(info->screen_base);
 	pci_release_regions(pd);
 	pci_disable_device(pd);
 	kfree(info->pixmap.addr);




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
