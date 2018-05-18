From: Sinan Kaya <okaya@codeaurora.org>
Date: Fri, 18 May 2018 14:17:50 +0000
Subject: [PATCH V2 1/2] efi/fb: Simplify fixup code to prefer struct resource
Message-Id: <1526653072-7153-1-git-send-email-okaya@codeaurora.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, timur@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sinan Kaya <okaya@codeaurora.org>, Peter Jones <pjones@redhat.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>

Get rid of base and size variables in favor of a struct resource.
The conditional for checking window can be replaced with
resource_contains().

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/video/fbdev/efifb.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index 46a4484..6daac8d 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -426,17 +426,20 @@ static void record_efifb_bar_resource(struct pci_dev *dev, int idx, u64 offset)
 
 static void efifb_fixup_resources(struct pci_dev *dev)
 {
-	u64 base = screen_info.lfb_base;
-	u64 size = screen_info.lfb_size;
+	struct resource screen_res = {
+		.start = screen_info.lfb_base,
+		.end = screen_info.lfb_base + screen_info.lfb_size - 1,
+		.flags = IORESOURCE_MEM,
+	};
 	int i;
 
 	if (efifb_pci_dev || screen_info.orig_video_isVGA != VIDEO_TYPE_EFI)
 		return;
 
 	if (screen_info.capabilities & VIDEO_CAPABILITY_64BIT_BASE)
-		base |= (u64)screen_info.ext_lfb_base << 32;
+		screen_res.start |= (u64)screen_info.ext_lfb_base << 32;
 
-	if (!base)
+	if (!screen_res.start)
 		return;
 
 	for (i = 0; i <= PCI_STD_RESOURCE_END; i++) {
@@ -445,8 +448,10 @@ static void efifb_fixup_resources(struct pci_dev *dev)
 		if (!(res->flags & IORESOURCE_MEM))
 			continue;
 
-		if (res->start <= base && res->end >= base + size - 1) {
-			record_efifb_bar_resource(dev, i, base - res->start);
+		if (resource_contains(res, &screen_res)) {
+			u64 win_offset =  screen_res.start - res->start;
+
+			record_efifb_bar_resource(dev, i, win_offset);
 			break;
 		}
 	}
-- 
2.7.4

