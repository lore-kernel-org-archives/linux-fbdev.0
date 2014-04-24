From: Masanari Iida <standby24x7@gmail.com>
Date: Thu, 24 Apr 2014 15:47:16 +0000
Subject: [PATCH] video/backlight: Fix string type mismatch in s6e63m0.c
Message-Id: <1398354436-25467-1-git-send-email-standby24x7@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jg1.han@samsung.com, cooloney@gmail.com, lee.jones@linaro.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Masanari Iida <standby24x7@gmail.com>

Fix string type mismatch in s6e63m0_sysfs_show_gamma_table().
gamma_table_count is defined as unsigned int.

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 drivers/video/backlight/s6e63m0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/s6e63m0.c b/drivers/video/backlight/s6e63m0.c
index 510a1bc..2d6d481 100644
--- a/drivers/video/backlight/s6e63m0.c
+++ b/drivers/video/backlight/s6e63m0.c
@@ -703,7 +703,7 @@ static ssize_t s6e63m0_sysfs_show_gamma_table(struct device *dev,
 	struct s6e63m0 *lcd = dev_get_drvdata(dev);
 	char temp[3];
 
-	sprintf(temp, "%d\n", lcd->gamma_table_count);
+	sprintf(temp, "%u\n", lcd->gamma_table_count);
 	strcpy(buf, temp);
 
 	return strlen(buf);
-- 
2.0.0.rc0.26.g779792a

