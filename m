From: Jingoo Han <jg1.han@samsung.com>
Date: Mon, 07 Nov 2011 06:03:01 +0000
Subject: [PATCH] video: s3c-fb: fix transparency length for pixel blending
Message-Id: <1320645781-9528-1-git-send-email-jg1.han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Transparency length is fixed for pixel blending in order to support
ARGB 8888 format.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/s3c-fb.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index 0753b1c..12eaee0 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -621,7 +621,8 @@ static int s3c_fb_set_par(struct fb_info *info)
 		} else if (var->transp.length = 1)
 			data |= WINCON1_BPPMODE_25BPP_A1888
 				| WINCON1_BLD_PIX;
-		else if (var->transp.length = 4)
+		else if ((var->transp.length = 4) ||
+			(var->transp.length = 8))
 			data |= WINCON1_BPPMODE_28BPP_A4888
 				| WINCON1_BLD_PIX | WINCON1_ALPHA_SEL;
 		else
-- 
1.7.1

