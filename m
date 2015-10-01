From: Ondrej Zary <linux@rainbow-software.org>
Date: Thu, 01 Oct 2015 21:22:52 +0000
Subject: [PATCH v2 2/5] gxt4500: fix 16bpp 565 mode
Message-Id: <1443734575-12468-3-git-send-email-linux@rainbow-software.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1443734575-12468-1-git-send-email-linux@rainbow-software.org>
In-Reply-To: <1443734575-12468-1-git-send-email-linux@rainbow-software.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mackerras <paulus@samba.org>
Cc: =Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>

Fix wrong colors in 16bpp 565 mode.

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>
---
 drivers/video/fbdev/gxt4500.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/gxt4500.c b/drivers/video/fbdev/gxt4500.c
index ae68696..3c481d0 100644
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

