From: aherrman@arcor.de
Subject: [PATCH 4/4] radeonfb: use PCI device Id in hex for name string
Date: Tue, 4 Sep 2007 13:00:50 +0200
Message-ID: <20070904110050.GH7320@devil>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753721AbXIDK7l@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: benh@kernel.crashing.org, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

.. instead of potentially using nonprintable characters.

I guess the former (odd) concatenation was used to construct name strings
that match the  "*_ATI_RADEON_??" macros in include/linux/pci_ids.h

The PCI Id in hex is much more convenient to use. E.g. it can easily be
verified against "lspci -nn" output.

Signed-off-by: Andreas Herrmann <aherrman@arcor.de>
---
 drivers/video/aty/radeon_base.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/video/aty/radeon_base.c b/drivers/video/aty/radeon_base.c
index 71b0c17..e6229b4 100644
--- a/drivers/video/aty/radeon_base.c
+++ b/drivers/video/aty/radeon_base.c
@@ -2184,9 +2184,8 @@ static int __devinit radeonfb_pci_register (struct pci_dev *pdev,
 	rinfo->lvds_timer.function = radeon_lvds_timer_func;
 	rinfo->lvds_timer.data = (unsigned long)rinfo;
 
-	strcpy(rinfo->name, "ATI Radeon XX ");
-	rinfo->name[11] = ent->device >> 8;
-	rinfo->name[12] = ent->device & 0xFF;
+	snprintf(rinfo->name, sizeof(rinfo->name),
+		 "ATI Radeon %x", ent->device & 0xffff);
 	rinfo->family = ent->driver_data & CHIP_FAMILY_MASK;
 	rinfo->chipset = pdev->device;
 	rinfo->has_CRTC2 = (ent->driver_data & CHIP_HAS_CRTC2) != 0;
-- 
1.5.3
