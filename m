From: Andrea della Porta <sfaragnaus@gmail.com>
Date: Fri, 07 Apr 2017 00:24:39 +0000
Subject: [PATCH] staging: sm750fb: ddk750_display.c - fixed checkpatch warning: line over 80 chars
Message-Id: <20170407002439.GA8300@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

staging: sm750fb: ddk750_display.c - fixed the following checkpatch warning:
WARNING: line over 80 characters
#149: FILE: drivers/staging/sm750fb/ddk750_display.c:149:
+               swPanelPowerSequence((output & PNL_SEQ_MASK) >> PNL_SEQ_OFFSET, 4);

Signed-off-by: Andrea della Porta <sfaragnaus@gmail.com>
---
 drivers/staging/sm750fb/ddk750_display.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/ddk750_display.c b/drivers/staging/sm750fb/ddk750_display.c
index e4724a6..9b116ed6 100644
--- a/drivers/staging/sm750fb/ddk750_display.c
+++ b/drivers/staging/sm750fb/ddk750_display.c
@@ -146,7 +146,8 @@ void ddk750_setLogicalDispOut(disp_output_t output)
 
 	if (output & PNL_SEQ_USAGE) {
 		/* set  panel sequence */
-		swPanelPowerSequence((output & PNL_SEQ_MASK) >> PNL_SEQ_OFFSET, 4);
+		swPanelPowerSequence((output & PNL_SEQ_MASK) >> PNL_SEQ_OFFSET,
+				     4);
 	}
 
 	if (output & DAC_USAGE)
-- 
2.4.10

