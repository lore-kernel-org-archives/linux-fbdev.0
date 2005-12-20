From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 6/9] i810fb: Fix suspend and resume hooks
Date: Tue, 20 Dec 2005 20:50:38 +0800
Message-ID: <43A7FE1E.4000001@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EoyFD-0002CX-Ox
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 20 Dec 2005 23:18:39 -0800
Received: from zproxy.gmail.com ([64.233.162.201])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EoyFD-0005tJ-BD
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 20 Dec 2005 23:18:39 -0800
Received: by zproxy.gmail.com with SMTP id r28so82174nza
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 20 Dec 2005 23:18:39 -0800 (PST)
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

The i810fb suspend and resume hooks have suffered bitrot over time.
Update to current framework, but functionality still not guaranteed to
work.
    
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/i810/i810_main.c |   56 ++++++++++++++++++++--------------------
 1 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/video/i810/i810_main.c b/drivers/video/i810/i810_main.c
index 4954a8e..266d0ab 100644
--- a/drivers/video/i810/i810_main.c
+++ b/drivers/video/i810/i810_main.c
@@ -42,6 +42,7 @@
 #include <linux/pci_ids.h>
 #include <linux/resource.h>
 #include <linux/unistd.h>
+#include <linux/console.h>
 
 #include <asm/io.h>
 #include <asm/div64.h>
@@ -1558,35 +1559,28 @@ static int i810fb_suspend(struct pci_dev
 {
 	struct fb_info *info = pci_get_drvdata(dev);
 	struct i810fb_par *par = info->par;
-	int blank = 0, prev_state = par->cur_state;
-
-	if (state.event == prev_state)
-		return 0;
 
 	par->cur_state = state.event;
 
-	switch (state.event) {
-	case 1:
-		blank = VESA_VSYNC_SUSPEND;
-		break;
-	case 2:
-		blank = VESA_HSYNC_SUSPEND;
-		break;
-	case 3:
-		blank = VESA_POWERDOWN;
-		break;
-	default:
-		return -EINVAL;
+	if (state.event == PM_EVENT_FREEZE) {
+		dev->dev.power.power_state = state;
+		return 0;
 	}
-	info->fbops->fb_blank(blank, info);
 
-	if (!prev_state) { 
-		agp_unbind_memory(par->i810_gtt.i810_fb_memory);
-		agp_unbind_memory(par->i810_gtt.i810_cursor_memory);
-		pci_disable_device(dev);
-	}
+	acquire_console_sem();
+	fb_set_suspend(info, 1);
+
+	if (info->fbops->fb_sync)
+		info->fbops->fb_sync(info);
+
+	i810fb_blank(FB_BLANK_POWERDOWN, info);
+	agp_unbind_memory(par->i810_gtt.i810_fb_memory);
+	agp_unbind_memory(par->i810_gtt.i810_cursor_memory);
+
 	pci_save_state(dev);
+	pci_disable_device(dev);
 	pci_set_power_state(dev, pci_choose_state(dev, state));
+	release_console_sem();
 
 	return 0;
 }
@@ -1595,22 +1589,28 @@ static int i810fb_resume(struct pci_dev 
 {
 	struct fb_info *info = pci_get_drvdata(dev);
 	struct i810fb_par *par = info->par;
+	int cur_state = par->cur_state;
+
+	par->cur_state = PM_EVENT_ON;
 
-	if (par->cur_state == 0)
+	if (cur_state == PM_EVENT_FREEZE) {
+		pci_set_power_state(dev, PCI_D0);
 		return 0;
+	}
 
-	pci_restore_state(dev);
+	acquire_console_sem();
 	pci_set_power_state(dev, PCI_D0);
+	pci_restore_state(dev);
 	pci_enable_device(dev);
+	pci_set_master(dev);
 	agp_bind_memory(par->i810_gtt.i810_fb_memory,
 			par->fb.offset);
 	agp_bind_memory(par->i810_gtt.i810_cursor_memory,
 			par->cursor_heap.offset);
-
+	i810fb_set_par(info);
+	fb_set_suspend (info, 0);
 	info->fbops->fb_blank(VESA_NO_BLANKING, info);
-
-	par->cur_state = 0;
-
+	release_console_sem();
 	return 0;
 }
 /***********************************************************************




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
