From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sun, 20 Dec 2009 17:16:46 +0000
Subject: [PATCH 2/5] viafb: remove dead code
Message-Id: <1261329409-3518-2-git-send-email-FlorianSchandinat@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1261329409-3518-1-git-send-email-FlorianSchandinat@gmx.de>
In-Reply-To: <1261329409-3518-1-git-send-email-FlorianSchandinat@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, JosephChan@via.com.tw, ScottFang@viatech.com.cn, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

viafb: remove dead code

Remove a completly unused function.

Signed-off-by: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
---
 drivers/video/via/via_utility.c |   12 ------------
 drivers/video/via/via_utility.h |    1 -
 2 files changed, 0 insertions(+), 13 deletions(-)

diff --git a/drivers/video/via/via_utility.c b/drivers/video/via/via_utility.c
index d53c3d5..aefdeee 100644
--- a/drivers/video/via/via_utility.c
+++ b/drivers/video/via/via_utility.c
@@ -239,15 +239,3 @@ void viafb_get_gamma_support_state(int bpp, unsigned int *support_state)
 	else
 		*support_state = CRT_Device | DVI_Device | LCD_Device;
 }
-
-int viafb_input_parameter_converter(int parameter_value)
-{
-	int result;
-
-	if (parameter_value >= 1 && parameter_value <= 9)
-		result = 1 << (parameter_value - 1);
-	else
-		result = 1;
-
-	return result;
-}
diff --git a/drivers/video/via/via_utility.h b/drivers/video/via/via_utility.h
index 2fd4552..1670ba8 100644
--- a/drivers/video/via/via_utility.h
+++ b/drivers/video/via/via_utility.h
@@ -30,6 +30,5 @@ bool viafb_lcd_get_support_expand_state(u32 xres, u32 yres);
 void viafb_set_gamma_table(int bpp, unsigned int *gamma_table);
 void viafb_get_gamma_table(unsigned int *gamma_table);
 void viafb_get_gamma_support_state(int bpp, unsigned int *support_state);
-int viafb_input_parameter_converter(int parameter_value);
 
 #endif /* __VIAUTILITY_H__ */
-- 
1.6.3.2

