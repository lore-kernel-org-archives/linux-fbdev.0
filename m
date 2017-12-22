From: kbuild test robot <lkp@intel.com>
Date: Fri, 22 Dec 2017 22:23:26 +0000
Subject: [RFC PATCH] backlight: otm3225a: otm3225a_ops can be static
Message-Id: <20171222222326.GA55764@lkp-sb04>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1513792670-4114-1-git-send-email-fb@ltec.ch>
In-Reply-To: <1513792670-4114-1-git-send-email-fb@ltec.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Felix Brack <fb@ltec.ch>
Cc: kbuild-all@01.org, linux-fbdev@vger.kernel.org, lee.jones@linaro.org, daniel.thompson@linaro.org, jingoohan1@gmail.com, b.zolnierkie@samsung.com, linux-kernel@vger.kernel.org


Fixes: 640b353b5467 ("backlight: otm3225a: add support for ORISE OTM3225A LCD SoC")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 otm3225a.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/otm3225a.c b/drivers/video/backlight/otm3225a.c
index 0de75f8..056ac8b 100644
--- a/drivers/video/backlight/otm3225a.c
+++ b/drivers/video/backlight/otm3225a.c
@@ -137,7 +137,7 @@ static int otm3225a_get_power(struct lcd_device *ld)
 	return dd->power;
 }
 
-struct lcd_ops otm3225a_ops = {
+static struct lcd_ops otm3225a_ops = {
 	.set_power = otm3225a_set_power,
 	.get_power = otm3225a_get_power,
 };
