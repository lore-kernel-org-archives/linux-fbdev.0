From: Dennis Munsie <dmunsie@cecropia.com>
Subject: [PATCH 6/7 2.6.17-rc6-mm2] add preliminary i2c
	support to intelfb
Date: Wed, 14 Jun 2006 13:53:25 -0400
Message-ID: <E0E89C4F-B8C6-494A-90D3-5B2DD664BAE5@cecropia.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FqZVt-0001Cz-WF for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 14 Jun 2006 10:50:46 -0700
Received: from mail6.sea5.speakeasy.net ([69.17.117.8])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FqZVt-0000fR-J5
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 14 Jun 2006 10:50:46 -0700
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Eric Hustvedt <ehustvedt@cecropia.com>, Dave Airlie <airlied@skynet.ie>

From: Dennis Munsie <dmunsie@cecropia.com>

[06/07] intelfb: adds intelfb_i2c.c which contains the infrastructure  
needed to
enumerate the i2c busses on the intelfb.

Signed-off-by: Dennis Munsie <dmunsie@cecropia.com>

---

drivers/video/intelfb/intelfb.h     |    4
drivers/video/intelfb/intelfb_i2c.c |  184 +++++++++++++++++++++++++++ 
+++++++++
drivers/video/intelfb/intelfbdrv.c  |    5
3 files changed, 193 insertions(+)

