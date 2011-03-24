From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Thu, 24 Mar 2011 15:57:41 +0000
Subject: [PATCH 1/3] viafb: add primary/secondary clock on/off switches
Message-Id: <1300983180-7343-2-git-send-email-FlorianSchandinat@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1300983180-7343-1-git-send-email-FlorianSchandinat@gmx.de>
In-Reply-To: <1300983180-7343-1-git-send-email-FlorianSchandinat@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

This patch adds functions to enable/disable the display clocks.
It also fixes a tiny bug that slipped in with a previous commit but
could not yet have caused any problems.

Signed-off-by: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
---
 drivers/video/via/hw.c |   38 +++++++++++++++++++++++++++++++++++++-
 1 files changed, 37 insertions(+), 1 deletions(-)

diff --git a/drivers/video/via/hw.c b/drivers/video/via/hw.c
index b38d3b4..712348d 100644
--- a/drivers/video/via/hw.c
+++ b/drivers/video/via/hw.c
@@ -1409,6 +1409,42 @@ void viafb_load_FIFO_reg(int set_iga, int hor_active, int ver_active)
 
 }
 
+static void set_primary_clock_state(u8 state)
+{
+	u8 value;
+
+	switch (state) {
+	case VIA_STATE_ON:
+		value = 0x20;
+		break;
+	case VIA_STATE_OFF:
+		value = 0x00;
+		break;
+	default:
+		return;
+	}
+
+	via_write_reg_mask(VIASR, 0x1B, value, 0x30);
+}
+
+static void set_secondary_clock_state(u8 state)
+{
+	u8 value;
+
+	switch (state) {
+	case VIA_STATE_ON:
+		value = 0x80;
+		break;
+	case VIA_STATE_OFF:
+		value = 0x00;
+		break;
+	default:
+		return;
+	}
+
+	via_write_reg_mask(VIASR, 0x1B, value, 0xC0);
+}
+
 static void set_primary_pll_state(u8 state)
 {
 	u8 value;
@@ -1442,7 +1478,7 @@ static void set_secondary_pll_state(u8 state)
 		return;
 	}
 
-	via_write_reg_mask(VIASR, 0x2D, value, 0x08);
+	via_write_reg_mask(VIASR, 0x2D, value, 0x0C);
 }
 
 static u32 cle266_encode_pll(struct pll_config pll)
-- 
1.6.3.2

