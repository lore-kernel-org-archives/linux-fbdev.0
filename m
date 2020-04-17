From: Jason Yan <yanaijie@huawei.com>
Date: Fri, 17 Apr 2020 08:59:11 +0000
Subject: [PATCH] backlight: lms501kf03: remove unused 'seq_sleep_in' and 'seq_up_dn'
Message-Id: <20200417092257.13694-1-yanaijie@huawei.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lee.jones@linaro.org, daniel.thompson@linaro.org, jingoohan1@gmail.com, b.zolnierkie@samsung.com, yanaijie@huawei.com, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Hulk Robot <hulkci@huawei.com>

Fix the following gcc warning:

drivers/video/backlight/lms501kf03.c:96:28: warning: ‘seq_sleep_in’
defined but not used [-Wunused-const-variable=]
 static const unsigned char seq_sleep_in[] = {
                            ^~~~~~~~~~~~
drivers/video/backlight/lms501kf03.c:92:28: warning: ‘seq_up_dn’ defined
but not used [-Wunused-const-variable=]
 static const unsigned char seq_up_dn[] = {
                            ^~~~~~~~~

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/video/backlight/lms501kf03.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/video/backlight/lms501kf03.c b/drivers/video/backlight/lms501kf03.c
index 8ae32e3573c1..c1bd02bb8b2e 100644
--- a/drivers/video/backlight/lms501kf03.c
+++ b/drivers/video/backlight/lms501kf03.c
@@ -89,14 +89,6 @@ static const unsigned char seq_rgb_gamma[] = {
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 };
 
-static const unsigned char seq_up_dn[] = {
-	0x36, 0x10,
-};
-
-static const unsigned char seq_sleep_in[] = {
-	0x10,
-};
-
 static const unsigned char seq_sleep_out[] = {
 	0x11,
 };
-- 
2.21.1
