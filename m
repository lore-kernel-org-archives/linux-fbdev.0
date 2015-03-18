From: Lorenzo Stoakes <lstoakes@gmail.com>
Date: Wed, 18 Mar 2015 08:57:23 +0000
Subject: [PATCH RESEND 2/5] staging: sm750fb: Make internal functions static
Message-Id: <1426669046-29935-2-git-send-email-lstoakes@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426669046-29935-1-git-send-email-lstoakes@gmail.com>
In-Reply-To: <1426669046-29935-1-git-send-email-lstoakes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, Lorenzo Stoakes <lstoakes@gmail.com>

This patch declares externally unavailable functions static. This fixes
the following sparse warnings:-

drivers/staging/sm750fb/ddk750_swi2c.c:223:6: warning: symbol 'swI2CStart' was not declared. Should it be static?
drivers/staging/sm750fb/ddk750_swi2c.c:234:6: warning: symbol 'swI2CStop' was not declared. Should it be static?
drivers/staging/sm750fb/ddk750_swi2c.c:252:6: warning: symbol 'swI2CWriteByte' was not declared. Should it be static?
drivers/staging/sm750fb/ddk750_swi2c.c:320:15: warning: symbol 'swI2CReadByte' was not declared. Should it be static?
drivers/staging/sm750fb/ddk750_swi2c.c:361:6: warning: symbol 'swI2CInit_SM750LE' was not declared. Should it be static?
drivers/staging/sm750fb/ddk750_hwi2c.c:63:6: warning: symbol 'hwI2CWaitTXDone' was not declared. Should it be static?
drivers/staging/sm750fb/ddk750_hwi2c.c:93:14: warning: symbol 'hwI2CWriteData' was not declared. Should it be static?
drivers/staging/sm750fb/ddk750_hwi2c.c:160:14: warning: symbol 'hwI2CReadData' was not declared. Should it be static?

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 drivers/staging/sm750fb/ddk750_hwi2c.c |  6 +++---
 drivers/staging/sm750fb/ddk750_swi2c.c | 10 +++++-----
 drivers/staging/sm750fb/sm750_accel.c  |  2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

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
diff --git a/drivers/staging/sm750fb/ddk750_swi2c.c b/drivers/staging/sm750fb/ddk750_swi2c.c
index 1249759..516f5bb 100644
--- a/drivers/staging/sm750fb/ddk750_swi2c.c
+++ b/drivers/staging/sm750fb/ddk750_swi2c.c
@@ -220,7 +220,7 @@ static void swI2CAck(void)
 /*
  *  This function sends the start command to the slave device
  */
-void swI2CStart(void)
+static void swI2CStart(void)
 {
     /* Start I2C */
     swI2CSDA(1);
@@ -231,7 +231,7 @@ void swI2CStart(void)
 /*
  *  This function sends the stop command to the slave device
  */
-void swI2CStop(void)
+static void swI2CStop(void)
 {
     /* Stop the I2C */
     swI2CSCL(1);
@@ -249,7 +249,7 @@ void swI2CStop(void)
  *       0   - Success
  *      -1   - Fail to write byte
  */
-long swI2CWriteByte(unsigned char data)
+static long swI2CWriteByte(unsigned char data)
 {
     unsigned char value = data;
     int i;
@@ -317,7 +317,7 @@ long swI2CWriteByte(unsigned char data)
  *  Return Value:
  *      One byte data read from the Slave device
  */
-unsigned char swI2CReadByte(unsigned char ack)
+static unsigned char swI2CReadByte(unsigned char ack)
 {
     int i;
     unsigned char data = 0;
@@ -358,7 +358,7 @@ unsigned char swI2CReadByte(unsigned char ack)
  *      -1   - Fail to initialize the i2c
  *       0   - Success
  */
-long swI2CInit_SM750LE(
+static long swI2CInit_SM750LE(
     unsigned char i2cClkGPIO,
     unsigned char i2cDataGPIO
 )
--
2.3.2
