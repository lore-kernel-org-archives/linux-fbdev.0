From: Jake Moilanen <moilanen@austin.ibm.com>
Subject: [PATCH] ATI RN50 pci id
Date: Fri, 28 Oct 2005 13:46:52 -0500
Message-ID: <20051028134652.6bb2bc57.moilanen@austin.ibm.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EVZJ3-0002nX-9c
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 28 Oct 2005 11:50:25 -0700
Received: from e31.co.us.ibm.com ([32.97.110.149])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1EVZJ3-0007Bu-4n
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 28 Oct 2005 11:50:25 -0700
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e31.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id j9SIoFOw025174
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 28 Oct 2005 14:50:15 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j9SIoFk9466230
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 28 Oct 2005 12:50:15 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id j9SIoF7h011812
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 28 Oct 2005 12:50:15 -0600
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: benh@kernel.crashing.org
Cc: linux-fbdev-devel@lists.sourceforge.net

Here's the PCI ID for the ATI RN50 chip.

Jake

Signed-off-by: Jake Moilanen <moilanen@austin.ibm.com>

Index: 2.6.14/drivers/video/aty/ati_ids.h
===================================================================
--- 2.6.14.orig/drivers/video/aty/ati_ids.h	2005-03-02 01:38:04.000000000 -0600
+++ 2.6.14/drivers/video/aty/ati_ids.h	2005-10-28 12:51:14.895957225 -0500
@@ -150,6 +150,7 @@
 #define PCI_CHIP_RV200_QX		0x5158
 #define PCI_CHIP_RV100_QY		0x5159
 #define PCI_CHIP_RV100_QZ		0x515A
+#define PCI_CHIP_RN50			0x515E
 #define PCI_CHIP_RAGE128RE		0x5245
 #define PCI_CHIP_RAGE128RF		0x5246
 #define PCI_CHIP_RAGE128RG		0x5247
Index: 2.6.14/drivers/video/aty/radeon_base.c
===================================================================
--- 2.6.14.orig/drivers/video/aty/radeon_base.c	2005-10-28 09:54:59.864156837 -0500
+++ 2.6.14/drivers/video/aty/radeon_base.c	2005-10-28 12:52:32.164274339 -0500
@@ -113,6 +113,7 @@
 	/* Radeon VE/7000 */
 	CHIP_DEF(PCI_CHIP_RV100_QY, 	RV100,	CHIP_HAS_CRTC2),
 	CHIP_DEF(PCI_CHIP_RV100_QZ, 	RV100,	CHIP_HAS_CRTC2),
+	CHIP_DEF(PCI_CHIP_RN50,		RV100,	CHIP_HAS_CRTC2),	
 	/* Radeon IGP320M (U1) */
 	CHIP_DEF(PCI_CHIP_RS100_4336,	RS100,	CHIP_HAS_CRTC2 | CHIP_IS_IGP | CHIP_IS_MOBILITY),
 	/* Radeon IGP320 (A3) */


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
