From: Ragavendra BN <ragavendra.bn@gmail.com>
Date: Fri, 13 Mar 2015 03:43:33 +0000
Subject: [PATCH] staging: sm750fb: braces, indents, spaces fix
Message-Id: <20150313034333.GA10618@localhost.localdomain>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

Signed-off-by: Ragavendra BN <ragavendra.bn@gmail.com>

This patch removes the braces for the single line if statement. It fixes
the indent positions correctly. It fixes the spaces appropriately making the code give no
warnings by the checkpath.pl script check.

---
 drivers/staging/sm750fb/ddk750_chip.c |   22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
index b71169e..041a05a 100644
--- a/drivers/staging/sm750fb/ddk750_chip.c
+++ b/drivers/staging/sm750fb/ddk750_chip.c
@@ -20,22 +20,16 @@ logical_chip_type_t getChipType()
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

