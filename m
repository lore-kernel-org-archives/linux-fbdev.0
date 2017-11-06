From: Huacai Chen <chenhc@lemote.com>
Date: Mon, 06 Nov 2017 00:43:03 +0000
Subject: [PATCH] sm750fb: Fix parameter mistake in poke32
Message-Id: <1509928983-13176-1-git-send-email-chenhc@lemote.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

In commit c075b6f2d357ea9 ("staging: sm750fb: Replace POKE32 and PEEK32
by inline functions"), POKE32 has been replaced by the inline function
poke32. But it exchange the "addr" and "data" parameters by mistake, so
fix it.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Liangliang Huang <huangll@lemote.com>
---
 drivers/staging/sm750fb/ddk750_chip.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/ddk750_chip.h b/drivers/staging/sm750fb/ddk750_chip.h
index 09c223f..aee82fc 100644
--- a/drivers/staging/sm750fb/ddk750_chip.h
+++ b/drivers/staging/sm750fb/ddk750_chip.h
@@ -18,7 +18,7 @@ static inline u32 peek32(u32 addr)
 	return readl(addr + mmio750);
 }
 
-static inline void poke32(u32 data, u32 addr)
+static inline void poke32(u32 addr, u32 data)
 {
 	writel(data, addr + mmio750);
 }
-- 
2.7.0

