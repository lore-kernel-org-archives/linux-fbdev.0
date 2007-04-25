From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 37/41] nvidiafb/rivafb: Switch to
	pci_get refcounting
Date: Wed, 25 Apr 2007 15:21:38 +0800
Message-ID: <462F0182.9060307@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HgcDY-0001lz-A5 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 00:47:12 -0700
Received: from nz-out-0506.google.com ([64.233.162.232])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HgcDX-0007wF-Pt
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 00:47:12 -0700
Received: by nz-out-0506.google.com with SMTP id i11so419955nzi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 25 Apr 2007 00:47:11 -0700 (PDT)
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
Cc: Alan Cox <alan@redhat.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Alan Cox <alan@redhat.com>

Switch to pci_get refcounting APIs

[adaplas]
Fix a long-standing bug where the return value of
pci_find_slot()/pci_get_bus_and_slot() is ignored.

Signed-off-by: Alan Cox <alan@redhat.com>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/nvidia/nv_hw.c    |   15 +++++++++------
 drivers/video/nvidia/nv_setup.c |    3 ++-
 drivers/video/riva/nv_driver.c  |    6 ++++--
 drivers/video/riva/riva_hw.c    |   12 ++++++++----
 4 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/video/nvidia/nv_hw.c b/drivers/video/nvidia/nv_hw.c
index ea42611..f297c7b 100644
--- a/drivers/video/nvidia/nv_hw.c
+++ b/drivers/video/nvidia/nv_hw.c
@@ -686,7 +686,7 @@ static void nForceUpdateArbitrationSetti
 
 	if ((par->Chipset & 0x0FF0) == 0x01A0) {
 		unsigned int uMClkPostDiv;
-		dev = pci_find_slot(0, 3);
+		dev = pci_get_bus_and_slot(0, 3);
 		pci_read_config_dword(dev, 0x6C, &uMClkPostDiv);
 		uMClkPostDiv = (uMClkPostDiv >> 8) & 0xf;
 
@@ -694,11 +694,11 @@ static void nForceUpdateArbitrationSetti
 			uMClkPostDiv = 4;
 		MClk = 400000 / uMClkPostDiv;
 	} else {
-		dev = pci_find_slot(0, 5);
+		dev = pci_get_bus_and_slot(0, 5);
 		pci_read_config_dword(dev, 0x4c, &MClk);
 		MClk /= 1000;
 	}
-
+	pci_dev_put(dev);
 	pll = NV_RD32(par->PRAMDAC0, 0x0500);
 	M = (pll >> 0) & 0xFF;
 	N = (pll >> 8) & 0xFF;
@@ -707,19 +707,21 @@ static void nForceUpdateArbitrationSetti
 	sim_data.pix_bpp = (char)pixelDepth;
 	sim_data.enable_video = 0;
 	sim_data.enable_mp = 0;
-	pci_find_slot(0, 1);
+	dev = pci_get_bus_and_slot(0, 1);
 	pci_read_config_dword(dev, 0x7C, &sim_data.memory_type);
+	pci_dev_put(dev);
 	sim_data.memory_type = (sim_data.memory_type >> 12) & 1;
 	sim_data.memory_width = 64;
 
-	dev = pci_find_slot(0, 3);
+	dev = pci_get_bus_and_slot(0, 3);
 	pci_read_config_dword(dev, 0, &memctrl);
+	pci_dev_put(dev);
 	memctrl >>= 16;
 
 	if ((memctrl == 0x1A9) || (memctrl == 0x1AB) || (memctrl == 0x1ED)) {
 		int dimm[3];
 
-		pci_find_slot(0, 2);
+		dev = pci_get_bus_and_slot(0, 2);
 		pci_read_config_dword(dev, 0x40, &dimm[0]);
 		dimm[0] = (dimm[0] >> 8) & 0x4f;
 		pci_read_config_dword(dev, 0x44, &dimm[1]);
@@ -731,6 +733,7 @@ static void nForceUpdateArbitrationSetti
 			printk("nvidiafb: your nForce DIMMs are not arranged "
 			       "in optimal banks!\n");
 		}
+		pci_dev_put(dev);
 	}
 
 	sim_data.mem_latency = 3;
