From: Daniel Drake <dsd@laptop.org>
Date: Tue, 21 Sep 2010 15:36:56 +0000
Subject: [PATCH 1/2] viafb: Mark via_port_cfg as const
Message-Id: <20100921153657.09BD79D401B@zog.reactivated.net>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This data is never changed.

Signed-off-by: Daniel Drake <dsd@laptop.org>
---
 drivers/video/via/via-core.c |    2 +-
 drivers/video/via/via-gpio.c |    2 +-
 drivers/video/via/via_i2c.c  |   12 ++++++------
 include/linux/via-core.h     |    2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/video/via/via-core.c b/drivers/video/via/via-core.c
index 66f4030..08390fe 100644
--- a/drivers/video/via/via-core.c
+++ b/drivers/video/via/via-core.c
@@ -19,7 +19,7 @@
 /*
  * The default port config.
  */
-static struct via_port_cfg adap_configs[] = {
+static const struct via_port_cfg adap_configs[] = {
 	[VIA_PORT_26]	= { VIA_PORT_I2C,  VIA_MODE_OFF, VIASR, 0x26 },
 	[VIA_PORT_31]	= { VIA_PORT_I2C,  VIA_MODE_I2C, VIASR, 0x31 },
 	[VIA_PORT_25]	= { VIA_PORT_GPIO, VIA_MODE_GPIO, VIASR, 0x25 },
diff --git a/drivers/video/via/via-gpio.c b/drivers/video/via/via-gpio.c
index 39acb37..265d0ce 100644
--- a/drivers/video/via/via-gpio.c
+++ b/drivers/video/via/via-gpio.c
@@ -192,7 +192,7 @@ EXPORT_SYMBOL_GPL(viafb_gpio_lookup);
 static __devinit int viafb_gpio_probe(struct platform_device *platdev)
 {
 	struct viafb_dev *vdev = platdev->dev.platform_data;
-	struct via_port_cfg *port_cfg = vdev->port_cfg;
+	const struct via_port_cfg *port_cfg = vdev->port_cfg;
 	int i, ngpio = 0, ret;
 	struct viafb_gpio *gpio;
 	unsigned long flags;
diff --git a/drivers/video/via/via_i2c.c b/drivers/video/via/via_i2c.c
index da9e4ca..66090c0 100644
--- a/drivers/video/via/via_i2c.c
+++ b/drivers/video/via/via_i2c.c
@@ -174,7 +174,7 @@ EXPORT_SYMBOL_GPL(viafb_find_i2c_adapter);
 
 static int create_i2c_bus(struct i2c_adapter *adapter,
 			  struct i2c_algo_bit_data *algo,
-			  struct via_port_cfg *adap_cfg,
+			  const struct via_port_cfg *adap_cfg,
 			  struct pci_dev *pdev)
 {
 	algo->setsda = via_i2c_setsda;
@@ -183,7 +183,7 @@ static int create_i2c_bus(struct i2c_adapter *adapter,
 	algo->getscl = via_i2c_getscl;
 	algo->udelay = 40;
 	algo->timeout = 20;
-	algo->data = adap_cfg;
+	algo->data = (void *) adap_cfg;
 
 	sprintf(adapter->name, "viafb i2c io_port idx 0x%02x",
 		adap_cfg->ioport_index);
@@ -198,8 +198,8 @@ static int create_i2c_bus(struct i2c_adapter *adapter,
 	/* i2c_set_adapdata(adapter, adap_cfg); */
 
 	/* Raise SCL and SDA */
-	via_i2c_setsda(adap_cfg, 1);
-	via_i2c_setscl(adap_cfg, 1);
+	via_i2c_setsda((void *) adap_cfg, 1);
+	via_i2c_setscl((void *) adap_cfg, 1);
 	udelay(20);
 
 	return i2c_bit_add_bus(adapter);
@@ -208,13 +208,13 @@ static int create_i2c_bus(struct i2c_adapter *adapter,
 static int viafb_i2c_probe(struct platform_device *platdev)
 {
 	int i, ret;
-	struct via_port_cfg *configs;
+	const struct via_port_cfg *configs;
 
 	i2c_vdev = platdev->dev.platform_data;
 	configs = i2c_vdev->port_cfg;
 
 	for (i = 0; i < VIAFB_NUM_PORTS; i++) {
-		struct via_port_cfg *adap_cfg = configs++;
+		const struct via_port_cfg *adap_cfg = configs++;
 		struct via_i2c_stuff *i2c_stuff = &via_i2c_par[i];
 
 		i2c_stuff->is_active = 0;
diff --git a/include/linux/via-core.h b/include/linux/via-core.h
index 7ffb521..172db7c 100644
--- a/include/linux/via-core.h
+++ b/include/linux/via-core.h
@@ -66,7 +66,7 @@ struct via_port_cfg {
 struct viafb_dev {
 	struct pci_dev *pdev;
 	int chip_type;
-	struct via_port_cfg *port_cfg;
+	const struct via_port_cfg *port_cfg;
 	/*
 	 * Spinlock for access to device registers.  Not yet
 	 * globally used.
-- 
1.7.2.2

