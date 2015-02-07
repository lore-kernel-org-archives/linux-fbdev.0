From: Ondrej Zary <linux@rainbow-software.org>
Date: Sat, 07 Feb 2015 20:53:35 +0000
Subject: [PATCH 2/4] tridentfb: Fix set_lwidth on TGUI9440 and CYBER9320
Message-Id: <1423342417-26069-2-git-send-email-linux@rainbow-software.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423342417-26069-1-git-send-email-linux@rainbow-software.org>
In-Reply-To: <1423342417-26069-1-git-send-email-linux@rainbow-software.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Krzysztof Helt <krzysztof.h1@wp.pl>
Cc: linux-fbdev@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>

According to X.Org driver, chips older than TGUI9660 have only 1 width bit
in AddColReg. Touching the 2nd one causes I2C/DDC to fail on TGUI9440.

Set only 1 bit of width in AddColReg on TGUI9440 and CYBER9320.

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>
---
 drivers/video/fbdev/tridentfb.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/tridentfb.c b/drivers/video/fbdev/tridentfb.c
index 7429713..01b43e9 100644
--- a/drivers/video/fbdev/tridentfb.c
+++ b/drivers/video/fbdev/tridentfb.c
@@ -673,8 +673,14 @@ static int get_nativex(struct tridentfb_par *par)
 static inline void set_lwidth(struct tridentfb_par *par, int width)
 {
 	write3X4(par, VGA_CRTC_OFFSET, width & 0xFF);
-	write3X4(par, AddColReg,
-		 (read3X4(par, AddColReg) & 0xCF) | ((width & 0x300) >> 4));
+	/* chips older than TGUI9660 have only 1 width bit in AddColReg */
+	/* touching the other one breaks I2C/DDC */
+	if (par->chip_id = TGUI9440 || par->chip_id = CYBER9320)
+		write3X4(par, AddColReg,
+		     (read3X4(par, AddColReg) & 0xEF) | ((width & 0x100) >> 4));
+	else
+		write3X4(par, AddColReg,
+		     (read3X4(par, AddColReg) & 0xCF) | ((width & 0x300) >> 4));
 }
 
 /* For resolutions smaller than FP resolution stretch */
-- 
Ondrej Zary

