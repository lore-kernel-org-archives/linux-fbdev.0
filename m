From: Krzysztof Helt <krzysztof.h1-IjDXvh/HVVUAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/2] tdfxfb: move I2C functionality into the tdfxfb
Date: Mon, 23 Mar 2009 19:26:37 +0100
Message-ID: <20090323192637.b820f669.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Linux-fbdev-devel <linux-fbdev-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>

From: Krzysztof Helt <krzysztof.h1-5tc4TXWwyLM@public.gmane.org>

The I2C functionality provided by the i2c-voodoo3 driver
is moved into the tdfxfb (frame buffer driver for Voodoo3
cards). This way there is no conflict between the i2c driver
and the fb driver.

The tdfxfb does not make use from the DDC functionality yet
but provides all the functionality of the i2c-voodoo3 driver.

Signed-off-by: Krzysztof Helt <krzysztof.h1-5tc4TXWwyLM@public.gmane.org>
---
I prefer to send these patches through Andrew Morton's
tree as the second patch is not related to the i2c stuff.

Both patches are for the -mm tree.

 drivers/video/Kconfig  |    9 ++
 drivers/video/tdfxfb.c |  200 +++++++++++++++++++++++++++++++++++++++++++++++-
 include/video/tdfx.h   |   26 ++++++
 3 files changed, 234 insertions(+), 1 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 6ff3364..eeca6d5 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -1550,6 +1550,7 @@ config FB_3DFX
 	select FB_CFB_IMAGEBLIT
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
+	select FB_MODE_HELPERS
 	help
 	  This driver supports graphics boards with the 3Dfx Banshee,
 	  Voodoo3 or VSA-100 (aka Voodoo4/5) chips. Say Y if you have
@@ -1565,6 +1566,14 @@ config FB_3DFX_ACCEL
 	This will compile the 3Dfx Banshee/Voodoo3/VSA-100 frame buffer
 	device driver with acceleration functions.
 
+config FB_3DFX_I2C
+	bool "Enable DDC/I2C support"
+	depends on FB_3DFX && EXPERIMENTAL
+	select FB_DDC
+	default y
+	help
+	  Say Y here if you want DDC/I2C support for your 3dfx Voodoo3.
+
 config FB_VOODOO1
 	tristate "3Dfx Voodoo Graphics (sst1) support"
 	depends on FB && PCI
diff --git a/drivers/video/tdfxfb.c b/drivers/video/tdfxfb.c
index 14bd3f3..be40506 100644
--- a/drivers/video/tdfxfb.c
+++ b/drivers/video/tdfxfb.c
@@ -10,6 +10,12 @@
  * Created      : Thu Sep 23 18:17:43 1999, hmallat
  * Last modified: Tue Nov  2 21:19:47 1999, hmallat
  *
+ * I2C part copied from the i2c-voodoo3.c driver by:
+ * Frodo Looijaard <frodol-B0qZmFHriGg@public.gmane.org>,
+ * Philip Edelbrock <phil-KXOFo5pg7o1l57MIdRCFDg@public.gmane.org>,
+ * Ralph Metzler <rjkm-KutymZ0aA5sRtNtAH2Wc8g@public.gmane.org>, and
+ * Mark D. Studebaker <mdsxyz123-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
+ *
  * Lots of the information here comes from the Daryll Strauss' Banshee
  * patches to the XF86 server, and the rest comes from the 3dfx
  * Banshee specification. I'm very much indebted to Daryll for his
@@ -1167,6 +1173,190 @@ static struct fb_ops tdfxfb_ops = {
 #endif
 };
 
