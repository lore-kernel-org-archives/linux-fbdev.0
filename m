From: Vasiliy Kulikov <segoon@openwall.com>
Date: Sun, 21 Nov 2010 17:40:01 +0000
Subject: [PATCH] video: arcfb: fix buffer overflow
Message-Id: <1290361202-15065-1-git-send-email-segoon@openwall.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org
Cc: Jaya Kumar <jayalk@intworks.biz>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

(count + p) is not checked for integer overflow.  If p < fbmemlength
and count = (size_t)(1 - p) (very big unsigned integer) then
count + p = 1 < fbmemlength and copy_to_user(base_addr+p, buf, count)
overflows base_addr.

Signed-off-by: Vasiliy Kulikov <segoon@openwall.com>
---
 Compile tested only.

 drivers/video/arcfb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/arcfb.c b/drivers/video/arcfb.c
index 3ec4923..67a4cd4 100644
--- a/drivers/video/arcfb.c
+++ b/drivers/video/arcfb.c
@@ -454,7 +454,7 @@ static ssize_t arcfb_write(struct fb_info *info, const char __user *buf,
 	xres = info->var.xres;
 	fbmemlength = (xres * info->var.yres)/8;
 
-	if (p > fbmemlength)
+	if (p > fbmemlength || (p + count < p))
 		return -ENOSPC;
 
 	err = 0;
-- 
1.7.0.4

