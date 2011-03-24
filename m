From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Thu, 24 Mar 2011 15:57:45 +0000
Subject: [PATCH 3/3] viafb: add VIA slapping capability
Message-Id: <1300983180-7343-4-git-send-email-FlorianSchandinat@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1300983180-7343-1-git-send-email-FlorianSchandinat@gmx.de>
In-Reply-To: <1300983180-7343-1-git-send-email-FlorianSchandinat@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

This patch introduces dummy functions to execute when we don't know
what we should do (due to missing documentation). They do nothing
but print a nice message in the log explaining the situation.
To trigger this message initial power management support is
activated which might save a bit energy by disabling PLL and clock
if no device is configured to use them.

Note: The message is only shown for the oldest IGPs CLE266 and K400
      as for the other platforms there are reasonable assumptions
      how it does (hopefully) work.

Signed-off-by: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
---
 drivers/video/via/hw.c        |   19 +++++++++++++++++++
 drivers/video/via/via_clock.c |   30 ++++++++++++++++++++++++------
 2 files changed, 43 insertions(+), 6 deletions(-)

diff --git a/drivers/video/via/hw.c b/drivers/video/via/hw.c
index f1eff0b..df84251 100644
--- a/drivers/video/via/hw.c
+++ b/drivers/video/via/hw.c
@@ -2289,6 +2289,25 @@ int viafb_setmode(struct VideoModeTable *vmode_tbl, int video_bpp,
 			get_sync(viafbinfo1));
 	}
 
+	clock.set_primary_clock_source(VIA_CLKSRC_X1, true);
+	clock.set_secondary_clock_source(VIA_CLKSRC_X1, true);
+
+	if (viaparinfo->shared->iga1_devices) {
+		clock.set_primary_pll_state(VIA_STATE_ON);
+		clock.set_primary_clock_state(VIA_STATE_ON);
+	} else {
+		clock.set_primary_pll_state(VIA_STATE_OFF);
+		clock.set_primary_clock_state(VIA_STATE_OFF);
+	}
+
+	if (viaparinfo->shared->iga2_devices) {
+		clock.set_secondary_pll_state(VIA_STATE_ON);
+		clock.set_secondary_clock_state(VIA_STATE_ON);
+	} else {
+		clock.set_secondary_pll_state(VIA_STATE_OFF);
+		clock.set_secondary_clock_state(VIA_STATE_OFF);
+	}
+
 	via_set_state(devices, VIA_STATE_ON);
 	device_screen_on();
 	return 1;
diff --git a/drivers/video/via/via_clock.c b/drivers/video/via/via_clock.c
index 29afe4c..a1f9039 100644
--- a/drivers/video/via/via_clock.c
+++ b/drivers/video/via/via_clock.c
@@ -29,6 +29,9 @@
 #include "global.h"
 #include "debug.h"
 
+const char *via_slap = "Please slap VIA Technologies to motivate them "
+	"releasing full documentation for your platform!\n";
+
 static inline u32 cle266_encode_pll(struct via_pll_config pll)
 {
 	return (pll.multiplier << 8)
@@ -229,19 +232,34 @@ static void set_secondary_clock_source(enum via_clksrc source, bool use_pll)
 	via_write_reg_mask(VIACR, 0x6C, data, 0x0F);
 }
 
+static void dummy_set_clock_state(u8 state)
+{
+	printk(KERN_INFO "Using undocumented set clock state.\n%s", via_slap);
+}
+
+static void dummy_set_clock_source(enum via_clksrc source, bool use_pll)
+{
+	printk(KERN_INFO "Using undocumented set slock soure.\n%s", via_slap);
+}
+
+static void dummy_set_pll_state(u8 state)
+{
+	printk(KERN_INFO "Using undocumented set PLL state.\n%s", via_slap);
+}
+
 void via_clock_init(struct via_clock *clock, int gfx_chip)
 {
 	switch (gfx_chip) {
 	case UNICHROME_CLE266:
 	case UNICHROME_K400:
-		clock->set_primary_clock_state = NULL;
-		clock->set_primary_clock_source = NULL;
-		clock->set_primary_pll_state = NULL;
+		clock->set_primary_clock_state = dummy_set_clock_state;
+		clock->set_primary_clock_source = dummy_set_clock_source;
+		clock->set_primary_pll_state = dummy_set_pll_state;
 		clock->set_primary_pll = cle266_set_primary_pll;
 
-		clock->set_secondary_clock_state = NULL;
-		clock->set_secondary_clock_source = NULL;
-		clock->set_secondary_pll_state = NULL;
+		clock->set_secondary_clock_state = dummy_set_clock_state;
+		clock->set_secondary_clock_source = dummy_set_clock_source;
+		clock->set_secondary_pll_state = dummy_set_pll_state;
 		clock->set_secondary_pll = cle266_set_secondary_pll;
 		break;
 	case UNICHROME_K800:
-- 
1.6.3.2

