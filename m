From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 1/2] intelfb: Do not ioremap entire graphics aperture
Date: Mon, 15 Aug 2005 21:27:13 +0800
Message-ID: <43009831.4050705@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E4fAH-000679-Is
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Aug 2005 06:38:09 -0700
Received: from zproxy.gmail.com ([64.233.162.198])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E4fAH-0000Xe-6J
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Aug 2005 06:38:09 -0700
Received: by zproxy.gmail.com with SMTP id s18so704403nze
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 15 Aug 2005 06:38:02 -0700 (PDT)
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Sylvain Meyer <sylvain.meyer@worldonline.fr>, Pavel Kysilka <goldenfish@bsys.cz>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Reported by: Pavel Kysilka (Bugzilla Bug 4738)

modprobe of intelfb results in the following error message:

prog3:/usr/src/linux-2.6.12-rc6# modprobe intelfb
intelfb: Framebuffer driver for Intel(R) 830M/845G/852GM/855GM/865G/915G chi
intelfb: Version 0.9.2
ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 16
allocation failed: out of vmalloc space - use vmalloc=<size> to increase siz
intelfb: Cannot remap FB region.
prog3:/usr/src/linux-2.6.12-rc6#

This will fail if the graphics aperture size is greater than 128 MB.

Fix is to ioremap only from the beginning of graphics aperture to the end
of the used framebuffer memory.

From: Sylvain Meyer <sylvain.meyer@worldonline.fr>
Signed-off-by: Sylvain Meyer <sylvain.meyer@worldonline.fr>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

intelfbdrv.c |   50 +++++++++++++++++++++++++++-----------------------
1 files changed, 27 insertions(+), 23 deletions(-)

diff --git a/drivers/video/intelfb/intelfbdrv.c b/drivers/video/intelfb/intelfbdrv.c
--- a/drivers/video/intelfb/intelfbdrv.c
+++ b/drivers/video/intelfb/intelfbdrv.c
@@ -579,23 +579,6 @@ intelfb_pci_register(struct pci_dev *pde
		return -ENODEV;
	}

-	/* Map the fb and MMIO regions */
-	dinfo->aperture.virtual = (u8 __iomem *)ioremap_nocache
-		(dinfo->aperture.physical, dinfo->aperture.size);
-	if (!dinfo->aperture.virtual) {
-		ERR_MSG("Cannot remap FB region.\n");
-		cleanup(dinfo);
-		return -ENODEV;
-	}
-	dinfo->mmio_base =
-		(u8 __iomem *)ioremap_nocache(dinfo->mmio_base_phys,
-					       INTEL_REG_SIZE);
-	if (!dinfo->mmio_base) {
-		ERR_MSG("Cannot remap MMIO region.\n");
-		cleanup(dinfo);
-		return -ENODEV;
-	}
-
	/* Get the chipset info. */
	dinfo->pci_chipset = pdev->device;

@@ -626,9 +609,15 @@ intelfb_pci_register(struct pci_dev *pde
		dinfo->accel = 0;
	}

+	if (MB(voffset) < stolen_size)
+		offset = (stolen_size >> 12);
+	else
+		offset = ROUND_UP_TO_PAGE(MB(voffset))/GTT_PAGE_SIZE;
+
	/* Framebuffer parameters - Use all the stolen memory if >= vram */
-	if (ROUND_UP_TO_PAGE(stolen_size) >= MB(vram)) {
+	if (ROUND_UP_TO_PAGE(stolen_size) >= ((offset << 12) +  MB(vram))) {
		dinfo->fb.size = ROUND_UP_TO_PAGE(stolen_size);
+		dinfo->fb.offset = 0;
		dinfo->fbmem_gart = 0;
	} else {
		dinfo->fb.size =  MB(vram);
@@ -659,11 +648,6 @@ intelfb_pci_register(struct pci_dev *pde
		return -ENODEV;
	}

-	if (MB(voffset) < stolen_size)
-		offset = (stolen_size >> 12);
-	else
-		offset = ROUND_UP_TO_PAGE(MB(voffset))/GTT_PAGE_SIZE;
-
	/* set the mem offsets - set them after the already used pages */
	if (dinfo->accel) {
		dinfo->ring.offset = offset + gtt_info.current_memory;
@@ -678,6 +662,26 @@ intelfb_pci_register(struct pci_dev *pde
			+ (dinfo->cursor.size >> 12);
	}

+	/* Map the fb and MMIO regions */
+	/* ioremap only up to the end of used aperture */
+	dinfo->aperture.virtual = (u8 __iomem *)ioremap_nocache
+		(dinfo->aperture.physical, (dinfo->fb.offset << 12)
+		 + dinfo->fb.size);
+	if (!dinfo->aperture.virtual) {
+		ERR_MSG("Cannot remap FB region.\n");
+		cleanup(dinfo);
+		return -ENODEV;
+	}
+
+	dinfo->mmio_base =
+		(u8 __iomem *)ioremap_nocache(dinfo->mmio_base_phys,
+					       INTEL_REG_SIZE);
+	if (!dinfo->mmio_base) {
+		ERR_MSG("Cannot remap MMIO region.\n");
+		cleanup(dinfo);
+		return -ENODEV;
+	}
+
	/* Allocate memories (which aren't stolen) */
	if (dinfo->accel) {
		if (!(dinfo->gtt_ring_mem =








-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
