From: David Vrabel <dvrabel@arcom.com>
Subject: gx1fb: (try to) play nicer with various BIOSes
Date: Tue, 03 Jan 2006 16:18:44 +0000
Message-ID: <43BAA3E4.40802@arcom.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000208070705000804030906"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EtotN-0005W8-Id
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 03 Jan 2006 08:20:09 -0800
Received: from webapps.arcom.com ([194.200.159.168])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EtotJ-0004kc-MC
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 03 Jan 2006 08:20:09 -0800
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
To: linux-fbdev-devel list <linux-fbdev-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------000208070705000804030906
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

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

David Vrabel
-- 
David Vrabel, Design Engineer

Arcom, Clifton Road           Tel: +44 (0)1223 411200 ext. 3233
Cambridge CB1 7EA, UK         Web: http://www.arcom.com/

--------------000208070705000804030906
Content-Type: text/plain;
 name="w.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="w.patch"

Index: linux-2.6-working/arch/i386/pci/fixup.c
===================================================================
--- linux-2.6-working.orig/arch/i386/pci/fixup.c	2006-01-03 08:46:51.000000000 +0000
+++ linux-2.6-working/arch/i386/pci/fixup.c	2006-01-03 15:59:54.000000000 +0000
@@ -442,3 +442,19 @@
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
Index: linux-2.6-working/drivers/video/geode/gx1fb_core.c
===================================================================
--- linux-2.6-working.orig/drivers/video/geode/gx1fb_core.c	2006-01-03 08:46:54.000000000 +0000
+++ linux-2.6-working/drivers/video/geode/gx1fb_core.c	2006-01-03 16:00:43.000000000 +0000
@@ -215,11 +215,11 @@
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
 
@@ -229,12 +229,9 @@
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

--------------000208070705000804030906--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
