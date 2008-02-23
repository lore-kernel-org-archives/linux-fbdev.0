From: Andres Salomon <dilinger@queued.net>
Subject: [PATCH 4/4] gxfb: use PCI_DEVICE() for gxfb's pci device table
Date: Sat, 23 Feb 2008 01:11:00 -0500
Message-ID: <20080223011100.72ca0c4f@ephemeral>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760097AbYBWGJu@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: adaplas@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, info-linux@geode.amd.com, Jordan Crouse <jordan.crouse@amd.com>


Drop the class/class_mask stuff; it's unnecessary
as long as the vendor and device IDs match.

Signed-off-by: Andres Salomon <dilinger@debian.org>
---
 drivers/video/geode/gxfb_core.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/video/geode/gxfb_core.c b/drivers/video/geode/gxfb_core.c
index 07ff4bc..08fa25e 100644
--- a/drivers/video/geode/gxfb_core.c
+++ b/drivers/video/geode/gxfb_core.c
@@ -396,9 +396,7 @@ static void gxfb_remove(struct pci_dev *pdev)
 }
 
 static struct pci_device_id gxfb_id_table[] = {
-	{ PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_GX_VIDEO,
-	  PCI_ANY_ID, PCI_ANY_ID, PCI_BASE_CLASS_DISPLAY << 16,
-	  0xff0000, 0 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_GX_VIDEO) },
 	{ 0, }
 };
 
-- 
1.5.3.7
