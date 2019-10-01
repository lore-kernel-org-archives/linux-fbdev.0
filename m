From: Matthias Kaehlcke <mka@chromium.org>
Date: Tue, 01 Oct 2019 23:29:24 +0000
Subject: [PATCH] backlight: pwm_bl: Don't assign levels table repeatedly
Message-Id: <20191001162835.1.I4f2ede1f55ddd1c72b0303b7fd7f73a782fa33e5@changeid>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

pwm_backlight_probe() re-assigns pb->levels for every brightness
level. This is not needed and was likely not intended, since
neither side of the assignment changes during the loop. Assign
the field only once.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

 drivers/video/backlight/pwm_bl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 746eebc411df..959436b9e92b 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -564,6 +564,8 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 	memset(&props, 0, sizeof(struct backlight_properties));
 
 	if (data->levels) {
+		pb->levels = data->levels;
+
 		/*
 		 * For the DT case, only when brightness levels is defined
 		 * data->levels is filled. For the non-DT case, data->levels
@@ -572,8 +574,6 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 		for (i = 0; i <= data->max_brightness; i++) {
 			if (data->levels[i] > pb->scale)
 				pb->scale = data->levels[i];
-
-			pb->levels = data->levels;
 		}
 
 		if (pwm_backlight_is_linear(data))
-- 
2.23.0.444.g18eeb5a265-goog
