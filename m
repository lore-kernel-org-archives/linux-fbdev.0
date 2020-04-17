From: Jason Yan <yanaijie@huawei.com>
Date: Fri, 17 Apr 2020 08:59:12 +0000
Subject: [PATCH] backlight: qcom-wled: remove 'wled4_string_cfg' and 'wled3_string_cfg'
Message-Id: <20200417092335.14163-1-yanaijie@huawei.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: agross@kernel.org, bjorn.andersson@linaro.org, lee.jones@linaro.org, daniel.thompson@linaro.org, jingoohan1@gmail.com, b.zolnierkie@samsung.com, kgunda@codeaurora.org, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Hulk Robot <hulkci@huawei.com>, Jason Yan <yanaijie@huawei.com>

Fix the following gcc warning:

drivers/video/backlight/qcom-wled.c:939:34: warning: ‘wled4_string_cfg’
defined but not used [-Wunused-const-variable=]
 static const struct wled_var_cfg wled4_string_cfg = {
                                  ^~~~~~~~~~~~~~~~
drivers/video/backlight/qcom-wled.c:935:34: warning: ‘wled3_string_cfg’
defined but not used [-Wunused-const-variable=]
 static const struct wled_var_cfg wled3_string_cfg = {
                                  ^~~~~~~~~~~~~~~~

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/video/backlight/qcom-wled.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
index 3d276b30a78c..df53fbd5cd03 100644
--- a/drivers/video/backlight/qcom-wled.c
+++ b/drivers/video/backlight/qcom-wled.c
@@ -932,14 +932,6 @@ static const struct wled_var_cfg wled4_string_i_limit_cfg = {
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
 static u32 wled_values(const struct wled_var_cfg *cfg, u32 idx)
 {
 	if (idx >= cfg->size)
-- 
2.21.1
