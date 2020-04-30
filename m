From: Matej Dujava <mdujava@kocurkovo.cz>
Date: Thu, 30 Apr 2020 20:09:26 +0000
Subject: [PATCH 3/3] staging: sm750fb: print error message with actual value
Message-Id: <1588277366-19354-4-git-send-email-mdujava@kocurkovo.cz>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1588277366-19354-1-git-send-email-mdujava@kocurkovo.cz>
In-Reply-To: <1588277366-19354-1-git-send-email-mdujava@kocurkovo.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

This patch will update error message, so it is same as error message in
another function.

Signed-off-by: Matej Dujava <mdujava@kocurkovo.cz>
---
 drivers/staging/sm750fb/sm750.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index c3ce7e653c7f..a1a82e59dfee 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -390,7 +390,7 @@ static int lynxfb_ops_set_par(struct fb_info *info)
 	var->accel_flags = 0;/*FB_ACCELF_TEXT;*/
 
 	if (ret) {
-		pr_err("pixel bpp format not satisfied\n.");
+		pr_err("bpp %d not supported\n", var->bits_per_pixel);
 		return ret;
 	}
 	ret = hw_sm750_crtc_setMode(crtc, var, fix);
-- 
2.26.2
