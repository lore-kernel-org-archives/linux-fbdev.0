From: Scott Matheina <scott@matheina.com>
Date: Tue, 10 Jan 2017 02:23:26 +0000
Subject: [PATCH 1/2]  staging:sm750fb:ddk750_chip.c Adds braces to last arm of statement
Message-Id: <1484015010-6058-1-git-send-email-scott@matheina.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org

Fixes absence of braces on last arm of statement, identified by
checkpatch

Signed-off-by: Scott Matheina <scott@matheina.com>
---
 drivers/staging/sm750fb/ddk750_chip.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
index f59ce5c..ec33f1f 100644
--- a/drivers/staging/sm750fb/ddk750_chip.c
+++ b/drivers/staging/sm750fb/ddk750_chip.c
@@ -25,8 +25,9 @@ void sm750_set_chip_type(unsigned short devId, u8 revId)
 			chip = SM750LE;
 			pr_info("found sm750le\n");
 		}
-	} else
+	} else {
 		chip = SM_UNKNOWN;
+	}
 }
 
 static unsigned int get_mxclk_freq(void)
-- 
2.7.4

