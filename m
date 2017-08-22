From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Tue, 22 Aug 2017 18:29:48 +0000
Subject: [PATCH] video: fm2fb: constify zorro_device_id
Message-Id: <e530300dd132c9567ea6f7e8c6b923ed4dfb35a0.1503425803.git.arvind.yadav.cs@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

zorro_device_id are not supposed to change at runtime. All functions
working with zorro_device_id provided by <linux/zorro.h> work with
const zorro_device_id. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/video/fbdev/fm2fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/fm2fb.c b/drivers/video/fbdev/fm2fb.c
index e69d47a..ac7a4eb 100644
--- a/drivers/video/fbdev/fm2fb.c
+++ b/drivers/video/fbdev/fm2fb.c
@@ -213,7 +213,7 @@ static int fm2fb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
 
 static int fm2fb_probe(struct zorro_dev *z, const struct zorro_device_id *id);
 
-static struct zorro_device_id fm2fb_devices[] = {
+static const struct zorro_device_id fm2fb_devices[] = {
 	{ ZORRO_PROD_BSC_FRAMEMASTER_II },
 	{ ZORRO_PROD_HELFRICH_RAINBOW_II },
 	{ 0 }
-- 
2.7.4

