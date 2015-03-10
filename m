From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Tue, 10 Mar 2015 17:28:56 +0000
Subject: [PATCH 5/6] staging: sm750fb: fix mixed declarations
Message-Id: <1426007817-1884-6-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426007817-1884-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1426007817-1884-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

we were getting build warning about mixed declaration. the variable
is now declared at the beginning of the block.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/staging/sm750fb/sm750.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 87029b6..021b863 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -1175,6 +1175,7 @@ ALLOC_FB:
 		else
 		{
 			struct lynxfb_par * par;
+			int errno;
 			pr_info("framebuffer #%d alloc okay\n",fbidx);
 			share->fbinfo[fbidx] = info[fbidx];
 			par = info[fbidx]->par;
@@ -1191,7 +1192,7 @@ ALLOC_FB:
 
 			/* register frame buffer*/
 			pr_info("Ready to register framebuffer #%d.\n",fbidx);
-			int errno = register_framebuffer(info[fbidx]);
+			errno = register_framebuffer(info[fbidx]);
 			if (errno < 0) {
 				pr_err("Failed to register fb_info #%d. err %d\n",fbidx, errno);
 				if(fbidx = 0)
-- 
1.8.1.2

