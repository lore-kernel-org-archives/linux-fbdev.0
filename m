From: Baole Ni <baolex.ni@intel.com>
Date: Tue, 02 Aug 2016 12:06:11 +0000
Subject: [PATCH 0993/1285] Replace numeric parameter like 0444 with macro
Message-Id: <20160802120611.16275-1-baolex.ni@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: michael.hennerich@analog.com, jingoohan1@gmail.com, lee.jones@linaro.org, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, m.chehab@samsung.com, gregkh@linuxfoundation.org, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com, mathias.nyman@linux.intel.com, stern@rowland.harvard.edu, oneukum@suse.com

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/video/backlight/adp5520_bl.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/video/backlight/adp5520_bl.c b/drivers/video/backlight/adp5520_bl.c
index dd88ba1..cedd1d6 100644
--- a/drivers/video/backlight/adp5520_bl.c
+++ b/drivers/video/backlight/adp5520_bl.c
@@ -187,7 +187,7 @@ static ssize_t adp5520_bl_dark_max_store(struct device *dev,
 {
 	return adp5520_store(dev, buf, count, ADP5520_DARK_MAX);
 }
-static DEVICE_ATTR(dark_max, 0664, adp5520_bl_dark_max_show,
+static DEVICE_ATTR(dark_max, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH, adp5520_bl_dark_max_show,
 			adp5520_bl_dark_max_store);
 
 static ssize_t adp5520_bl_office_max_show(struct device *dev,
@@ -202,7 +202,7 @@ static ssize_t adp5520_bl_office_max_store(struct device *dev,
 {
 	return adp5520_store(dev, buf, count, ADP5520_OFFICE_MAX);
 }
-static DEVICE_ATTR(office_max, 0664, adp5520_bl_office_max_show,
+static DEVICE_ATTR(office_max, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH, adp5520_bl_office_max_show,
 			adp5520_bl_office_max_store);
 
 static ssize_t adp5520_bl_daylight_max_show(struct device *dev,
@@ -224,7 +224,7 @@ static ssize_t adp5520_bl_daylight_max_store(struct device *dev,
 
 	return adp5520_store(dev, buf, count, ADP5520_DAYLIGHT_MAX);
 }
-static DEVICE_ATTR(daylight_max, 0664, adp5520_bl_daylight_max_show,
+static DEVICE_ATTR(daylight_max, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH, adp5520_bl_daylight_max_show,
 			adp5520_bl_daylight_max_store);
 
 static ssize_t adp5520_bl_dark_dim_show(struct device *dev,
@@ -239,7 +239,7 @@ static ssize_t adp5520_bl_dark_dim_store(struct device *dev,
 {
 	return adp5520_store(dev, buf, count, ADP5520_DARK_DIM);
 }
-static DEVICE_ATTR(dark_dim, 0664, adp5520_bl_dark_dim_show,
+static DEVICE_ATTR(dark_dim, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH, adp5520_bl_dark_dim_show,
 			adp5520_bl_dark_dim_store);
 
 static ssize_t adp5520_bl_office_dim_show(struct device *dev,
@@ -254,7 +254,7 @@ static ssize_t adp5520_bl_office_dim_store(struct device *dev,
 {
 	return adp5520_store(dev, buf, count, ADP5520_OFFICE_DIM);
 }
-static DEVICE_ATTR(office_dim, 0664, adp5520_bl_office_dim_show,
+static DEVICE_ATTR(office_dim, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH, adp5520_bl_office_dim_show,
 			adp5520_bl_office_dim_store);
 
 static ssize_t adp5520_bl_daylight_dim_show(struct device *dev,
@@ -269,7 +269,7 @@ static ssize_t adp5520_bl_daylight_dim_store(struct device *dev,
 {
 	return adp5520_store(dev, buf, count, ADP5520_DAYLIGHT_DIM);
 }
-static DEVICE_ATTR(daylight_dim, 0664, adp5520_bl_daylight_dim_show,
+static DEVICE_ATTR(daylight_dim, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH, adp5520_bl_daylight_dim_show,
 			adp5520_bl_daylight_dim_store);
 
 static struct attribute *adp5520_bl_attributes[] = {
-- 
2.9.2

