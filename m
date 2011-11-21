From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 21 Nov 2011 20:53:58 +0000
Subject: [PATCH 7/8] fbdev/amifb: Enable Copper DMA after setting up the Copper
Message-Id: <1321908839-11419-7-git-send-email-geert@linux-m68k.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1321908839-11419-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1321908839-11419-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org
Cc: linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>

Else the Copper may start executing random instructions

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/video/amifb.c |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/video/amifb.c b/drivers/video/amifb.c
index 13e7a17..2bfaf1b 100644
--- a/drivers/video/amifb.c
+++ b/drivers/video/amifb.c
@@ -3733,17 +3733,15 @@ default_chipset:
 	memset(dummysprite, 0, DUMMYSPRITEMEMSIZE);
 
 	/*
-	 * Enable Display DMA
+	 * Make sure the Copper has something to do
 	 */
-
-	custom.dmacon = DMAF_SETCLR | DMAF_MASTER | DMAF_RASTER | DMAF_COPPER |
-			DMAF_BLITTER | DMAF_SPRITE;
+	ami_init_copper();
 
 	/*
-	 * Make sure the Copper has something to do
+	 * Enable Display DMA
 	 */
-
-	ami_init_copper();
+	custom.dmacon = DMAF_SETCLR | DMAF_MASTER | DMAF_RASTER | DMAF_COPPER |
+			DMAF_BLITTER | DMAF_SPRITE;
 
 	if (request_irq(IRQ_AMIGA_COPPER, amifb_interrupt, 0,
 			"fb vertb handler", &currentpar)) {
-- 
1.7.0.4

