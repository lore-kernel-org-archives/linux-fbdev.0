From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] igafb: switch to pci_get API
Date: Mon, 16 Oct 2006 16:57:24 +0100
Message-ID: <1161014244.24237.108.camel@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GZUQS-0001RQ-R3 for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 16 Oct 2006 08:30:48 -0700
Received: from [81.2.110.250] (helo=lxorguk.ukuu.org.uk)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GZUQM-00032r-5Q
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 16 Oct 2006 08:30:48 -0700
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
To: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc1-mm1/drivers/video/igafb.c linux-2.6.19-rc1-mm1/drivers/video/igafb.c
--- linux.vanilla-2.6.19-rc1-mm1/drivers/video/igafb.c	2006-10-13 15:06:57.000000000 +0100
+++ linux-2.6.19-rc1-mm1/drivers/video/igafb.c	2006-10-13 17:21:18.000000000 +0100
@@ -384,19 +384,21 @@
         if (!con_is_present())
                 return -ENXIO;
 
-        pdev = pci_find_device(PCI_VENDOR_ID_INTERG, 
+        pdev = pci_get_device(PCI_VENDOR_ID_INTERG, 
                                PCI_DEVICE_ID_INTERG_1682, 0);
 	if (pdev == NULL) {
 		/*
 		 * XXX We tried to use cyber2000fb.c for IGS 2000.
 		 * But it does not initialize the chip in JavaStation-E, alas.
 		 */
-        	pdev = pci_find_device(PCI_VENDOR_ID_INTERG, 0x2000, 0);
+        	pdev = pci_get_device(PCI_VENDOR_ID_INTERG, 0x2000, 0);
         	if(pdev == NULL) {
         	        return -ENXIO;
 		}
 		iga2000 = 1;
 	}
+	/* We leak a reference here but as it cannot be unloaded this is
+	   fine. If you write unload code remember to free it in unload */
 	
 	size = sizeof(struct fb_info) + sizeof(struct iga_par) + sizeof(u32)*16;
 


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
