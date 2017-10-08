From: Christos Gkekas <chris.gekas@gmail.com>
Date: Sun, 08 Oct 2017 21:56:48 +0000
Subject: [PATCH] cklight: tps65217_bl: Remove unnecessary default brightness check
Message-Id: <1507499808-12896-1-git-send-email-chris.gekas@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Christos Gkekas <chris.gekas@gmail.com>

Variable val holds the default brightness and is unsigned, therefore
checking whether it is less than zero is redundant.

Signed-off-by: Christos Gkekas <chris.gekas@gmail.com>
---
 drivers/video/backlight/tps65217_bl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/backlight/tps65217_bl.c b/drivers/video/backlight/tps65217_bl.c
index fd524ad..61ea82d 100644
--- a/drivers/video/backlight/tps65217_bl.c
+++ b/drivers/video/backlight/tps65217_bl.c
@@ -239,8 +239,7 @@ tps65217_bl_parse_dt(struct platform_device *pdev)
 	}
 
 	if (!of_property_read_u32(node, "default-brightness", &val)) {
-		if (val < 0 ||
-			val > 100) {
+		if (val > 100) {
 			dev_err(&pdev->dev,
 				"invalid 'default-brightness' value in the device tree\n");
 			err = ERR_PTR(-EINVAL);
-- 
2.7.4

