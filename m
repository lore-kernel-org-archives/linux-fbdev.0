From: Jingoo Han <jg1.han@samsung.com>
Date: Fri, 26 Oct 2012 07:01:39 +0000
Subject: [PATCH 2/3] video: s3c-fb: return an error when bpp is invalid
Message-Id: <002201cdb347$bf4459b0$3dcd0d10$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patch returns an error, when bpp is invalid in
s3c_fb_check_var(). If invalid bpp is requested,
an error should be returned.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/s3c-fb.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index 89cd278..f453b8b 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -330,6 +330,7 @@ static int s3c_fb_check_var(struct fb_var_screeninfo *var,
 
 	default:
 		dev_err(sfb->dev, "invalid bpp\n");
+		return -EINVAL;
 	}
 
 	dev_dbg(sfb->dev, "%s: verified parameters\n", __func__);
-- 
1.7.1


