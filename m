From: Juston Li <juston.h.li@gmail.com>
Date: Sat, 20 Jun 2015 18:36:39 +0000
Subject: [PATCH 05/19] staging: sm750fb: remove space between function name and parenthesis
Message-Id: <1434825413-4994-5-git-send-email-juston.h.li@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAFow2F-rzu4Jywjo3JngEYDYMtuSRzS3pUFhwb5XLTWjRjmTJw@mail.gmail.com>
In-Reply-To: <CAFow2F-rzu4Jywjo3JngEYDYMtuSRzS3pUFhwb5XLTWjRjmTJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Juston Li <juston.h.li@gmail.com>

fixes checkpatch.pl warning:
WARNING: space prohibited between function name and open parenthesis '('

Signed-off-by: Juston Li <juston.h.li@gmail.com>
---
 drivers/staging/sm750fb/sm750_accel.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index 3c61103..bb96ea5 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -278,11 +278,11 @@ unsigned int rop2)   /* ROP value */
 	{
 
 	write_dpr(accel, DE_SOURCE,
-		  FIELD_SET  (0, DE_SOURCE, WRAP, DISABLE) |
+		  FIELD_SET(0, DE_SOURCE, WRAP, DISABLE) |
 		  FIELD_VALUE(0, DE_SOURCE, X_K1, sx)   |
 		  FIELD_VALUE(0, DE_SOURCE, Y_K2, sy)); /* dpr0 */
 	write_dpr(accel, DE_DESTINATION,
-		  FIELD_SET  (0, DE_DESTINATION, WRAP, DISABLE) |
+		  FIELD_SET(0, DE_DESTINATION, WRAP, DISABLE) |
 		  FIELD_VALUE(0, DE_DESTINATION, X,    dx)  |
 		  FIELD_VALUE(0, DE_DESTINATION, Y,    dy)); /* dpr04 */
 	write_dpr(accel, DE_DIMENSION,
@@ -390,11 +390,11 @@ int hw_imageblit(struct lynx_accel *accel,
 	 /* Note: For 2D Source in Host Write, only X_K1_MONO field is needed, and Y_K2 field is not used.
 	    For mono bitmap, use startBit for X_K1. */
 	write_dpr(accel, DE_SOURCE,
-		  FIELD_SET  (0, DE_SOURCE, WRAP, DISABLE)       |
+		  FIELD_SET(0, DE_SOURCE, WRAP, DISABLE)       |
 		  FIELD_VALUE(0, DE_SOURCE, X_K1_MONO, startBit)); /* dpr00 */
 
 	write_dpr(accel, DE_DESTINATION,
-		  FIELD_SET  (0, DE_DESTINATION, WRAP, DISABLE) |
+		  FIELD_SET(0, DE_DESTINATION, WRAP, DISABLE) |
 		  FIELD_VALUE(0, DE_DESTINATION, X,    dx)    |
 		  FIELD_VALUE(0, DE_DESTINATION, Y,    dy)); /* dpr04 */
 
-- 
2.4.4

--
To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
