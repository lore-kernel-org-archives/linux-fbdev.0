From: Chuhong Yuan <hslester96@gmail.com>
Date: Fri, 01 Nov 2019 06:53:33 +0000
Subject: [PATCH] backlight: lp855x: disable enable regulator when remove
Message-Id: <20191101065333.7004-1-hslester96@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Milo Kim <milo.kim@ti.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>

lp855x forgets to disable enable regulator when remove.
Add a call to regulator_disable in remove just like what is done to
supply regulator.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/video/backlight/lp855x_bl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/backlight/lp855x_bl.c b/drivers/video/backlight/lp855x_bl.c
index f68920131a4a..4fcf9ec18868 100644
--- a/drivers/video/backlight/lp855x_bl.c
+++ b/drivers/video/backlight/lp855x_bl.c
@@ -499,6 +499,8 @@ static int lp855x_remove(struct i2c_client *cl)
 	backlight_update_status(lp->bl);
 	if (lp->supply)
 		regulator_disable(lp->supply);
+	if (lp->enable)
+		regulator_disable(lp->enable);
 	sysfs_remove_group(&lp->dev->kobj, &lp855x_attr_group);
 
 	return 0;
-- 
2.23.0
