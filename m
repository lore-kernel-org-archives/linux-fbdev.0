From: Baole Ni <baolex.ni@intel.com>
Date: Tue, 02 Aug 2016 12:09:13 +0000
Subject: [PATCH 1022/1285] Replace numeric parameter like 0444 with macro
Message-Id: <20160802120913.18243-1-baolex.ni@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, m.chehab@samsung.com, gregkh@linuxfoundation.org, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com, oneukum@suse.com

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/video/fbdev/w100fb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/w100fb.c b/drivers/video/fbdev/w100fb.c
index 10951c8..2e6db35 100644
--- a/drivers/video/fbdev/w100fb.c
+++ b/drivers/video/fbdev/w100fb.c
@@ -110,7 +110,7 @@ static ssize_t flip_store(struct device *dev, struct device_attribute *attr, con
 	return count;
 }
 
-static DEVICE_ATTR(flip, 0644, flip_show, flip_store);
+static DEVICE_ATTR(flip, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, flip_show, flip_store);
 
 static ssize_t w100fb_reg_read(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
@@ -121,7 +121,7 @@ static ssize_t w100fb_reg_read(struct device *dev, struct device_attribute *attr
 	return count;
 }
 
-static DEVICE_ATTR(reg_read, 0200, NULL, w100fb_reg_read);
+static DEVICE_ATTR(reg_read, S_IWUSR, NULL, w100fb_reg_read);
 
 static ssize_t w100fb_reg_write(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
@@ -136,7 +136,7 @@ static ssize_t w100fb_reg_write(struct device *dev, struct device_attribute *att
 	return count;
 }
 
-static DEVICE_ATTR(reg_write, 0200, NULL, w100fb_reg_write);
+static DEVICE_ATTR(reg_write, S_IWUSR, NULL, w100fb_reg_write);
 
 
 static ssize_t fastpllclk_show(struct device *dev, struct device_attribute *attr, char *buf)
@@ -166,7 +166,7 @@ static ssize_t fastpllclk_store(struct device *dev, struct device_attribute *att
 	return count;
 }
 
-static DEVICE_ATTR(fastpllclk, 0644, fastpllclk_show, fastpllclk_store);
+static DEVICE_ATTR(fastpllclk, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, fastpllclk_show, fastpllclk_store);
 
 /*
  * Some touchscreens need hsync information from the video driver to
-- 
2.9.2

