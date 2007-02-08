From: Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH]: change rivafb_remove to __devexit
Date: Thu, 8 Feb 2007 11:42:53 -0500
Message-ID: <20070208164253.17754.41290.sendpatchset@prarit.boston.redhat.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HFCMu-0004aX-4R for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 08 Feb 2007 08:43:32 -0800
Received: from mx1.redhat.com ([66.187.233.31])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HFCMg-00048b-Nt
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 08 Feb 2007 08:43:32 -0800
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com
	[172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l18GgsRq016327
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 8 Feb 2007 11:42:54 -0500
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id
	l18Ggslr029789 for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 8 Feb 2007 11:42:54 -0500
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

Change rivafb_remove to __deviexit to fix MODPOST warnings:

WARNING: drivers/video/riva/rivafb.o - Section mismatch: reference to
.exit.text:rivafb_remove from .data.rel.local after 'rivafb_driver' (at offset 0x28)

Signed-off-by: Prarit Bhargava <prarit@redhat.com>

--- linux-2.6.19.ia64.orig/drivers/video/riva/fbdev.c	2007-02-07 09:56:37.000000000 -0500
+++ linux-2.6.19.ia64/drivers/video/riva/fbdev.c	2007-02-08 11:39:35.000000000 -0500
@@ -2154,7 +2154,7 @@ err_ret:
 	return ret;
 }
 
-static void __exit rivafb_remove(struct pci_dev *pd)
+static void __devexit rivafb_remove(struct pci_dev *pd)
 {
 	struct fb_info *info = pci_get_drvdata(pd);
 	struct riva_par *par = info->par;
@@ -2232,7 +2232,7 @@ static struct pci_driver rivafb_driver =
 	.name		= "rivafb",
 	.id_table	= rivafb_pci_tbl,
 	.probe		= rivafb_probe,
-	.remove		= __exit_p(rivafb_remove),
+	.remove		= __devexit_p(rivafb_remove),
 };
 
 

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
