From: Lee Jones <lee.jones@linaro.org>
Date: Wed, 24 Jun 2020 14:57:21 +0000
Subject: [PATCH 8/8] backlight: qcom-wled: Remove unused configs for LED3 and LED4
Message-Id: <20200624145721.2590327-9-lee.jones@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200624145721.2590327-1-lee.jones@linaro.org>
In-Reply-To: <20200624145721.2590327-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: daniel.thompson@linaro.org, jingoohan1@gmail.com, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>, Andy Gross <agross@kernel.org>, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org

Fixes W=1 warnings:

 drivers/video/backlight/qcom-wled.c:1294:34: warning: ‘wled4_string_cfg’ defined but not used [-Wunused-const-variable=]
 1294 | static const struct wled_var_cfg wled4_string_cfg = {
 | ^~~~~~~~~~~~~~~~
 drivers/video/backlight/qcom-wled.c:1290:34: warning: ‘wled3_string_cfg’ defined but not used [-Wunused-const-variable=]
 1290 | static const struct wled_var_cfg wled3_string_cfg = {
 | ^~~~~~~~~~~~~~~~

Cc: <stable@vger.kernel.org>
Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-arm-msm@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/backlight/qcom-wled.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
index 4c8c34b994414..c25c31199952c 100644
--- a/drivers/video/backlight/qcom-wled.c
+++ b/drivers/video/backlight/qcom-wled.c
@@ -1287,14 +1287,6 @@ static const struct wled_var_cfg wled4_string_i_limit_cfg = {
 	.size = ARRAY_SIZE(wled4_string_i_limit_values),
 };
 
-static const struct wled_var_cfg wled3_string_cfg = {
-	.size = 8,
-};
-
-static const struct wled_var_cfg wled4_string_cfg = {
-	.size = 16,
-};
-
 static const struct wled_var_cfg wled5_mod_sel_cfg = {
 	.size = 2,
 };
-- 
2.25.1
