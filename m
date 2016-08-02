From: Baole Ni <baolex.ni@intel.com>
Date: Tue, 02 Aug 2016 12:09:17 +0000
Subject: [PATCH 1023/1285] Replace numeric parameter like 0444 with macro
Message-Id: <20160802120917.18309-1-baolex.ni@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/video/fbdev/wm8505fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/wm8505fb.c b/drivers/video/fbdev/wm8505fb.c
index e925619..c704303 100644
--- a/drivers/video/fbdev/wm8505fb.c
+++ b/drivers/video/fbdev/wm8505fb.c
@@ -182,7 +182,7 @@ static ssize_t contrast_store(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR(contrast, 0644, contrast_show, contrast_store);
+static DEVICE_ATTR(contrast, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, contrast_show, contrast_store);
 
 static inline u_int chan_to_field(u_int chan, struct fb_bitfield *bf)
 {
-- 
2.9.2

