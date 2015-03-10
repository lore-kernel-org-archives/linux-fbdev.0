From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Tue, 10 Mar 2015 17:28:55 +0000
Subject: [PATCH 4/6] staging: sm750fb: correct incompatible pointer type
Message-Id: <1426007817-1884-5-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426007817-1884-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1426007817-1884-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

we were getting build warnings about assignment of incompatible
pointer types. some of the function definitions were having wrong
return type or arguments.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/staging/sm750fb/sm750.h       | 11 ++++++-----
 drivers/staging/sm750fb/sm750_accel.c |  4 ++--
 drivers/staging/sm750fb/sm750_accel.h |  4 ++--
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index d39968c..edb955a 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -23,7 +23,7 @@ struct lynx_accel{
 	volatile unsigned char __iomem * dpPortBase;
 
 	/* function fointers */
-	int (*de_init)(struct lynx_accel *);
+	void (*de_init)(struct lynx_accel *);
 
 	int (*de_wait)(void);/* see if hardware ready to work */
 
@@ -34,8 +34,8 @@ struct lynx_accel{
 						u32,u32,u32,u32,
 						u32,u32,u32,u32);
 
-	int (*de_imageblit)(struct lynx_accel *,const char *,u32,u32,u32,
-						u32,u32,u32,u32,u32,u32,u32,u32,u32);
+	int (*de_imageblit)(struct lynx_accel *, const char *, u32, u32, u32,
+			    u32, u32, u32, u32, u32, u32, u32, u32, u32);
 
 };
 
@@ -120,8 +120,9 @@ struct lynxfb_crtc{
 	int(*proc_setColReg)(struct lynxfb_crtc*,ushort,ushort,ushort,ushort);
 	void (*clear)(struct lynxfb_crtc*);
         /* pan display */
-        int(*proc_panDisplay)(struct lynxfb_crtc*, struct fb_var_screeninfo*,
-                struct fb_info*);
+	int (*proc_panDisplay)(struct lynxfb_crtc*,
+			       const struct fb_var_screeninfo*,
+			       const struct fb_info*);
 	/* cursor information */
 	struct lynx_cursor cursor;
 };
diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index ee211de..421adef 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -397,8 +397,8 @@ static unsigned int deGetTransparency(struct lynx_accel * accel)
 
 int hw_imageblit(
 struct lynx_accel * accel,
-unsigned char *pSrcbuf, /* pointer to start of source buffer in system memory */
-int srcDelta,          /* Pitch value (in bytes) of the source buffer, +ive means top down and -ive mean button up */
+const char *pSrcbuf, /* pointer to start of source buffer in system memory */
+unsigned int srcDelta,          /* Pitch value (in bytes) of the source buffer, +ive means top down and -ive mean button up */
 unsigned int startBit, /* Mono data can start at any bit in a byte, this value should be 0 to 7 */
 unsigned int dBase,    /* Address of destination: offset in frame buffer */
 unsigned int dPitch,   /* Pitch value of destination surface in BYTE */
diff --git a/drivers/staging/sm750fb/sm750_accel.h b/drivers/staging/sm750fb/sm750_accel.h
index 575f4a7..9c16618 100644
--- a/drivers/staging/sm750fb/sm750_accel.h
+++ b/drivers/staging/sm750fb/sm750_accel.h
@@ -260,8 +260,8 @@ unsigned int rop2);
 
 int hw_imageblit(
 struct lynx_accel * accel,
-unsigned char *pSrcbuf, /* pointer to start of source buffer in system memory */
-int srcDelta,          /* Pitch value (in bytes) of the source buffer, +ive means top down and -ive mean button up */
+const char *pSrcbuf, /* pointer to start of source buffer in system memory */
+unsigned int srcDelta, /* Pitch value (in bytes) of the source buffer, +ive means top down and -ive mean button up */
 unsigned int startBit, /* Mono data can start at any bit in a byte, this value should be 0 to 7 */
 unsigned int dBase,    /* Address of destination: offset in frame buffer */
 unsigned int dPitch,   /* Pitch value of destination surface in BYTE */
-- 
1.8.1.2

