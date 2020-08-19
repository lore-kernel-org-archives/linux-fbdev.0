From: Dinghao Liu <dinghao.liu@zju.edu.cn>
Date: Wed, 19 Aug 2020 03:04:56 +0000
Subject: [PATCH] video: backlight: sky81452-backlight: Fix refcount imbalance on error
Message-Id: <20200819030456.7054-1-dinghao.liu@zju.edu.cn>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dinghao.liu@zju.edu.cn, kjlu@umn.edu
Cc: Daniel Thompson <daniel.thompson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, Bryan Wu <cooloney@gmail.com>, Gyungoh Yoo <jack.yoo@skyworksinc.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>

When of_property_read_u32_array() returns an error code, a
pairing refcount decrement is needed to keep np's refcount
balanced.

Fixes: f705806c9f355 ("backlight: Add support Skyworks SKY81452 backlight driver")
Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
---
 drivers/video/backlight/sky81452-backlight.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/backlight/sky81452-backlight.c b/drivers/video/backlight/sky81452-backlight.c
index 0ce181585008..8268ac43d54f 100644
--- a/drivers/video/backlight/sky81452-backlight.c
+++ b/drivers/video/backlight/sky81452-backlight.c
@@ -217,6 +217,7 @@ static struct sky81452_bl_platform_data *sky81452_bl_parse_dt(
 					num_entry);
 		if (ret < 0) {
 			dev_err(dev, "led-sources node is invalid.\n");
+			of_node_put(np);
 			return ERR_PTR(-EINVAL);
 		}
 
-- 
2.17.1
