From: Daniel Mack <daniel@zonque.org>
Date: Tue, 19 Jun 2018 09:56:15 +0000
Subject: [PATCH] video: fbdev: pxafb: zero allocated memory for video modes
Message-Id: <20180619095615.14680-1-daniel@zonque.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

When parsing the video modes from DT properties, make sure to zero out
memory befor using it. This is important because not all fields in the mode
struct are explicitly initialized, even though they are used later on.

Fixes: 420a488278e86 (video: fbdev: pxafb: initial devicetree conversion)
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 drivers/video/fbdev/pxafb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/pxafb.c b/drivers/video/fbdev/pxafb.c
index c2c2e2790079..64926c95d06c 100644
--- a/drivers/video/fbdev/pxafb.c
+++ b/drivers/video/fbdev/pxafb.c
@@ -2131,7 +2131,8 @@ static int of_get_pxafb_display(struct device *dev, struct device_node *disp,
 
 	ret = -ENOMEM;
 	info->modes = kmalloc_array(timings->num_timings,
-				    sizeof(info->modes[0]), GFP_KERNEL);
+				    sizeof(info->modes[0]),
+				    GFP_KERNEL | __GFP_ZERO);
 	if (!info->modes)
 		goto out;
 	info->num_modes = timings->num_timings;
-- 
2.17.1

