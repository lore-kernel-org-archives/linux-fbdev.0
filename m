From: Prasant Jalan <prasant.jalan@gmail.com>
Date: Fri, 31 Mar 2017 19:22:02 +0000
Subject: [PATCH 2/2] staging: sm750fb: removed line continuations in quoted strings
Message-Id: <1490987402-9301-2-git-send-email-prasant.jalan@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1490987402-9301-1-git-send-email-prasant.jalan@gmail.com>
In-Reply-To: <1490987402-9301-1-git-send-email-prasant.jalan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com
Cc: sudip.mukherjee@codethink.co.uk, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, Prasant Jalan <prasant.jalan@gmail.com>

checkpatch gives WARNING: Avoid line continuations in quoted strings.

Trivial fix by removing line continuations and adding another quote at
the start of next line.

Signed-off-by: Prasant Jalan <prasant.jalan@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 445c68d..386d4ad 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -837,15 +837,15 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 
 	/* some member of info->var had been set by fb_find_mode */
 
-	pr_info("Member of info->var is :\n\
-		xres=%d\n\
-		yres=%d\n\
-		xres_virtual=%d\n\
-		yres_virtual=%d\n\
-		xoffset=%d\n\
-		yoffset=%d\n\
-		bits_per_pixel=%d\n \
-		...\n",
+	pr_info("Member of info->var is :\n"
+		"xres=%d\n"
+		"yres=%d\n"
+		"xres_virtual=%d\n"
+		"yres_virtual=%d\n"
+		"xoffset=%d\n"
+		"yoffset=%d\n"
+		"bits_per_pixel=%d\n"
+		" ...\n",
 		var->xres,
 		var->yres,
 		var->xres_virtual,
-- 
2.7.4

