From: Sven Luther <sven.luther@wanadoo.fr>
Subject: [sven.luther@wanadoo.fr: radeon 9200SE device id support for 2.4 and 2.6.]
Date: Sun, 18 Jan 2004 16:10:07 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040118151007.GA7425@iliana>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AiEZB-0004Go-6Z
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 18 Jan 2004 07:10:21 -0800
Received: from smtp1.wanadoo.fr ([193.252.22.30] helo=mwinf0102.wanadoo.fr)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1AiEZA-0008Ml-KT
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 18 Jan 2004 07:10:20 -0800
Received: from iliana (AStrasbourg-206-1-14-10.w81-48.abo.wanadoo.fr [81.48.74.10])
	by mwinf0102.wanadoo.fr (SMTP Server) with ESMTP id A1A4A1BFD3FB
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 18 Jan 2004 16:10:10 +0100 (CET)
Received: from luther by iliana with local (Exim 3.36 #1 (Debian))
	id 1AiEYz-0001vw-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 18 Jan 2004 16:10:09 +0100
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net

Hello,

Here is a smallish patch which can be added to both the 2.4 and 2.6
trees (altough the patch is against tag v2.4.24 of the linuxppc-2.4
tree).

It adds support for the Radeon 9200Se Ya, Yb, Yc and Yd variants, works
fine for me, and i think i have seen it also used by some other
debian/ppc users.

Friendly,

Sven Luther

diff -urN linuxppc-2.4.24/drivers/video/radeonfb.c linux-2.4.24-pegasos/drivers/video/radeonfb.c
--- linuxppc-2.4.24/drivers/video/radeonfb.c	2004-01-11 18:43:09.000000000 +0100
+++ linux-2.4.24-pegasos/drivers/video/radeonfb.c	2004-01-14 10:59:39.000000000 +0100
@@ -202,6 +202,10 @@
 	RADEON_If,
 	RADEON_Ig,
 	RADEON_Y_,
+	RADEON_Ya,
+	RADEON_Yb,
+	RADEON_Yc,
+	RADEON_Yd,
 	RADEON_Ld,
 	RADEON_Le,
 	RADEON_Lf,
@@ -261,6 +265,10 @@
 	{ "9000 If", RADEON_RV250 },
 	{ "9000 Ig", RADEON_RV250 },
 	{ "9200 Y", RADEON_RV280 },
+	{ "9200 Ya", RADEON_RV280 },
+	{ "9200 Yb", RADEON_RV280 },
+	{ "9200 Yc", RADEON_RV280 },
+	{ "9200 Yd", RADEON_RV280 },
 	{ "M9 Ld", RADEON_M9 },
 	{ "M9 Le", RADEON_M9 },
 	{ "M9 Lf", RADEON_M9 },
@@ -326,6 +334,10 @@
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_NH, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_NH},
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_NI, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_NI},
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_Y_, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_Y_},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_Ya, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_Ya},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_Ya, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_Yb},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_Ya, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_Yc},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_Yd, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_Yd},
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_AD, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_AD},
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_AP, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_AP},
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_AR, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_AR},
diff -urN linuxppc-2.4.24/include/linux/pci_ids.h linux-2.4.24-pegasos/include/linux/pci_ids.h
--- linuxppc-2.4.24/include/linux/pci_ids.h	2004-01-11 18:41:11.000000000 +0100
+++ linux-2.4.24-pegasos/include/linux/pci_ids.h	2004-01-14 10:59:39.000000000 +0100
@@ -287,6 +287,10 @@
 #define PCI_DEVICE_ID_ATI_RADEON_Ig	0x4967
 /* Radeon RV280 (9200) */
 #define PCI_DEVICE_ID_ATI_RADEON_Y_	0x5960
+#define PCI_DEVICE_ID_ATI_RADEON_Ya    0x5961
+#define PCI_DEVICE_ID_ATI_RADEON_Yb    0x5962
+#define PCI_DEVICE_ID_ATI_RADEON_Yc    0x5963
+#define PCI_DEVICE_ID_ATI_RADEON_Yd    0x5964
 /* Radeon R300 (9700) */
 #define PCI_DEVICE_ID_ATI_RADEON_ND	0x4e44
 #define PCI_DEVICE_ID_ATI_RADEON_NE	0x4e45


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
