From: Andreas Steinmetz <ast@domdv.de>
Subject: [PATCH] add device id to radeonfb for 2.6.2
Date: Fri, 06 Feb 2004 12:40:20 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <40237D24.9020806@domdv.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080106070502040607060208"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ap4LW-0000Ms-SI
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 06 Feb 2004 03:40:30 -0800
Received: from hermes.domdv.de ([193.102.202.1] helo=zeus.domdv.de)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1Ap4LW-00013a-9x
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 06 Feb 2004 03:40:30 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: ajoshi@shell.unixbox.com
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080106070502040607060208
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The attached patch adds the pci id 5961 to radeonfb. Without the patch 
my 9200 displays only a blank screen. lspci output below. The patch is 
against 2.6.2.

05:00.0 VGA compatible controller: ATI Technologies Inc Radeon RV280 
[Radeon 9200] (rev 01) (prog-if 00 [VGA])
         Subsystem: Giga-byte Technology: Unknown device 4018
         Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 16
         Memory at e0000000 (32-bit, prefetchable) [size=128M]
         I/O ports at b800 [size=256]
         Memory at feaf0000 (32-bit, non-prefetchable) [size=64K]
         Expansion ROM at feac0000 [disabled] [size=128K]
         Capabilities: [58] AGP version 3.0
         Capabilities: [50] Power Management version 2

-- 
Andreas Steinmetz

--------------080106070502040607060208
Content-Type: text/plain;
 name="radeon.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="radeon.patch"

diff -rNu linux-2.6.2-orig/drivers/video/radeonfb.c linux-2.6.2/drivers/video/radeonfb.c
--- linux-2.6.2-orig/drivers/video/radeonfb.c	2004-02-04 04:44:55.000000000 +0100
+++ linux-2.6.2/drivers/video/radeonfb.c	2004-02-06 11:55:18.000000000 +0100
@@ -114,6 +114,7 @@
 	RADEON_Ie,
 	RADEON_If,
 	RADEON_Ig,
+	RADEON_Ya,
 	RADEON_Yd,
 	RADEON_Ld,
 	RADEON_Le,
@@ -208,6 +209,7 @@
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_Ie, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_Ie},
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_If, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_If},
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_Ig, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_Ig},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_Ya, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_Ya},
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_Yd, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_Yd},
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_Ld, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_Ld},
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_Le, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_Le},
diff -rNu linux-2.6.2-orig/include/linux/pci_ids.h linux-2.6.2/include/linux/pci_ids.h
--- linux-2.6.2-orig/include/linux/pci_ids.h	2004-02-04 04:43:43.000000000 +0100
+++ linux-2.6.2/include/linux/pci_ids.h	2004-02-06 11:45:51.000000000 +0100
@@ -291,6 +291,7 @@
 #define PCI_DEVICE_ID_ATI_RADEON_Ig	0x4967
 /* Radeon RV280 (9200) */
 #define PCI_DEVICE_ID_ATI_RADEON_Y_	0x5960
+#define PCI_DEVICE_ID_ATI_RADEON_Ya	0x5961
 #define PCI_DEVICE_ID_ATI_RADEON_Yd	0x5964
 /* Radeon R300 (9500) */
 #define PCI_DEVICE_ID_ATI_RADEON_AD	0x4144

--------------080106070502040607060208--



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
