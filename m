From: Juston Li <juston.h.li@gmail.com>
Date: Wed, 15 Jul 2015 04:14:36 +0000
Subject: [PATCH v5 07/19] staging: sm750fb: add space after close brace
Message-Id: <1436933688-5408-7-git-send-email-juston.h.li@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAFow2F9-0W4VRjLHmXZuv2vCwyGYRDatbCOrmg5o-AY0-nb-dw@mail.gmail.com>
In-Reply-To: <CAFow2F9-0W4VRjLHmXZuv2vCwyGYRDatbCOrmg5o-AY0-nb-dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Juston Li <juston.h.li@gmail.com>

Fixes checkpatch.pl error:
ERROR: space required after that close brace '}'

Signed-off-by: Juston Li <juston.h.li@gmail.com>
---
 drivers/staging/sm750fb/ddk750_display.c | 2 +-
 drivers/staging/sm750fb/ddk750_mode.c    | 2 +-
 drivers/staging/sm750fb/ddk750_power.c   | 2 +-
 drivers/staging/sm750fb/sm750.h          | 2 +-
 drivers/staging/sm750fb/sm750_cursor.c   | 8 ++++----
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_display.c b/drivers/staging/sm750fb/ddk750_display.c
index c7171a4..4a3cb86 100644
--- a/drivers/staging/sm750fb/ddk750_display.c
+++ b/drivers/staging/sm750fb/ddk750_display.c
@@ -166,7 +166,7 @@ static void waitNextVerticalSync(int ctrl, int delay)
 			while (status = SYSTEM_CTRL_PANEL_VSYNC_INACTIVE);
 		}
 
-	}else {
+	} else {
 
 		/* Do not wait when the Primary PLL is off or display control is already off.
 			   This will prevent the software to wait forever. */
diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
index efc1fab..3d8b06d 100644
--- a/drivers/staging/sm750fb/ddk750_mode.c
+++ b/drivers/staging/sm750fb/ddk750_mode.c
@@ -109,7 +109,7 @@ static int programModeRegisters(mode_parameter_t *pModeParam, pll_value_t *pll)
 
 		if (getChipType() = SM750LE) {
 			displayControlAdjust_SM750LE(pModeParam, ulTmpValue);
-		}else {
+		} else {
 			ulReg = PEEK32(CRT_DISPLAY_CTRL)
 					& FIELD_CLEAR(CRT_DISPLAY_CTRL, VSYNC_PHASE)
 					& FIELD_CLEAR(CRT_DISPLAY_CTRL, HSYNC_PHASE)
diff --git a/drivers/staging/sm750fb/ddk750_power.c b/drivers/staging/sm750fb/ddk750_power.c
index e2c0bb3..5f697b8 100644
--- a/drivers/staging/sm750fb/ddk750_power.c
+++ b/drivers/staging/sm750fb/ddk750_power.c
@@ -8,7 +8,7 @@ void ddk750_setDPMS(DPMS_t state)
 	if (getChipType() = SM750LE) {
 		value = PEEK32(CRT_DISPLAY_CTRL);
 		POKE32(CRT_DISPLAY_CTRL, FIELD_VALUE(value, CRT_DISPLAY_CTRL, DPMS, state));
-	}else {
+	} else {
 		value = PEEK32(SYSTEM_CTRL);
 		value= FIELD_VALUE(value, SYSTEM_CTRL, DPMS, state);
 		POKE32(SYSTEM_CTRL, value);
diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index 71e9a7a..8ac5410 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -53,7 +53,7 @@ struct lynx_share{
 		int mtrr_off;
 		struct{
 			int vram;
-		}mtrr;
+		} mtrr;
 	/* all smi graphic adaptor got below attributes */
 	unsigned long vidmem_start;
 	unsigned long vidreg_start;
diff --git a/drivers/staging/sm750fb/sm750_cursor.c b/drivers/staging/sm750fb/sm750_cursor.c
index 3a21af9..2fcec32 100644
--- a/drivers/staging/sm750fb/sm750_cursor.c
+++ b/drivers/staging/sm750fb/sm750_cursor.c
@@ -143,7 +143,7 @@ void hw_cursor_setData(struct lynx_cursor *cursor,
 			if (opr & (0x80 >> j))
 			{	/* use fg color,id = 2 */
 				data |= 2 << (j*2);
-			}else {
+			} else {
 				/* use bg color,id = 1 */
 				data |= 1 << (j*2);
 			}
@@ -173,7 +173,7 @@ void hw_cursor_setData(struct lynx_cursor *cursor,
 			/* need a return */
 			pstart += offset;
 			pbuffer = pstart;
-		}else {
+		} else {
 			pbuffer += sizeof(u16);
 		}
 
@@ -223,7 +223,7 @@ void hw_cursor_setData2(struct lynx_cursor *cursor,
 			if (opr & (0x80 >> j))
 			{	/* use fg color,id = 2 */
 				data |= 2 << (j*2);
-			}else {
+			} else {
 				/* use bg color,id = 1 */
 				data |= 1 << (j*2);
 			}
@@ -242,7 +242,7 @@ void hw_cursor_setData2(struct lynx_cursor *cursor,
 			/* need a return */
 			pstart += offset;
 			pbuffer = pstart;
-		}else {
+		} else {
 			pbuffer += sizeof(u16);
 		}
 
-- 
2.4.5

