From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 16/20] skeletonfb: More corrections
Date: Sat, 05 May 2007 23:02:51 +0800
Message-ID: <463C9C9B.2000603@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HkMT5-0001km-MM for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 05 May 2007 08:46:46 -0700
Received: from py-out-1112.google.com ([64.233.166.180])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HkMEP-0008EN-25
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 05 May 2007 08:31:33 -0700
Received: by py-out-1112.google.com with SMTP id a29so906538pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 05 May 2007 08:31:32 -0700 (PDT)
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

From: Krzysztof Helt <krzysztof.h1@wp.pl>

More corrections to skeletonfb.c file:
- fixed types of more arguments
- removed returned values in void functions
- removed not existing fb_poll function
- fixed closing comment typo
- corrected misleading constant name ADDR

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
Acked-By: James Simmons <jsimmons@infradead.org>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/skeletonfb.c |   26 +++++---------------------
 1 files changed, 5 insertions(+), 21 deletions(-)

diff --git a/drivers/video/skeletonfb.c b/drivers/video/skeletonfb.c
index 7a7ed7d..c15b6fe 100644
--- a/drivers/video/skeletonfb.c
+++ b/drivers/video/skeletonfb.c
@@ -148,7 +148,7 @@ int xxxfb_setup(char*);
  *
  *	Returns negative errno on error, or zero on success.
  */
-static int xxxfb_open(const struct fb_info *info, int user)
+static int xxxfb_open(struct fb_info *info, int user)
 {
     return 0;
 }
@@ -167,7 +167,7 @@ static int xxxfb_open(const struct fb_in
  *
  *	Returns negative errno on error, or zero on success.
  */
-static int xxxfb_release(const struct fb_info *info, int user)
+static int xxxfb_release(struct fb_info *info, int user)
 {
     return 0;
 }
@@ -629,19 +629,6 @@ void xxxfb_rotate(struct fb_info *info, 
 }
 
 /**
- *	xxxfb_poll - NOT a required function. The purpose of this
- *		     function is to provide a way for some process
- *		     to wait until a specific hardware event occurs
- *		     for the framebuffer device.
- * 				 
- *      @info: frame buffer structure that represents a single frame buffer
- *	@wait: poll table where we store process that await a event.     
- */
-void xxxfb_poll(struct fb_info *info, poll_table *wait)
-{
-}
-
-/**
  *	xxxfb_sync - NOT a required function. Normally the accel engine 
  *		     for a graphics card take a specific amount of time.
  *		     Often we have to wait for the accelerator to finish
@@ -678,7 +665,6 @@ static struct fb_ops xxxfb_ops = {
 	.fb_imageblit	= xxxfb_imageblit,	/* Needed !!! */
 	.fb_cursor	= xxxfb_cursor,		/* Optional !!! */
 	.fb_rotate	= xxxfb_rotate,
-	.fb_poll	= xxxfb_poll,
 	.fb_sync	= xxxfb_sync,
 	.fb_ioctl	= xxxfb_ioctl,
 	.fb_mmap	= xxxfb_mmap,
@@ -692,7 +678,7 @@ static struct fb_ops xxxfb_ops = {
 
 /* static int __init xxfb_probe (struct device *device) -- for platform devs */
 static int __devinit xxxfb_probe(struct pci_dev *dev,
-			      const_struct pci_device_id *ent)
+			      const struct pci_device_id *ent)
 {
     struct fb_info *info;
     struct xxx_par *par;
@@ -858,8 +844,6 @@ static void __devexit xxxfb_remove(struc
 		/* ... */
 		framebuffer_release(info);
 	}
-
-	return 0;
 }
 
 #ifdef CONFIG_PCI
@@ -902,7 +886,7 @@ #endif /* CONFIG_PM */
 static struct pci_device_id xxxfb_id_table[] = {
 	{ PCI_VENDOR_ID_XXX, PCI_DEVICE_ID_XXX,
 	  PCI_ANY_ID, PCI_ANY_ID, PCI_BASE_CLASS_DISPLAY << 16,
-	  ADDR, 0 },
+	  PCI_CLASS_MASK, 0 },
 	{ 0, }
 };
 
@@ -1033,7 +1017,7 @@ int __init xxxfb_setup(char *options)
 {
     /* Parse user speficied options (`video=xxxfb:') */
 }
-#endif /* MODULE *?
+#endif /* MODULE */
 
 /* ------------------------------------------------------------------------- */
 


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
