From: Colin King <colin.king@canonical.com>
Date: Wed, 11 Jul 2018 11:35:23 +0000
Subject: [PATCH] staging: sm750fb: remove redundant pointer 'output'
Message-Id: <20180711113523.31549-1-colin.king@canonical.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Pointer 'output' is being assigned but is never used hence it is redundant
and can be removed.

Cleans up clang warning:
warning: variable 'output' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/sm750fb/sm750.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 67207b0554cd..846d7d243994 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -512,12 +512,10 @@ static int lynxfb_ops_check_var(struct fb_var_screeninfo *var,
 {
 	struct lynxfb_par *par;
 	struct lynxfb_crtc *crtc;
-	struct lynxfb_output *output;
 	resource_size_t request;
 
 	par = info->par;
 	crtc = &par->crtc;
-	output = &par->output;
 
 	pr_debug("check var:%dx%d-%d\n",
 		 var->xres,
-- 
2.17.1

