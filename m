From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Tue, 10 Feb 2015 12:49:32 +0000
Subject: [PATCH] fbdev: sm501fb: use memset_io
Message-Id: <1423571852-14511-1-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

we should really be using memset_io() instead of using memset() as
this is actually io space mapped into our memory.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
it has only been build tested. I only have the hardware of sm712 and sm750.

 drivers/video/fbdev/sm501fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/sm501fb.c b/drivers/video/fbdev/sm501fb.c
index e8d4121..d0a4e2f 100644
--- a/drivers/video/fbdev/sm501fb.c
+++ b/drivers/video/fbdev/sm501fb.c
@@ -1606,7 +1606,7 @@ static int sm501fb_start(struct sm501fb_info *info,
 	info->fbmem_len = resource_size(res);
 
 	/* clear framebuffer memory - avoids garbage data on unused fb */
-	memset(info->fbmem, 0, info->fbmem_len);
+	memset_io(info->fbmem, 0, info->fbmem_len);
 
 	/* clear palette ram - undefined at power on */
 	for (k = 0; k < (256 * 3); k++)
-- 
1.8.1.2

