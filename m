From: Bhumika Goyal <bhumirks@gmail.com>
Date: Thu, 10 Aug 2017 09:28:44 +0000
Subject: [PATCH 1/2] fbdev: matrox: make fb_ops const
Message-Id: <1502356605-20801-2-git-send-email-bhumirks@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1502356605-20801-1-git-send-email-bhumirks@gmail.com>
In-Reply-To: <1502356605-20801-1-git-send-email-bhumirks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: julia.lawall@lip6.fr, adaplas@gmail.com, b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>

Make fb_ops const as it is only used during a copy operation.
Done using Coccinelle.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/video/fbdev/matrox/matroxfb_base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/matrox/matroxfb_base.c b/drivers/video/fbdev/matrox/matroxfb_base.c
index 00ea4e4..49ef48d 100644
--- a/drivers/video/fbdev/matrox/matroxfb_base.c
+++ b/drivers/video/fbdev/matrox/matroxfb_base.c
@@ -1198,7 +1198,7 @@ static int matroxfb_blank(int blank, struct fb_info *info)
 	return 0;
 }
 
-static struct fb_ops matroxfb_ops = {
+static const struct fb_ops matroxfb_ops = {
 	.owner =	THIS_MODULE,
 	.fb_open =	matroxfb_open,
 	.fb_release =	matroxfb_release,
-- 
1.9.1

