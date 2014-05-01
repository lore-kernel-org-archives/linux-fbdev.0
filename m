From: Brian W Hart <hartb@linux.vnet.ibm.com>
Date: Thu, 01 May 2014 19:32:35 +0000
Subject: [PATCH] fbdev/fb.h: silence warning with -Wsign-compare
Message-Id: <20140501193235.GB6495@oc3347516403.ibm.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, trivial@kernel.org

Silence the warning when building with -Wsign-compare when fb.h is
included:

include/linux/fb.h: In function ‘__fb_pad_aligned_buffer’:
include/linux/fb.h:650:17: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]
   for (j = 0; j < s_pitch; j++)
                 ^

Signed-off-by: Brian W Hart <hartb@linux.vnet.ibm.com>
---
Compile tested only.

 include/linux/fb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fb.h b/include/linux/fb.h
index fe6ac95..0da7634 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -641,7 +641,7 @@ static inline void unlock_fb_info(struct fb_info *info)
 static inline void __fb_pad_aligned_buffer(u8 *dst, u32 d_pitch,
 					   u8 *src, u32 s_pitch, u32 height)
 {
-	int i, j;
+	u32 i, j;
 
 	d_pitch -= s_pitch;
 

