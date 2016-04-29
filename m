From: Manav Batra <batmanav10@gmail.com>
Date: Fri, 29 Apr 2016 09:21:43 +0000
Subject: [PATCH] staging: sm750fb: unsigned int instead of unsigned
Message-Id: <20160429092143.GA6303@iiitd.ac.in>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

Signed-off-by: Manav Batra <batmanav10@gmail.com>

Replaced occurences of unsigned with unsigned int.
---
 drivers/staging/sm750fb/sm750.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 6ed004e..0665b5c 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -575,11 +575,11 @@ static int lynxfb_ops_check_var(struct fb_var_screeninfo *var,
 	return hw_sm750_crtc_checkMode(crtc, var);
 }
 
-static int lynxfb_ops_setcolreg(unsigned regno,
-				unsigned red,
-				unsigned green,
-				unsigned blue,
-				unsigned transp,
+static int lynxfb_ops_setcolreg(unsigned int regno,
+				unsigned int red,
+				unsigned int green,
+				unsigned int blue,
+				unsigned int transp,
 				struct fb_info *info)
 {
 	struct lynxfb_par *par;
-- 
1.9.1

