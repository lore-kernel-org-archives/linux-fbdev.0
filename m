From: Ondrej Zary <linux@rainbow-software.org>
Date: Sat, 14 Feb 2015 23:09:29 +0000
Subject: [PATCH] gxt4500: fix 16bpp 565 mode
Message-Id: <1423955369-29423-1-git-send-email-linux@rainbow-software.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mackerras <paulus@samba.org>
Cc: linux-fbdev@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>

Fix wrong colors in 16bpp 565 mode.
Not sure if this is OK for big-endian systems or it breaks them.

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>
---
 drivers/video/fbdev/gxt4500.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/gxt4500.c b/drivers/video/fbdev/gxt4500.c
index 1bf9894..1f2fd5b 100644
--- a/drivers/video/fbdev/gxt4500.c
+++ b/drivers/video/fbdev/gxt4500.c
@@ -525,7 +525,7 @@ static int gxt4500_setcolreg(unsigned int reg, unsigned int red,
 		u32 val = reg;
 		switch (par->pixfmt) {
 		case DFA_PIX_16BIT_565:
-			val |= (reg << 11) | (reg << 6);
+			val |= (reg << 11) | (reg << 5);
 			break;
 		case DFA_PIX_16BIT_1555:
 			val |= (reg << 10) | (reg << 5);
-- 
Ondrej Zary

