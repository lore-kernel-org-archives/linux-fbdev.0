From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Fri, 07 Aug 2015 12:16:06 +0000
Subject: [PATCH 5/5] staging: sm750fb: simplify return
Message-Id: <1438949046-18765-5-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1438949046-18765-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1438949046-18765-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

Lets return the return value directly instead of using a variable to
store the result.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/staging/sm750fb/sm750.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index e7fad0f..07f8afd 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -298,17 +298,13 @@ static int lynxfb_ops_pan_display(struct fb_var_screeninfo *var,
 {
 	struct lynxfb_par *par;
 	struct lynxfb_crtc *crtc;
-	int ret;
 
 	if (!info)
 		return -EINVAL;
 
-	ret = 0;
 	par = info->par;
 	crtc = &par->crtc;
-	ret = crtc->proc_panDisplay(crtc, var, info);
-
-	return ret;
+	return crtc->proc_panDisplay(crtc, var, info);
 }
 
 static int lynxfb_ops_set_par(struct fb_info *info)
-- 
1.9.1

