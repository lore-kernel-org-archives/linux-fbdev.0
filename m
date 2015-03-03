From: Ondrej Zary <linux@rainbow-software.org>
Date: Tue, 03 Mar 2015 20:56:00 +0000
Subject: [PATCH 1/4] [resend] tridentfb: fix hang on Blade3D with CONFIG_CC_OPTIMIZE_FOR_SIZE
Message-Id: <1425416163-10700-1-git-send-email-linux@rainbow-software.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Krzysztof Helt <krzysztof.h1@wp.pl>
Cc: linux-fbdev@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>

When the kernel is compiled with -Os (CONFIG_CC_OPTIMIZE_FOR_SIZE), tridentfb
hangs the machine upon load with Blade3D cards unless acceleration is disabled.

This is caused by memcpy() which copies data byte-by-byte (rep movsb) when
compiled with -Os. The card does not like that - it requires 32-bit access.

Use iowrite_32() instead.

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>
Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
 drivers/video/fbdev/tridentfb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/tridentfb.c b/drivers/video/fbdev/tridentfb.c
index 7ed9a22..7429713 100644
--- a/drivers/video/fbdev/tridentfb.c
+++ b/drivers/video/fbdev/tridentfb.c
@@ -226,7 +226,7 @@ static void blade_image_blit(struct tridentfb_par *par, const char *data,
 	writemmr(par, DST1, point(x, y));
 	writemmr(par, DST2, point(x + w - 1, y + h - 1));
 
-	memcpy(par->io_virt + 0x10000, data, 4 * size);
+	iowrite32_rep(par->io_virt + 0x10000, data, size);
 }
 
 static void blade_copy_rect(struct tridentfb_par *par,
-- 
Ondrej Zary

