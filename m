From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 09/20] arkfb: Fix compiler warnings
Date: Sat, 05 May 2007 22:55:08 +0800
Message-ID: <463C9ACC.90902@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HkMDl-00005M-Qv for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 05 May 2007 08:30:54 -0700
Received: from py-out-1112.google.com ([64.233.166.180])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HkMDl-0008EN-GF
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 05 May 2007 08:30:53 -0700
Received: by py-out-1112.google.com with SMTP id a29so906538pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 05 May 2007 08:30:53 -0700 (PDT)
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

- add sparse annotations
- check return value of pci_enable_device()
- fix if CONFIG_PM=n

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/arkfb.c |   23 ++++++++++++++++-------
 1 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/video/arkfb.c b/drivers/video/arkfb.c
index 3a0ae2b..7155508 100644
--- a/drivers/video/arkfb.c
+++ b/drivers/video/arkfb.c
@@ -131,21 +131,22 @@ MODULE_PARM_DESC(mtrr, "FIFO threshold")
 static void arkfb_settile(struct fb_info *info, struct fb_tilemap *map)
 {
 	const u8 *font = map->data;
-	u8* fb = (u8 *) info->screen_base;
+	u8 __iomem *fb = (u8 __iomem *)info->screen_base;
 	int i, c;
 
 	if ((map->width != 8) || (map->height != 16) ||
 	    (map->depth != 1) || (map->length != 256)) {
-	    	printk(KERN_ERR "fb%d: unsupported font parameters: width %d, height %d, depth %d, length %d\n",
-			info->node, map->width, map->height, map->depth, map->length);
+	    	printk(KERN_ERR "fb%d: unsupported font parameters: width %d, "
+		       "height %d, depth %d, length %d\n", info->node,
+		       map->width, map->height, map->depth, map->length);
 		return;
 	}
 
 	fb += 2;
 	for (c = 0; c < map->length; c++) {
 		for (i = 0; i < map->height; i++) {
-			fb[i * 4] = font[i];
-			fb[i * 4 + (128*8)] = font[i];
+			fb_writeb(font[i], &fb[i * 4]);
+			fb_writeb(font[i], &fb[i * 4 + (128 * 8)]);
 		}
 		fb += 128;
 
@@ -1080,6 +1081,7 @@ #endif
 }
 
 
+#ifdef CONFIG_PM
 /* PCI suspend */
 
 static int ark_pci_suspend (struct pci_dev* dev, pm_message_t state)
@@ -1131,17 +1133,24 @@ static int ark_pci_resume (struct pci_de
 
 	pci_set_power_state(dev, PCI_D0);
 	pci_restore_state(dev);
-	pci_enable_device(dev);
+
+	if (pci_enable_device(dev))
+		goto fail;
+
 	pci_set_master(dev);
 
 	arkfb_set_par(info);
 	fb_set_suspend(info, 0);
 
 	mutex_unlock(&(par->open_lock));
+fail:
 	release_console_sem();
 	return 0;
 }
-
+#else
+#define ark_pci_suspend NULL
+#define ark_pci_resume NULL
+#endif /* CONFIG_PM */
 
 /* List of boards that we are trying to support */
 


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
