From: Jingoo Han <jg1.han@samsung.com>
Date: Wed, 26 Dec 2012 08:14:30 +0000
Subject: [PATCH 2/4] video: s3c-fb: remove duplicated S3C_FB_MAX_WIN
Message-Id: <032901cde341$07e59c00$17b0d400$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

S3C_FB_MAX_WIN is already defined in 'plat-samsung/include/plat/fb.h'.
So, this definition in 'include/video/samsung_fimd.h' should be
removed to avoid the duplication.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 include/video/samsung_fimd.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/include/video/samsung_fimd.h b/include/video/samsung_fimd.h
index e755448..0865256 100644
--- a/include/video/samsung_fimd.h
+++ b/include/video/samsung_fimd.h
@@ -438,8 +438,6 @@
 #define BLENDCON_NEW_8BIT_ALPHA_VALUE		(1 << 0)
 #define BLENDCON_NEW_4BIT_ALPHA_VALUE		(0 << 0)
 
-#define S3C_FB_MAX_WIN (5)  /* number of hardware windows available. */
-
 /* Notes on per-window bpp settings
  *
  * Value	Win0	 Win1	  Win2	   Win3	    Win 4
-- 
1.7.2.5


