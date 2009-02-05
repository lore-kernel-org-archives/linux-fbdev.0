From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 1/3] atyfb: Properly save PCI state
	before changing PCI PM level
Date: Thu, 05 Feb 2009 11:57:32 +1100
Message-ID: <20090205005749.61CEDDDEE7@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <benh@ozlabs.org>) id 1LUsZ2-0007vu-BD
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 05 Feb 2009 00:57:56 +0000
Received: from ozlabs.org ([203.10.76.45])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1LUsYz-0007FS-VH
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 05 Feb 2009 00:57:56 +0000
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: fbdev list <linux-fbdev-devel@lists.sourceforge.net>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org

This fixes atyfb to properly save the PCI config space -before- it
potentially switches the PM state of the chip. This avoids a
warning with the new PM core and is the right thing to do anyway.

I also slightly cleaned up the code that checks whether we are
running on a PowerMac to do a runtime check instead of a compile
check only, and replaced a deprecated number with the proper
symbolic constant.

Finally, I removed the useless switch to D0 from resume since
the core does it for us.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 drivers/video/aty/atyfb_base.c |   20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

--- linux-work.orig/drivers/video/aty/atyfb_base.c	2009-02-04 13:10:22.000000000 +1100
+++ linux-work/drivers/video/aty/atyfb_base.c	2009-02-04 13:13:11.000000000 +1100
@@ -1978,7 +1978,7 @@ static int aty_power_mgmt(int sleep, str
 
 	return timeout ? 0 : -EIO;
 }
-#endif
+#endif /* CONFIG_PPC_PMAC */
 
 static int atyfb_pci_suspend(struct pci_dev *pdev, pm_message_t state)
 {
@@ -2002,9 +2002,15 @@ static int atyfb_pci_suspend(struct pci_
 	par->asleep = 1;
 	par->lock_blank = 1;
 
+	/* Because we may change PCI D state ourselves, we need to
+	 * first save the config space content so the core can
+	 * restore it properly on resume.
+	 */
+	pci_save_state(pdev);
+
 #ifdef CONFIG_PPC_PMAC
 	/* Set chip to "suspend" mode */
-	if (aty_power_mgmt(1, par)) {
+	if (machine_is(powermac) && aty_power_mgmt(1, par)) {
 		par->asleep = 0;
 		par->lock_blank = 0;
 		atyfb_blank(FB_BLANK_UNBLANK, info);
@@ -2047,11 +2053,15 @@ static int atyfb_pci_resume(struct pci_d
 
 	acquire_console_sem();
 
+	/* PCI state will have been restored by the core, so
+	 * we should be in D0 now with our config space fully
+	 * restored
+	 */
+
 #ifdef CONFIG_PPC_PMAC
-	if (pdev->dev.power.power_state.event == 2)
+	if (machine_is(powermac) &&
+	    pdev->dev.power.power_state.event == PM_EVENT_SUSPEND)
 		aty_power_mgmt(0, par);
-#else
-	pci_set_power_state(pdev, PCI_D0);
 #endif
 
 	aty_resume_chip(info);

------------------------------------------------------------------------------
Create and Deploy Rich Internet Apps outside the browser with Adobe(R)AIR(TM)
software. With Adobe AIR, Ajax developers can use existing skills and code to
build responsive, highly engaging applications that combine the power of local
resources and data with the reach of the web. Download the Adobe AIR SDK and
Ajax docs to start building applications today-http://p.sf.net/sfu/adobe-com
