From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Tue, 10 Feb 2015 12:20:40 +0000
Subject: [PATCH] staging: sm7xxfb: make vgamode static
Message-Id: <1423570120-9041-1-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

the variable vgamode is used only in this file and hence can be
safely made as static.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
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
1.8.1.2

