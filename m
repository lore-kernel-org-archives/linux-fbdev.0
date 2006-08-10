From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 7/8] nvidiafb: Honor the return value of
	pci_enable_device
Date: Thu, 10 Aug 2006 19:52:45 +0800
Message-ID: <44DB1E0D.9080808@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GB9Au-0003Hj-UD for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 10 Aug 2006 04:58:09 -0700
Received: from nz-out-0102.google.com ([64.233.162.196])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GB9At-0006Ho-NJ
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 10 Aug 2006 04:58:08 -0700
Received: by nz-out-0102.google.com with SMTP id m22so116768nzf
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 10 Aug 2006 04:58:07 -0700 (PDT)
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

Check the return value of pci_enable_device().

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/nvidia/nvidia.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/video/nvidia/nvidia.c b/drivers/video/nvidia/nvidia.c
index f8cd4c5..731edf7 100644
--- a/drivers/video/nvidia/nvidia.c
+++ b/drivers/video/nvidia/nvidia.c
@@ -984,7 +984,10 @@ static int nvidiafb_resume(struct pci_de
 
 	if (par->pm_state != PM_EVENT_FREEZE) {
 		pci_restore_state(dev);
-		pci_enable_device(dev);
+
+		if (pci_enable_device(dev))
+			goto fail;
+
 		pci_set_master(dev);
 	}
 
@@ -993,6 +996,7 @@ static int nvidiafb_resume(struct pci_de
 	fb_set_suspend (info, 0);
 	nvidiafb_blank(FB_BLANK_UNBLANK, info);
 
+fail:
 	release_console_sem();
 	return 0;
 }


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
