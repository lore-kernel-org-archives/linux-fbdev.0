From: Kangjie Lu <kjlu@umn.edu>
Date: Thu, 14 Mar 2019 07:30:27 +0000
Subject: [PATCH] video: hgafb: fix a NULL pointer dereference
Message-Id: <20190314073027.22337-1-kjlu@umn.edu>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kjlu@umn.edu
Cc: pakki001@umn.edu, Ferenc Bakonyi <fero@drama.obuda.kando.hu>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-nvidia@lists.surfsouth.com, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

When ioremap fails, hga_vram should not be dereferenced. The fix
check the failure to avoid NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/video/fbdev/hgafb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/hgafb.c b/drivers/video/fbdev/hgafb.c
index 463028543173..59e1cae57948 100644
--- a/drivers/video/fbdev/hgafb.c
+++ b/drivers/video/fbdev/hgafb.c
@@ -285,6 +285,8 @@ static int hga_card_detect(void)
 	hga_vram_len  = 0x08000;
 
 	hga_vram = ioremap(0xb0000, hga_vram_len);
+	if (!hga_vram)
+		goto error;
 
 	if (request_region(0x3b0, 12, "hgafb"))
 		release_io_ports = 1;
-- 
2.17.1
