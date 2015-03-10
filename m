From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Tue, 10 Mar 2015 17:28:53 +0000
Subject: [PATCH 2/6] staging: sm750fb: remove unused variables
Message-Id: <1426007817-1884-3-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426007817-1884-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1426007817-1884-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

removed some variables which were only declared but were never used.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/staging/sm750fb/sm750_cursor.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_cursor.c b/drivers/staging/sm750fb/sm750_cursor.c
index 480615c..76b6029 100644
--- a/drivers/staging/sm750fb/sm750_cursor.c
+++ b/drivers/staging/sm750fb/sm750_cursor.c
@@ -99,7 +99,6 @@ void hw_cursor_setData(struct lynx_cursor * cursor,
 	u8 color,mask,opr;
 	u16 data;
 	u16 * pbuffer,*pstart;
-	static ulong odd = 0;
 
 	/*  in byte*/
 	pitch = cursor->w >> 3;
@@ -188,7 +187,7 @@ void hw_cursor_setData2(struct lynx_cursor * cursor,
 			u16 rop,const u8* pcol,const u8* pmsk)
 {
 	int i,j,count,pitch,offset;
-	u8 color,mask,opr;
+	u8 color, mask;
 	u16 data;
 	u16 * pbuffer,*pstart;
 
-- 
1.8.1.2

