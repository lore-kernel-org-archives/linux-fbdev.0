From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 9/10] i810fb: Add i2c/DDC support
Date: Sun, 04 Sep 2005 22:46:24 +0800
Message-ID: <431B08C0.4060106@gmail.com>
References: <43177635.8020005@gmail.com> <1125841891.7590.52.camel@tom>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EBvlz-0002er-1j
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 04 Sep 2005 07:47:07 -0700
Received: from zproxy.gmail.com ([64.233.162.197])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EBvlx-0006mr-V0
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 04 Sep 2005 07:47:07 -0700
Received: by zproxy.gmail.com with SMTP id 9so525208nzo
        for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 04 Sep 2005 07:46:59 -0700 (PDT)
In-Reply-To: <1125841891.7590.52.camel@tom>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Nicolas Boichat <nicolas@boichat.ch>
Cc: linux-fbdev-devel@lists.sourceforge.net

Nicolas Boichat wrote:
> Hello Antonino,
> 
> I have an information that may interest you: On i865G, you can connect
> an AGP daughter card to add a DVI connector. The I2C bus of this
> connector is accessed using the register that I called GPIO"C", and its
> offset is 0x0501C (it is not documented in Intel datasheets). It works
> exactly like the busses on GPIOA (0x05010) and GPIOB (0x05014), i.e. you
> can reuse the same functions.

Okay.

> 
> BTW, you could merge i810i2c_* and i810ddc_* functions, as they are the
> same excepting the register address (you did this in rivafb).
> 

Good idea. Can anyone test the patch? I don't have the hardware anymore

Tony

