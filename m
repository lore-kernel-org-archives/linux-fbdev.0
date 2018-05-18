From: rkir@google.com
Date: Fri, 18 May 2018 23:31:56 +0000
Subject: [PATCH] Fix checkpatch warnings in goldfishfb.c
Message-Id: <20180518233156.84527-1-rkir@google.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Roman Kiryanov <rkir@google.com>

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 drivers/video/fbdev/goldfishfb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/goldfishfb.c b/drivers/video/fbdev/goldfishfb.c
index 3b70044773b6..de29c4ff77e5 100644
--- a/drivers/video/fbdev/goldfishfb.c
+++ b/drivers/video/fbdev/goldfishfb.c
@@ -124,6 +124,7 @@ static int goldfish_fb_check_var(struct fb_var_screeninfo *var,
 static int goldfish_fb_set_par(struct fb_info *info)
 {
 	struct goldfish_fb *fb = container_of(info, struct goldfish_fb, fb);
+
 	if (fb->rotation != fb->fb.var.rotate) {
 		info->fix.line_length = info->var.xres * 2;
 		fb->rotation = fb->fb.var.rotate;
@@ -148,13 +149,14 @@ static int goldfish_fb_pan_display(struct fb_var_screeninfo *var,
 	wait_event_timeout(fb->wait,
 			fb->base_update_count != base_update_count, HZ / 15);
 	if (fb->base_update_count = base_update_count)
-		pr_err("goldfish_fb_pan_display: timeout waiting for base update\n");
+		pr_err("%s: timeout waiting for base update\n", __func__);
 	return 0;
 }
 
 static int goldfish_fb_blank(int blank, struct fb_info *info)
 {
 	struct goldfish_fb *fb = container_of(info, struct goldfish_fb, fb);
+
 	switch (blank) {
 	case FB_BLANK_NORMAL:
 		writel(1, fb->reg_base + FB_SET_BLANK);
-- 
2.17.0.441.gb46fe60e1d-goog

