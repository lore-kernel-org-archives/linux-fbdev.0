From: Lorenzo Stoakes <lstoakes@gmail.com>
Date: Fri, 20 Mar 2015 15:22:12 +0000
Subject: [PATCH RESEND 2 2/5] staging: sm750fb: Make internal functions static
Message-Id: <1426864935-29350-2-git-send-email-lstoakes@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426864935-29350-1-git-send-email-lstoakes@gmail.com>
In-Reply-To: <1426864935-29350-1-git-send-email-lstoakes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, Lorenzo Stoakes <lstoakes@gmail.com>

This patch declares externally unavailable functions static. This fixes
the following sparse warnings:-

drivers/staging/sm750fb/ddk750_hwi2c.c:63:6: warning: symbol 'hwI2CWaitTXDone' was not declared. Should it be static?
drivers/staging/sm750fb/ddk750_hwi2c.c:93:14: warning: symbol 'hwI2CWriteData' was not declared. Should it be static?
drivers/staging/sm750fb/ddk750_hwi2c.c:160:14: warning: symbol 'hwI2CReadData' was not declared. Should it be static?

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 drivers/staging/sm750fb/ddk750_hwi2c.c |  6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_hwi2c.c b/drivers/staging/sm750fb/ddk750_hwi2c.c
index 84dfb6f..7826376 100644
--- a/drivers/staging/sm750fb/ddk750_hwi2c.c
+++ b/drivers/staging/sm750fb/ddk750_hwi2c.c
@@ -60,7 +60,7 @@ void hwI2CClose(void)
 }


-long hwI2CWaitTXDone(void)
+static long hwI2CWaitTXDone(void)
 {
     unsigned int timeout;

@@ -90,7 +90,7 @@ long hwI2CWaitTXDone(void)
  *  Return Value:
  *      Total number of bytes those are actually written.
  */
-unsigned int hwI2CWriteData(
+static unsigned int hwI2CWriteData(
     unsigned char deviceAddress,
     unsigned int length,
     unsigned char *pBuffer
@@ -157,7 +157,7 @@ unsigned int hwI2CWriteData(
  *  Return Value:
  *      Total number of actual bytes read from the slave device
  */
-unsigned int hwI2CReadData(
+static unsigned int hwI2CReadData(
     unsigned char deviceAddress,
     unsigned int length,
     unsigned char *pBuffer
--
2.3.2
