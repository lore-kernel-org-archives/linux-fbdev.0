From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Sun, 08 Mar 2015 12:43:24 +0000
Subject: [PATCH 2/4] staging: sm750fb: remove pragma optimize
Message-Id: <1425817886-14387-2-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1425817886-14387-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1425817886-14387-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

remove use of #pragma optimize which will usually be ignored by the
compiler.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/staging/sm750fb/ddk750_swi2c.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_swi2c.c b/drivers/staging/sm750fb/ddk750_swi2c.c
index b53407b..cae6b9b 100644
--- a/drivers/staging/sm750fb/ddk750_swi2c.c
+++ b/drivers/staging/sm750fb/ddk750_swi2c.c
@@ -217,8 +217,6 @@ static unsigned char swI2CReadSDA(void)
         return 0;
 }
 
-#pragma optimize( "", off )
-
 /*
  *  This function sends ACK signal
  */
@@ -356,7 +354,6 @@ unsigned char swI2CReadByte(unsigned char ack)
 
     return data;
 }
-#pragma optimize( "", on )
 
 /*
  * This function initializes GPIO port for SW I2C communication.
-- 
1.8.1.2

