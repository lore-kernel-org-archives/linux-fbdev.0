From: Aymen Qader <qader.aymen@gmail.com>
Date: Sat, 29 Sep 2018 17:38:07 +0000
Subject: [PATCH] staging: sm750fb: Remove extra space character
Message-Id: <20180929173807.14261-1-qader.aymen@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, Aymen Qader <qader.aymen@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

Remove an extra space in ddk750_mode.c to fix indentation

Signed-off-by: Aymen Qader <qader.aymen@gmail.com>
---
 drivers/staging/sm750fb/ddk750_mode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
index 7e22d093b091..4dac691ad1b1 100644
--- a/drivers/staging/sm750fb/ddk750_mode.c
+++ b/drivers/staging/sm750fb/ddk750_mode.c
@@ -131,7 +131,7 @@ static int programModeRegisters(struct mode_parameter *pModeParam,
 				  DISPLAY_CTRL_HSYNC_PHASE |
 				  DISPLAY_CTRL_TIMING | DISPLAY_CTRL_PLANE);
 
-			 poke32(CRT_DISPLAY_CTRL, tmp | reg);
+			poke32(CRT_DISPLAY_CTRL, tmp | reg);
 		}
 
 	} else if (pll->clockType = PRIMARY_PLL) {
-- 
2.17.1
