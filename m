From: =?utf-8?q?Michel=20D=C3=A4nzer?= <michel@tungstengraphics.com>
Subject: [PATCH 2/3] vmlfb: Add suspend/resume support.
Date: Thu, 16 Aug 2007 17:19:57 +0200
Message-ID: <10260.5989705355$1187279599@news.gmane.org>
References: <11872775981058-git-send-email-> <11872775984188-git-send-email->
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="===============0303639127=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1ILhem-0008RF-Kc for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 16 Aug 2007 08:53:08 -0700
Received: from darkcity.gna.ch ([195.226.6.51] helo=mail.gna.ch)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1ILhej-0003F2-U6
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 16 Aug 2007 08:53:08 -0700
In-Reply-To: <11872775984188-git-send-email->
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Antonino Daplas <adaplas@gmail.com>, Richard Purdie <rpurdie@rpsys.net>
Cc: linux-fbdev-devel@lists.sourceforge.net, =?utf-8?q?Michel=20D=C3=A4nzer?= <michel@tungstengraphics.com>, Alan Hourihane <alanh@tungstengraphics.com>

--===============0303639127==

From: Michel D������nzer <michel@tungstengraphics.com>

Mostly restore fbdev state on resume.

Signed-off-by: Michel D������nzer <michel@tungstengraphics.com>
---
 drivers/video/vermilion/vermilion.c |  108 ++++++++++++++++++++++++++++++++++-
 drivers/video/vermilion/vermilion.h |    5 ++
 2 files changed, 112 insertions(+), 1 deletions(-)

diff --git a/drivers/video/vermilion/vermilion.c b/drivers/video/vermilion/vermilion.c
index de531c9..af72f67 100644
--- a/drivers/video/vermilion/vermilion.c
+++ b/drivers/video/vermilion/vermilion.c
@@ -41,6 +41,10 @@
 #include <linux/mmzone.h>
 #include <asm/uaccess.h>
 
+#ifdef CONFIG_PM
+#include <linux/console.h>
+#endif
+
 /* #define VERMILION_DEBUG */
 
 #include "vermilion.h"
@@ -1067,11 +1071,113 @@ static struct pci_device_id vml_ids[] = {
 	{0}
 };
 
+#ifdef CONFIG_PM
+static int vmlfb_suspend(struct pci_dev *pdev, pm_message_t state)
+{
+	struct fb_info *info = pci_get_drvdata(pdev);
+	struct vml_info *vinfo = container_of(info, struct vml_info, info);
+
+	printk(KERN_DEBUG "vmlfb: suspending to state: %d\n", state.event);
+
+	acquire_console_sem();
+
+	fb_set_suspend(info, 1);
+
+	/* Blank display and LCD */
+	vmlfb_blank(FB_BLANK_POWERDOWN, info);
+
+	/* Suspend the chip */
+	if (subsys && subsys->suspend) {
+		int ret = subsys->suspend(subsys, state);
+
+		if (ret) {
+			vmlfb_blank(0, info);
+			fb_set_suspend(info, 0);
+			release_console_sem();
+			return ret;
+		}
+	}
+
+	pci_save_state(vinfo->par->gpu);
+	pci_disable_device(vinfo->par->gpu);
+	pci_set_power_state(vinfo->par->gpu,
+			    pci_choose_state(vinfo->par->gpu, state));
+
+	pci_save_state(pdev);
+	pci_disable_device(pdev);
+	pci_set_power_state(pdev, pci_choose_state(pdev, state));
+
+	release_console_sem();
+
+	pdev->dev.power.power_state = state;
+
+	return 0;
+}
+
+static int vmlfb_resume(struct pci_dev *pdev)
+{
+	struct fb_info *info = pci_get_drvdata(pdev);
+	struct vml_info *vinfo = container_of(info, struct vml_info, info);
+
+	if (pdev->dev.power.power_state.event == PM_EVENT_ON)
+		return 0;
+
+	acquire_console_sem();
+
+	/* Wake up devices */
+	if (subsys && subsys->resume) {
+		int ret = subsys->resume(subsys);
+
+		if (ret) {
+			release_console_sem();
+			return ret;
+		}
+	}
+
+	pci_set_power_state(vinfo->par->gpu, PCI_D0);
+	pci_restore_state(vinfo->par->gpu);
+	if (pci_enable_device(vinfo->par->gpu)) {
+		release_console_sem();
+		return -1;
+	}
+
+	pci_set_power_state(pdev, PCI_D0);
+	pci_restore_state(pdev);
+	if (pci_enable_device(pdev)) {
+		release_console_sem();
+		return -1;
+	}
+
+	/* Restore display */
+	vmlfb_set_par(info);
+	fb_pan_display(info, &info->var);
+	fb_set_cmap(&info->cmap, info);
+
+	/* Refresh */
+	fb_set_suspend(info, 0);
+
+	/* Unblank */
+	vmlfb_blank(0, info);
+
+	release_console_sem();
+
+	pdev->dev.power.power_state = PMSG_ON;
+
+	printk(KERN_DEBUG "vmlfb: resumed\n");
+
+	return 0;
+}
+#endif /* CONFIG_PM */
+
 static struct pci_driver vmlfb_pci_driver = {
 	.name = "vmlfb",
 	.id_table = vml_ids,
 	.probe = vml_pci_probe,
-	.remove = __devexit_p(vml_pci_remove)
+	.remove = __devexit_p(vml_pci_remove),
+#ifdef CONFIG_PM
+	.suspend = vmlfb_suspend,
+	.resume	= vmlfb_resume,
+#endif /* CONFIG_PM */
 };
 
 static void __exit vmlfb_cleanup(void)
diff --git a/drivers/video/vermilion/vermilion.h b/drivers/video/vermilion/vermilion.h
index 1fc6695..97b6e54 100644
--- a/drivers/video/vermilion/vermilion.h
+++ b/drivers/video/vermilion/vermilion.h
@@ -247,6 +247,11 @@ struct vml_sys {
 
 	int (*set_clock) (struct vml_sys * sys, int clock);
 	int (*nearest_clock) (const struct vml_sys * sys, int clock);
+
+#ifdef CONFIG_PM
+	int (*suspend) (const struct vml_sys *sys, pm_message_t state);
+	int (*resume) (const struct vml_sys *sys);
+#endif
 };
 
 extern int vmlfb_register_subsys(struct vml_sys *sys);
-- 
1.5.2.4



--===============0303639127==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--===============0303639127==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============0303639127==--
