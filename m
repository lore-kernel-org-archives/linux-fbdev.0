From: Jesse Barnes <jbarnes@engr.sgi.com>
Subject: [PATCH] fix radeon, r128 host & BAR value confusion
Date: Mon, 13 Dec 2004 15:19:46 -0800
Message-ID: <200412131519.46398.jbarnes@engr.sgi.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_SOivBJtpFmWPqIj"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CdzU5-0003VF-7j
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 13 Dec 2004 15:20:05 -0800
Received: from omx3-ext.sgi.com ([192.48.171.20] helo=omx3.sgi.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CdzU3-0002ZO-7F
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 13 Dec 2004 15:20:05 -0800
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
To: ajoshi@shell.unixbox.com, linux-fbdev-devel@lists.sourceforge.net
Cc: benh@kernel.crashing.org

--Boundary-00=_SOivBJtpFmWPqIj
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On some platforms, the values in the resource structures are not equivalent to 
what's in the BARs, so you need to distinguish between them.  This patch 
fixes both of the drivers to use the BAR value where appropriate to 
enable/disable ROM space access and also prevents the destruction of the ROM 
BAR value as it may be needed if the card needs to be posted again.  Please 
Cc me on any replies as I'm not on linux-fbdev-devel.

Signed-off-by: Jesse Barnes <jbarnes@sgi.com>

Thanks,
Jesse

--Boundary-00=_SOivBJtpFmWPqIj
Content-Type: text/plain;
  charset="us-ascii";
  name="aty-rom-enable-fixes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="aty-rom-enable-fixes.patch"

===== drivers/video/aty/aty128fb.c 1.52 vs edited =====
--- 1.52/drivers/video/aty/aty128fb.c	2004-11-12 11:40:39 -08:00
+++ edited/drivers/video/aty/aty128fb.c	2004-12-13 15:13:55 -08:00
@@ -791,6 +791,7 @@
 static void __init aty128_unmap_ROM(struct pci_dev *dev, void __iomem * rom)
 {
 	struct resource *r = &dev->resource[PCI_ROM_RESOURCE];
+	u32 val;
 	
 	iounmap(rom);
 	
@@ -801,8 +802,9 @@
 		r->end -= r->start;
 		r->start = 0;
 	}
-	/* This will disable and set address to unassigned */
-	pci_write_config_dword(dev, dev->rom_base_reg, 0);
+	/* This will disable it again */
+	pci_read_config_dword(dev, dev->rom_base_reg, &val);
+	pci_write_config_dword(dev, dev->rom_base_reg, val & ~PCI_ROM_ADDRESS_ENABLE);
 }
 
 
@@ -830,8 +832,10 @@
 	
 	/* enable if needed */
 	if (!(r->flags & PCI_ROM_ADDRESS_ENABLE)) {
+		u32 val;
+		pci_read_config_dword(dev, dev->rom_base_reg, &val);
 		pci_write_config_dword(dev, dev->rom_base_reg,
-				       r->start | PCI_ROM_ADDRESS_ENABLE);
+				       val | PCI_ROM_ADDRESS_ENABLE);
 		r->flags |= PCI_ROM_ADDRESS_ENABLE;
 	}
 	
===== drivers/video/aty/radeon_base.c 1.35 vs edited =====
--- 1.35/drivers/video/aty/radeon_base.c	2004-11-11 00:39:04 -08:00
+++ edited/drivers/video/aty/radeon_base.c	2004-12-13 15:11:56 -08:00
@@ -265,6 +265,7 @@
 {
 	// leave it disabled and unassigned
 	struct resource *r = &dev->resource[PCI_ROM_RESOURCE];
+	u32 val;
 	
 	if (!rinfo->bios_seg)
 		return;
@@ -277,8 +278,9 @@
 		r->end -= r->start;
 		r->start = 0;
 	}
-	/* This will disable and set address to unassigned */
-	pci_write_config_dword(dev, dev->rom_base_reg, 0);
+	/* This will disable it again */
+	pci_read_config_dword(dev, dev->rom_base_reg, &val);
+	pci_write_config_dword(dev, dev->rom_base_reg, val & ~PCI_ROM_ADDRESS_ENABLE);
 }
 
 static int __devinit radeon_map_ROM(struct radeonfb_info *rinfo, struct pci_dev *dev)
@@ -310,8 +312,10 @@
 	
 	/* enable if needed */
 	if (!(r->flags & PCI_ROM_ADDRESS_ENABLE)) {
+		u32 val;
+		pci_read_config_dword(dev, dev->rom_base_reg, &val);
 		pci_write_config_dword(dev, dev->rom_base_reg,
-				       r->start | PCI_ROM_ADDRESS_ENABLE);
+				       val | PCI_ROM_ADDRESS_ENABLE);
 		r->flags |= PCI_ROM_ADDRESS_ENABLE;
 	}
 	

--Boundary-00=_SOivBJtpFmWPqIj--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
