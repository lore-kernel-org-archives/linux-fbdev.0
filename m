From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Sat, 04 Nov 2017 21:24:21 +0000
Subject: [PATCH 3/3] sm501fb: suspend and resume fb if it exists
Message-Id: <1509830661-7384-3-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1509830661-7384-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1509830661-7384-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

There are cases when panel and crt both are not defined and only one of
them is defined and initialized. In such cases, suspend or resume it
only if it is defined.

Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/video/fbdev/sm501fb.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/video/fbdev/sm501fb.c b/drivers/video/fbdev/sm501fb.c
index 577a483..49233c1 100644
--- a/drivers/video/fbdev/sm501fb.c
+++ b/drivers/video/fbdev/sm501fb.c
@@ -2101,6 +2101,9 @@ static int sm501fb_suspend_fb(struct sm501fb_info *info,
 	struct fb_info *fbi = info->fb[head];
 	struct sm501fb_par *par = fbi->par;
 
+	if (!fbi)
+		return 0;
+
 	if (par->screen.size = 0)
 		return 0;
 
@@ -2148,6 +2151,9 @@ static void sm501fb_resume_fb(struct sm501fb_info *info,
 	struct fb_info *fbi = info->fb[head];
 	struct sm501fb_par *par = fbi->par;
 
+	if (!fbi)
+		return;
+
 	if (par->screen.size = 0)
 		return;
 
-- 
2.1.4

