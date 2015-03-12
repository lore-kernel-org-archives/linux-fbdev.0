From: Ragavendra BN <ragavendra.bn@gmail.com>
Date: Thu, 12 Mar 2015 10:33:19 +0000
Subject: [PATCH] staging: sm750fb: if else block checkpath warnings
Message-Id: <20150312103319.GA19906@localhost.localdomain>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

Signed-off-by: Ragavendra BN <ragavendra.bn@gmail.com>

This patch fixes the coding style warnings found by checkpath.pl for
the if else block

---
 drivers/staging/sm750fb/ddk750_chip.c |   25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
index 2c12dd0..041a05a 100644
--- a/drivers/staging/sm750fb/ddk750_chip.c
+++ b/drivers/staging/sm750fb/ddk750_chip.c
@@ -11,7 +11,8 @@ typedef struct _pllcalparam{
 pllcalparam;
 
 
-logical_chip_type_t getChipType(){
+logical_chip_type_t getChipType()
+{
 	unsigned short physicalID;
 	char physicalRev;
 	logical_chip_type_t chip;
@@ -19,22 +20,16 @@ logical_chip_type_t getChipType(){
 	physicalID = devId750;//either 0x718 or 0x750
 	physicalRev = revId750;
 
-    if (physicalID = 0x718)
-    {
-        chip = SM718;
-    }
-    else if (physicalID = 0x750)
-    {
-        chip = SM750;
+	if (physicalID = 0x718) {
+		chip = SM718;
+	} else if (physicalID = 0x750) {
+		chip = SM750;
 		/* SM750 and SM750LE are different in their revision ID only. */
-		if (physicalRev = SM750LE_REVISION_ID){
+		if (physicalRev = SM750LE_REVISION_ID)
 			chip = SM750LE;
-		}
-    }
-    else
-    {
-        chip = SM_UNKNOWN;
-    }
+	} else {
+		chip = SM_UNKNOWN;
+	}
 
 	return chip;
 }
-- 
1.7.10.4

