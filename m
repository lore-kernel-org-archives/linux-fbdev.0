From: James Simmons <jsimmons@www.infradead.org>
Subject: NVIDIA pci ids.
Date: Sat, 22 Jan 2005 00:13:23 +0000 (GMT)
Message-ID: <Pine.LNX.4.56.0501220012400.861@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cs8u8-0003D3-JK
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 21 Jan 2005 16:13:28 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1Cs8u7-0003Fh-4a
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 21 Jan 2005 16:13:28 -0800
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Antonino A. Daplas" <adaplas@hotpop.com>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


Here are some PCI ids for NVIDIA cards and the CT 69000. Please apply.


--- linus-2.6/include/linux/pci_ids.h	2005-01-21 10:25:58.000000000 -0800
+++ fbdev-2.6/include/linux/pci_ids.h	2005-01-21 16:09:32.000000000 -0800
@@ -561,6 +561,7 @@
 #define PCI_DEVICE_ID_CT_65550		0x00e0
 #define PCI_DEVICE_ID_CT_65554		0x00e4
 #define PCI_DEVICE_ID_CT_65555		0x00e5
+#define PCI_DEVICE_ID_CT_69000		0x00c0
 
 #define PCI_VENDOR_ID_MIRO		0x1031
 #define PCI_DEVICE_ID_MIRO_36050	0x5601
@@ -1164,6 +1165,16 @@
 #define PCI_DEVICE_ID_NVIDIA_QUADRO4_900XGL	0x0258
 #define PCI_DEVICE_ID_NVIDIA_QUADRO4_750XGL	0x0259
 #define PCI_DEVICE_ID_NVIDIA_QUADRO4_700XGL	0x025B
+#define PCI_DEVICE_ID_NVIDIA_GEFORCE4_TI_4800	0x0280
+#define PCI_DEVICE_ID_NVIDIA_GEFORCE4_TI_4280	0x0281
+#define PCI_DEVICE_ID_NVIDIA_GEFORCE4_TI_4800_SE 0x0282
+#define PCI_DEVICE_ID_NVIDIA_GEFORCE4_4200_GO	0x0286
+#define PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5800_U	0x0301
+#define PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5800	0x0302
+#define PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5600_U	0x0311
+#define PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5600	0x0312
+#define PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5200_U	0x0321
+#define PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5200	0x0322
 #define PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_GO_5200	0x0329
 
 #define PCI_VENDOR_ID_IMS		0x10e0


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
