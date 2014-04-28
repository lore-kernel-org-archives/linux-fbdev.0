From: Masanari Iida <standby24x7@gmail.com>
Date: Mon, 28 Apr 2014 10:54:15 +0000
Subject: [PATCH] fbdev: omap2: Fix format string mismatch in display-sysfs.c
Message-Id: <1398682455-21043-1-git-send-email-standby24x7@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Masanari Iida <standby24x7@gmail.com>

Fix two format string mismatch in display-sysfs.c

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 drivers/video/fbdev/omap2/dss/display-sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/display-sysfs.c b/drivers/video/fbdev/omap2/dss/display-sysfs.c
index 5a2095a..5928bc9 100644
--- a/drivers/video/fbdev/omap2/dss/display-sysfs.c
+++ b/drivers/video/fbdev/omap2/dss/display-sysfs.c
@@ -184,7 +184,7 @@ static ssize_t display_rotate_show(struct device *dev,
 	if (!dssdev->driver->get_rotate)
 		return -ENOENT;
 	rotate = dssdev->driver->get_rotate(dssdev);
-	return snprintf(buf, PAGE_SIZE, "%u\n", rotate);
+	return snprintf(buf, PAGE_SIZE, "%d\n", rotate);
 }
 
 static ssize_t display_rotate_store(struct device *dev,
@@ -215,7 +215,7 @@ static ssize_t display_mirror_show(struct device *dev,
 	if (!dssdev->driver->get_mirror)
 		return -ENOENT;
 	mirror = dssdev->driver->get_mirror(dssdev);
-	return snprintf(buf, PAGE_SIZE, "%u\n", mirror);
+	return snprintf(buf, PAGE_SIZE, "%d\n", mirror);
 }
 
 static ssize_t display_mirror_store(struct device *dev,
-- 
2.0.0.rc1

