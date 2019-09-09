From: Sreeram Veluthakkal <srrmvlt@gmail.com>
Date: Mon, 09 Sep 2019 01:26:05 +0000
Subject: [PATCH] FBTFT: fb_agm1264k: usleep_range is preferred over udelay
Message-Id: <20190909012605.15051-1-srrmvlt@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: gregkh@linuxfoundation.org
Cc: nishadkamdar@gmail.com, jeremy@azazel.net, thomas.petazzoni@free-electrons.com, payal.s.kshirsagar.98@gmail.com, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, Sreeram Veluthakkal <srrmvlt@gmail.com>

This patch fixes the issue:
FILE: drivers/staging/fbtft/fb_agm1264k-fl.c:88:
CHECK: usleep_range is preferred over udelay; see Documentation/timers/timers-howto.rst
+       udelay(20);

Signed-off-by: Sreeram Veluthakkal <srrmvlt@gmail.com>
---
 drivers/staging/fbtft/fb_agm1264k-fl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fb_agm1264k-fl.c b/drivers/staging/fbtft/fb_agm1264k-fl.c
index eeeeec97ad27..2dece71fd3b5 100644
--- a/drivers/staging/fbtft/fb_agm1264k-fl.c
+++ b/drivers/staging/fbtft/fb_agm1264k-fl.c
@@ -85,7 +85,7 @@ static void reset(struct fbtft_par *par)
 	dev_dbg(par->info->device, "%s()\n", __func__);
 
 	gpiod_set_value(par->gpio.reset, 0);
-	udelay(20);
+	usleep_range(20, 40);
 	gpiod_set_value(par->gpio.reset, 1);
 	mdelay(120);
 }
-- 
2.17.1
