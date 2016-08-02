From: Baole Ni <baolex.ni@intel.com>
Date: Tue, 02 Aug 2016 12:06:45 +0000
Subject: [PATCH 0999/1285] Replace numeric parameter like 0444 with macro
Message-Id: <20160802120645.16675-1-baolex.ni@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, m.chehab@samsung.com, gregkh@linuxfoundation.org, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de, chuansheng.liu@intel.com, baolex.ni@intel.com, mathias.nyman@linux.intel.com, stern@rowland.harvard.edu, oneukum@suse.com

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/video/fbdev/auo_k190x.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/auo_k190x.c b/drivers/video/fbdev/auo_k190x.c
index 9580374..7e62a38 100644
--- a/drivers/video/fbdev/auo_k190x.c
+++ b/drivers/video/fbdev/auo_k190x.c
@@ -707,9 +707,9 @@ static ssize_t temp_show(struct device *dev, struct device_attribute *attr,
 	return sprintf(buf, "%d\n", temp);
 }
 
-static DEVICE_ATTR(update_mode, 0644, update_mode_show, update_mode_store);
-static DEVICE_ATTR(flash, 0644, flash_show, flash_store);
-static DEVICE_ATTR(temp, 0644, temp_show, NULL);
+static DEVICE_ATTR(update_mode, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, update_mode_show, update_mode_store);
+static DEVICE_ATTR(flash, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, flash_show, flash_store);
+static DEVICE_ATTR(temp, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, temp_show, NULL);
 
 static struct attribute *auok190x_attributes[] = {
 	&dev_attr_update_mode.attr,
-- 
2.9.2

