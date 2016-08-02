From: Baole Ni <baolex.ni@intel.com>
Date: Tue, 02 Aug 2016 12:06:31 +0000
Subject: [PATCH 0997/1285] Replace numeric parameter like 0444 with macro
Message-Id: <20160802120631.16539-1-baolex.ni@intel.com>
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
 drivers/video/backlight/s6e63m0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/backlight/s6e63m0.c b/drivers/video/backlight/s6e63m0.c
index 3c4a22a..f389f7e 100644
--- a/drivers/video/backlight/s6e63m0.c
+++ b/drivers/video/backlight/s6e63m0.c
@@ -688,7 +688,7 @@ static ssize_t s6e63m0_sysfs_store_gamma_mode(struct device *dev,
 	return len;
 }
 
-static DEVICE_ATTR(gamma_mode, 0644,
+static DEVICE_ATTR(gamma_mode, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH,
 		s6e63m0_sysfs_show_gamma_mode, s6e63m0_sysfs_store_gamma_mode);
 
 static ssize_t s6e63m0_sysfs_show_gamma_table(struct device *dev,
@@ -702,7 +702,7 @@ static ssize_t s6e63m0_sysfs_show_gamma_table(struct device *dev,
 
 	return strlen(buf);
 }
-static DEVICE_ATTR(gamma_table, 0444,
+static DEVICE_ATTR(gamma_table, S_IRUSR | S_IRGRP | S_IROTH,
 		s6e63m0_sysfs_show_gamma_table, NULL);
 
 static int s6e63m0_probe(struct spi_device *spi)
-- 
2.9.2