+#ifdef CONFIG_FB_3DFX_I2C
+/* The voo GPIO registers don't have individual masks for each bit
+   so we always have to read before writing. */
+
+static void tdfxfb_i2c_setscl(void *data, int val)
+{
+	struct tdfxfb_i2c_chan 	*chan = data;
+	struct tdfx_par 	*par = chan->par;
+	unsigned int r;
+
+	r = tdfx_inl(par, VIDSERPARPORT);
+	if (val)
+		r |= I2C_SCL_OUT;
+	else
+		r &= ~I2C_SCL_OUT;
+	tdfx_outl(par, VIDSERPARPORT, r);
+	tdfx_inl(par, VIDSERPARPORT);	/* flush posted write */
+}
+
+static void tdfxfb_i2c_setsda(void *data, int val)
+{
+	struct tdfxfb_i2c_chan 	*chan = data;
+	struct tdfx_par 	*par = chan->par;
+	unsigned int r;
+
+	r = tdfx_inl(par, VIDSERPARPORT);
+	if (val)
+		r |= I2C_SDA_OUT;
+	else
+		r &= ~I2C_SDA_OUT;
+	tdfx_outl(par, VIDSERPARPORT, r);
+	tdfx_inl(par, VIDSERPARPORT);	/* flush posted write */
+}
+
+/* The GPIO pins are open drain, so the pins always remain outputs.
+   We rely on the i2c-algo-bit routines to set the pins high before
+   reading the input from other chips. */
+
+static int tdfxfb_i2c_getscl(void *data)
+{
+	struct tdfxfb_i2c_chan 	*chan = data;
+	struct tdfx_par 	*par = chan->par;
+
+	return (0 != (tdfx_inl(par, VIDSERPARPORT) & I2C_SCL_IN));
+}
+
+static int tdfxfb_i2c_getsda(void *data)
+{
+	struct tdfxfb_i2c_chan 	*chan = data;
+	struct tdfx_par 	*par = chan->par;
+
+	return (0 != (tdfx_inl(par, VIDSERPARPORT) & I2C_SDA_IN));
+}
+
+static void tdfxfb_ddc_setscl(void *data, int val)
+{
+	struct tdfxfb_i2c_chan 	*chan = data;
+	struct tdfx_par 	*par = chan->par;
+	unsigned int r;
+
+	r = tdfx_inl(par, VIDSERPARPORT);
+	if (val)
+		r |= DDC_SCL_OUT;
+	else
+		r &= ~DDC_SCL_OUT;
+	tdfx_outl(par, VIDSERPARPORT, r);
+	tdfx_inl(par, VIDSERPARPORT);	/* flush posted write */
+}
+
+static void tdfxfb_ddc_setsda(void *data, int val)
+{
+	struct tdfxfb_i2c_chan 	*chan = data;
+	struct tdfx_par 	*par = chan->par;
+	unsigned int r;
+
+	r = tdfx_inl(par, VIDSERPARPORT);
+	if (val)
+		r |= DDC_SDA_OUT;
+	else
+		r &= ~DDC_SDA_OUT;
+	tdfx_outl(par, VIDSERPARPORT, r);
+	tdfx_inl(par, VIDSERPARPORT);	/* flush posted write */
+}
+
+static int tdfxfb_ddc_getscl(void *data)
+{
+	struct tdfxfb_i2c_chan 	*chan = data;
+	struct tdfx_par 	*par = chan->par;
+
+	return (0 != (tdfx_inl(par, VIDSERPARPORT) & DDC_SCL_IN));
+}
+
+static int tdfxfb_ddc_getsda(void *data)
+{
+	struct tdfxfb_i2c_chan 	*chan = data;
+	struct tdfx_par 	*par = chan->par;
+
+	return (0 != (tdfx_inl(par, VIDSERPARPORT) & DDC_SDA_IN));
+}
+
+static int __devinit tdfxfb_setup_ddc_bus(struct tdfxfb_i2c_chan *chan,
+					  const char *name, struct device *dev)
+{
+	int rc;
+
+	strlcpy(chan->adapter.name, name, sizeof(chan->adapter.name));
+	chan->adapter.owner		= THIS_MODULE;
+	chan->adapter.class		= I2C_CLASS_DDC;
+	chan->adapter.algo_data		= &chan->algo;
+	chan->adapter.dev.parent	= dev;
+	chan->algo.setsda		= tdfxfb_ddc_setsda;
+	chan->algo.setscl		= tdfxfb_ddc_setscl;
+	chan->algo.getsda		= tdfxfb_ddc_getsda;
+	chan->algo.getscl		= tdfxfb_ddc_getscl;
+	chan->algo.udelay		= 10;
+	chan->algo.timeout		= msecs_to_jiffies(500);
+	chan->algo.data 		= chan;
+
+	i2c_set_adapdata(&chan->adapter, chan);
+
+	rc = i2c_bit_add_bus(&chan->adapter);
+	if (rc == 0)
+		DPRINTK("I2C bus %s registered.\n", name);
+	else
+		chan->par = NULL;
+
+	return rc;
+}
+
+static int __devinit tdfxfb_setup_i2c_bus(struct tdfxfb_i2c_chan *chan,
+					  const char *name, struct device *dev)
+{
+	int rc;
+
+	strlcpy(chan->adapter.name, name, sizeof(chan->adapter.name));
+	chan->adapter.owner		= THIS_MODULE;
+	chan->adapter.class		= I2C_CLASS_TV_ANALOG;
+	chan->adapter.algo_data		= &chan->algo;
+	chan->adapter.dev.parent	= dev;
+	chan->algo.setsda		= tdfxfb_i2c_setsda;
+	chan->algo.setscl		= tdfxfb_i2c_setscl;
+	chan->algo.getsda		= tdfxfb_i2c_getsda;
+	chan->algo.getscl		= tdfxfb_i2c_getscl;
+	chan->algo.udelay		= 10;
+	chan->algo.timeout		= msecs_to_jiffies(500);
+	chan->algo.data 		= chan;
+
+	i2c_set_adapdata(&chan->adapter, chan);
+
+	rc = i2c_bit_add_bus(&chan->adapter);
+	if (rc == 0)
+		DPRINTK("I2C bus %s registered.\n", name);
+	else
+		chan->par = NULL;
+
+	return rc;
+}
+
+static void __devinit tdfxfb_create_i2c_busses(struct fb_info *info)
+{
+	struct tdfx_par *par = info->par;
+
+	tdfx_outl(par, VIDINFORMAT, 0x8160);
+	tdfx_outl(par, VIDSERPARPORT, 0xcffc0020);
+
+	par->chan[0].par = par;
+	par->chan[1].par = par;
+
+	tdfxfb_setup_ddc_bus(&par->chan[0], "Voodoo3-DDC", info->dev);
+	tdfxfb_setup_i2c_bus(&par->chan[1], "Voodoo3-I2C", info->dev);
+}
+
+static void tdfxfb_delete_i2c_busses(struct tdfx_par *par)
+{
+	if (par->chan[0].par)
+		i2c_del_adapter(&par->chan[0].adapter);
+	par->chan[0].par = NULL;
+
+	if (par->chan[1].par)
+		i2c_del_adapter(&par->chan[1].adapter);
+	par->chan[1].par = NULL;
+}
+#endif /* CONFIG_FB_3DFX_I2C */
+
 /**
  *      tdfxfb_probe - Device Initializiation
  *
@@ -1284,7 +1474,9 @@ static int __devinit tdfxfb_probe(struct pci_dev *pdev,
 	if (hwcursor)
 		info->fix.smem_len = (info->fix.smem_len - 1024) &
 					(PAGE_MASK << 1);
-
+#ifdef CONFIG_FB_3DFX_I2C
+	tdfxfb_create_i2c_busses(info);
+#endif
 	if (!mode_option)
 		mode_option = "640x480@60";
 
@@ -1315,6 +1507,9 @@ static int __devinit tdfxfb_probe(struct pci_dev *pdev,
 	return 0;
 
 out_err_iobase:
+#ifdef CONFIG_FB_3DFX_I2C
+	tdfxfb_delete_i2c_busses(default_par);
+#endif
 	if (default_par->mtrr_handle >= 0)
 		mtrr_del(default_par->mtrr_handle, info->fix.smem_start,
 			 info->fix.smem_len);
@@ -1379,6 +1574,9 @@ static void __devexit tdfxfb_remove(struct pci_dev *pdev)
 	struct tdfx_par *par = info->par;
 
 	unregister_framebuffer(info);
+#ifdef CONFIG_FB_3DFX_I2C
+	tdfxfb_delete_i2c_busses(par);
+#endif
 	if (par->mtrr_handle >= 0)
 		mtrr_del(par->mtrr_handle, info->fix.smem_start,
 			 info->fix.smem_len);
diff --git a/include/video/tdfx.h b/include/video/tdfx.h
index 7431d96..befbaf0 100644
--- a/include/video/tdfx.h
+++ b/include/video/tdfx.h
@@ -1,6 +1,9 @@
 #ifndef _TDFX_H
 #define _TDFX_H
 
+#include <linux/i2c.h>
+#include <linux/i2c-algo-bit.h>
+
 /* membase0 register offsets */
 #define STATUS		0x00
 #define PCIINIT0	0x04
