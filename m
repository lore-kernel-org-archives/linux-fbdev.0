From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 12 Jan 2015 08:40:19 +0000
Subject: [PATCH 3/5] video: atafb: Remove obsolete IRQ_TYPE_PRIO
Message-Id: <1421052021-12560-4-git-send-email-geert@linux-m68k.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1421052021-12560-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1421052021-12560-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, linux-fbdev@vger.kernel.org

IRQ_TYPE_PRIO is no longer used by the Atari platform interrupt code
since commit 734085651c9b80aa ("[PATCH] m68k: convert atari irq code")
in v2.6.18-rc1, so drop it.

Note that its value has been reused for a different purpose
(IRQ_TYPE_EDGE_FALLING) since commit 6a6de9ef5850d063 ("[PATCH] genirq:
core") in v2.6.18-rc1.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-fbdev@vger.kernel.org
---
 drivers/video/fbdev/atafb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/atafb.c b/drivers/video/fbdev/atafb.c
index b2d38097a95718ce..7b231771a4b668b0 100644
--- a/drivers/video/fbdev/atafb.c
+++ b/drivers/video/fbdev/atafb.c
@@ -3121,8 +3121,7 @@ int __init atafb_init(void)
 			printk("atafb_init: initializing Falcon hw\n");
 			fbhw = &falcon_switch;
 			atafb_ops.fb_setcolreg = &falcon_setcolreg;
-			error = request_irq(IRQ_AUTO_4, falcon_vbl_switcher,
-					    IRQ_TYPE_PRIO,
+			error = request_irq(IRQ_AUTO_4, falcon_vbl_switcher, 0,
 					    "framebuffer:modeswitch",
 					    falcon_vbl_switcher);
 			if (error)
-- 
1.9.1

