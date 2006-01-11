From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 2/5] gx1fb: (try to) play nicer with various BIOSes
Date: Wed, 11 Jan 2006 19:54:44 +0800
Message-ID: <43C4F204.1050401@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ewf5U-0005pg-Bx
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 11 Jan 2006 04:28:24 -0800
Received: from zproxy.gmail.com ([64.233.162.206])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Ewf5U-0006t5-3f
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 11 Jan 2006 04:28:24 -0800
Received: by zproxy.gmail.com with SMTP id r28so137883nza
        for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 11 Jan 2006 04:28:21 -0800 (PST)
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
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, David Vrabel <dvrabel@arcom.com>

From: David Vrabel <dvrabel@arcom.com>

Seems that the CS5530A chip used in Geode GX1 systems has some crazy
feature that causes SMI traps when accessing the PCI configuration space
of the video device.  Various GX1 BIOSes seem to use this 'feature' to
hide the real BARs of the device.  This patch disables these traps (in
an  early PCI fixup) so that Linux sees the real, physical BARs and not
the virtual ones provided by the BIOS.

This should allow the GX1 framebuffer driver to work on more systems
that have different BIOSes as the driver no longer guesses at what the
virtual BARs mean.

I'm not entirely sure it the correct solution as I can neither test
regular VGA console nor the X's 'cyrix' video driver so there might be
some breakage there -- probably best to get some more testers before
applying it.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 arch/i386/pci/fixup.c            |   16 ++++++++++++++++
 drivers/video/geode/gx1fb_core.c |   11 ++++-------
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/arch/i386/pci/fixup.c b/arch/i386/pci/fixup.c
index 65f6707..83c3645 100644
--- a/arch/i386/pci/fixup.c
+++ b/arch/i386/pci/fixup.c
@@ -449,3 +449,19 @@ static void __devinit pci_post_fixup_tos
 }
 DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_TI, 0x8032,
 			 pci_post_fixup_toshiba_ohci1394);
+
+
+/*
+ * Prevent the BIOS trapping accesses to the Cyrix CS5530A video device
+ * configuration space.
+ */
+static void __devinit pci_early_fixup_cyrix_5530(struct pci_dev *dev)
+{
+	u8 r;
+	/* clear 'F4 Video Configuration Trap' bit */
+	pci_read_config_byte(dev, 0x42, &r);
+	r &= 0xfd;
+	pci_write_config_byte(dev, 0x42, r);
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_CYRIX, PCI_DEVICE_ID_CYRIX_5530_LEGACY,
+			pci_early_fixup_cyrix_5530);
diff --git a/drivers/video/geode/gx1fb_core.c b/drivers/video/geode/gx1fb_core.c
index 8e8da74..20e6915 100644
--- a/drivers/video/geode/gx1fb_core.c
+++ b/drivers/video/geode/gx1fb_core.c
@@ -215,11 +215,11 @@ static int __init gx1fb_map_video_memory
 	if (ret < 0)
 		return ret;
 
-	ret = pci_request_region(dev, 1, "gx1fb (video)");
+	ret = pci_request_region(dev, 0, "gx1fb (video)");
 	if (ret < 0)
 		return ret;
-	par->vid_regs = ioremap(pci_resource_start(dev, 1),
-				pci_resource_len(dev, 1));
+	par->vid_regs = ioremap(pci_resource_start(dev, 0),
+				pci_resource_len(dev, 0));
 	if (!par->vid_regs)
 		return -ENOMEM;
 
@@ -229,12 +229,9 @@ static int __init gx1fb_map_video_memory
 	if (!par->dc_regs)
 		return -ENOMEM;
 
-	ret = pci_request_region(dev, 0, "gx1fb (frame buffer)");
-	if (ret < 0 )
-		return -EBUSY;
 	if ((fb_len = gx1_frame_buffer_size()) < 0)
 		return -ENOMEM;
-	info->fix.smem_start = pci_resource_start(dev, 0);
+	info->fix.smem_start = gx_base + 0x800000;
 	info->fix.smem_len = fb_len;
 	info->screen_base = ioremap(info->fix.smem_start, info->fix.smem_len);
 	if (!info->screen_base)





-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
