From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date: Mon, 16 Mar 2015 10:51:09 +0000
Subject: [PATCH] staging/sm75fb: Declare static functions as such
Message-Id: <1426503069-27901-1-git-send-email-ricardo.ribalda@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>

This patch fixes this sparse warning

CHECK   drivers/staging/sm750fb/ddk750_swi2c.c
drivers/staging/sm750fb/ddk750_swi2c.c:223:6: warning: symbol
  'swI2CStart' was not declared. Should it be static?
drivers/staging/sm750fb/ddk750_swi2c.c:234:6: warning: symbol
  'swI2CStop' was not declared. Should it be static?
drivers/staging/sm750fb/ddk750_swi2c.c:252:6: warning: symbol
  'swI2CWriteByte' was not declared. Should it be static?
drivers/staging/sm750fb/ddk750_swi2c.c:320:15: warning: symbol
  'swI2CReadByte' was not declared. Should it be static?
drivers/staging/sm750fb/ddk750_swi2c.c:361:6: warning: symbol
  'swI2CInit_SM750LE' was not declared. Should it be static?

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/staging/sm750fb/ddk750_swi2c.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_swi2c.c b/drivers/staging/sm750fb/ddk750_swi2c.c
index 1249759..231ec85 100644
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
@@ -358,10 +358,8 @@ unsigned char swI2CReadByte(unsigned char ack)
  *      -1   - Fail to initialize the i2c
  *       0   - Success
  */
-long swI2CInit_SM750LE(
-    unsigned char i2cClkGPIO,
-    unsigned char i2cDataGPIO
-)
+static long swI2CInit_SM750LE(unsigned char i2cClkGPIO,
+			      unsigned char i2cDataGPIO)
 {
     int i;
 
-- 
2.1.4

