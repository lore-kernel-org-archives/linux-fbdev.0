From: Amitoj Kaur Chawla <amitoj1606@gmail.com>
Date: Wed, 08 Apr 2015 16:55:14 +0000
Subject: [PATCH] Staging: sm750fb: Remove space after parenthesis
Message-Id: <20150408165506.GA23120@amitoj-Inspiron-3542>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

Fixed error by removing space after open parenthesis '('
Problem found using checkpatch.pl
ERROR: space prohibited after that open parenthesis '('

Signed-off-by: Amitoj Kaur Chawla <amitoj1606@gmail.com>
---
 drivers/staging/sm750fb/ddk750_chip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
index 7b28328..3cb860c 100644
--- a/drivers/staging/sm750fb/ddk750_chip.c
+++ b/drivers/staging/sm750fb/ddk750_chip.c
@@ -285,7 +285,7 @@ int ddk750_initHw(initchip_param_t *pInitParam)
 		ulReg = FIELD_SET(ulReg, VGA_CONFIGURATION, MODE, GRAPHIC);
 		POKE32(VGA_CONFIGURATION, ulReg);
 	} else {
-#if defined(__i386__) || defined( __x86_64__)
+#if defined(__i386__) || defined(__x86_64__)
 		/* set graphic mode via IO method */
 		outb_p(0x88, 0x3d4);
 		outb_p(0x06, 0x3d5);
@@ -382,7 +382,7 @@ int ddk750_initHw(initchip_param_t *pInitParam)
 
 unsigned int absDiff(unsigned int a, unsigned int b)
 {
-	if ( a > b )
+	if (a > b)
 		return(a - b);
 	else
 		return(b - a);
-- 
1.9.1

