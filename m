From: Baole Ni <baolex.ni@intel.com>
Date: Tue, 02 Aug 2016 12:06:16 +0000
Subject: [PATCH 0994/1285] Replace numeric parameter like 0444 with macro
Message-Id: <20160802120616.16341-1-baolex.ni@intel.com>
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
 drivers/video/backlight/adp8860_bl.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/video/backlight/adp8860_bl.c b/drivers/video/backlight/adp8860_bl.c
index 510e559..d0cf892 100644
--- a/drivers/video/backlight/adp8860_bl.c
+++ b/drivers/video/backlight/adp8860_bl.c
@@ -473,7 +473,7 @@ static ssize_t adp8860_bl_l3_dark_max_store(struct device *dev,
 	return adp8860_store(dev, buf, count, ADP8860_BLMX3);
 }
 
-static DEVICE_ATTR(l3_dark_max, 0664, adp8860_bl_l3_dark_max_show,
+static DEVICE_ATTR(l3_dark_max, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH, adp8860_bl_l3_dark_max_show,
 			adp8860_bl_l3_dark_max_store);
 
 static ssize_t adp8860_bl_l2_office_max_show(struct device *dev,
@@ -487,7 +487,7 @@ static ssize_t adp8860_bl_l2_office_max_store(struct device *dev,
 {
 	return adp8860_store(dev, buf, count, ADP8860_BLMX2);
 }
-static DEVICE_ATTR(l2_office_max, 0664, adp8860_bl_l2_office_max_show,
+static DEVICE_ATTR(l2_office_max, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH, adp8860_bl_l2_office_max_show,
 			adp8860_bl_l2_office_max_store);
 
 static ssize_t adp8860_bl_l1_daylight_max_show(struct device *dev,
@@ -507,7 +507,7 @@ static ssize_t adp8860_bl_l1_daylight_max_store(struct device *dev,
 
 	return adp8860_store(dev, buf, count, ADP8860_BLMX1);
 }
-static DEVICE_ATTR(l1_daylight_max, 0664, adp8860_bl_l1_daylight_max_show,
+static DEVICE_ATTR(l1_daylight_max, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH, adp8860_bl_l1_daylight_max_show,
 			adp8860_bl_l1_daylight_max_store);
 
 static ssize_t adp8860_bl_l3_dark_dim_show(struct device *dev,
@@ -522,7 +522,7 @@ static ssize_t adp8860_bl_l3_dark_dim_store(struct device *dev,
 {
 	return adp8860_store(dev, buf, count, ADP8860_BLDM3);
 }
-static DEVICE_ATTR(l3_dark_dim, 0664, adp8860_bl_l3_dark_dim_show,
+static DEVICE_ATTR(l3_dark_dim, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH, adp8860_bl_l3_dark_dim_show,
 			adp8860_bl_l3_dark_dim_store);
 
 static ssize_t adp8860_bl_l2_office_dim_show(struct device *dev,
@@ -537,7 +537,7 @@ static ssize_t adp8860_bl_l2_office_dim_store(struct device *dev,
 {
 	return adp8860_store(dev, buf, count, ADP8860_BLDM2);
 }
-static DEVICE_ATTR(l2_office_dim, 0664, adp8860_bl_l2_office_dim_show,
+static DEVICE_ATTR(l2_office_dim, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH, adp8860_bl_l2_office_dim_show,
 			adp8860_bl_l2_office_dim_store);
 
 static ssize_t adp8860_bl_l1_daylight_dim_show(struct device *dev,
@@ -552,7 +552,7 @@ static ssize_t adp8860_bl_l1_daylight_dim_store(struct device *dev,
 {
 	return adp8860_store(dev, buf, count, ADP8860_BLDM1);
 }
-static DEVICE_ATTR(l1_daylight_dim, 0664, adp8860_bl_l1_daylight_dim_show,
+static DEVICE_ATTR(l1_daylight_dim, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH, adp8860_bl_l1_daylight_dim_show,
 			adp8860_bl_l1_daylight_dim_store);
 
 #ifdef ADP8860_EXT_FEATURES
@@ -580,7 +580,7 @@ static ssize_t adp8860_bl_ambient_light_level_show(struct device *dev,
 
 	return sprintf(buf, "%u\n", ret_val);
 }
-static DEVICE_ATTR(ambient_light_level, 0444,
+static DEVICE_ATTR(ambient_light_level, S_IRUSR | S_IRGRP | S_IROTH,
 		adp8860_bl_ambient_light_level_show, NULL);
 
 static ssize_t adp8860_bl_ambient_light_zone_show(struct device *dev,
@@ -634,7 +634,7 @@ static ssize_t adp8860_bl_ambient_light_zone_store(struct device *dev,
 
 	return count;
 }
-static DEVICE_ATTR(ambient_light_zone, 0664,
+static DEVICE_ATTR(ambient_light_zone, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH,
 		adp8860_bl_ambient_light_zone_show,
 		adp8860_bl_ambient_light_zone_store);
 #endif
-- 
2.9.2

