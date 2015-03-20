From: Amitoj Kaur Chawla <amitoj1606@gmail.com>
Date: Fri, 20 Mar 2015 14:36:56 +0000
Subject: [PATCH] sm750fb: Fix C99 comment and if-else braces
Message-Id: <20150320142455.GA17954@amitoj-Inspiron-3542>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

The edits have been made to fix C99 Comment and properly indent
the if-else statements with the braces.

Also, to use tabs instead of spaces.

Signed-off-by: Amitoj Kaur Chawla <amitoj1606@gmail.com>
---
 drivers/staging/sm750fb/ddk750_chip.c | 35 ++++++++++++++---------------------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
index 33add64..1e6b474 100644
--- a/drivers/staging/sm750fb/ddk750_chip.c
+++ b/drivers/staging/sm750fb/ddk750_chip.c
@@ -17,38 +17,31 @@ logical_chip_type_t getChipType(void)
 	char physicalRev;
 	logical_chip_type_t chip;
 
-	physicalID = devId750;//either 0x718 or 0x750
+	physicalID = devId750; /* either 0x718 or 0x750 */
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
 
-
 inline unsigned int twoToPowerOfx(unsigned long x)
 {
-    unsigned long i;
-    unsigned long result = 1;
+	unsigned long i;
+	unsigned long result = 1;
 
-    for (i=1; i<=x; i++)
-        result *= 2;
-    return result;
+	for (i = 1; i <= x; i++)
+		result *= 2;
+	return result;
 }
 
 inline unsigned int calcPLL(pll_value_t *pPLL)
-- 
1.9.1

