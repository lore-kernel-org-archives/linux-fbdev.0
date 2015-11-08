From: Othmar Pasteka <pasteka@kabsi.at>
Date: Sun, 08 Nov 2015 00:43:31 +0000
Subject: [PATCH 2/2] staging: sm750fb: add spaces around operator
Message-Id: <dff05f0aaa83ddedafd5f061548dc2ba75486fd3.1446942955.git.pasteka@kabsi.at>
List-Id: <linux-fbdev.vger.kernel.org>
References: <e426148688caace0a5083b379c1eaab85e424c74.1446942955.git.pasteka@kabsi.at>
In-Reply-To: <e426148688caace0a5083b379c1eaab85e424c74.1446942955.git.pasteka@kabsi.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, sudip@vectorindia.org, greg@kroah.com
Cc: devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Othmar Pasteka <pasteka@kabsi.at>

checkpatch.pl says: CHECK: spaces preferred around that '+' (ctx:VxV)

Signed-off-by: Othmar Pasteka <pasteka@kabsi.at>
---
 drivers/staging/sm750fb/sm750_cursor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/sm750_cursor.c b/drivers/staging/sm750fb/sm750_cursor.c
index cab891c..0a41585 100644
--- a/drivers/staging/sm750fb/sm750_cursor.c
+++ b/drivers/staging/sm750fb/sm750_cursor.c
@@ -143,7 +143,7 @@ void hw_cursor_setData(struct lynx_cursor *cursor,
 		iowrite16(data, pbuffer);
 
 		/* assume pitch is 1,2,4,8,...*/
-		if ((i+1) % pitch = 0) {
+		if ((i + 1) % pitch = 0) {
 			/* need a return */
 			pstart += offset;
 			pbuffer = pstart;
-- 
2.5.3