diff --git a/drivers/video/nvidia/nv_setup.c b/drivers/video/nvidia/nv_setup.c
index 336ddb0..707e2c8 100644
--- a/drivers/video/nvidia/nv_setup.c
+++ b/drivers/video/nvidia/nv_setup.c
@@ -261,7 +261,7 @@ #ifdef __BIG_ENDIAN
 	}
 #endif
 
-	dev = pci_find_slot(0, 1);
+	dev = pci_get_bus_and_slot(0, 1);
 	if ((par->Chipset & 0xffff) == 0x01a0) {
 		int amt = 0;
 
@@ -276,6 +276,7 @@ #endif
 		par->RamAmountKBytes =
 		    (NV_RD32(par->PFB, 0x020C) & 0xFFF00000) >> 10;
 	}
+	pci_dev_put(dev);
 
 	par->CrystalFreqKHz = (NV_RD32(par->PEXTDEV, 0x0000) & (1 << 6)) ?
 	    14318 : 13500;
diff --git a/drivers/video/riva/nv_driver.c b/drivers/video/riva/nv_driver.c
index be630a0..a110268 100644
--- a/drivers/video/riva/nv_driver.c
+++ b/drivers/video/riva/nv_driver.c
@@ -231,12 +231,14 @@ unsigned long riva_get_memlen(struct riv
 	case NV_ARCH_30:
 		if(chipset == NV_CHIP_IGEFORCE2) {
 
-			dev = pci_find_slot(0, 1);
+			dev = pci_get_bus_and_slot(0, 1);
 			pci_read_config_dword(dev, 0x7C, &amt);
+			pci_dev_put(dev);
 			memlen = (((amt >> 6) & 31) + 1) * 1024;
 		} else if (chipset == NV_CHIP_0x01F0) {
-			dev = pci_find_slot(0, 1);
+			dev = pci_get_bus_and_slot(0, 1);
 			pci_read_config_dword(dev, 0x84, &amt);
+			pci_dev_put(dev);
 			memlen = (((amt >> 4) & 127) + 1) * 1024;
 		} else {
 			switch ((NV_RD32(chip->PFB, 0x0000020C) >> 20) &
diff --git a/drivers/video/riva/riva_hw.c b/drivers/video/riva/riva_hw.c
index c1f092c..b64a11c 100644
--- a/drivers/video/riva/riva_hw.c
+++ b/drivers/video/riva/riva_hw.c
@@ -1118,8 +1118,9 @@ (
     unsigned int uMClkPostDiv;
     struct pci_dev *dev;
 
-    dev = pci_find_slot(0, 3);
+    dev = pci_get_bus_and_slot(0, 3);
     pci_read_config_dword(dev, 0x6C, &uMClkPostDiv);
+    pci_dev_put(dev);
     uMClkPostDiv = (uMClkPostDiv >> 8) & 0xf;
 
     if(!uMClkPostDiv) uMClkPostDiv = 4;
@@ -1132,8 +1133,9 @@ (
     sim_data.enable_video   = 0;
     sim_data.enable_mp      = 0;
 
-    dev = pci_find_slot(0, 1);
+    dev = pci_get_bus_and_slot(0, 1);
     pci_read_config_dword(dev, 0x7C, &sim_data.memory_type);
+    pci_dev_put(dev);
     sim_data.memory_type    = (sim_data.memory_type >> 12) & 1;
 
     sim_data.memory_width   = 64;
@@ -2112,12 +2114,14 @@ #endif
      * Fill in chip configuration.
      */
     if(chipset == NV_CHIP_IGEFORCE2) {
-        dev = pci_find_slot(0, 1);
+        dev = pci_get_bus_and_slot(0, 1);
         pci_read_config_dword(dev, 0x7C, &amt);
+        pci_dev_put(dev);
         chip->RamAmountKBytes = (((amt >> 6) & 31) + 1) * 1024;
     } else if(chipset == NV_CHIP_0x01F0) {
-        dev = pci_find_slot(0, 1);
+        dev = pci_get_bus_and_slot(0, 1);
         pci_read_config_dword(dev, 0x84, &amt);
+        pci_dev_put(dev);
         chip->RamAmountKBytes = (((amt >> 4) & 127) + 1) * 1024;
     } else {
         switch ((NV_RD32(chip->PFB, 0x0000020C) >> 20) & 0x000000FF)


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
