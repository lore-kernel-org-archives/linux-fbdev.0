From: Manish Badarkhe <badarkhe.manish@gmail.com>
Date: Thu, 10 Oct 2013 04:40:31 +0000
Subject: [PATCH] video: da8xx-fb: remove unwanted define
Message-Id: <1381379311-22240-1-git-send-email-badarkhe.manish@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, nsekhar@ti.com, badarkhe.manish@gmail.com

Remove unwanted define "WSI_TIMEOUT" present in code.

Signed-off-by: Manish Badarkhe <badarkhe.manish@gmail.com>
---
:100644 100644 e030e17... fa61323... M	drivers/video/da8xx-fb.c
 drivers/video/da8xx-fb.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index e030e17..fa61323 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -129,7 +129,6 @@
 
 #define LCD_NUM_BUFFERS	2
 
-#define WSI_TIMEOUT	50
 #define PALETTE_SIZE	256
 
 #define	CLK_MIN_DIV	2
-- 
1.7.10.4

