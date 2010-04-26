From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Mon, 26 Apr 2010 18:09:44 +0000
Subject: [PATCH 1/4] Minimal support for viafb suspend/resume
Message-Id: <1272305387-4872-2-git-send-email-FlorianSchandinat@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1272305387-4872-1-git-send-email-FlorianSchandinat@gmx.de>
In-Reply-To: <1272305387-4872-1-git-send-email-FlorianSchandinat@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, JosephChan@via.com.tw, ScottFang@viatech.com.cn, corbet@lwn.net, Deepak Saxena <dsaxena@laptop.org>

From: Deepak Saxena <dsaxena@laptop.org>

This patch adds minimal support for suspend/resume of the
VIA framebuffer device. It requires a version of OFW
that restores the video mode.

This patch is OLPC-specific as the proper upstream solution
is to move the VIA video path to using the kernel modesetting
infrastructure and doing a proper save/restore in the kernel.

[jc: extensive changes for 2.6.34 merge]
Signed-off-by: Deepak Saxena <dsaxena@laptop.org>
---
 drivers/video/via/viafbdev.c |   51 ++++++++++++++++++++++++++++++++++++++++++
 drivers/video/via/viafbdev.h |    3 ++
 2 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/drivers/video/via/viafbdev.c b/drivers/video/via/viafbdev.c
index d21bc89..8197096 100644
--- a/drivers/video/via/viafbdev.c
+++ b/drivers/video/via/viafbdev.c
@@ -1732,6 +1732,53 @@ static int parse_mode(const char *str, u32 *xres, u32 *yres)
 	return 0;
 }
 
+
+#ifdef CONFIG_PM
+static int viafb_suspend(struct pci_dev *pdev, pm_message_t state)
+{
+	if (state.event = PM_EVENT_SUSPEND) {
+		acquire_console_sem();
+
+		memcpy_fromio(viaparinfo->shared->saved_regs,
+			      viaparinfo->shared->engine_mmio + 0x100,
+			      0xff * sizeof(u32));
+
+		fb_set_suspend(viafbinfo, 1);
+
+		viafb_sync(viafbinfo);
+
+		pci_save_state(pdev);
+		pci_disable_device(pdev);
+		pci_set_power_state(pdev, pci_choose_state(pdev, state));
+		release_console_sem();
+	}
+
+	return 0;
+}
+
+static int viafb_resume(struct pci_dev *pdev)
+{
+	acquire_console_sem();
+	pci_set_power_state(pdev, PCI_D0);
+	pci_restore_state(pdev);
+	if (pci_enable_device(pdev))
+		goto fail;
+	pci_set_master(pdev);
+
+	memcpy_toio(viaparinfo->shared->engine_mmio + 0x100,
+		    viaparinfo->shared->saved_regs,
+		    0x100 * sizeof(u32));
+
+	fb_set_suspend(viafbinfo, 0);
+
+fail:
+	release_console_sem();
+	return 0;
+}
+
+#endif
+
+
 static int __devinit via_pci_probe(struct pci_dev *pdev,
 				   const struct pci_device_id *ent)
 {
@@ -2095,6 +2142,10 @@ static struct pci_driver viafb_driver = {
 	.id_table	= viafb_pci_table,
 	.probe		= via_pci_probe,
 	.remove		= __devexit_p(via_pci_remove),
+#ifdef CONFIG_PM
+	.suspend	= viafb_suspend,
+	.resume		= viafb_resume,
+#endif
 };
 
 static int __init viafb_init(void)
diff --git a/drivers/video/via/viafbdev.h b/drivers/video/via/viafbdev.h
index 4bc00ec..d58a0ac 100644
--- a/drivers/video/via/viafbdev.h
+++ b/drivers/video/via/viafbdev.h
@@ -60,6 +60,9 @@ struct viafb_shared {
 		u8 dst_bpp, u32 dst_addr, u32 dst_pitch, u32 dst_x, u32 dst_y,
 		u32 *src_mem, u32 src_addr, u32 src_pitch, u32 src_x, u32 src_y,
 		u32 fg_color, u32 bg_color, u8 fill_rop);
+
+	/* For suspend/resume */
+	u32 saved_regs[0x100];
 };
 
 struct viafb_par {
-- 
1.6.3.2

