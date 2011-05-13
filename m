From: Anatolij Gustschin <agust@denx.de>
Date: Fri, 13 May 2011 15:54:48 +0000
Subject: [PATCH 4/5] video: mb862xx: add support for controller's I2C bus adapter
Message-Id: <1305302089-7666-5-git-send-email-agust@denx.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Add adapter driver for I2C adapter in Coral-P(A)/Lime GDCs.
So we can easily access devices on controller's I2C bus using
i2c-dev interface.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
 drivers/video/mb862xx/Makefile      |    2 +-
 drivers/video/mb862xx/mb862xx-i2c.c |  168 +++++++++++++++++++++++++++++++++++
 drivers/video/mb862xx/mb862xx_reg.h |   21 +++++
 drivers/video/mb862xx/mb862xxfb.c   |    2 +
 drivers/video/mb862xx/mb862xxfb.h   |    3 +
 5 files changed, 195 insertions(+), 1 deletions(-)
 create mode 100644 drivers/video/mb862xx/mb862xx-i2c.c

diff --git a/drivers/video/mb862xx/Makefile b/drivers/video/mb862xx/Makefile
index d777771..3a36c45 100644
--- a/drivers/video/mb862xx/Makefile
+++ b/drivers/video/mb862xx/Makefile
@@ -2,4 +2,4 @@
 # Makefile for the MB862xx framebuffer driver
 #
 
-obj-$(CONFIG_FB_MB862XX)	:= mb862xxfb.o mb862xxfb_accel.o
+obj-$(CONFIG_FB_MB862XX)	:= mb862xxfb.o mb862xxfb_accel.o mb862xx-i2c.o
diff --git a/drivers/video/mb862xx/mb862xx-i2c.c b/drivers/video/mb862xx/mb862xx-i2c.c
new file mode 100644
index 0000000..d50cc71
--- /dev/null
+++ b/drivers/video/mb862xx/mb862xx-i2c.c
@@ -0,0 +1,168 @@
+/*
+ * Coral-P(A)/Lime I2C adapter driver
+ *
+ * (C) 2011 DENX Software Engineering, Anatolij Gustschin <agust@denx.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/fb.h>
+#include <linux/i2c.h>
+#include <linux/io.h>
+
+#include "mb862xxfb.h"
+#include "mb862xx_reg.h"
+
+static int mb862xx_i2c_wait_event(struct i2c_adapter *adap)
+{
+	struct mb862xxfb_par *par = adap->algo_data;
+	u32 reg;
+
+	do {
+		reg = inreg(i2c, GC_I2C_BCR);
+		if (reg & (I2C_INT | I2C_BER))
+			break;
+	} while (1);
+
+	return (reg & I2C_BER) ? 0 : 1;
+}
+
+static int mb862xx_i2c_do_address(struct i2c_adapter *adap, int addr)
+{
+	struct mb862xxfb_par *par = adap->algo_data;
+
+	outreg(i2c, GC_I2C_DAR, addr);
+	outreg(i2c, GC_I2C_CCR, I2C_CLOCK_AND_ENABLE);
+	outreg(i2c, GC_I2C_BCR, par->i2c_rs ? I2C_REPEATED_START : I2C_START);
+	if (!mb862xx_i2c_wait_event(adap))
+		return -EIO;
+	par->i2c_rs = !(inreg(i2c, GC_I2C_BSR) & I2C_LRB);
+	return par->i2c_rs;
+}
+
+static int mb862xx_i2c_write_byte(struct i2c_adapter *adap, u8 byte)
+{
+	struct mb862xxfb_par *par = adap->algo_data;
+
+	outreg(i2c, GC_I2C_DAR, byte);
+	outreg(i2c, GC_I2C_BCR, I2C_START);
+	if (!mb862xx_i2c_wait_event(adap))
+		return -EIO;
+	return !(inreg(i2c, GC_I2C_BSR) & I2C_LRB);
+}
+
+static int mb862xx_i2c_read_byte(struct i2c_adapter *adap, u8 *byte, int last)
+{
+	struct mb862xxfb_par *par = adap->algo_data;
+
+	outreg(i2c, GC_I2C_BCR, I2C_START | (last ? 0 : I2C_ACK));
+	if (!mb862xx_i2c_wait_event(adap))
+		return 0;
+	*byte = inreg(i2c, GC_I2C_DAR);
+	return 1;
+}
+
+void mb862xx_i2c_stop(struct i2c_adapter *adap)
+{
+	struct mb862xxfb_par *par = adap->algo_data;
+
+	outreg(i2c, GC_I2C_BCR, I2C_STOP);
+	outreg(i2c, GC_I2C_CCR, I2C_DISABLE);
+	par->i2c_rs = 0;
+}
+
+static int mb862xx_i2c_read(struct i2c_adapter *adap, struct i2c_msg *m)
+{
+	int i, ret = 0;
+	int last = m->len - 1;
+
+	for (i = 0; i < m->len; i++) {
+		if (!mb862xx_i2c_read_byte(adap, &m->buf[i], i = last)) {
+			ret = -EIO;
+			break;
+		}
+	}
+	return ret;
+}
+
+static int mb862xx_i2c_write(struct i2c_adapter *adap, struct i2c_msg *m)
+{
+	int i, ret = 0;
+
+	for (i = 0; i < m->len; i++) {
+		if (!mb862xx_i2c_write_byte(adap, m->buf[i])) {
+			ret = -EIO;
+			break;
+		}
+	}
+	return ret;
+}
+
+static int mb862xx_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
+			int num)
+{
+	struct mb862xxfb_par *par = adap->algo_data;
+	struct i2c_msg *m;
+	int addr;
+	int i = 0, err = 0;
+
+	dev_dbg(par->dev, "%s: %d msgs\n", __func__, num);
+
+	for (i = 0; i < num; i++) {
+		m = &msgs[i];
+		if (!m->len) {
+			dev_dbg(par->dev, "%s: null msgs\n", __func__);
+			continue;
+		}
+		addr = m->addr;
+		if (m->flags & I2C_M_RD)
+			addr |= 1;
+
+		err = mb862xx_i2c_do_address(adap, addr);
+		if (err < 0)
+			break;
+		if (m->flags & I2C_M_RD)
+			err = mb862xx_i2c_read(adap, m);
+		else
+			err = mb862xx_i2c_write(adap, m);
+	}
+
+	if (i)
+		mb862xx_i2c_stop(adap);
+
+	return (err < 0) ? err : i;
+}
+
+static u32 mb862xx_func(struct i2c_adapter *adap)
+{
+	return I2C_FUNC_SMBUS_BYTE_DATA;
+}
+
+static const struct i2c_algorithm mb862xx_algo = {
+	.master_xfer	= mb862xx_xfer,
+	.functionality	= mb862xx_func,
+};
+
+static struct i2c_adapter mb862xx_i2c_adapter = {
+	.name		= "MB862xx I2C adapter",
+	.algo		= &mb862xx_algo,
+	.owner		= THIS_MODULE,
+};
+
+int mb862xx_i2c_init(struct mb862xxfb_par *par)
+{
+	int ret;
+
+	mb862xx_i2c_adapter.algo_data = par;
+	par->adap = &mb862xx_i2c_adapter;
+
+	ret = i2c_add_adapter(par->adap);
+	if (ret < 0) {
+		dev_err(par->dev, "failed to add %s\n",
+			mb862xx_i2c_adapter.name);
+	}
+	return ret;
+}
diff --git a/drivers/video/mb862xx/mb862xx_reg.h b/drivers/video/mb862xx/mb862xx_reg.h
index 737fc01..5784b01 100644
--- a/drivers/video/mb862xx/mb862xx_reg.h
+++ b/drivers/video/mb862xx/mb862xx_reg.h
@@ -80,6 +80,27 @@
 
 #define GC_DISP_REFCLK_400	400
 
+/* I2C */
+#define GC_I2C_BSR		0x00000000	/* BSR */
+#define GC_I2C_BCR		0x00000004	/* BCR */
+#define GC_I2C_CCR		0x00000008	/* CCR */
+#define GC_I2C_ADR		0x0000000C	/* ADR */
+#define GC_I2C_DAR		0x00000010	/* DAR */
+
+#define I2C_DISABLE		0x00000000
+#define I2C_STOP		0x00000000
+#define I2C_START		0x00000010
+#define I2C_REPEATED_START	0x00000030
+#define I2C_CLOCK_AND_ENABLE	0x0000003f
+#define I2C_READY		0x01
+#define I2C_INT			0x01
+#define I2C_INTE		0x02
+#define I2C_ACK			0x08
+#define I2C_BER			0x80
+#define I2C_BEIE		0x40
+#define I2C_TRX			0x80
+#define I2C_LRB			0x10
+
 /* Carmine specific */
 #define MB86297_DRAW_BASE		0x00020000
 #define MB86297_DISP0_BASE		0x00100000
