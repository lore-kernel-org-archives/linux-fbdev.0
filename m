From: Jingoo Han <jg1.han@samsung.com>
Date: Fri, 26 Oct 2012 07:00:03 +0000
Subject: [PATCH 1/3] video: s3c-fb: add "drop through" comment
Message-Id: <002101cdb347$86236950$926a3bf0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patch adds a "drop through" comment to improve
the readability.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/s3c-fb.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index 2ed7b63..89cd278 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -288,6 +288,7 @@ static int s3c_fb_check_var(struct fb_var_screeninfo *var,
 		/* 666 with one bit alpha/transparency */
 		var->transp.offset	= 18;
 		var->transp.length	= 1;
+		/* drop through */
 	case 18:
 		var->bits_per_pixel	= 32;
 
-- 
1.7.1


