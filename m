From: Baole Ni <baolex.ni@intel.com>
Date: Tue, 02 Aug 2016 12:06:21 +0000
Subject: [PATCH 0995/1285] Replace numeric parameter like 0444 with macro
Message-Id: <20160802120621.16407-1-baolex.ni@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jingoohan1@gmail.com, lee.jones@linaro.org, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, m.chehab@samsung.com, gregkh@linuxfoundation.org, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com, mathias.nyman@linux.intel.com, stern@rowland.harvard.edu, oneukum@suse.com

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/video/backlight/adp8870_bl.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/video/backlight/adp8870_bl.c b/drivers/video/backlight/adp8870_bl.c
index 21acac9..107a489 100644
--- a/drivers/video/backlight/adp8870_bl.c
+++ b/drivers/video/backlight/adp8870_bl.c
@@ -593,7 +593,7 @@ static ssize_t adp8870_bl_l5_dark_max_store(struct device *dev,
 {
 	return adp8870_store(dev, buf, count, ADP8870_BLMX5);
 }
-static DEVICE_ATTR(l5_dark_max, 0664, adp8870_bl_l5_dark_max_show,
+static DEVICE_ATTR(l5_dark_max, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH, adp8870_bl_l5_dark_max_show,
 			adp8870_bl_l5_dark_max_store);
 
 
@@ -608,7 +608,7 @@ static ssize_t adp8870_bl_l4_indoor_max_store(struct device *dev,
 {
 	return adp8870_store(dev, buf, count, ADP8870_BLMX4);
 }
-static DEVICE_ATTR(l4_indoor_max, 0664, adp8870_bl_l4_indoor_max_show,
+static DEVICE_ATTR(l4_indoor_max, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH, adp8870_bl_l4_indoor_max_show,
 			adp8870_bl_l4_indoor_max_store);
 
 
@@ -624,7 +624,7 @@ static ssize_t adp8870_bl_l3_office_max_store(struct device *dev,
 	return adp8870_store(dev, buf, count, ADP8870_BLMX3);
 }
 
-static DEVICE_ATTR(l3_office_max, 0664, adp8870_bl_l3_office_max_show,
+static DEVICE_ATTR(l3_office_max, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH, adp8870_bl_l3_office_max_show,
 			adp8870_bl_l3_office_max_store);
 
 static ssize_t adp8870_bl_l2_bright_max_show(struct device *dev,
@@ -638,7 +638,7 @@ static ssize_t adp8870_bl_l2_bright_max_store(struct device *dev,
 {
 	return adp8870_store(dev, buf, count, ADP8870_BLMX2);
 }
-static DEVICE_ATTR(l2_bright_max, 0664, adp8870_bl_l2_bright_max_show,
+static DEVICE_ATTR(l2_bright_max, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH, adp8870_bl_l2_bright_max_show,
 			adp8870_bl_l2_bright_max_store);
 
 static ssize_t adp8870_bl_l1_daylight_max_show(struct device *dev,
@@ -658,7 +658,7 @@ static ssize_t adp8870_bl_l1_daylight_max_store(struct device *dev,
 
 	return adp8870_store(dev, buf, count, ADP8870_BLMX1);
 }
-static DEVICE_ATTR(l1_daylight_max, 0664, adp8870_bl_l1_daylight_max_show,
+static DEVICE_ATTR(l1_daylight_max, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH, adp8870_bl_l1_daylight_max_show,
 			adp8870_bl_l1_daylight_max_store);
 
 static ssize_t adp8870_bl_l5_dark_dim_show(struct device *dev,
@@ -673,7 +673,7 @@ static ssize_t adp8870_bl_l5_dark_dim_store(struct device *dev,
 {
 	return adp8870_store(dev, buf, count, ADP8870_BLDM5);
 }
-static DEVICE_ATTR(l5_dark_dim, 0664, adp8870_bl_l5_dark_dim_show,
+static DEVICE_ATTR(l5_dark_dim, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH, adp8870_bl_l5_dark_dim_show,
 			adp8870_bl_l5_dark_dim_store);
 
 static ssize_t adp8870_bl_l4_indoor_dim_show(struct device *dev,
@@ -688,7 +688,7 @@ static ssize_t adp8870_bl_l4_indoor_dim_store(struct device *dev,
 {
 	return adp8870_store(dev, buf, count, ADP8870_BLDM4);
 }
-static DEVICE_ATTR(l4_indoor_dim, 0664, adp8870_bl_l4_indoor_dim_show,
+static DEVICE_ATTR(l4_indoor_dim, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH, adp8870_bl_l4_indoor_dim_show,
 			adp8870_bl_l4_indoor_dim_store);
 
 
@@ -704,7 +704,7 @@ static ssize_t adp8870_bl_l3_office_dim_store(struct device *dev,
 {
 	return adp8870_store(dev, buf, count, ADP8870_BLDM3);
 }
-static DEVICE_ATTR(l3_office_dim, 0664, adp8870_bl_l3_office_dim_show,
+static DEVICE_ATTR(l3_office_dim, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH, adp8870_bl_l3_office_dim_show,
 			adp8870_bl_l3_office_dim_store);
 
 static ssize_t adp8870_bl_l2_bright_dim_show(struct device *dev,
@@ -719,7 +719,7 @@ static ssize_t adp8870_bl_l2_bright_dim_store(struct device *dev,
 {
 	return adp8870_store(dev, buf, count, ADP8870_BLDM2);
 }
-static DEVICE_ATTR(l2_bright_dim, 0664, adp8870_bl_l2_bright_dim_show,
+static DEVICE_ATTR(l2_bright_dim, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH, adp8870_bl_l2_bright_dim_show,
 			adp8870_bl_l2_bright_dim_store);
 
 static ssize_t adp8870_bl_l1_daylight_dim_show(struct device *dev,
@@ -734,7 +734,7 @@ static ssize_t adp8870_bl_l1_daylight_dim_store(struct device *dev,
 {
 	return adp8870_store(dev, buf, count, ADP8870_BLDM1);
 }
-static DEVICE_ATTR(l1_daylight_dim, 0664, adp8870_bl_l1_daylight_dim_show,
+static DEVICE_ATTR(l1_daylight_dim, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH, adp8870_bl_l1_daylight_dim_show,
 			adp8870_bl_l1_daylight_dim_store);
 
 #ifdef ADP8870_EXT_FEATURES
@@ -764,7 +764,7 @@ static ssize_t adp8870_bl_ambient_light_level_show(struct device *dev,
 
 	return sprintf(buf, "%u\n", ret_val);
 }
-static DEVICE_ATTR(ambient_light_level, 0444,
+static DEVICE_ATTR(ambient_light_level, S_IRUSR | S_IRGRP | S_IROTH,
 		adp8870_bl_ambient_light_level_show, NULL);
 
 static ssize_t adp8870_bl_ambient_light_zone_show(struct device *dev,
@@ -818,7 +818,7 @@ static ssize_t adp8870_bl_ambient_light_zone_store(struct device *dev,
 
 	return count;
 }
-static DEVICE_ATTR(ambient_light_zone, 0664,
+static DEVICE_ATTR(ambient_light_zone, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH,
 		adp8870_bl_ambient_light_zone_show,
 		adp8870_bl_ambient_light_zone_store);
 #endif
-- 
2.9.2