diff --git a/drivers/video/i810/i810-i2c.c b/drivers/video/i810/i810-i2c.c
--- a/drivers/video/i810/i810-i2c.c
+++ b/drivers/video/i810/i810-i2c.c
@@ -42,96 +42,51 @@
 
 static void i810i2c_setscl(void *data, int state)
 {
-        struct i810fb_i2c_chan    *chan = (struct i810fb_i2c_chan *)data;
+        struct i810fb_i2c_chan    *chan = data;
         struct i810fb_par         *par = chan->par;
 	u8                        *mmio = par->mmio_start_virtual;
 	
-	i810_writel(mmio, GPIOB, (state ? SCL_VAL_OUT : 0) | SCL_DIR |
+	i810_writel(mmio, chan->ddc_base, (state ? SCL_VAL_OUT : 0) | SCL_DIR |
 		    SCL_DIR_MASK | SCL_VAL_MASK);
-	i810_readl(mmio, GPIOB);	/* flush posted write */
+	i810_readl(mmio, chan->ddc_base);	/* flush posted write */
 }
 
 static void i810i2c_setsda(void *data, int state)
 {
-        struct i810fb_i2c_chan    *chan = (struct i810fb_i2c_chan *)data;
+        struct i810fb_i2c_chan    *chan = data;
         struct i810fb_par         *par = chan->par;
 	u8                        *mmio = par->mmio_start_virtual;
 	
- 	i810_writel(mmio, GPIOB, (state ? SDA_VAL_OUT : 0) | SDA_DIR |
+ 	i810_writel(mmio, chan->ddc_base, (state ? SDA_VAL_OUT : 0) | SDA_DIR |
 		    SDA_DIR_MASK | SDA_VAL_MASK);
-	i810_readl(mmio, GPIOB);	/* flush posted write */
+	i810_readl(mmio, chan->ddc_base);	/* flush posted write */
 }
 
 static int i810i2c_getscl(void *data)
 {
-        struct i810fb_i2c_chan    *chan = (struct i810fb_i2c_chan *)data;
+        struct i810fb_i2c_chan    *chan = data;
         struct i810fb_par         *par = chan->par;
 	u8                        *mmio = par->mmio_start_virtual;
 	
-	i810_writel(mmio, GPIOB, SCL_DIR_MASK);
-	i810_writel(mmio, GPIOB, 0);
-	return (0 != (i810_readl(mmio, GPIOB) & SCL_VAL_IN));
+	i810_writel(mmio, chan->ddc_base, SCL_DIR_MASK);
+	i810_writel(mmio, chan->ddc_base, 0);
+	return (0 != (i810_readl(mmio, chan->ddc_base) & SCL_VAL_IN));
 }
 
 static int i810i2c_getsda(void *data)
 {
-        struct i810fb_i2c_chan    *chan = (struct i810fb_i2c_chan *)data;
+        struct i810fb_i2c_chan    *chan = data;
         struct i810fb_par         *par = chan->par;
 	u8                        *mmio = par->mmio_start_virtual;
 	
-	i810_writel(mmio, GPIOB, SDA_DIR_MASK);
-	i810_writel(mmio, GPIOB, 0);
-	return (0 != (i810_readl(mmio, GPIOB) & SDA_VAL_IN));
+	i810_writel(mmio, chan->ddc_base, SDA_DIR_MASK);
+	i810_writel(mmio, chan->ddc_base, 0);
+	return (0 != (i810_readl(mmio, chan->ddc_base) & SDA_VAL_IN));
 }
 
-static void i810ddc_setscl(void *data, int state)
-{
-        struct i810fb_i2c_chan    *chan = (struct i810fb_i2c_chan *)data;
-        struct i810fb_par       *par = chan->par;
-	u8                      *mmio = par->mmio_start_virtual;
-	
-	i810_writel(mmio, GPIOA, (state ? SCL_VAL_OUT : 0) | SCL_DIR |
-		    SCL_DIR_MASK | SCL_VAL_MASK);
-	i810_readl(mmio, GPIOA);	/* flush posted write */
-}
-
-static void i810ddc_setsda(void *data, int state)
-{
-        struct i810fb_i2c_chan    *chan = (struct i810fb_i2c_chan *)data;
-        struct i810fb_par         *par = chan->par;
-	u8                      *mmio = par->mmio_start_virtual;
-	
- 	i810_writel(mmio, GPIOA, (state ? SDA_VAL_OUT : 0) | SDA_DIR |
-		    SDA_DIR_MASK | SDA_VAL_MASK);
-	i810_readl(mmio, GPIOA);	/* flush posted write */
-}
-
-static int i810ddc_getscl(void *data)
-{
-        struct i810fb_i2c_chan    *chan = (struct i810fb_i2c_chan *)data;
-        struct i810fb_par         *par = chan->par;
-	u8                      *mmio = par->mmio_start_virtual;
-	
-	i810_writel(mmio, GPIOA, SCL_DIR_MASK);
-	i810_writel(mmio, GPIOA, 0);
-	return (0 != (i810_readl(mmio, GPIOA) & SCL_VAL_IN));
-}
 
-static int i810ddc_getsda(void *data)
-{
-        struct i810fb_i2c_chan    *chan = (struct i810fb_i2c_chan *)data;
-        struct i810fb_par         *par = chan->par;
-	u8                      *mmio = par->mmio_start_virtual;
-	
-	i810_writel(mmio, GPIOA, SDA_DIR_MASK);
-	i810_writel(mmio, GPIOA, 0);
-	return (0 != (i810_readl(mmio, GPIOA) & SDA_VAL_IN));
-}
-
-#define I2C_ALGO_DDC_I810   0x0e0000
-#define I2C_ALGO_I2C_I810   0x0f0000
-static int i810_setup_i2c_bus(struct i810fb_i2c_chan *chan, const char *name,
-			      int conn)
+#define I2C_ALGO_I810   0x0f0000
+static int i810_setup_i2c_bus(struct i810fb_i2c_chan *chan, const char *name)
 {
         int rc;
 
@@ -139,22 +94,11 @@ static int i810_setup_i2c_bus(struct i81
         chan->adapter.owner             = THIS_MODULE;
         chan->adapter.algo_data         = &chan->algo;
         chan->adapter.dev.parent        = &chan->par->dev->dev;
-	switch (conn) {
-	case 1:
-		chan->adapter.id                = I2C_ALGO_DDC_I810;
-		chan->algo.setsda               = i810ddc_setsda;
-		chan->algo.setscl               = i810ddc_setscl;
-		chan->algo.getsda               = i810ddc_getsda;
-		chan->algo.getscl               = i810ddc_getscl;
-		break;
-	case 2:
-		chan->adapter.id                = I2C_ALGO_I2C_I810;
-		chan->algo.setsda               = i810i2c_setsda;
-		chan->algo.setscl               = i810i2c_setscl;
-		chan->algo.getsda               = i810i2c_getsda;
-		chan->algo.getscl               = i810i2c_getscl;
-		break;
-	}
+	chan->adapter.id                = I2C_ALGO_I810;
+	chan->algo.setsda               = i810i2c_setsda;
+	chan->algo.setscl               = i810i2c_setscl;
+	chan->algo.getsda               = i810i2c_getsda;
+	chan->algo.getscl               = i810i2c_getscl;
 	chan->algo.udelay               = 10;
 	chan->algo.mdelay               = 10;
         chan->algo.timeout              = (HZ/2);
@@ -168,11 +112,15 @@ static int i810_setup_i2c_bus(struct i81
         udelay(20);
 
         rc = i2c_bit_add_bus(&chan->adapter);
+
         if (rc == 0) 
                 dev_dbg(&chan->par->dev->dev, "I2C bus %s registered.\n",name);
-        else
+        else {
                 dev_warn(&chan->par->dev->dev, "Failed to register I2C bus "
 			 "%s.\n", name);
+		chan->par = NULL;
+	}
+
         return rc;
 }
 
@@ -180,8 +128,14 @@ void i810_create_i2c_busses(struct i810f
 {
         par->chan[0].par        = par;
 	par->chan[1].par        = par;
-	i810_setup_i2c_bus(&par->chan[0], "I810-DDC", 1);
-	i810_setup_i2c_bus(&par->chan[1], "I810-I2C", 2);
+	par->chan[2].par        = par;
+
+	par->chan[0].ddc_base = GPIOA;
+	i810_setup_i2c_bus(&par->chan[0], "I810-DDC");
+	par->chan[1].ddc_base = GPIOB;
+	i810_setup_i2c_bus(&par->chan[1], "I810-I2C");
+	par->chan[2].ddc_base = GPIOC;
+	i810_setup_i2c_bus(&par->chan[2], "I810-GPIOC");
 }
 
 void i810_delete_i2c_busses(struct i810fb_par *par)
@@ -189,9 +143,14 @@ void i810_delete_i2c_busses(struct i810f
         if (par->chan[0].par)
                 i2c_bit_del_bus(&par->chan[0].adapter);
         par->chan[0].par = NULL;
+
 	if (par->chan[1].par)
 		i2c_bit_del_bus(&par->chan[1].adapter);
 	par->chan[1].par = NULL;
+
+	if (par->chan[2].par)
+		i2c_bit_del_bus(&par->chan[2].adapter);
+	par->chan[2].par = NULL;
 }
 
 static u8 *i810_do_probe_i2c_edid(struct i810fb_i2c_chan *chan)
@@ -221,6 +180,7 @@ static u8 *i810_do_probe_i2c_edid(struct
 		DPRINTK("i810-i2c: I2C Transfer successful\n");
                 return buf;
 	}
+
         DPRINTK("i810-i2c: Unable to read EDID block.\n");
         kfree(buf);
         return NULL;
@@ -233,7 +193,7 @@ int i810_probe_i2c_connector(struct fb_i
         int i;
 
 	DPRINTK("i810-i2c: Probe DDC%i Bus\n", conn);
-	if (conn < 3) {
+	if (conn < 4) {
 		for (i = 0; i < 3; i++) {
 			/* Do the real work */
 			edid = i810_do_probe_i2c_edid(&par->chan[conn-1]);
@@ -253,5 +213,3 @@ int i810_probe_i2c_connector(struct fb_i
 
         return (edid) ? 0 : 1;
 }
-
-
diff --git a/drivers/video/i810/i810.h b/drivers/video/i810/i810.h
--- a/drivers/video/i810/i810.h
+++ b/drivers/video/i810/i810.h
@@ -249,6 +249,7 @@ struct i810fb_i2c_chan {
 	struct i810fb_par *par;
 	struct i2c_adapter adapter;
 	struct i2c_algo_bit_data algo;
+	unsigned long ddc_base;
 };
 
 struct i810fb_par {
@@ -262,7 +263,7 @@ struct i810fb_par {
 	struct heap_data         iring;
 	struct heap_data         cursor_heap;
 	struct vgastate          state;
-	struct i810fb_i2c_chan   chan[2];
+	struct i810fb_i2c_chan   chan[3];
 	atomic_t                 use_count;
 	u32 pseudo_palette[17];
 	unsigned long mmio_start_phys;
diff --git a/drivers/video/i810/i810_main.c b/drivers/video/i810/i810_main.c
--- a/drivers/video/i810/i810_main.c
+++ b/drivers/video/i810/i810_main.c
@@ -1844,7 +1844,7 @@ static void __devinit i810fb_find_init_m
 #ifdef CONFIG_FB_I810_I2C
 	i810_create_i2c_busses(par);
 
-	for (i = 0; i < 3; i++) {
+	for (i = 0; i < 4; i++) {
 		err = i810_probe_i2c_connector(info, &par->edid, i+1);
 		if (!err)
 			break;
diff --git a/drivers/video/i810/i810_regs.h b/drivers/video/i810/i810_regs.h
--- a/drivers/video/i810/i810_regs.h
+++ b/drivers/video/i810/i810_regs.h
@@ -70,6 +70,7 @@
 #define HVSYNC                0x05000 
 #define GPIOA                 0x05010
 #define GPIOB                 0x05014 
+#define GPIOC                 0x0501C
 
 /* Clock Control and Power Management Registers (06000h 06FFFh) */
 #define DCLK_0D               0x06000


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
