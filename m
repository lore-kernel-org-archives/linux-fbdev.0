From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sat, 30 Apr 2011 14:18:04 +0000
Subject: [PATCH 1/3] viafb: use write combining for video ram
Message-Id: <1304173086-3434-2-git-send-email-FlorianSchandinat@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1304173086-3434-1-git-send-email-FlorianSchandinat@gmx.de>
In-Reply-To: <1304173086-3434-1-git-send-email-FlorianSchandinat@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

This can give a speed up of factor 6-9, which is quite notable.

Signed-off-by: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
---
 drivers/video/via/via-core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/via/via-core.c b/drivers/video/via/via-core.c
index 6723d69..5b0129b 100644
--- a/drivers/video/via/via-core.c
+++ b/drivers/video/via/via-core.c
@@ -505,7 +505,7 @@ static int __devinit via_pci_setup_mmio(struct viafb_dev *vdev)
 	ret = vdev->fbmem_len = viafb_get_fb_size_from_pci(vdev->chip_type);
 	if (ret < 0)
 		goto out_unmap;
-	vdev->fbmem = ioremap_nocache(vdev->fbmem_start, vdev->fbmem_len);
+	vdev->fbmem = ioremap_wc(vdev->fbmem_start, vdev->fbmem_len);
 	if (vdev->fbmem = NULL) {
 		ret = -ENOMEM;
 		goto out_unmap;
-- 
1.6.3.2

