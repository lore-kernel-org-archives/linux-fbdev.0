From: Liu Yuan <namei.unix@gmail.com>
Date: Thu, 07 Apr 2011 09:06:18 +0000
Subject: [PATCH] drivers, video: Add a check for strict_strtoul()
Message-Id: <1302167178-9216-1-git-send-email-namei.unix@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Liu Yuan <tailai.ly@taobao.com>

It should check if strict_strtoul() succeeds.This
patch fixes it.

Signed-off-by: Liu Yuan <tailai.ly@taobao.com>
---
 drivers/video/backlight/adp5520_bl.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/video/backlight/adp5520_bl.c b/drivers/video/backlight/adp5520_bl.c
index af31197..fdef632 100644
--- a/drivers/video/backlight/adp5520_bl.c
+++ b/drivers/video/backlight/adp5520_bl.c
@@ -212,7 +212,9 @@ static ssize_t adp5520_bl_daylight_max_store(struct device *dev,
 {
 	struct adp5520_bl *data = dev_get_drvdata(dev);
 
-	strict_strtoul(buf, 10, &data->cached_daylight_max);
+	if (strict_strtoul(buf, 10, &data->cached_daylight_max) < 0)
+		return -EINVAL;
+
 	return adp5520_store(dev, buf, count, ADP5520_DAYLIGHT_MAX);
 }
 static DEVICE_ATTR(daylight_max, 0664, adp5520_bl_daylight_max_show,
-- 
1.7.1

