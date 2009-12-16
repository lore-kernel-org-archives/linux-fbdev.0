From: Roel Kluin <roel.kluin@gmail.com>
Date: Wed, 16 Dec 2009 14:50:52 +0000
Subject: [PATCH] fbdev: use correct size in do_fscreeninfo_to_user()
Message-Id: <4B28F3CC.90509@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, adaplas@pol.net, linux-fbdev@vger.kernel.org

Although these sizes may be the same it is better to calculate the size of
the source, than of the destiny.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 99bbd28..57959c8 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -1234,7 +1234,7 @@ static int do_fscreeninfo_to_user(struct fb_fix_screeninfo *fix,
 	__u32 data;
 	int err;
 
-	err = copy_to_user(&fix32->id, &fix->id, sizeof(fix32->id));
+	err = copy_to_user(&fix32->id, &fix->id, sizeof(fix->id));
 
 	data = (__u32) (unsigned long) fix->smem_start;
 	err |= put_user(data, &fix32->smem_start);
