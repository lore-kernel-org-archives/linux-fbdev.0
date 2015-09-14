From: Anjali Menon <cse.anjalimenon@gmail.com>
Date: Mon, 14 Sep 2015 10:58:35 +0000
Subject: [PATCH] staging: sm750fb: Added a space
Message-Id: <1442228300-5167-1-git-send-email-cse.anjalimenon@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: gregkh@linuxfoundation.org
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, Anjali Menon <cse.anjalimenon@gmail.com>

Added a space to fix the following coding style error detected by
checkpatch.

ERROR: space required before the open parenthesis '('

Signed-off-by: Anjali Menon <cse.anjalimenon@gmail.com>
---
 drivers/staging/sm750fb/ddk750_dvi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/ddk750_dvi.c b/drivers/staging/sm750fb/ddk750_dvi.c
index f5932bb..1eea768 100644
--- a/drivers/staging/sm750fb/ddk750_dvi.c
+++ b/drivers/staging/sm750fb/ddk750_dvi.c
@@ -45,7 +45,7 @@ int dviInit(
 {
 	dvi_ctrl_device_t *pCurrentDviCtrl;
 	pCurrentDviCtrl = g_dcftSupportedDviController;
-	if(pCurrentDviCtrl->pfnInit != NULL)
+	if (pCurrentDviCtrl->pfnInit != NULL)
 	{
 		return pCurrentDviCtrl->pfnInit(edgeSelect, busSelect, dualEdgeClkSelect, hsyncEnable,
                               vsyncEnable, deskewEnable, deskewSetting, continuousSyncEnable,
-- 
1.9.1

