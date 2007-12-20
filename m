From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: atyfb: Early video resume for PowerMacs
Date: Thu, 20 Dec 2007 14:59:36 +1100
Message-ID: <1198123176.31714.8.camel@pasglop>
Reply-To: benh@kernel.crashing.org,
	linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1J5CZk-0007x4-Pn for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 19 Dec 2007 20:00:00 -0800
Received: from gate.crashing.org ([63.228.1.57]
	ident=[U2FsdGVkX19yAVuwG2sC/uD+kzTSIwFvIffdKdvt7gA=])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1J5CZk-0003r7-7P
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 19 Dec 2007 20:00:00 -0800
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

This adds support for early resuming of the video driver on some
powermacs that support it. Makes video come back earlier and thus
debugging of suspend/resume problems easier.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

This is for 2.6.25

Index: linux-merge/drivers/video/aty/atyfb_base.c
===================================================================
--- linux-merge.orig/drivers/video/aty/atyfb_base.c	2007-12-20 14:50:23.000000000 +1100
+++ linux-merge/drivers/video/aty/atyfb_base.c	2007-12-20 14:58:44.000000000 +1100
@@ -76,6 +76,7 @@
 
 #ifdef __powerpc__
 #include <asm/machdep.h>
+#include <asm/pmac_feature.h>
 #include <asm/prom.h>
 #include "../macmodes.h"
 #endif
@@ -2057,17 +2058,18 @@ static int atyfb_pci_suspend(struct pci_
 
 #ifdef CONFIG_PPC_PMAC
 	/* Set chip to "suspend" mode */
-	if (aty_power_mgmt(1, par)) {
-		par->asleep = 0;
-		par->lock_blank = 0;
-		atyfb_blank(FB_BLANK_UNBLANK, info);
-		fb_set_suspend(info, 0);
-		release_console_sem();
-		return -EIO;
-	}
-#else
+	if (machine_is(powermac)) {
+		if (aty_power_mgmt(1, par)) {
+			par->asleep = 0;
+			par->lock_blank = 0;
+			atyfb_blank(FB_BLANK_UNBLANK, info);
+			fb_set_suspend(info, 0);
+			release_console_sem();
+			return -EIO;
+		}
+	} else
+#endif /* CONFIG_PPC_PMAC */
 	pci_set_power_state(pdev, pci_choose_state(pdev, state));
-#endif
 
 	release_console_sem();
 
@@ -2076,7 +2078,7 @@ static int atyfb_pci_suspend(struct pci_
 	return 0;
 }
 
-static int atyfb_pci_resume(struct pci_dev *pdev)
+static int atyfb_do_resume(struct pci_dev *pdev)
 {
 	struct fb_info *info = pci_get_drvdata(pdev);
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
@@ -2084,14 +2086,14 @@ static int atyfb_pci_resume(struct pci_d
 	if (pdev->dev.power.power_state.event == PM_EVENT_ON)
 		return 0;
 
-	acquire_console_sem();
+	pci_set_power_state(pdev, PCI_D0);
 
 #ifdef CONFIG_PPC_PMAC
-	if (pdev->dev.power.power_state.event == 2)
-		aty_power_mgmt(0, par);
-#else
-	pci_set_power_state(pdev, PCI_D0);
-#endif
+	if (machine_is(powermac)) {
+		if (pdev->dev.power.power_state.event == 2)
+			aty_power_mgmt(0, par);
+	}
+#endif /* CONFIG_PPC_PMAC */
 
 	aty_resume_chip(info);
 
@@ -2107,13 +2109,34 @@ static int atyfb_pci_resume(struct pci_d
 	par->lock_blank = 0;
 	atyfb_blank(FB_BLANK_UNBLANK, info);
 
-	release_console_sem();
-
 	pdev->dev.power.power_state = PMSG_ON;
 
 	return 0;
 }
 
+static int atyfb_pci_resume(struct pci_dev *pdev)
+{
+	int rc;
+
+	acquire_console_sem();
+	rc = atyfb_do_resume(pdev);
+	release_console_sem();
+
+	return rc;
+}
+
+#ifdef CONFIG_PPC_PMAC
+static void atyfb_early_resume(void *data)
+{
+	struct atyfb_par *par = data;
+
+	if (try_acquire_console_sem())
+		return;
+	atyfb_do_resume(par->pdev);
+	release_console_sem();
+}
+#endif /* CONFIG_PPC_PMAC */
+
 #endif /*  defined(CONFIG_PM) && defined(CONFIG_PCI) */
 
 /* Backlight */
@@ -2596,7 +2619,7 @@ static int __devinit aty_init(struct fb_
 	}
 
 	memset(&var, 0, sizeof(var));
-#ifdef CONFIG_PPC
+#ifdef CONFIG_PPC_PMAC
 	if (machine_is(powermac)) {
 		/*
 		 *  FIXME: The NVRAM stuff should be put in a Mac-specific file, as it
@@ -2631,7 +2654,8 @@ static int __devinit aty_init(struct fb_
 					       &var))
 				has_var = 1;
 		}
-	}
+		pmac_set_early_video_resume(atyfb_early_resume, par);
+}
 
 #endif /* !CONFIG_PPC */
 



-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services
for just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
