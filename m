From: Matej Dujava <mdujava@kocurkovo.cz>
Date: Wed, 10 May 2017 21:55:59 +0000
Subject: [PATCH 9/9] staging: sm750fb: Remove typedef from "typedef enum _sii164_hot_plug_mode_t"
Message-Id: <1494453359-3722-10-git-send-email-mdujava@kocurkovo.cz>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patch removes typedefs from enum and renames it from "typedef enum
_sii164_hot_plug_mode_t" to "enum sii164_hot_plug_mode" as per kernel
coding standards.

Signed-off-by: Matej Dujava <mdujava@kocurkovo.cz>
---
 drivers/staging/sm750fb/ddk750_sii164.c | 2 +-
 drivers/staging/sm750fb/ddk750_sii164.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_sii164.c b/drivers/staging/sm750fb/ddk750_sii164.c
index 0431833..f7bf84e8 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.c
+++ b/drivers/staging/sm750fb/ddk750_sii164.c
@@ -296,7 +296,7 @@ void sii164SetPower(unsigned char powerUp)
  *  sii164SelectHotPlugDetectionMode
  *      This function selects the mode of the hot plug detection.
  */
-static void sii164SelectHotPlugDetectionMode(sii164_hot_plug_mode_t hotPlugMode)
+static void sii164SelectHotPlugDetectionMode(enum sii164_hot_plug_mode hotPlugMode)
 {
 	unsigned char detectReg;
 
diff --git a/drivers/staging/sm750fb/ddk750_sii164.h b/drivers/staging/sm750fb/ddk750_sii164.h
index 6968cf5..e06ba72 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.h
+++ b/drivers/staging/sm750fb/ddk750_sii164.h
@@ -4,12 +4,12 @@
 #define USE_DVICHIP
 
 /* Hot Plug detection mode structure */
-typedef enum _sii164_hot_plug_mode_t {
+enum sii164_hot_plug_mode {
 	SII164_HOTPLUG_DISABLE = 0,         /* Disable Hot Plug output bit (always high). */
 	SII164_HOTPLUG_USE_MDI,             /* Use Monitor Detect Interrupt bit. */
 	SII164_HOTPLUG_USE_RSEN,            /* Use Receiver Sense detect bit. */
 	SII164_HOTPLUG_USE_HTPLG            /* Use Hot Plug detect bit. */
-} sii164_hot_plug_mode_t;
+};
 
 
 /* Silicon Image SiI164 chip prototype */
-- 
1.8.3.1

