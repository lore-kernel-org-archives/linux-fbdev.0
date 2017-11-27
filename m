From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 27 Nov 2017 09:16:29 +0000
Subject: [PATCH] video: fb_ddc: Delete an error message for a failed memory allocation in fb_do_probe_ddc_edi
Message-Id: <93d83083-b0ee-5993-3b7b-329999c9afcd@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 27 Nov 2017 10:12:26 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/video/fbdev/core/fb_ddc.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/core/fb_ddc.c b/drivers/video/fbdev/core/fb_ddc.c
index 8bf5f2f54be7..256b518d1db9 100644
--- a/drivers/video/fbdev/core/fb_ddc.c
+++ b/drivers/video/fbdev/core/fb_ddc.c
@@ -37,11 +37,8 @@ static unsigned char *fb_do_probe_ddc_edid(struct i2c_adapter *adapter)
 		}
 	};
 
-	if (!buf) {
-		dev_warn(&adapter->dev, "unable to allocate memory for EDID "
-			 "block.\n");
+	if (!buf)
 		return NULL;
-	}
 
 	if (i2c_transfer(adapter, msgs, 2) = 2)
 		return buf;
-- 
2.15.0

