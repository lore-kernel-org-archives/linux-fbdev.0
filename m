From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Wed, 25 Sep 2013 11:41:49 +0000
Subject: [PATCH 1/6] video: udlfb: Use NULL instead of 0
Message-Id: <1380108594-19090-1-git-send-email-sachin.kamat@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

new_back is a pointer. Use NULL instead of 0.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Bernie Thompson <bernie@plugable.com>
---
 drivers/video/udlfb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/udlfb.c b/drivers/video/udlfb.c
index d2e5bc3..025f14e 100644
--- a/drivers/video/udlfb.c
+++ b/drivers/video/udlfb.c
@@ -1166,7 +1166,7 @@ static int dlfb_realloc_framebuffer(struct dlfb_data *dev, struct fb_info *info)
 	int new_len;
 	unsigned char *old_fb = info->screen_base;
 	unsigned char *new_fb;
-	unsigned char *new_back = 0;
+	unsigned char *new_back = NULL;
 
 	pr_warn("Reallocating framebuffer. Addresses will change!\n");
 
-- 
1.7.9.5

