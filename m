From: Lynn Lei <lynnl.wit@gmail.com>
Date: Sun, 02 Jul 2017 14:27:40 +0000
Subject: [PATCH] staging: sm750fb: refactor method and fix potential type inconsistence
Message-Id: <20170702142335.GA9915@lynnl.wit>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com
Cc: teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

make reg variable typed `u32' not `unsigned int'
this can fix potential type inconsistence in some platforms

refactor swPanelPowerSequence() make the code less redundant

a early check for disp to skip unnecessary delay

Signed-off-by: Lynn Lei <lynnl.wit@gmail.com>
---
 drivers/staging/sm750fb/ddk750_display.c | 36 ++++++++++++++------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_display.c b/drivers/staging/sm750fb/ddk750_display.c
index 9b116ed6ecc7..0f666dc2729a 100644
--- a/drivers/staging/sm750fb/ddk750_display.c
+++ b/drivers/staging/sm750fb/ddk750_display.c
@@ -86,28 +86,24 @@ static void primary_wait_vertical_sync(int delay)
 
 static void swPanelPowerSequence(int disp, int delay)
 {
-	unsigned int reg;
+	u32 reg;
+	u32 opt[] = {
+		PANEL_DISPLAY_CTRL_FPEN, PANEL_DISPLAY_CTRL_DATA,
+		PANEL_DISPLAY_CTRL_VBIASEN, PANEL_DISPLAY_CTRL_FPEN,
+	};
+	u32 size, i;
+
+	if (disp = 0)
+		return;
+
+	size = sizeof(opt) / sizeof(u32);
 
 	/* disp should be 1 to open sequence */
-	reg = peek32(PANEL_DISPLAY_CTRL);
-	reg |= (disp ? PANEL_DISPLAY_CTRL_FPEN : 0);
-	poke32(PANEL_DISPLAY_CTRL, reg);
-	primary_wait_vertical_sync(delay);
-
-	reg = peek32(PANEL_DISPLAY_CTRL);
-	reg |= (disp ? PANEL_DISPLAY_CTRL_DATA : 0);
-	poke32(PANEL_DISPLAY_CTRL, reg);
-	primary_wait_vertical_sync(delay);
-
-	reg = peek32(PANEL_DISPLAY_CTRL);
-	reg |= (disp ? PANEL_DISPLAY_CTRL_VBIASEN : 0);
-	poke32(PANEL_DISPLAY_CTRL, reg);
-	primary_wait_vertical_sync(delay);
-
-	reg = peek32(PANEL_DISPLAY_CTRL);
-	reg |= (disp ? PANEL_DISPLAY_CTRL_FPEN : 0);
-	poke32(PANEL_DISPLAY_CTRL, reg);
-	primary_wait_vertical_sync(delay);
+	for (i = 0; i < size; i++) {
+		reg = peek32(PANEL_DISPLAY_CTRL) | opt[i];
+		poke32(PANEL_DISPLAY_CTRL, reg);
+		primary_wait_vertical_sync(delay);
+	}
 }
 
 void ddk750_setLogicalDispOut(disp_output_t output)
-- 
2.13.2

