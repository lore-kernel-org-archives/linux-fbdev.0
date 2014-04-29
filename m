From: Masanari Iida <standby24x7@gmail.com>
Date: Tue, 29 Apr 2014 12:21:55 +0000
Subject: [PATCH 2/2] video: fbdev: Fix format string mismatch in gbefb.c
Message-Id: <1398774115-15353-2-git-send-email-standby24x7@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1398774115-15353-1-git-send-email-standby24x7@gmail.com>
In-Reply-To: <1398774115-15353-1-git-send-email-standby24x7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Masanari Iida <standby24x7@gmail.com>

Fix format string mismatch in gbefb_show_memsize().

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 drivers/video/fbdev/gbefb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/gbefb.c b/drivers/video/fbdev/gbefb.c
index 3ec65a8..4aa56ba 100644
--- a/drivers/video/fbdev/gbefb.c
+++ b/drivers/video/fbdev/gbefb.c
@@ -1068,7 +1068,7 @@ static struct fb_ops gbefb_ops = {
 
 static ssize_t gbefb_show_memsize(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d\n", gbe_mem_size);
+	return snprintf(buf, PAGE_SIZE, "%u\n", gbe_mem_size);
 }
 
 static DEVICE_ATTR(size, S_IRUGO, gbefb_show_memsize, NULL);
-- 
2.0.0.rc1

