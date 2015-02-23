From: Peter Senna Tschudin <peter.senna@gmail.com>
Date: Mon, 23 Feb 2015 11:16:16 +0000
Subject: [PATCH] staging/sm7xxfb: Make 'struct vgamode' static
Message-Id: <1424690176-7966-1-git-send-email-peter.senna@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc: Peter Senna Tschudin <peter.senna@gmail.com>

sparse was complaining that symbol 'vgamode' was not declared.

Declaring vgamode as static.

Signed-off-by: Peter Senna Tschudin <peter.senna@gmail.com>
---
Tested by compilation only

 drivers/staging/sm7xxfb/sm7xx.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm7xxfb/sm7xx.h b/drivers/staging/sm7xxfb/sm7xx.h
index 7cc1896..c5d6253 100644
--- a/drivers/staging/sm7xxfb/sm7xx.h
+++ b/drivers/staging/sm7xxfb/sm7xx.h
@@ -119,7 +119,7 @@ struct ModeInit {
 /**********************************************************************
 			 SM712 Mode table.
  **********************************************************************/
-struct ModeInit vgamode[] = {
+static struct ModeInit vgamode[] = {
 	{
 	 /*  mode#0: 640 x 480  16Bpp  60Hz */
 	 640, 480, 16, 60,
-- 
2.1.0

