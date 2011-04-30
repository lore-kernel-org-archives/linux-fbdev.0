From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sat, 30 Apr 2011 14:18:05 +0000
Subject: [PATCH 2/3] viafb: try to map less memory in case of failure
Message-Id: <1304173086-3434-3-git-send-email-FlorianSchandinat@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1304173086-3434-1-git-send-email-FlorianSchandinat@gmx.de>
In-Reply-To: <1304173086-3434-1-git-send-email-FlorianSchandinat@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

The current code might result in trying to remap 512MB video ram on
a 32 bit system which is quite likely to fail.
This patch tries to map less of it down to 8MB as this should still
be enough to get a reasonably well working framebuffer. This should
make viafb work for many people without requiring them to manually
allocate more space.

Signed-off-by: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
---
 drivers/video/via/via-core.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/video/via/via-core.c b/drivers/video/via/via-core.c
index 5b0129b..eb112b6 100644
--- a/drivers/video/via/via-core.c
+++ b/drivers/video/via/via-core.c
@@ -505,7 +505,14 @@ static int __devinit via_pci_setup_mmio(struct viafb_dev *vdev)
 	ret = vdev->fbmem_len = viafb_get_fb_size_from_pci(vdev->chip_type);
 	if (ret < 0)
 		goto out_unmap;
-	vdev->fbmem = ioremap_wc(vdev->fbmem_start, vdev->fbmem_len);
+
+	/* try to map less memory on failure, 8 MB should be still enough */
+	for (; vdev->fbmem_len >= 8 << 20; vdev->fbmem_len /= 2) {
+		vdev->fbmem = ioremap_wc(vdev->fbmem_start, vdev->fbmem_len);
+		if (vdev->fbmem)
+			break;
+	}
+
 	if (vdev->fbmem = NULL) {
 		ret = -ENOMEM;
 		goto out_unmap;
-- 
1.6.3.2

