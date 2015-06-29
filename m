From: Juston Li <juston.h.li@gmail.com>
Date: Mon, 29 Jun 2015 17:55:30 +0000
Subject: [PATCH v4 13/19] staging: sm750fb: add space after semicolon
Message-Id: <1435600536-13135-13-git-send-email-juston.h.li@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAFow2F-+fT0iRmFd+H_X-1gBmvCsgehxXeyr7A8Zk9TtfD0aBA@mail.gmail.com>
In-Reply-To: <CAFow2F-+fT0iRmFd+H_X-1gBmvCsgehxXeyr7A8Zk9TtfD0aBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, dan.carpenter@oracle.com
Cc: Juston Li <juston.h.li@gmail.com>

Fixes checkpatch.pl error:
ERROR: space required after that ';'

Signed-off-by: Juston Li <juston.h.li@gmail.com>
---
 drivers/staging/sm750fb/sm750.h        |  2 +-
 drivers/staging/sm750fb/sm750_cursor.c | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index d6916fd..9b101a9 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -168,7 +168,7 @@ struct lynxfb_par {
 			({ \
 			unsigned long long hz = 1000*1000*1000*1000ULL;	\
 			do_div(hz, ps);	\
-			(unsigned long)hz;})
+			(unsigned long)hz; })
 
 static inline unsigned long ps_to_hz(unsigned int psvalue)
 {
diff --git a/drivers/staging/sm750fb/sm750_cursor.c b/drivers/staging/sm750fb/sm750_cursor.c
index 9dabac1..4ed7ca2 100644
--- a/drivers/staging/sm750fb/sm750_cursor.c
+++ b/drivers/staging/sm750fb/sm750_cursor.c
@@ -122,7 +122,7 @@ void hw_cursor_setData(struct lynx_cursor *cursor,
 		odd=0;
 */
 
-	for (i = 0;i < count;i++)
+	for (i = 0; i < count; i++)
 	{
 		color = *pcol++;
 		mask = *pmsk++;
@@ -137,7 +137,7 @@ void hw_cursor_setData(struct lynx_cursor *cursor,
 		else
 			opr = mask & color;
 
-		for (j = 0;j < 8;j++)
+		for (j = 0; j < 8; j++)
 		{
 
 			if (opr & (0x80 >> j))
@@ -149,7 +149,7 @@ void hw_cursor_setData(struct lynx_cursor *cursor,
 			}
 		}
 #else
-		for (j = 0;j < 8;j++) {
+		for (j = 0; j < 8; j++) {
 			if (mask & (0x80>>j)) {
 				if (rop = ROP_XOR)
 					opr = mask ^ color;
@@ -204,7 +204,7 @@ void hw_cursor_setData2(struct lynx_cursor *cursor,
 	pstart = cursor->vstart;
 	pbuffer = pstart;
 
-	for (i = 0;i < count;i++)
+	for (i = 0; i < count; i++)
 	{
 		color = *pcol++;
 		mask = *pmsk++;
@@ -217,7 +217,7 @@ void hw_cursor_setData2(struct lynx_cursor *cursor,
 		else
 			opr = mask & color;
 
-		for (j = 0;j < 8;j++)
+		for (j = 0; j < 8; j++)
 		{
 
 			if (opr & (0x80 >> j))
@@ -229,7 +229,7 @@ void hw_cursor_setData2(struct lynx_cursor *cursor,
 			}
 		}
 #else
-		for (j = 0;j < 8;j++) {
+		for (j = 0; j < 8; j++) {
 			if (mask & (1<<j))
 				data |= ((color & (1<<j))?1:2)<<(j*2);
 		}
-- 
2.4.4