diff --git a/drivers/video/mb862xx/mb862xxfb.c b/drivers/video/mb862xx/mb862xxfb.c
index ffb6a2c..a9779f8 100644
--- a/drivers/video/mb862xx/mb862xxfb.c
+++ b/drivers/video/mb862xx/mb862xxfb.c
@@ -772,6 +772,8 @@ static int coralp_init(struct mb862xxfb_par *par)
 	} else {
 		return -ENODEV;
 	}
+
+	mb862xx_i2c_init(par);
 	return 0;
 }
 
diff --git a/drivers/video/mb862xx/mb862xxfb.h b/drivers/video/mb862xx/mb862xxfb.h
index d7e7cb7..f0f57ea 100644
--- a/drivers/video/mb862xx/mb862xxfb.h
+++ b/drivers/video/mb862xx/mb862xxfb.h
@@ -57,11 +57,14 @@ struct mb862xxfb_par {
 	unsigned int		refclk;		/* disp. reference clock */
 	struct mb862xx_gc_mode	*gc_mode;	/* GDC mode init data */
 	int			pre_init;	/* don't init display if 1 */
+	struct i2c_adapter	*adap;		/* GDC I2C bus adapter */
+	int			i2c_rs;
 
 	u32			pseudo_palette[16];
 };
 
 extern void mb862xxfb_init_accel(struct fb_info *info, int xres);
+extern int mb862xx_i2c_init(struct mb862xxfb_par *par);
 
 #if defined(CONFIG_FB_MB862XX_LIME) && defined(CONFIG_FB_MB862XX_PCI_GDC)
 #error	"Select Lime GDC or CoralP/Carmine support, but not both together"
-- 
1.7.1

