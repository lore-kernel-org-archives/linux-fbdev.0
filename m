From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Subject: [PATCH] viafb: fix ioremap_nocache error handling
Date: Fri, 14 Aug 2009 19:47:56 +0000
Message-ID: <1250279276-3936-1-git-send-email-FlorianSchandinat@gmx.de>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757041AbZHNTqS@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, JosephChan@via.com.tw, ScottFang@viatech.com.cn, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

viafb: fix ioremap_nocache error handling

Correct the returned error code for remapping the video framebuffer.
Introduce error handling for remapping MMIO register address space to
avoid a NULL pointer dereference. Disable hardware acceleration if
remapping MMIO register address space failed as those registers are only
used for hardware acceleration.

Signed-off-by: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
---
 viafbdev.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/video/via/viafbdev.c b/drivers/video/via/viafbdev.c
index 743eed4..72759b6 100644
--- a/drivers/video/via/viafbdev.c
+++ b/drivers/video/via/viafbdev.c
@@ -2134,12 +2134,16 @@ static int __devinit via_pci_probe(void)
 
 	if (!viaparinfo->fbmem_virt) {
 		printk(KERN_INFO "ioremap failed\n");
-		return -1;
+		return -ENOMEM;
 	}
 
 	viafb_get_mmio_info(&viaparinfo->mmio_base, &viaparinfo->mmio_len);
 	viaparinfo->io_virt = ioremap_nocache(viaparinfo->mmio_base,
 		viaparinfo->mmio_len);
+	if (!viaparinfo->io_virt) {
+		printk(KERN_WARNING "ioremap failed: hardware acceleration disabled\n");
+		viafb_accel = 0;
+	}
 
 	viafbinfo->node = 0;
 	viafbinfo->fbops = &viafb_ops;
-- 
1.6.3.2
