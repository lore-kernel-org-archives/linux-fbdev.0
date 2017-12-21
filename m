From: Mathieu Malaterre <malat@debian.org>
Date: Thu, 21 Dec 2017 22:07:56 +0000
Subject: [PATCH v3] Fix loading of module radeonfb on PowerMac
Message-Id: <20171221220757.24672-1-malat@debian.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1479153557-20849-1-git-send-email-malat@debian.org>
In-Reply-To: <1479153557-20849-1-git-send-email-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>, Mathieu Malaterre <malat@debian.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org

When the linux kernel is build with (typical kernel ship with Debian
installer):

CONFIG_FB_OF=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_FB_RADEON=m

The offb driver takes precedence over module radeonfb. It is then
impossible to load the module, error reported is:

[   96.551486] radeonfb 0000:00:10.0: enabling device (0006 -> 0007)
[   96.551526] radeonfb 0000:00:10.0: BAR 0: can't reserve [mem 0x98000000-0x9fffffff pref]
[   96.551531] radeonfb (0000:00:10.0): cannot request region 0.
[   96.551545] radeonfb: probe of 0000:00:10.0 failed with error -16

This patch reproduce the behavior of the module radeon, so as to make it
possible to load radeonfb when offb is first loaded.

It should be noticed that `offb_destroy` is never called which explain the
need to skip error detection on the radeon side.

Signed-off-by: Mathieu Malaterre <malat@debian.org>
Link: https://bugs.debian.org/826629#57
Link: https://bugzilla.kernel.org/show_bug.cgi?id9741
Suggested-by: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
---
v2: Only fails when CONFIG_PCC is not set
v3: Only fails when CONFIG_FB_OF is not set, CONFIG_PCC was too broad. Since the conflicts in region is due to OFfb explicitly refers to it.

 drivers/video/fbdev/aty/radeon_base.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/video/fbdev/aty/radeon_base.c b/drivers/video/fbdev/aty/radeon_base.c
index 4d77daeecf99..221879196531 100644
--- a/drivers/video/fbdev/aty/radeon_base.c
+++ b/drivers/video/fbdev/aty/radeon_base.c
@@ -2259,6 +2259,22 @@ static const struct bin_attribute edid2_attr = {
 	.read	= radeon_show_edid2,
 };
 
+static int radeon_kick_out_firmware_fb(struct pci_dev *pdev)
+{
+	struct apertures_struct *ap;
+
+	ap = alloc_apertures(1);
+	if (!ap)
+		return -ENOMEM;
+
+	ap->ranges[0].base = pci_resource_start(pdev, 0);
+	ap->ranges[0].size = pci_resource_len(pdev, 0);
+
+	remove_conflicting_framebuffers(ap, KBUILD_MODNAME, false);
+	kfree(ap);
+
+	return 0;
+}
 
 static int radeonfb_pci_register(struct pci_dev *pdev,
 				 const struct pci_device_id *ent)
@@ -2312,19 +2328,27 @@ static int radeonfb_pci_register(struct pci_dev *pdev,
 	rinfo->fb_base_phys = pci_resource_start (pdev, 0);
 	rinfo->mmio_base_phys = pci_resource_start (pdev, 2);
 
+	ret = radeon_kick_out_firmware_fb(pdev);
+	if (ret)
+		return ret;
+
 	/* request the mem regions */
 	ret = pci_request_region(pdev, 0, "radeonfb framebuffer");
 	if (ret < 0) {
+#ifndef CONFIG_FB_OF
 		printk( KERN_ERR "radeonfb (%s): cannot request region 0.\n",
 			pci_name(rinfo->pdev));
 		goto err_release_fb;
+#endif
 	}
 
 	ret = pci_request_region(pdev, 2, "radeonfb mmio");
 	if (ret < 0) {
+#ifndef CONFIG_FB_OF
 		printk( KERN_ERR "radeonfb (%s): cannot request region 2.\n",
 			pci_name(rinfo->pdev));
 		goto err_release_pci0;
+#endif
 	}
 
 	/* map the regions */
@@ -2509,10 +2533,12 @@ static int radeonfb_pci_register(struct pci_dev *pdev,
 	iounmap(rinfo->mmio_base);
 err_release_pci2:
 	pci_release_region(pdev, 2);
+#ifndef CONFIG_FB_OF
 err_release_pci0:
 	pci_release_region(pdev, 0);
 err_release_fb:
         framebuffer_release(info);
+#endif
 err_disable:
 err_out:
 	return ret;
-- 
2.11.0

