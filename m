From: Lucas Correia Villa Real <lucasvr@gobolinux.org>
Subject: [PATCH] GeForce 5200 on rivafb
Date: Tue, 7 Dec 2004 23:47:23 -0200
Message-ID: <200412072347.23194.lucasvr@gobolinux.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_r0ltBgy7lZQiMoC"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cbquv-00053E-A9
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 07 Dec 2004 17:46:57 -0800
Received: from loncoche.terra.com.br ([200.154.55.229])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1Cbquu-0000MU-DA
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 07 Dec 2004 17:46:57 -0800
Received: from potosi.terra.com.br (potosi.terra.com.br [200.154.55.131])
	by loncoche.terra.com.br (Postfix) with ESMTP id 8E6F6E79603
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue,  7 Dec 2004 23:46:52 -0200 (BRST)
Received: from ummagumma.ozzmosis.net (200-102-085-101.nhoce7002.dsl.brasiltelecom.net.br [200.102.85.101])
	(authenticated user lucasvr)
	by potosi.terra.com.br (Postfix) with ESMTP id 00A4437005E
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue,  7 Dec 2004 23:46:51 -0200 (BRST)
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sourceforge.net


--Boundary-00=_r0ltBgy7lZQiMoC
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I was trying to figure out why my GeForce FX 5200 wasn't being recognized by 
rivafb, when I saw that its ID was not being included by the driver.

The following patch (against 2.6.10-rc3) allows it to compile and switch to 
graphics mode successfully.

Just a note: the README file shipped with the NVIDIA driver has a complete 
list of device ID's. While it's easy to add them all into riva.c and 
pci_ids.h, I'm not very sure if it's okay to flood them with #defines and by 
increasing heavily the rivafb_pci_tbl table.

Is it ok to do that, or were you waiting to get a feedback from users from 
those cards first? I can provide a patch to include all the missing cards if 
there's no problem on doing that.

Thanks!
Lucas

--Boundary-00=_r0ltBgy7lZQiMoC
Content-Type: text/x-diff;
  charset="us-ascii";
  name="rivafb-geforcefx.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="rivafb-geforcefx.patch"

diff -X dontdiff-2.6 -Nur 2.6.10-rc3-vanilla/drivers/video/riva/fbdev.c 2.6.10-rc3-lucasvr/drivers/video/riva/fbdev.c
--- 2.6.10-rc3-vanilla/drivers/video/riva/fbdev.c	2004-12-07 09:58:14.000000000 -0200
+++ 2.6.10-rc3-lucasvr/drivers/video/riva/fbdev.c	2004-12-07 22:45:52.000000000 -0200
@@ -192,6 +192,10 @@
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_QUADRO4_700XGL,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5200_ULTRA,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5200,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_GO_5200,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ 0, } /* terminate list */
@@ -1876,6 +1880,8 @@
 		case 0x0300:   /* GeForceFX 5800 */
 		case 0x0310:   /* GeForceFX 5600 */
 		case 0x0320:   /* GeForceFX 5200 */
+		case 0x0321:   /* GeForceFX 5200 Ultra */
+		case 0x0322:   /* GeForceFX 5200 */
 		case 0x0330:   /* GeForceFX 5900 */
 		case 0x0340:   /* GeForceFX 5700 */
 		     arch =  NV_ARCH_30;
diff -X dontdiff-2.6 -Nur 2.6.10-rc3-vanilla/include/linux/pci_ids.h 2.6.10-rc3-lucasvr/include/linux/pci_ids.h
--- 2.6.10-rc3-vanilla/include/linux/pci_ids.h	2004-12-07 09:58:25.000000000 -0200
+++ 2.6.10-rc3-lucasvr/include/linux/pci_ids.h	2004-12-07 22:45:29.000000000 -0200
@@ -1144,6 +1144,8 @@
 #define PCI_DEVICE_ID_NVIDIA_QUADRO4_900XGL	0x0258
 #define PCI_DEVICE_ID_NVIDIA_QUADRO4_750XGL	0x0259
 #define PCI_DEVICE_ID_NVIDIA_QUADRO4_700XGL	0x025B
+#define PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5200_ULTRA 0x0321
+#define PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_5200    0x0322
 #define PCI_DEVICE_ID_NVIDIA_GEFORCE_FX_GO_5200	0x0329
 
 #define PCI_VENDOR_ID_IMS		0x10e0

--Boundary-00=_r0ltBgy7lZQiMoC--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
