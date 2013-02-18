From: Jingoo Han <jg1.han@samsung.com>
Date: Mon, 18 Feb 2013 05:14:06 +0000
Subject: [PATCH 2/5 RESEND] video: s3c-fb: remove duplicated S3C_FB_MAX_WIN
Message-Id: <000301ce0d96$c68ba8a0$53a2f9e0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <000201ce0d96$9fa550b0$deeff210$%han@samsung.com>
In-Reply-To: <000201ce0d96$9fa550b0$deeff210$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Andrew Morton' <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, 'Florian Tobias Schandinat' <FlorianSchandinat@gmx.de>, 'Jingoo Han' <jg1.han@samsung.com>

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


