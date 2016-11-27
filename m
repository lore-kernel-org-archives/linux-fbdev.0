From: Andrea Ghittino <aghittino@gmail.com>
Date: Sun, 27 Nov 2016 16:56:11 +0000
Subject: [PATCH] staging: sm750fb: fix tabstop style warning
Message-Id: <20161127165506.GA4129@myhd3>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Fixes sm750fb tabstop style warning
found by checkpatch.pl tool

Signed-off-by: Andrea Ghittino <aghittino at gmail.com>
---
diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index 6fd18d2..af0db57 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -395,6 +395,6 @@ int sm750_hw_imageblit(struct lynx_accel *accel,
 		pSrcbuf += srcDelta;
 	}
 
-	    return 0;
+	return 0;
 }
 
