From: Stefani Seibold <stefani@seibold.net>
Date: Mon, 03 Jan 2011 09:28:59 +0000
Subject: [PATCH] fix i810 i2c bug
Message-Id: <1294046939.20021.12.camel@wall-e>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, linux-fbdev@vger.kernel.org, adaplas@gmail.com

These patch fix a longstanding bug in the i810 frame buffer driver. 

The handling of the i2c bus is wrong: A 1 bit should not written to the
i2c, these will be done by switch the i2c to input. Driving an 1 bit
active is against the i2c spec.

An active driven of a 1 bit will result in very strange error, depending
which side is the more powerful one. In my case it depends on the
temperature of the Display-Controller-EEprom: With an cold eprom a got
the correct EDID datas, with a warm one some of the 1 bits was 0 :-(

The same bug is also in the intelfb driver in the file
drivers/video/intelfb/intelfb_i2c.c. The functions intelfb_gpio_setscl()
and intelfb_gpio_setsda() do drive the 1 bit active to the i2c bus. But
since i have no card which is used by the intelfb driver i cannot fix
it.

The patch is against linux next-20101231

- Stefani

Signed-off-by: Stefani Seibold <stefani@seibold.net>
---
 i810-i2c.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff -u -N -r -p linux-2.6.35.orig/drivers/video/i810/i810-i2c.c linux-2.6.35/drivers/video/i810/i810-i2c.c
--- linux-2.6.35.orig/drivers/video/i810/i810-i2c.c	2010-08-02 00:11:14.000000000 +0200
+++ linux-2.6.35/drivers/video/i810/i810-i2c.c	2010-10-04 12:24:29.000000000 +0200
@@ -45,8 +45,10 @@ static void i810i2c_setscl(void *data, i
         struct i810fb_par         *par = chan->par;
 	u8                        __iomem *mmio = par->mmio_start_virtual;
 
-	i810_writel(mmio, chan->ddc_base, (state ? SCL_VAL_OUT : 0) | SCL_DIR |
-		    SCL_DIR_MASK | SCL_VAL_MASK);
+	if (state)
+		i810_writel(mmio, chan->ddc_base, SCL_DIR_MASK | SCL_VAL_MASK);
+	else
+		i810_writel(mmio, chan->ddc_base, SCL_DIR | SCL_DIR_MASK | SCL_VAL_MASK);
 	i810_readl(mmio, chan->ddc_base);	/* flush posted write */
 }
 
@@ -56,8 +58,10 @@ static void i810i2c_setsda(void *data, i
         struct i810fb_par         *par = chan->par;
 	u8                        __iomem *mmio = par->mmio_start_virtual;
 
- 	i810_writel(mmio, chan->ddc_base, (state ? SDA_VAL_OUT : 0) | SDA_DIR |
-		    SDA_DIR_MASK | SDA_VAL_MASK);
+	if (state)
+		i810_writel(mmio, chan->ddc_base, SDA_DIR_MASK | SDA_VAL_MASK);
+	else
+		i810_writel(mmio, chan->ddc_base, SDA_DIR | SDA_DIR_MASK | SDA_VAL_MASK);
 	i810_readl(mmio, chan->ddc_base);	/* flush posted write */
 }
 


