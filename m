From: Jules Irenge <jbi.octave@gmail.com>
Date: Sat, 16 Mar 2019 00:01:09 +0000
Subject: [PATCH] staging: sm759fb: fix camelcase check issue
Message-Id: <20190316000109.22244-1-jbi.octave@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Lower case of parameters to fix camelcase warning
 Issue reported by checkpatch.pl tool

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 drivers/staging/sm750fb/ddk750_chip.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
index 4c1f00f551da..6bdf643707c2 100644
--- a/drivers/staging/sm750fb/ddk750_chip.c
+++ b/drivers/staging/sm750fb/ddk750_chip.c
@@ -15,14 +15,14 @@ enum logical_chip_type sm750_get_chip_type(void)
 	return chip;
 }
 
-void sm750_set_chip_type(unsigned short devId, u8 revId)
+void sm750_set_chip_type(unsigned short dev_id, u8 rev_id)
 {
-	if (devId = 0x718) {
+	if (dev_id = 0x718) {
 		chip = SM718;
-	} else if (devId = 0x750) {
+	} else if (dev_id = 0x750) {
 		chip = SM750;
 		/* SM750 and SM750LE are different in their revision ID only. */
-		if (revId = SM750LE_REVISION_ID) {
+		if (rev_id = SM750LE_REVISION_ID) {
 			chip = SM750LE;
 			pr_info("found sm750le\n");
 		}
-- 
2.20.1
