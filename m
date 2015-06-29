From: Juston Li <juston.h.li@gmail.com>
Date: Mon, 29 Jun 2015 17:55:25 +0000
Subject: [PATCH v4 08/19] staging: sm750fb: add space after enum definition
Message-Id: <1435600536-13135-8-git-send-email-juston.h.li@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAFow2F-+fT0iRmFd+H_X-1gBmvCsgehxXeyr7A8Zk9TtfD0aBA@mail.gmail.com>
In-Reply-To: <CAFow2F-+fT0iRmFd+H_X-1gBmvCsgehxXeyr7A8Zk9TtfD0aBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, dan.carpenter@oracle.com
Cc: Juston Li <juston.h.li@gmail.com>

Fixes checkpatch.pl warning:
WARNING: missing space after enum definition

Signed-off-by: Juston Li <juston.h.li@gmail.com>
---
 drivers/staging/sm750fb/ddk750_display.h | 2 +-
 drivers/staging/sm750fb/sm750_hw.h       | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_display.h b/drivers/staging/sm750fb/ddk750_display.h
index 018a661..a7f50cc 100644
--- a/drivers/staging/sm750fb/ddk750_display.h
+++ b/drivers/staging/sm750fb/ddk750_display.h
@@ -129,7 +129,7 @@ typedef enum _disp_output_t
 }
 disp_output_t;
 #else
-typedef enum _disp_output_t{
+typedef enum _disp_output_t {
 	do_LCD1_PRI = PNL_2_PRI|PRI_TP_ON|PNL_SEQ_ON|DAC_ON,
 	do_LCD1_SEC = PNL_2_SEC|SEC_TP_ON|PNL_SEQ_ON|DAC_ON,
 #if 0
diff --git a/drivers/staging/sm750fb/sm750_hw.h b/drivers/staging/sm750fb/sm750_hw.h
index adc61edf..af2db7c 100644
--- a/drivers/staging/sm750fb/sm750_hw.h
+++ b/drivers/staging/sm750fb/sm750_hw.h
@@ -9,7 +9,7 @@
 #endif
 
 
-enum sm750_pnltype{
+enum sm750_pnltype {
 
 	sm750_24TFT = 0,/* 24bit tft */
 
@@ -19,7 +19,7 @@ enum sm750_pnltype{
 };
 
 /* vga channel is not concerned  */
-enum sm750_dataflow{
+enum sm750_dataflow {
 	sm750_simul_pri,/* primary => all head */
 
 	sm750_simul_sec,/* secondary => all head */
@@ -30,13 +30,13 @@ enum sm750_dataflow{
 };
 
 
-enum sm750_channel{
+enum sm750_channel {
 	sm750_primary = 0,
 	/* enum value equal to the register filed data */
 	sm750_secondary = 1,
 };
 
-enum sm750_path{
+enum sm750_path {
 	sm750_panel = 1,
 	sm750_crt = 2,
 	sm750_pnc = 3,/* panel and crt */
-- 
2.4.4

