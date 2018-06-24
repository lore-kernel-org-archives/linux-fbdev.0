From: Daniel Mack <daniel@zonque.org>
Date: Sun, 24 Jun 2018 15:38:14 +0000
Subject: [PATCH 1/4] video: fbdev: pxafb: clear allocated memory for video modes
Message-Id: <20180624153817.24387-1-daniel@zonque.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

When parsing the video modes from DT properties, make sure to zero out
memory before using it. This is important because not all fields in the mode
struct are explicitly initialized, even though they are used later on.

Fixes: 420a488278e86 (video: fbdev: pxafb: initial devicetree conversion)
Reviewed-by: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 drivers/video/fbdev/pxafb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/pxafb.c b/drivers/video/fbdev/pxafb.c
index 76722a59f55e..dfe382e68287 100644
--- a/drivers/video/fbdev/pxafb.c
+++ b/drivers/video/fbdev/pxafb.c
@@ -2128,8 +2128,8 @@ static int of_get_pxafb_display(struct device *dev, struct device_node *disp,
 		return -EINVAL;
 
 	ret = -ENOMEM;
-	info->modes = kmalloc_array(timings->num_timings,
-				    sizeof(info->modes[0]), GFP_KERNEL);
+	info->modes = kcalloc(timings->num_timings, sizeof(info->modes[0]),
+			      GFP_KERNEL);
 	if (!info->modes)
 		goto out;
 	info->num_modes = timings->num_timings;
-- 
2.17.1

