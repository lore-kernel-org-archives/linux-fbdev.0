From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 8/8] i810fb: Honor the return value of
	pci_enable_device
Date: Thu, 10 Aug 2006 19:53:24 +0800
Message-ID: <44DB1E34.4050902@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GB9Az-0003Hu-Qb for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 10 Aug 2006 04:58:13 -0700
Received: from py-out-1112.google.com ([64.233.166.176])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GB9Ay-0002fu-JM
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 10 Aug 2006 04:58:13 -0700
Received: by py-out-1112.google.com with SMTP id c31so811494pyd
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 10 Aug 2006 04:58:12 -0700 (PDT)
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

 drivers/video/i810/i810_main.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/video/i810/i810_main.c b/drivers/video/i810/i810_main.c
index d42edac..b55a12d 100644
--- a/drivers/video/i810/i810_main.c
+++ b/drivers/video/i810/i810_main.c
@@ -1602,7 +1602,10 @@ static int i810fb_resume(struct pci_dev 
 	acquire_console_sem();
 	pci_set_power_state(dev, PCI_D0);
 	pci_restore_state(dev);
-	pci_enable_device(dev);
+
+	if (pci_enable_device(dev))
+		goto fail;
+
 	pci_set_master(dev);
 	agp_bind_memory(par->i810_gtt.i810_fb_memory,
 			par->fb.offset);
@@ -1611,6 +1614,7 @@ static int i810fb_resume(struct pci_dev 
 	i810fb_set_par(info);
 	fb_set_suspend (info, 0);
 	info->fbops->fb_blank(VESA_NO_BLANKING, info);
+fail:
 	release_console_sem();
 	return 0;
 }


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
