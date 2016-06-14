From: yeongjun Kim <iam.yeongjunkim@gmail.com>
Date: Tue, 14 Jun 2016 15:38:33 +0000
Subject: [PATCH] staging: sm750fb: fix block comments errors in ddk750_display.c
Message-Id: <20160614153833.GA23451@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160606190432.GA5308@moshe-Lenovo-Yoga-2-Pro>
In-Reply-To: <20160606190432.GA5308@moshe-Lenovo-Yoga-2-Pro>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com
Cc: teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

WARNING: Block comments use * on subsequent lines
WARNING: Block comments use a trailing */ on a separate line
WARNING: Block comments use * on subsequent lines
WARNING: Block comments use a trailing */ on a separate line

Signed-off-by: yeongjun Kim <iam.yeongjunkim@gmail.com>
---
 drivers/staging/sm750fb/ddk750_display.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_display.c b/drivers/staging/sm750fb/ddk750_display.c
index ca4973e..a040042 100644
--- a/drivers/staging/sm750fb/ddk750_display.c
+++ b/drivers/staging/sm750fb/ddk750_display.c
@@ -68,8 +68,10 @@ static void waitNextVerticalSync(int ctrl, int delay)
 	if (!ctrl) {
 		/* primary controller */
 
-		/* Do not wait when the Primary PLL is off or display control is already off.
-		   This will prevent the software to wait forever. */
+		/*
+		 * Do not wait when the Primary PLL is off or display control is
+		 * already off. This will prevent the software to wait forever.
+		 */
 		if (!(PEEK32(PANEL_PLL_CTRL) & PLL_CTRL_POWER) ||
 		    !(PEEK32(PANEL_DISPLAY_CTRL) & DISPLAY_CTRL_TIMING)) {
 			return;
@@ -88,9 +90,10 @@ static void waitNextVerticalSync(int ctrl, int delay)
 		}
 
 	} else {
-
-		/* Do not wait when the Primary PLL is off or display control is already off.
-			   This will prevent the software to wait forever. */
+		/*
+		 * Do not wait when the Primary PLL is off or display control is
+		 * already off. This will prevent the software to wait forever.
+		 */
 		if (!(PEEK32(CRT_PLL_CTRL) & PLL_CTRL_POWER) ||
 		    !(PEEK32(CRT_DISPLAY_CTRL) & DISPLAY_CTRL_TIMING)) {
 			return;
-- 
1.9.1

