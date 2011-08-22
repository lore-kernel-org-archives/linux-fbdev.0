From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 22 Aug 2011 08:27:47 +0000
Subject: [PATCH 06/10] OMAP: OMAPFB: string parsing cleanups
Message-Id: <1314001671-18123-7-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1314001671-18123-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1314001671-18123-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Use strtobool instead of kstrtoint when parsing bool from sysfs.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/omapfb/omapfb-sysfs.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-sysfs.c b/drivers/video/omap2/omapfb/omapfb-sysfs.c
index 153bf1a..1694d51 100644
--- a/drivers/video/omap2/omapfb/omapfb-sysfs.c
+++ b/drivers/video/omap2/omapfb/omapfb-sysfs.c
@@ -104,16 +104,14 @@ static ssize_t store_mirror(struct device *dev,
 {
 	struct fb_info *fbi = dev_get_drvdata(dev);
 	struct omapfb_info *ofbi = FB2OFB(fbi);
-	int mirror;
+	bool mirror;
 	int r;
 	struct fb_var_screeninfo new_var;
 
-	r = kstrtoint(buf, 0, &mirror);
+	r = strtobool(buf, &mirror);
 	if (r)
 		return r;
 
-	mirror = !!mirror;
-
 	if (!lock_fb_info(fbi))
 		return -ENODEV;
 
-- 
1.7.4.1

