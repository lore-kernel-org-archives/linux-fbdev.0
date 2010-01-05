From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Tue, 05 Jan 2010 22:59:59 +0000
Subject: [PATCH 4/4] viafb: fix acceleration for some chips
Message-Id: <1262732399-3416-4-git-send-email-FlorianSchandinat@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1262732399-3416-1-git-send-email-FlorianSchandinat@gmx.de>
 <1262732399-3416-2-git-send-email-FlorianSchandinat@gmx.de>
 <1262732399-3416-3-git-send-email-FlorianSchandinat@gmx.de>
In-Reply-To: <1262732399-3416-3-git-send-email-FlorianSchandinat@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, JosephChan@via.com.tw, ScottFang@viatech.com.cn, Erik-Jan Post <ej.lfs@xs4all.nl>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

From: Erik-Jan Post <ej.lfs@xs4all.nl>

viafb: fix acceleration for some chips

This patch fixes a regression in hardware acceleration which made the
accelerated framebuffer unusable on some chips. These need extra
initialization and an extra flag which is no longer needed/available
on current chips.

Signed-off-by: Erik-Jan Post <ej.lfs@xs4all.nl>
Signed-off-by: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
---
 drivers/video/via/accel.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/video/via/accel.c b/drivers/video/via/accel.c
index 9d4f3a4..d5077df 100644
--- a/drivers/video/via/accel.c
+++ b/drivers/video/via/accel.c
@@ -137,7 +137,7 @@ static int hw_bitblt_1(void __iomem *engine, u8 op, u32 width, u32 height,
 			tmp, dst_pitch);
 		return -EINVAL;
 	}
-	tmp = (tmp >> 3) | (dst_pitch << (16 - 3));
+	tmp = VIA_PITCH_ENABLE | (tmp >> 3) | (dst_pitch << (16 - 3));
 	writel(tmp, engine + 0x38);
 
 	if (op = VIA_BITBLT_FILL)
@@ -352,6 +352,9 @@ int viafb_init_engine(struct fb_info *info)
 	viapar->shared->vq_vram_addr = viapar->fbmem_free;
 	viapar->fbmem_used += VQ_SIZE;
 
+	/* Init 2D engine reg to reset 2D engine */
+	writel(0x0, engine + VIA_REG_KEYCONTROL);
+
 	/* Init AGP and VQ regs */
 	switch (chip_name) {
 	case UNICHROME_K8M890:
-- 
1.6.3.2

