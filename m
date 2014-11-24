From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 24 Nov 2014 18:05:35 +0000
Subject: [PATCH v2] backlight: lp8788: Deletion of a check before backlight_device_unregister()
Message-Id: <5473736F.8070705@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <530C5E18.1020800@users.sourceforge.net> <alpine.DEB.2.10.1402251014170.2080@hadrien> <530CD2C4.4050903@users.sourceforge.net> <alpine.DEB.2.10.1402251840450.7035@hadrien> <530CF8FF.8080600@users.sourceforge.net> <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6> <530DD06F.4090703@users.sourceforge.net> <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6> <5317A59D.4@users.sourceforge.net> <54720DEB.4060109@users.sourceforge.net> <20141124101006.GD4241@x1>
In-Reply-To: <20141124101006.GD4241@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lee Jones <lee.jones@linaro.org>
Cc: Bryan Wu <cooloney@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Jingoo Han <jg1.han@samsung.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>

From: Markus Elfring <elfring@users.sourceforge.net>

The backlight_device_unregister() function tests whether its argument is NULL
and then returns immediately. Thus the test around the call is not needed.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/video/backlight/lp8788_bl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/backlight/lp8788_bl.c b/drivers/video/backlight/lp8788_bl.c
index d6c4f6a..24a055c 100644
--- a/drivers/video/backlight/lp8788_bl.c
+++ b/drivers/video/backlight/lp8788_bl.c
@@ -221,8 +221,7 @@ static void lp8788_backlight_unregister(struct lp8788_bl *bl)
 {
 	struct backlight_device *bl_dev = bl->bl_dev;
 
-	if (bl_dev)
-		backlight_device_unregister(bl_dev);
+	backlight_device_unregister(bl_dev);
 }
 
 static ssize_t lp8788_get_bl_ctl_mode(struct device *dev,
-- 
2.1.3

