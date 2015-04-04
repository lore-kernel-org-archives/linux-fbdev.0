From: Nickolaus Woodruff <nickolauswoodruff@gmail.com>
Date: Sat, 04 Apr 2015 19:22:45 +0000
Subject: [PATCH] staging: sm7xxfb: Fix sparse warning
Message-Id: <20150404165120.GA3111@Caladan>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipmmukherjee@gmail.com, teddywang@siliconmotion.com, gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

This patch fixes the following sparse warning in sm7xx.h:

drivers/staging/sm7xxfb/sm7xx.h:122:17: warning: symbol 'vgamode'
was not declared. Should it be static?

Signed-off-by: Nickolaus Woodruff <nickolauswoodruff@gmail.com>
---
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
1.9.1

