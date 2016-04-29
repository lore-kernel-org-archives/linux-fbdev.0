From: Manav Batra <batmanav10@gmail.com>
Date: Fri, 29 Apr 2016 06:26:52 +0000
Subject: [PATCH] staging: sm750fb: Braces {} on all arms
Message-Id: <20160429062652.GA4718@iiitd.ac.in>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

Signed-off-by: Manav Batra <batmanav10@gmail.com>

Applied braces on all arms of the statement.
---
 drivers/staging/sm750fb/ddk750_chip.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
index f80ee77..7748862 100644
--- a/drivers/staging/sm750fb/ddk750_chip.c
+++ b/drivers/staging/sm750fb/ddk750_chip.c
@@ -19,15 +19,16 @@ logical_chip_type_t getChipType(void)
 	physicalID = devId750; /* either 0x718 or 0x750 */
 	physicalRev = revId750;
 
-	if (physicalID = 0x718)
+	if (physicalID = 0x718) {
 		chip = SM718;
-	else if (physicalID = 0x750) {
+	} else if (physicalID = 0x750) {
 		chip = SM750;
 		/* SM750 and SM750LE are different in their revision ID only. */
 		if (physicalRev = SM750LE_REVISION_ID)
 			chip = SM750LE;
-	} else
+	} else {
 		chip = SM_UNKNOWN;
+	}
 
 	return chip;
 }
-- 
1.9.1

