From: anders.fridlund@gmail.com
Date: Thu, 09 Jul 2015 12:45:22 +0000
Subject: [PATCH] Staging: sm750fb: ddk750_dvi.h: Fix brace coding style issue
Message-Id: <1436445922-5218-1-git-send-email-anders.fridlund@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com
Cc: gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, Anders Fridlund <anders.fridlund@gmail.com>

From: Anders Fridlund <anders.fridlund@gmail.com>

This is a patch to the ddk750_dvi.h file that fixes up a brace error
found by the checkpatch.pl tool

Signed-off-by: Anders Fridlund <anders.fridlund@gmail.com>
---
 drivers/staging/sm750fb/ddk750_dvi.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_dvi.h b/drivers/staging/sm750fb/ddk750_dvi.h
index 83bbd6d..e1d4c9a 100644
--- a/drivers/staging/sm750fb/ddk750_dvi.h
+++ b/drivers/staging/sm750fb/ddk750_dvi.h
@@ -26,8 +26,7 @@ typedef unsigned char (*PFN_DVICTRL_CHECKINTERRUPT)(void);
 typedef void (*PFN_DVICTRL_CLEARINTERRUPT)(void);
 
 /* Structure to hold all the function pointer to the DVI Controller. */
-typedef struct _dvi_ctrl_device_t
-{
+typedef struct _dvi_ctrl_device_t {
 	PFN_DVICTRL_INIT		pfnInit;
 	PFN_DVICTRL_RESETCHIP		pfnResetChip;
 	PFN_DVICTRL_GETCHIPSTRING	pfnGetChipString;
-- 
1.9.1

