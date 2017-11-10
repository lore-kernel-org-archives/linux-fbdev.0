From: Colin King <colin.king@canonical.com>
Date: Fri, 10 Nov 2017 17:32:31 +0000
Subject: [PATCH] video: fbdev: sm501fb: fix potential null pointer dereference on fbi
Message-Id: <20171110173231.24598-1-colin.king@canonical.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The pointer fbi is dereferenced with par = fbi->par before there is a
null check on fbi, hence there is a potential null pointer dereference
on a null par.  Fix this by moving the dereference after the null
pointer check.

Detected by CoverityScan, CID#1461301 ("Dereference before null check")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/video/fbdev/sm501fb.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/sm501fb.c b/drivers/video/fbdev/sm501fb.c
index 8d4fdb373299..6f0a19501c6a 100644
--- a/drivers/video/fbdev/sm501fb.c
+++ b/drivers/video/fbdev/sm501fb.c
@@ -2100,11 +2100,12 @@ static int sm501fb_suspend_fb(struct sm501fb_info *info,
 			      enum sm501_controller head)
 {
 	struct fb_info *fbi = info->fb[head];
-	struct sm501fb_par *par = fbi->par;
+	struct sm501fb_par *par;
 
 	if (!fbi)
 		return 0;
 
+	par = fbi->par;
 	if (par->screen.size = 0)
 		return 0;
 
@@ -2150,11 +2151,12 @@ static void sm501fb_resume_fb(struct sm501fb_info *info,
 			      enum sm501_controller head)
 {
 	struct fb_info *fbi = info->fb[head];
-	struct sm501fb_par *par = fbi->par;
+	struct sm501fb_par *par;
 
 	if (!fbi)
 		return;
 
+	par = fbi->par;
 	if (par->screen.size = 0)
 		return;
 
-- 
2.14.1

