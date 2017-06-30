From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Fri, 30 Jun 2017 20:57:43 +0000
Subject: [PATCH RESEND] staging: sm750fb: avoid conflicting vesafb
Message-Id: <1498856263-4544-1-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, Teddy Wang <teddy.wang@siliconmotion.com>, stable@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

From: Teddy Wang <teddy.wang@siliconmotion.com>

If vesafb is enabled in the config then /dev/fb0 is created by vesa
and this sm750 driver gets fb1, fb2. But we need to be fb0 and fb1 to
effectively work with xorg.
So if it has been alloted fb1, then try to remove the other fb0.

Cc: <stable@vger.kernel.org> # v4.4+
Signed-off-by: Teddy Wang <teddy.wang@siliconmotion.com>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---

In the previous send, why #ifdef is used was asked.
https://lkml.org/lkml/2017/6/25/57

Answered at: https://lkml.org/lkml/2017/6/25/69
Also pasting here for reference.

'Did a quick research into "why".
The patch d8801e4df91e ("x86/PCI: Set IORESOURCE_ROM_SHADOW only for the
default VGA device") has started setting IORESOURCE_ROM_SHADOW in flags
for a default VGA device and that is being done only for x86.
And so, we will need that #ifdef to check IORESOURCE_ROM_SHADOW as that
needs to be checked only for a x86 and not for other arch.'

 drivers/staging/sm750fb/sm750.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index d5934f3..8199dbe 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -1053,6 +1053,26 @@ static int sm750fb_frambuffer_alloc(struct sm750_dev *sm750_dev, int fbidx)
 	return err;
 }
 
+static int lynxfb_kick_out_firmware_fb(struct pci_dev *pdev)
+{
+	struct apertures_struct *ap;
+	bool primary = false;
+
+	ap = alloc_apertures(1);
+	if (!ap)
+		return -ENOMEM;
+
+	ap->ranges[0].base = pci_resource_start(pdev, 0);
+	ap->ranges[0].size = pci_resource_len(pdev, 0);
+#ifdef CONFIG_X86
+	primary = pdev->resource[PCI_ROM_RESOURCE].flags &
+					IORESOURCE_ROM_SHADOW;
+#endif
+	remove_conflicting_framebuffers(ap, "sm750_fb1", primary);
+	kfree(ap);
+	return 0;
+}
+
 static int lynxfb_pci_probe(struct pci_dev *pdev,
 			    const struct pci_device_id *ent)
 {
@@ -1061,6 +1081,10 @@ static int lynxfb_pci_probe(struct pci_dev *pdev,
 	int fbidx;
 	int err;
 
+	err = lynxfb_kick_out_firmware_fb(pdev);
+	if (err)
+		return err;
+
 	/* enable device */
 	err = pcim_enable_device(pdev);
 	if (err)
-- 
1.9.1

