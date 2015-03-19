From: Amitoj Kaur Chawla <amitoj1606@gmail.com>
Date: Thu, 19 Mar 2015 18:17:56 +0000
Subject: [PATCH] sm750fb: Fix Comment and if else braces
Message-Id: <20150319180556.GA12241@amitoj-Inspiron-3542>
List-Id: <linux-fbdev.vger.kernel.org>
References: <550B11C0.1030300@gmail.com>
In-Reply-To: <550B11C0.1030300@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

The edits have been made to add a space before the comment and the errors in
braces in the if-else statements.
Previously in commit 2d34f53f1065878cd881ac61a183f8e836583d51, removed
the C99 comments and errors in if-else indentation and braces.
 
Signed-off-by: Amitoj Kaur Chawla <amitoj1606@gmail.com>
---
 drivers/staging/sm750fb/ddk750_chip.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
index 33fa456..bdf6a73 100644
--- a/drivers/staging/sm750fb/ddk750_chip.c
+++ b/drivers/staging/sm750fb/ddk750_chip.c
@@ -17,20 +17,17 @@ logical_chip_type_t getChipType(void)
 	char physicalRev;
 	logical_chip_type_t chip;
 
-	physicalID = devId750;/* either 0x718 or 0x750 */
+	physicalID = devId750; /* either 0x718 or 0x750 */
 	physicalRev = revId750;
 
 	if (physicalID = 0x718) {
 		chip = SM718;
-	}
-	else if (physicalID = 0x750) {
+	} else if (physicalID = 0x750) {
 		chip = SM750;
 		/* SM750 and SM750LE are different in their revision ID only. */
-		if (physicalRev = SM750LE_REVISION_ID) {
+		if (physicalRev = SM750LE_REVISION_ID)
 			chip = SM750LE;
-		}
-	}
-	else {
+	} else {
 		chip = SM_UNKNOWN;
 	}
 
-- 
1.9.1

