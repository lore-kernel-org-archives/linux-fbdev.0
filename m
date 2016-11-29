From: Andrea Ghittino <aghittino@gmail.com>
Date: Tue, 29 Nov 2016 21:57:21 +0000
Subject: [PATCH v3] staging: sm750fb: fix tabstop style warning
Message-Id: <20161129215539.GA5530@myhd3>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Fixes sm750fb tabstop style warning
found by checkpatch.pl tool

Signed-off-by: Andrea Ghittino <aghittino@gmail.com>
---
changelog:
v2) Fixed email subject
v3) Fixed email format

drivers/staging/sm750fb/sm750_accel.c |    2 +-
1 file changed, 1 insertion(+), 1 deletion(-)

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
 
