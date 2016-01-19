From: Charles Rose <charles.rose.linux@gmail.com>
Date: Tue, 19 Jan 2016 23:42:15 +0000
Subject: [PATCH] staging: sm750fb: cleanup: fix brace placement
Message-Id: <1453246935-5037-1-git-send-email-charles.rose.linux@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Fix brace placement warnings caught by checkpatch.pl.

Signed-off-by: Charles Rose <charles.rose.linux@gmail.com>
---
 drivers/staging/sm750fb/sm750_cursor.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_cursor.c b/drivers/staging/sm750fb/sm750_cursor.c
index 3b7ce92..cab891c 100644
--- a/drivers/staging/sm750fb/sm750_cursor.c
+++ b/drivers/staging/sm750fb/sm750_cursor.c
@@ -143,8 +143,7 @@ void hw_cursor_setData(struct lynx_cursor *cursor,
 		iowrite16(data, pbuffer);
 
 		/* assume pitch is 1,2,4,8,...*/
-		if ((i+1) % pitch = 0)
-		{
+		if ((i+1) % pitch = 0) {
 			/* need a return */
 			pstart += offset;
 			pbuffer = pstart;
-- 
2.5.0

