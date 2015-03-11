From: Lorenzo Stoakes <lstoakes@gmail.com>
Date: Wed, 11 Mar 2015 01:28:43 +0000
Subject: [PATCH 4/6] staging: sm750fb: Expose hw712_fillrect externally
Message-Id: <1426037325-8392-4-git-send-email-lstoakes@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426037325-8392-1-git-send-email-lstoakes@gmail.com>
In-Reply-To: <1426037325-8392-1-git-send-email-lstoakes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, Lorenzo Stoakes <lstoakes@gmail.com>

This patch adds a reference to hw712_fillrect which is not used elsewhere in the driver,
but appears to be an alternative to the hw_fillrect method. This patch fixes the following sparse warning:-

drivers/staging/sm750fb/sm750_accel.c:95:5: warning: symbol 'hw712_fillrect' was not declared. Should it be static?

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 drivers/staging/sm750fb/sm750_accel.c | 2 +-
 drivers/staging/sm750fb/sm750_accel.h | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index 4aa763b..6521c3b 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -92,7 +92,7 @@ void hw_set2dformat(struct lynx_accel * accel,int fmt)
 /* seems sm712 RectFill command is broken,so need use BitBlt to
  * replace it. */
 
-static int hw712_fillrect(struct lynx_accel * accel,
+int hw712_fillrect(struct lynx_accel * accel,
 				u32 base,u32 pitch,u32 Bpp,
 				u32 x,u32 y,u32 width,u32 height,
 				u32 color,u32 rop)
diff --git a/drivers/staging/sm750fb/sm750_accel.h b/drivers/staging/sm750fb/sm750_accel.h
index 3ee0bd8..51a9367 100644
--- a/drivers/staging/sm750fb/sm750_accel.h
+++ b/drivers/staging/sm750fb/sm750_accel.h
@@ -238,11 +238,16 @@ void hw_set2dformat(struct lynx_accel * accel,int fmt);
 
 void hw_de_init(struct lynx_accel * accel);
 
+int hw712_fillrect(struct lynx_accel * accel,
+				u32 base,u32 pitch,u32 Bpp,
+				u32 x,u32 y,u32 width,u32 height,
+				u32 color,u32 rop);
+
 int hw_fillrect(struct lynx_accel * accel,
 				u32 base,u32 pitch,u32 Bpp,
 				u32 x,u32 y,u32 width,u32 height,
 				u32 color,u32 rop);
 
 int hw_copyarea(
 struct lynx_accel * accel,
 unsigned int sBase,  /* Address of source: offset in frame buffer */
-- 
2.3.2

