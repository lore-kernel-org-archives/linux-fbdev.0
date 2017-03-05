From: Arushi Singhal <arushisinghal19971997@gmail.com>
Date: Sun, 05 Mar 2017 11:36:48 +0000
Subject: [PATCH 1/3] staging: sm750fb: fixes add blank line after function/struct/union/enum declarations
Message-Id: <20170305112450.9066-2-arushisinghal19971997@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170305112450.9066-1-arushisinghal19971997@gmail.com>
In-Reply-To: <20170305112450.9066-1-arushisinghal19971997@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com
Cc: teddy.wang@siliconmotion.com, outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, Arushi Singhal <arushisinghal19971997@gmail.com>

This patch fixes the warnings reported by checkpatch.pl
for please use a blank line after function/struct/union/enum
declarations.

Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
---
 drivers/staging/sm750fb/ddk750_display.h | 1 +
 drivers/staging/sm750fb/ddk750_mode.h    | 2 ++
 drivers/staging/sm750fb/ddk750_power.h   | 1 +
 drivers/staging/sm750fb/sm750_cursor.c   | 3 +++
 4 files changed, 7 insertions(+)

diff --git a/drivers/staging/sm750fb/ddk750_display.h b/drivers/staging/sm750fb/ddk750_display.h
index e2a3f84ca4c5..8bf22e4f0d8b 100644
--- a/drivers/staging/sm750fb/ddk750_display.h
+++ b/drivers/staging/sm750fb/ddk750_display.h
@@ -100,6 +100,7 @@ typedef enum _disp_output_t {
 	do_CRT_PRI = CRT_2_PRI | PRI_TP_ON | DPMS_ON | DAC_ON,
 	do_CRT_SEC = CRT_2_SEC | SEC_TP_ON | DPMS_ON | DAC_ON,
 }
+
 disp_output_t;
 
 void ddk750_setLogicalDispOut(disp_output_t);
diff --git a/drivers/staging/sm750fb/ddk750_mode.h b/drivers/staging/sm750fb/ddk750_mode.h
index 2183e664cf4b..b4cd90a5d2bc 100644
--- a/drivers/staging/sm750fb/ddk750_mode.h
+++ b/drivers/staging/sm750fb/ddk750_mode.h
@@ -7,6 +7,7 @@ typedef enum _spolarity_t {
 	POS = 0, /* positive */
 	NEG, /* negative */
 }
+
 spolarity_t;
 
 typedef struct _mode_parameter_t {
@@ -32,6 +33,7 @@ typedef struct _mode_parameter_t {
 	/* Clock Phase. This clock phase only applies to Panel. */
 	spolarity_t clock_phase_polarity;
 }
+
 mode_parameter_t;
 
 int ddk750_setModeTiming(mode_parameter_t *, clock_type_t);
diff --git a/drivers/staging/sm750fb/ddk750_power.h b/drivers/staging/sm750fb/ddk750_power.h
index ec0b99d6a7ad..1f22a67493af 100644
--- a/drivers/staging/sm750fb/ddk750_power.h
+++ b/drivers/staging/sm750fb/ddk750_power.h
@@ -7,6 +7,7 @@ typedef enum _DPMS_t {
 	crtDPMS_SUSPEND = 0x2,
 	crtDPMS_OFF = 0x3,
 }
+
 DPMS_t;
 
 #define setDAC(off) {							\
diff --git a/drivers/staging/sm750fb/sm750_cursor.c b/drivers/staging/sm750fb/sm750_cursor.c
index aa232c31b312..1e29a0f0a53d 100644
--- a/drivers/staging/sm750fb/sm750_cursor.c
+++ b/drivers/staging/sm750fb/sm750_cursor.c
@@ -54,6 +54,7 @@ void sm750_hw_cursor_enable(struct lynx_cursor *cursor)
 	reg = (cursor->offset & HWC_ADDRESS_ADDRESS_MASK) | HWC_ADDRESS_ENABLE;
 	poke32(HWC_ADDRESS, reg);
 }
+
 void sm750_hw_cursor_disable(struct lynx_cursor *cursor)
 {
 	poke32(HWC_ADDRESS, 0);
@@ -65,6 +66,7 @@ void sm750_hw_cursor_setSize(struct lynx_cursor *cursor,
 	cursor->w = w;
 	cursor->h = h;
 }
+
 void sm750_hw_cursor_setPos(struct lynx_cursor *cursor,
 						int x, int y)
 {
@@ -74,6 +76,7 @@ void sm750_hw_cursor_setPos(struct lynx_cursor *cursor,
 		(x & HWC_LOCATION_X_MASK));
 	poke32(HWC_LOCATION, reg);
 }
+
 void sm750_hw_cursor_setColor(struct lynx_cursor *cursor,
 						u32 fg, u32 bg)
 {
-- 
2.11.0

