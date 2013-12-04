From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 04 Dec 2013 12:28:28 +0000
Subject: [PATCH 01/26] OMAPDSS: rename display-sysfs 'name' entry
Message-Id: <1386160133-24026-2-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

omapdss in compat mode creates some sysfs files into the device's sysfs
directory, including a 'name' file. This works fine for
platform_devices, but breaks with i2c or spi devices, as those already
have a 'name' file.

Fix this by renaming the omapdss's 'name' file to 'display_name'.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/display-sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/display-sysfs.c b/drivers/video/omap2/dss/display-sysfs.c
index 21d7f77df702..f7b5f9561041 100644
--- a/drivers/video/omap2/dss/display-sysfs.c
+++ b/drivers/video/omap2/dss/display-sysfs.c
@@ -277,7 +277,7 @@ static ssize_t display_wss_store(struct device *dev,
 	return size;
 }
 
-static DEVICE_ATTR(name, S_IRUGO, display_name_show, NULL);
+static DEVICE_ATTR(display_name, S_IRUGO, display_name_show, NULL);
 static DEVICE_ATTR(enabled, S_IRUGO|S_IWUSR,
 		display_enabled_show, display_enabled_store);
 static DEVICE_ATTR(tear_elim, S_IRUGO|S_IWUSR,
@@ -292,7 +292,7 @@ static DEVICE_ATTR(wss, S_IRUGO|S_IWUSR,
 		display_wss_show, display_wss_store);
 
 static const struct attribute *display_sysfs_attrs[] = {
-	&dev_attr_name.attr,
+	&dev_attr_display_name.attr,
 	&dev_attr_enabled.attr,
 	&dev_attr_tear_elim.attr,
 	&dev_attr_timings.attr,
-- 
1.8.3.2

