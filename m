From: Richard Purdie <rpurdie@rpsys.net>
Subject: [patch] w100fb: make blanking function interrupt safe
Date: Wed, 26 Jan 2005 21:01:43 +0000
Message-ID: <200501262101.43156.rpurdie@rpsys.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CtuIb-0005eP-02
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 26 Jan 2005 13:02:01 -0800
Received: from tim.rpsys.net ([194.106.48.114] ident=0)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CtuIZ-0007ab-1W
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 26 Jan 2005 13:02:00 -0800
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
To: "adaplas@hotpop.com" <adaplas@hotpop.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

w100fb bugfix: The blanking function used vmalloc/vfree which isn't 
interrupt safe. To avoid problems, switch to kmalloc/kfree and
use several buffers to avoid kmalloc size limitations.

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>

Index: linux-2.6.11-rc2/drivers/video/w100fb.c
===================================================================
--- linux-2.6.11-rc2.orig/drivers/video/w100fb.c	2005-01-22 01:48:35.000000000 +0000
+++ linux-2.6.11-rc2/drivers/video/w100fb.c	2005-01-26 20:45:40.381370304 +0000
@@ -22,7 +22,6 @@
 #include <linux/device.h>
 #include <linux/string.h>
 #include <linux/proc_fs.h>
-#include <linux/vmalloc.h>
 #include <asm/io.h>
 #include <asm/uaccess.h>
 #include <video/w100fb.h>
@@ -90,8 +89,6 @@
 
 static struct w100fb_par *current_par;
 
-static u16 *gSaveImagePtr = NULL;
-
 /* Remapped addresses for base cfg, memmapped regs and the frame buffer itself */
 static void *remapped_base;
 static void *remapped_regs;
@@ -494,42 +491,56 @@
 }
 
 
+/* Need to split up the buffers to stay within the limits of kmalloc */
+#define W100_BUF_NUM	6
+static uint32_t *gSaveImagePtr[W100_BUF_NUM] = { NULL };
+
 static void w100fb_save_buffer(void)
 {
-	int i;
-
-	if (gSaveImagePtr != NULL) {
-		vfree(gSaveImagePtr);
-		gSaveImagePtr = NULL;
-	}
-	gSaveImagePtr = vmalloc(current_par->xres * current_par->yres * BITS_PER_PIXEL / 8);
-	if (gSaveImagePtr != NULL) {
-		for (i = 0; i < (current_par->xres * current_par->yres); i++)
-			*(gSaveImagePtr + i) = readw(remapped_fbuf + (2*i));
-	} else {
-		printk(KERN_WARNING "can't alloc pre-off image buffer\n");
+	int i, j, bufsize;
+
+	bufsize=(current_par->xres * current_par->yres * BITS_PER_PIXEL / 8) / W100_BUF_NUM;
+	for (i = 0; i < W100_BUF_NUM; i++) {
+		if (gSaveImagePtr[i] == NULL) 
+			gSaveImagePtr[i] = kmalloc(bufsize, GFP_KERNEL);
+		if (gSaveImagePtr[i] == NULL) {
+			w100fb_clear_buffer();
+			printk(KERN_WARNING "can't alloc pre-off image buffer %d\n", i);
+			break;
+		}
+		for (j = 0; j < bufsize/4; j++)
+			*(gSaveImagePtr[i] + j) = readl(remapped_fbuf + (bufsize*i) + j*4);
 	}
 }
 
 
 static void w100fb_restore_buffer(void)
 {
-	int i;
-
-	if (gSaveImagePtr != NULL) {
-		for (i = 0; i < (current_par->xres * current_par->yres); i++) {
-				writew(*(gSaveImagePtr + i),remapped_fbuf + (2*i));
-			}
-		vfree(gSaveImagePtr);
-		gSaveImagePtr = NULL;
+	int i, j, bufsize;
+
+	bufsize=(current_par->xres * current_par->yres * BITS_PER_PIXEL / 8) / W100_BUF_NUM;
+	for (i = 0; i < W100_BUF_NUM; i++) {
+		if (gSaveImagePtr[i] == NULL) {
+			printk(KERN_WARNING "can't find pre-off image buffer %d\n", i); 
+			w100fb_clear_buffer();
+			break;
+		}
+		for (j = 0; j < (bufsize/4); j++)
+			writel(*(gSaveImagePtr[i] + j),remapped_fbuf + (bufsize*i) + (j*4));
+		kfree(gSaveImagePtr[i]);
+		gSaveImagePtr[i] = NULL;
 	}
 }
 
+
 static void w100fb_clear_buffer(void)
 {
-	if (gSaveImagePtr != NULL) {
-		vfree(gSaveImagePtr);
-		gSaveImagePtr = NULL;
+	int i;
+	for (i = 0; i < W100_BUF_NUM; i++) {
+		if (gSaveImagePtr[i] != NULL) {
+			kfree(gSaveImagePtr[i]);
+			gSaveImagePtr[i] = NULL;
+		}
 	}
 }
 



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