diff -Naurp -X linux-2.6.17-rc6-patched/Documentation/dontdiff  
linux-2.6.17-rc6-patched/drivers/video/intelfb/intelfb.h linux/ 
drivers/video/intelfb/intelfb.h
--- linux-2.6.17-rc6-patched/drivers/video/intelfb/intelfb.h	 
2006-06-14 12:37:40.000000000 -0500
+++ linux/drivers/video/intelfb/intelfb.h	2006-06-14  
12:38:25.000000000 -0500
@@ -365,4 +365,8 @@ struct intelfb_info {
extern int intelfb_var_to_depth(const struct fb_var_screeninfo *var);
+#ifdef CONFIG_FB_INTEL_I2C
+extern void intelfb_create_i2c_busses(struct intelfb_info *dinfo);
+#endif
+
#endif /* _INTELFB_H */
diff -Naurp -X linux-2.6.17-rc6-patched/Documentation/dontdiff  
linux-2.6.17-rc6-patched/drivers/video/intelfb/intelfb_i2c.c linux/ 
drivers/video/intelfb/intelfb_i2c.c
--- linux-2.6.17-rc6-patched/drivers/video/intelfb/intelfb_i2c.c	 
1969-12-31 19:00:00.000000000 -0500
+++ linux/drivers/video/intelfb/intelfb_i2c.c	2006-06-14  
12:38:25.000000000 -0500
@@ -0,0 +1,184 @@
+/ 
************************************************************************ 
**
+
+ Copyright 2006 Dave Airlie <airlied@linux.ie>
+
+All Rights Reserved.
+
+Permission is hereby granted, free of charge, to any person obtaining a
+copy of this software and associated documentation files (the  
"Software"),
+to deal in the Software without restriction, including without  
limitation
+on the rights to use, copy, modify, merge, publish, distribute, sub
+license, and/or sell copies of the Software, and to permit persons  
to whom
+the Software is furnished to do so, subject to the following  
conditions:
+
+The above copyright notice and this permission notice (including the  
next
+paragraph) shall be included in all copies or substantial portions  
of the
+Software.
+
+THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,  
EXPRESS OR
+IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF  
MERCHANTABILITY,
+FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT  
SHALL
+THE COPYRIGHT HOLDERS AND/OR THEIR SUPPLIERS BE LIABLE FOR ANY CLAIM,
+DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
+OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE  
OR THE
+USE OR OTHER DEALINGS IN THE SOFTWARE.
+
+*********************************************************************** 
***/
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/delay.h>
+#include <linux/pci.h>
+#include <linux/fb.h>
+
+#include <linux/i2c.h>
+#include <linux/i2c-id.h>
+#include <linux/i2c-algo-bit.h>
+
+#include <asm/io.h>
+
+#include "intelfb.h"
+#include "intelfbhw.h"
+
+/* bit locations in the registers */
+#define SCL_DIR_MASK		0x0001
+#define SCL_DIR			0x0002
+#define SCL_VAL_MASK		0x0004
+#define SCL_VAL_OUT		0x0008
+#define SCL_VAL_IN		0x0010
+#define SDA_DIR_MASK		0x0100
+#define SDA_DIR			0x0200
+#define SDA_VAL_MASK		0x0400
+#define SDA_VAL_OUT		0x0800
+#define SDA_VAL_IN		0x1000
+
+static void intelfb_gpio_setscl(void *data, int state)
+{
+	struct intelfb_i2c_chan *chan = data;
+	struct intelfb_info *dinfo = chan->dinfo;
+	u32 val;
+
+	OUTREG(chan->reg, (state ? SCL_VAL_OUT : 0) | SCL_DIR |  
SCL_DIR_MASK | SCL_VAL_MASK);
+	val = INREG(chan->reg);
+}
+
+static void intelfb_gpio_setsda(void *data, int state)
+{
+	struct intelfb_i2c_chan *chan = data;
+	struct intelfb_info *dinfo = chan->dinfo;
+	u32 val;
+
+	OUTREG(chan->reg, (state ? SDA_VAL_OUT : 0) | SDA_DIR |  
SDA_DIR_MASK | SDA_VAL_MASK);
+	val = INREG(chan->reg);
+}
+
+static int intelfb_gpio_getscl(void *data)
+{
+	struct intelfb_i2c_chan *chan = data;
+	struct intelfb_info *dinfo = chan->dinfo;
+	u32 val;
+
+	OUTREG(chan->reg, SCL_DIR_MASK);
+	OUTREG(chan->reg, 0);
+	val = INREG(chan->reg);
+	return ((val & SCL_VAL_IN) != 0);
+}
+
+static int intelfb_gpio_getsda(void *data)
+{
+	struct intelfb_i2c_chan *chan = data;
+	struct intelfb_info *dinfo = chan->dinfo;
+	u32 val;
+
+	OUTREG(chan->reg, SDA_DIR_MASK);
+	OUTREG(chan->reg, 0);
+	val = INREG(chan->reg);
+	return ((val & SDA_VAL_IN) != 0);
+}
+
+static int intelfb_setup_i2c_bus(struct intelfb_info *dinfo,
+								 struct intelfb_i2c_chan *chan,
+								 const u32 reg, const char *name)
+{
+	int rc;
+
+	chan->dinfo					= dinfo;
+	chan->reg					= reg;
+	snprintf(chan->adapter.name, I2C_NAME_SIZE, "intelfb %s", name);
+	chan->adapter.owner			= THIS_MODULE;
+	chan->adapter.id			= I2C_HW_B_INTELFB;
+	chan->adapter.algo_data		= &chan->algo;
+	chan->adapter.dev.parent	= &chan->dinfo->pdev->dev;
+	chan->algo.setsda			= intelfb_gpio_setsda;
+	chan->algo.setscl			= intelfb_gpio_setscl;
+	chan->algo.getsda			= intelfb_gpio_getsda;
+	chan->algo.getscl			= intelfb_gpio_getscl;
+	chan->algo.udelay			= 40;
+	chan->algo.timeout			= 20;
+	chan->algo.data				= chan;
+
+	i2c_set_adapdata(&chan->adapter, chan);
+
+	/* Raise SCL and SDA */
+	intelfb_gpio_setsda(chan, 1);
+	intelfb_gpio_setscl(chan, 1);
+	udelay(20);
+
+	rc = i2c_bit_add_bus(&chan->adapter);
+	if (rc == 0)
+		DBG_MSG("I2C bus %s registered.\n", name);
+	else
+		WRN_MSG("Failed to register I2C bus %s.\n", name);
+	return rc;
+}
+
+void intelfb_create_i2c_busses(struct intelfb_info *dinfo)
+{
+	int i = 0;
+
+	/* everyone has at least a single analog output */
+	dinfo->num_outputs = 1;
+	dinfo->output[i].type = INTELFB_OUTPUT_ANALOG;
+
+	/* setup the DDC bus for analog output */
+	intelfb_setup_i2c_bus(dinfo, &dinfo->output[i].ddc_bus, GPIOA,  
"CRTDDC_A");
+	i++;
+
+    /* need to add the output busses for each device
+       - this function is very incomplete
+       - i915GM has LVDS and TVOUT for example
+    */
+    switch(dinfo->chipset) {
+	case INTEL_830M:
+	case INTEL_845G:
+	case INTEL_855GM:
+	case INTEL_865G:
+		dinfo->output[i].type = INTELFB_OUTPUT_DVO;
+		intelfb_setup_i2c_bus(dinfo, &dinfo->output[i].ddc_bus, GPIOD,  
"DVODDC_D");
+		intelfb_setup_i2c_bus(dinfo, &dinfo->output[i].i2c_bus, GPIOE,  
"DVOI2C_E");
+		i++;
+		break;
+	case INTEL_915G:
+	case INTEL_915GM:
+		/* has  some LVDS + tv-out */
+	case INTEL_945G:
+	case INTEL_945GM:
+		/* SDVO ports have a single control bus - 2 devices */
+		dinfo->output[i].type = INTELFB_OUTPUT_SDVO;
+		intelfb_setup_i2c_bus(dinfo, &dinfo->output[i].i2c_bus, GPIOE,  
"SDVOCTRL_E");
+		/* TODO: initialize the SDVO */
+//		I830SDVOInit(pScrn, i, DVOB);
+		i++;
+
+		/* set up SDVOC */
+		dinfo->output[i].type = INTELFB_OUTPUT_SDVO;
+		dinfo->output[i].i2c_bus = dinfo->output[i - 1].i2c_bus;
+		/* TODO: initialize the SDVO */
+//		I830SDVOInit(pScrn, i, DVOC);
+		i++;
+		break;
+	}
+	dinfo->num_outputs = i;
+}
diff -Naurp -X linux-2.6.17-rc6-patched/Documentation/dontdiff  
linux-2.6.17-rc6-patched/drivers/video/intelfb/intelfbdrv.c linux/ 
drivers/video/intelfb/intelfbdrv.c
--- linux-2.6.17-rc6-patched/drivers/video/intelfb/intelfbdrv.c	 
2006-06-14 12:37:40.000000000 -0500
+++ linux/drivers/video/intelfb/intelfbdrv.c	2006-06-14  
12:38:25.000000000 -0500
@@ -851,6 +851,11 @@ intelfb_pci_register(struct pci_dev *pde
	if (bailearly == 5)
		bailout(dinfo);
+#ifdef CONFIG_FB_INTEL_I2C
+	/* register I2C bus */
+	intelfb_create_i2c_busses(dinfo);
+#endif
+
	if (bailearly == 6)
		bailout(dinfo);
