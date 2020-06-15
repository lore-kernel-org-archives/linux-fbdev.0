From: Wang Qing <wangqing@vivo.com>
Date: Mon, 15 Jun 2020 08:54:02 +0000
Subject: [PATCH] drivers/video/backlight: Use kobj_to_dev() instead
Message-Id: <1592211242-31683-1-git-send-email-wangqing@vivo.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Wang Qing <wangqing@vivo.com>

Use kobj_to_dev() instead of container_of()

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/video/backlight/lm3533_bl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 mode change 100644 => 100755 drivers/video/backlight/lm3533_bl.c

diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backlight/lm3533_bl.c
index ee09d1b..0c7830f
--- a/drivers/video/backlight/lm3533_bl.c
+++ b/drivers/video/backlight/lm3533_bl.c
@@ -235,7 +235,7 @@ static struct attribute *lm3533_bl_attributes[] = {
 static umode_t lm3533_bl_attr_is_visible(struct kobject *kobj,
 					     struct attribute *attr, int n)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct lm3533_bl *bl = dev_get_drvdata(dev);
 	umode_t mode = attr->mode;
 
-- 
2.7.4
