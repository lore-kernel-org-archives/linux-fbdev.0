From: Simran Sandhu <f20171454@hyderabad.bits-pilani.ac.in>
Date: Thu, 19 Dec 2019 09:17:53 +0000
Subject: [PATCH 3/3] Staging: sm750fb: sm750.h:Fixed Coding Style Issue
Message-Id: <20191219090553.13243-1-f20171454@hyderabad.bits-pilani.ac.in>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: gregkh@linuxfoundation.org
Cc: devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, sudipm.mukherjee@gmail.comm, teddy.wang@siliconmotion.com, linux-kernel@vger.kernel.org

Fixed the checkpath error: function definition arguments
should also have identifier names

Signed-of-by: Simran Sandhu <f20171454@hyderabad.bits-pilani.ac.in>
---
 drivers/staging/sm750fb/sm750.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index ce90adcb449d..cf986bad7210 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -66,9 +66,9 @@ struct lynx_accel {
 						u32, u32, u32, u32,
 						u32, u32, u32, u32);
 
-	int (*de_imageblit)(struct lynx_accel *, const char *, u32, u32, u32, u32,
-							       u32, u32, u32, u32,
-							       u32, u32, u32, u32);
+	int (*de_imageblit)(struct lynx_accel *A, const char *B, u32 C, u32 D,
+		       						u32 E, u32 F, u32 G, u32 H, u32 I,
+							       	u32 J, u32 K, u32 L, u32 M, u32 N);
 
 };
 
-- 
2.17.1
