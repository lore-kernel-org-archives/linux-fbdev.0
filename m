From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] intel fb: switch to pci_get API
Date: Mon, 16 Oct 2006 16:59:12 +0100
Message-ID: <1161014353.24237.111.camel@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GZUS0-0001d1-CD for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 16 Oct 2006 08:32:24 -0700
Received: from [81.2.110.250] (helo=lxorguk.ukuu.org.uk)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GZURx-0003ZK-NJ
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 16 Oct 2006 08:32:24 -0700
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

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc1-mm1/drivers/video/intelfb/intelfbhw.c linux-2.6.19-rc1-mm1/drivers/video/intelfb/intelfbhw.c
--- linux.vanilla-2.6.19-rc1-mm1/drivers/video/intelfb/intelfbhw.c	2006-10-13 15:10:07.000000000 +0100
+++ linux-2.6.19-rc1-mm1/drivers/video/intelfb/intelfbhw.c	2006-10-13 17:21:18.000000000 +0100
@@ -161,7 +161,7 @@
 		return 1;
 
 	/* Find the bridge device.  It is always 0:0.0 */
-	if (!(bridge_dev = pci_find_slot(0, PCI_DEVFN(0, 0)))) {
+	if (!(bridge_dev = pci_get_bus_and_slot(0, PCI_DEVFN(0, 0)))) {
 		ERR_MSG("cannot find bridge device\n");
 		return 1;
 	}
@@ -169,6 +169,8 @@
 	/* Get the fb aperture size and "stolen" memory amount. */
 	tmp = 0;
 	pci_read_config_word(bridge_dev, INTEL_GMCH_CTRL, &tmp);
+	pci_dev_put(bridge_dev);
+	
 	switch (pdev->device) {
 	case PCI_DEVICE_ID_INTEL_915G:
 	case PCI_DEVICE_ID_INTEL_915GM:


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
