From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Wed, 11 Aug 2010 23:49:30 +0000
Subject: [PATCH 01/11] viafb: reset correct PLL
Message-Id: <1281570580-8253-2-git-send-email-FlorianSchandinat@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1281570580-8253-1-git-send-email-FlorianSchandinat@gmx.de>
In-Reply-To: <1281570580-8253-1-git-send-email-FlorianSchandinat@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Joseph Chan <JosephChan@via.com.tw>

viafb: reset correct PLL

Looks like we did reset the PLL of the (whatever) engine instead of
the PLL of the secondary display (IGA2, LCDCK). This patch fixes it.

Signed-off-by: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: Joseph Chan <JosephChan@via.com.tw>
---
 drivers/video/via/hw.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/via/hw.c b/drivers/video/via/hw.c
index 7dcb4d5..53b0651 100644
--- a/drivers/video/via/hw.c
+++ b/drivers/video/via/hw.c
@@ -1688,8 +1688,8 @@ void viafb_set_vclock(u32 clk, int set_iga)
 	}
 
 	if (set_iga = IGA2) {
-		viafb_write_reg_mask(SR40, VIASR, 0x01, BIT0);
-		viafb_write_reg_mask(SR40, VIASR, 0x00, BIT0);
+		viafb_write_reg_mask(SR40, VIASR, 0x04, BIT2);
+		viafb_write_reg_mask(SR40, VIASR, 0x00, BIT2);
 	}
 
 	/* Fire! */
-- 
1.6.3.2

