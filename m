From: Matej Dujava <mdujava@kocurkovo.cz>
Date: Wed, 10 May 2017 21:55:58 +0000
Subject: [PATCH 8/9] staging: sm750fb: Remove typedef from "typedef enum _DPMS_t"
Message-Id: <1494453359-3722-9-git-send-email-mdujava@kocurkovo.cz>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patch removes typedefs from enum and renames it from
"typedef enum _DPMS_t" to "enum DPMS" as per kernel coding standards.

Signed-off-by: Matej Dujava <mdujava@kocurkovo.cz>
---
 drivers/staging/sm750fb/ddk750_power.c | 2 +-
 drivers/staging/sm750fb/ddk750_power.h | 7 +++----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_power.c b/drivers/staging/sm750fb/ddk750_power.c
index 222ae1a..bc91e73 100644
--- a/drivers/staging/sm750fb/ddk750_power.c
+++ b/drivers/staging/sm750fb/ddk750_power.c
@@ -2,7 +2,7 @@
 #include "ddk750_reg.h"
 #include "ddk750_power.h"
 
-void ddk750_set_dpms(DPMS_t state)
+void ddk750_set_dpms(enum DPMS state)
 {
 	unsigned int value;
 
diff --git a/drivers/staging/sm750fb/ddk750_power.h b/drivers/staging/sm750fb/ddk750_power.h
index 44c4fc5..6764e53 100644
--- a/drivers/staging/sm750fb/ddk750_power.h
+++ b/drivers/staging/sm750fb/ddk750_power.h
@@ -1,20 +1,19 @@
 #ifndef DDK750_POWER_H__
 #define DDK750_POWER_H__
 
-typedef enum _DPMS_t {
+enum DPMS {
 	crtDPMS_ON = 0x0,
 	crtDPMS_STANDBY = 0x1,
 	crtDPMS_SUSPEND = 0x2,
 	crtDPMS_OFF = 0x3,
-}
-DPMS_t;
+};
 
 #define setDAC(off) {							\
 	poke32(MISC_CTRL,						\
 	       (peek32(MISC_CTRL) & ~MISC_CTRL_DAC_POWER_OFF) | (off)); \
 }
 
-void ddk750_set_dpms(DPMS_t state);
+void ddk750_set_dpms(enum DPMS state);
 void sm750_set_power_mode(unsigned int powerMode);
 void sm750_set_current_gate(unsigned int gate);
 
-- 
1.8.3.1

