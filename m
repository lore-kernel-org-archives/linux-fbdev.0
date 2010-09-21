From: Daniel Drake <dsd@laptop.org>
Date: Tue, 21 Sep 2010 15:46:04 +0000
Subject: [PATCH] viafb: Use proper register for bgcolor when doing MONO blits
Message-Id: <20100921154604.2E3059D401B@zog.reactivated.net>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Jon Nettleton <jon.nettleton@gmail.com>

Seemingly random colours were being painted as the background on the
terminal. This fixes MONO color blits.

Fixes http://dev.laptop.org/ticket/9323

Signed-off-by: Daniel Drake <dsd@laptop.org>

---
 drivers/video/via/accel.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/via/accel.c b/drivers/video/via/accel.c
index e44893e..8d9819c 100644
--- a/drivers/video/via/accel.c
+++ b/drivers/video/via/accel.c
@@ -287,7 +287,7 @@ static int hw_bitblt_2(void __iomem *engine, u8 op, u32 width, u32 height,
 		writel(fg_color, engine + 0x4C);
 
 	if (op = VIA_BITBLT_MONO)
-		writel(bg_color, engine + 0x50);
+		writel(bg_color, engine + 0x58);
 
 	if (op = VIA_BITBLT_FILL)
 		ge_cmd |= fill_rop << 24 | 0x00002000 | 0x00000001;
-- 
1.7.2.2

