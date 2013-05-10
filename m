From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Fri, 10 May 2013 11:58:49 +0000
Subject: [PATCH 2/2] video: udlfb: Make local symbol static
Message-Id: <1368186409-30709-2-git-send-email-sachin.kamat@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

'dlfb_handle_damage' is used only in this file. Make it static.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/video/udlfb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/udlfb.c b/drivers/video/udlfb.c
index 20353a6..d2e5bc3 100644
--- a/drivers/video/udlfb.c
+++ b/drivers/video/udlfb.c
@@ -573,7 +573,7 @@ static int dlfb_render_hline(struct dlfb_data *dev, struct urb **urb_ptr,
 	return 0;
 }
 
-int dlfb_handle_damage(struct dlfb_data *dev, int x, int y,
+static int dlfb_handle_damage(struct dlfb_data *dev, int x, int y,
 	       int width, int height, char *data)
 {
 	int i, ret;
-- 
1.7.9.5

