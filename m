From: Lynn Lei <lynnl.wit@gmail.com>
Date: Sun, 02 Jul 2017 14:40:33 +0000
Subject: [PATCH v2] staging: sm750fb: refactor method and fix potential type inconsistence
Message-Id: <20170702144033.GA5784@lynnl.wit>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com
Cc: teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

include PANEL_DISPLAY_CTRL_FPVDDEN control mask

Signed-off-by: Lynn Lei <lynnl.wit@gmail.com>
---
 drivers/staging/sm750fb/ddk750_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/ddk750_display.c b/drivers/staging/sm750fb/ddk750_display.c
index 0f666dc2729a..c68367e6cdeb 100644
--- a/drivers/staging/sm750fb/ddk750_display.c
+++ b/drivers/staging/sm750fb/ddk750_display.c
@@ -89,7 +89,7 @@ static void swPanelPowerSequence(int disp, int delay)
 	u32 reg;
 	u32 opt[] = {
 		PANEL_DISPLAY_CTRL_FPEN, PANEL_DISPLAY_CTRL_DATA,
-		PANEL_DISPLAY_CTRL_VBIASEN, PANEL_DISPLAY_CTRL_FPEN,
+		PANEL_DISPLAY_CTRL_VBIASEN, PANEL_DISPLAY_CTRL_FPVDDEN,
 	};
 	u32 size, i;
 
-- 
2.13.2

