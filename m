From: Wei Yongjun <weiyongjun1@huawei.com>
Date: Tue, 21 Jul 2020 13:48:41 +0000
Subject: [PATCH -next] backlight: cr_bllcd: Remove unused variable 'intensity'
Message-Id: <20200721134841.33893-1-weiyongjun1@huawei.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hulk Robot <hulkci@huawei.com>, Lee Jones <lee.jones@linaro.org>, Daniel
 Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Sam Ravnborg <sam@ravnborg.org>
Cc: linux-fbdev@vger.kernel.org, Wei Yongjun <weiyongjun1@huawei.com>, dri-devel@lists.freedesktop.org

Gcc report unused-variable warning as follows:

drivers/video/backlight/cr_bllcd.c:62:6: warning:
 unused variable 'intensity' [-Wunused-variable]
   62 |  int intensity = bd->props.brightness;
      |      ^~~~~~~~~

After commit 24d34617c24f ("backlight: cr_bllcd: Introduce
gpio-backlight semantics"), this variable is never used, this
commit removing it.

Fixes: 24d34617c24f ("backlight: cr_bllcd: Introduce gpio-backlight semantics")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/video/backlight/cr_bllcd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/backlight/cr_bllcd.c b/drivers/video/backlight/cr_bllcd.c
index a24d42e1ea3c..4ad0a72531fe 100644
--- a/drivers/video/backlight/cr_bllcd.c
+++ b/drivers/video/backlight/cr_bllcd.c
@@ -59,7 +59,6 @@ struct cr_panel {
 
 static int cr_backlight_set_intensity(struct backlight_device *bd)
 {
-	int intensity = bd->props.brightness;
 	u32 addr = gpio_bar + CRVML_PANEL_PORT;
 	u32 cur = inl(addr);
 
