From: Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH]: change nvidiafb_remove to __devexit
Date: Thu, 8 Feb 2007 11:29:52 -0500
Message-ID: <20070208162952.17679.45127.sendpatchset@prarit.boston.redhat.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HFCA2-0002NK-KF for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 08 Feb 2007 08:30:14 -0800
Received: from mx1.redhat.com ([66.187.233.31])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HFC9u-0003J7-Cl
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 08 Feb 2007 08:30:11 -0800
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com
	[172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l18GTs5e007066
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 8 Feb 2007 11:29:54 -0500
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id
	l18GTrmH024761 for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 8 Feb 2007 11:29:53 -0500
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
To: linux-fbdev-devel@lists.sourceforge.net, adaplas@pol.net
Cc: Prarit Bhargava <prarit@redhat.com>

Change nvidiafb_remove to __devexit to fix MODPOST warnings:

WARNING: drivers/video/nvidia/nvidiafb.o - Section mismatch: reference to
.exit.text:nvidiafb_remove from .data.rel.local after 'nvidiafb_driver' (at
offset 0x28)

Signed-off-by: Prarit Bhargava <prarit@redhat.com>

--- linux-2.6.19.ia64.orig/drivers/video/nvidia/nvidia.c	2007-02-07 09:56:37.000000000 -0500
+++ linux-2.6.19.ia64/drivers/video/nvidia/nvidia.c	2007-02-08 11:14:13.000000000 -0500
@@ -1347,7 +1347,7 @@ err_out:
 	return -ENODEV;
 }
 
-static void __exit nvidiafb_remove(struct pci_dev *pd)
+static void __devexit nvidiafb_remove(struct pci_dev *pd)
 {
 	struct fb_info *info = pci_get_drvdata(pd);
 	struct nvidia_par *par = info->par;
@@ -1433,7 +1433,7 @@ static struct pci_driver nvidiafb_driver
 	.probe    = nvidiafb_probe,
 	.suspend  = nvidiafb_suspend,
 	.resume   = nvidiafb_resume,
-	.remove   = __exit_p(nvidiafb_remove),
+	.remove   = __devexit_p(nvidiafb_remove),
 };
 
 /* ------------------------------------------------------------------------- *

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
