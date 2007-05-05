From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 10/20] vt8623fb: Fix compile warnings
Date: Sat, 05 May 2007 22:55:51 +0800
Message-ID: <463C9AF7.508@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HkMDo-00005e-Eu for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 05 May 2007 08:30:56 -0700
Received: from py-out-1112.google.com ([64.233.166.180])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HkMDn-0008EN-3q
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 05 May 2007 08:30:56 -0700
Received: by py-out-1112.google.com with SMTP id a29so906538pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 05 May 2007 08:30:54 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

- use memset_io()
- check for return value of pci_enable_device()
- fix for CONFIG_PM=n

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/vt8623fb.c |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/video/vt8623fb.c b/drivers/video/vt8623fb.c
index 4979af2..414e76b 100644
--- a/drivers/video/vt8623fb.c
+++ b/drivers/video/vt8623fb.c
@@ -497,7 +497,7 @@ static int vt8623fb_set_par(struct fb_in
 			 (info->var.vmode & FB_VMODE_DOUBLE) ? 2 : 1, 1,
 			 1, info->node);
 
-	memset((u8*)info->screen_base, 0x00, screen_size);
+	memset_io(info->screen_base, 0x00, screen_size);
 
 	/* Device and screen back on */
 	svga_wcrt_mask(0x17, 0x80, 0x80);
@@ -804,6 +804,7 @@ #endif
 }
 
 
+#ifdef CONFIG_PM
 /* PCI suspend */
 
 static int vt8623_pci_suspend(struct pci_dev* dev, pm_message_t state)
@@ -855,18 +856,25 @@ static int vt8623_pci_resume(struct pci_
 
 	pci_set_power_state(dev, PCI_D0);
 	pci_restore_state(dev);
-	pci_enable_device(dev);
+
+	if (pci_enable_device(dev))
+		goto fail;
+
 	pci_set_master(dev);
 
 	vt8623fb_set_par(info);
 	fb_set_suspend(info, 0);
 
 	mutex_unlock(&(par->open_lock));
+fail:
 	release_console_sem();
 
 	return 0;
 }
-
+#else
+#define vt8623_pci_suspend NULL
+#define vt8623_pci_resume NULL
+#endif /* CONFIG_PM */
 
 /* List of boards that we are trying to support */


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
