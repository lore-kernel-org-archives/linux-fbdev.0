From: Othmar Pasteka <pasteka@kabsi.at>
Date: Sun, 08 Nov 2015 10:58:51 +0000
Subject: [PATCH] staging: sm750fb: fix style for if clause
Message-Id: <1446980331-4254-1-git-send-email-pasteka@kabsi.at>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, sudip@vectorindia.org, greg@kroah.com
Cc: devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Othmar Pasteka <pasteka@kabsi.at>

Fix for checkpatch.pl complaints:
ERROR: that open brace { should be on the previous line
CHECK: spaces preferred around that '+' (ctx:VxV)

Signed-off-by: Othmar Pasteka <pasteka@kabsi.at>
---
 drivers/staging/sm750fb/sm750_cursor.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_cursor.c b/drivers/staging/sm750fb/sm750_cursor.c
index 3b7ce92..0a41585 100644
--- a/drivers/staging/sm750fb/sm750_cursor.c
+++ b/drivers/staging/sm750fb/sm750_cursor.c
@@ -143,8 +143,7 @@ void hw_cursor_setData(struct lynx_cursor *cursor,
 		iowrite16(data, pbuffer);
 
 		/* assume pitch is 1,2,4,8,...*/
-		if ((i+1) % pitch = 0)
-		{
+		if ((i + 1) % pitch = 0) {
 			/* need a return */
 			pstart += offset;
 			pbuffer = pstart;
-- 
2.5.3

