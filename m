From: Shailendra Verma <shailendra.v@samung.com>
Date: Fri, 30 Oct 2015 11:41:45 +0000
Subject: [PATCH] video:fbdev:core:Calculate the buffer alignment if buffer is not IO mapped.
Message-Id: <1446204585-23412-1-git-send-email-shailendra.v@samung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, vidushi.koul@samsung.com

From: Shailendra Verma <Shailendra.v@samsung.com>

Moving the instruction "align = buf->buf_align - 1" just after the
verification of the buffer if it is IP mapped or not as the buffer
alignment is not required if it is IO mapped.Thus it will save an
extra instuction execution when buffer is IO mapped.

Signed-off-by: Shailendra Verma <Shailendra.v@samsung.com>
---
 linux-4.3-rc6/drivers/video/fbdev/core/fbmem.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/linux-4.3-rc6/drivers/video/fbdev/core/fbmem.c b/linux-4.3-rc6/drivers/video/fbdev/core/fbmem.c
index 0705d88..d92ec99 100644
--- a/linux-4.3-rc6/drivers/video/fbdev/core/fbmem.c
+++ b/linux-4.3-rc6/drivers/video/fbdev/core/fbmem.c
@@ -157,7 +157,7 @@ EXPORT_SYMBOL(fb_pad_unaligned_buffer);
  */
 char* fb_get_buffer_offset(struct fb_info *info, struct fb_pixmap *buf, u32 size)
 {
-	u32 align = buf->buf_align - 1, offset;
+	u32 align, offset;
 	char *addr = buf->addr;
 
 	/* If IO mapped, we need to sync before access, no sharing of
@@ -169,6 +169,8 @@ char* fb_get_buffer_offset(struct fb_info *info, struct fb_pixmap *buf, u32 size
 		return addr;
 	}
 
+	align = buf->buf_align - 1;
+
 	/* See if we fit in the remaining pixmap space */
 	offset = buf->offset + align;
 	offset &= ~align;
-- 
1.7.9.5