@@ -123,6 +126,18 @@
 #define VIDCFG_PIXFMT_SHIFT             18
 #define DACMODE_2X			BIT(0)
 
+/* I2C bit locations in the VIDSERPARPORT register */
+#define DDC_ENAB	0x00040000
+#define DDC_SCL_OUT	0x00080000
+#define DDC_SDA_OUT	0x00100000
+#define DDC_SCL_IN	0x00200000
+#define DDC_SDA_IN	0x00400000
+#define I2C_ENAB	0x00800000
+#define I2C_SCL_OUT	0x01000000
+#define I2C_SDA_OUT	0x02000000
+#define I2C_SCL_IN	0x04000000
+#define I2C_SDA_IN	0x08000000
+
 /* VGA rubbish, need to change this for multihead support */
 #define MISC_W		0x3c2
 #define MISC_R		0x3cc
@@ -168,12 +183,23 @@ struct banshee_reg {
 	unsigned long miscinit0;
 };
 
+struct tdfx_par;
+
+struct tdfxfb_i2c_chan {
+	struct tdfx_par *par;
+	struct i2c_adapter adapter;
+	struct i2c_algo_bit_data algo;
+};
+
 struct tdfx_par {
 	u32 max_pixclock;
 	u32 palette[16];
 	void __iomem *regbase_virt;
 	unsigned long iobase;
 	int mtrr_handle;
+#ifdef CONFIG_FB_3DFX_I2C
+	struct tdfxfb_i2c_chan chan[2];
+#endif
 };
 
 #endif	/* __KERNEL__ */
-- 
1.5.2.2


----------------------------------------------------------------------
10% zysku na lokacie bankowej z gwarancja BFG. Sprawdz!
http://clk.tradedoubler.com/click?p=74281&a=1586724&g=17879004
