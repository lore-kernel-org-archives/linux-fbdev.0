From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [PATCH 1/2] fbdev: S3 Savage Framebuffer Driver
Date: Thu, 11 Nov 2004 10:23:29 +0800
Message-ID: <200411111023.29902.adaplas@hotpop.com>
References: <200410230436.42009.adaplas@hotpop.com> <20041110191735.GA19864@middle.of.nowhere>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CS4dD-000512-N4
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 10 Nov 2004 18:24:15 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CS4dC-0006fk-Ef
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 10 Nov 2004 18:24:15 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 6E9619CF4F9
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 11 Nov 2004 02:24:00 +0000 (UTC)
In-Reply-To: <20041110191735.GA19864@middle.of.nowhere>
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sourceforge.net, Jurriaan <thunder7@xs4all.nl>

On Thursday 11 November 2004 03:17, Jurriaan wrote:
> From: Antonino A. Daplas <adaplas@hotpop.com>
> Date: Sat, Oct 23, 2004 at 04:36:41AM +0800
>
> > S3 Savage Frambuffer Driver for the following chipsets:
> >
> > Savage 3D
> > Savage MX
> > Savage 4
> > Savage 2000
> > ProSavage
> > SuperSavage
>
> Excellent. I tried this (in 2.6.10-rc1-mm4) with my Thinkpad T23, which
> has a SuperSavage IX/C SDR according to lspci.
>
> If I compile the framebuffer into the kernel, it hangs during boot. The
> oops is only partly visible, but the first line of the traceback
> contains savage_setup_i2c_bus.

Ok, this is a bug that is triggered when the particular chipset has no
i2c support.

>
> If I compile it as a module, it comes up with 800x600, which looks like
> sh*t on a 1024x768 lcd panel. All my attempts to change the resolution,
> either with fbset, or variations on this command
>
> modprobe savagefb mode=1024x768-60
>
> didn't work.

Ok, this is another bug that prevents mode changing if the EDID block
is not found.

>
> Would you give me any hints on how to get it to come up with 1024x768?

With the attached patch, which fixes both bugs, you can boot with:

video=savagefb:1024x768@60

and use fbset to your heart's content. But without an EDID block, no mode
validating is done.

> I would love to see if it's faster than the vesa framebuffer I've been
> using so far.

Should be, at least console-wise, if acceleration is enabled. Significant,
but not to full potential, since in accelerated mode, the virtual resolution
is limited at 4096.

Thanks for reporting the bugs.  I'm also submitting the patch to Andrew.

Tony

diff -Nru a/drivers/video/savage/savagefb-i2c.c b/drivers/video/savage/savagefb-i2c.c
--- a/drivers/video/savage/savagefb-i2c.c	2004-10-27 15:25:25 +08:00
+++ b/drivers/video/savage/savagefb-i2c.c	2004-11-11 09:55:43 +08:00
@@ -141,32 +141,37 @@
 static int savage_setup_i2c_bus(struct savagefb_i2c_chan *chan,
 				const char *name)
 {
-	int rc;
+	int (*add_bus)(struct i2c_adapter *) = symbol_get(i2c_bit_add_bus);
+	int rc = 0;
+
+	if (add_bus && chan->par) {
+		strcpy(chan->adapter.name, name);
+		chan->adapter.owner		= THIS_MODULE;
+		chan->adapter.id		= I2C_ALGO_SAVAGE;
+		chan->adapter.algo_data		= &chan->algo;
+		chan->adapter.dev.parent	= &chan->par->pcidev->dev;
+		chan->algo.udelay		= 40;
+		chan->algo.mdelay               = 5;
+		chan->algo.timeout		= 20;
+		chan->algo.data 		= chan;
+
+		i2c_set_adapdata(&chan->adapter, chan);
+
+		/* Raise SCL and SDA */
+		chan->algo.setsda(chan, 1);
+		chan->algo.setscl(chan, 1);
+		udelay(20);
+
+		rc = add_bus(&chan->adapter);
+		if (rc == 0)
+			dev_dbg(&chan->par->pcidev->dev,
+				"I2C bus %s registered.\n", name);
+		else
+			dev_warn(&chan->par->pcidev->dev,
+				 "Failed to register I2C bus %s.\n", name);
+	} else
+		chan->par = NULL;
 
-	strcpy(chan->adapter.name, name);
-	chan->adapter.owner		= THIS_MODULE;
-	chan->adapter.id		= I2C_ALGO_SAVAGE;
-	chan->adapter.algo_data		= &chan->algo;
-	chan->adapter.dev.parent	= &chan->par->pcidev->dev;
-	chan->algo.udelay		= 40;
-	chan->algo.mdelay               = 5;
-	chan->algo.timeout		= 20;
-	chan->algo.data 		= chan;
-
-	i2c_set_adapdata(&chan->adapter, chan);
-
-	/* Raise SCL and SDA */
-	chan->algo.setsda(chan, 1);
-	chan->algo.setscl(chan, 1);
-	udelay(20);
-
-	rc = i2c_bit_add_bus(&chan->adapter);
-	if (rc == 0)
-		dev_dbg(&chan->par->pcidev->dev,
-			"I2C bus %s registered.\n", name);
-	else
-		dev_warn(&chan->par->pcidev->dev,
-			 "Failed to register I2C bus %s.\n", name);
 	return rc;
 }
 
@@ -174,7 +179,7 @@
 {
 	struct savagefb_par *par = (struct savagefb_par *)info->par;
 	par->chan.par	= par;
-
+
 	switch(info->fix.accel) {
 	case FB_ACCEL_PROSAVAGE_DDRK:
 	case FB_ACCEL_PROSAVAGE_PM:
@@ -193,6 +198,8 @@
 		par->chan.algo.getsda = savage4_gpio_getsda;
 		par->chan.algo.getscl = savage4_gpio_getscl;
 		break;
+	default:
+		par->chan.par = NULL;
 	}
 
 	savage_setup_i2c_bus(&par->chan, "SAVAGE DDC2");
@@ -202,9 +209,12 @@
 void savagefb_delete_i2c_busses(struct fb_info *info)
 {
 	struct savagefb_par *par = (struct savagefb_par *)info->par;
+	int (*del_bus)(struct i2c_adapter *) =
+		symbol_get(i2c_bit_del_bus);
+
+	if (del_bus && par->chan.par)
+		del_bus(&par->chan.adapter);
 
-	if (par->chan.par)
-		i2c_bit_del_bus(&par->chan.adapter);
 	par->chan.par = NULL;
 }
 EXPORT_SYMBOL(savagefb_delete_i2c_busses);
@@ -212,6 +222,8 @@
 static u8 *savage_do_probe_i2c_edid(struct savagefb_i2c_chan *chan)
 {
 	u8 start = 0x0;
+	int (*transfer)(struct i2c_adapter *, struct i2c_msg *, int) =
+		symbol_get(i2c_transfer);
 	struct i2c_msg msgs[] = {
 		{
 			.addr	= SAVAGE_DDC,
@@ -223,20 +235,23 @@
 			.len	= EDID_LENGTH,
 		},
 	};
-	u8 *buf;
+	u8 *buf = NULL;
 
-	buf = kmalloc(EDID_LENGTH, GFP_KERNEL);
-	if (!buf) {
-		dev_warn(&chan->par->pcidev->dev, "Out of memory!\n");
-		return NULL;
+	if (transfer && chan->par) {
+		buf = kmalloc(EDID_LENGTH, GFP_KERNEL);
+		if (buf) {
+			msgs[1].buf = buf;
+
+			if (transfer(&chan->adapter, msgs, 2) != 2) {
+				dev_dbg(&chan->par->pcidev->dev,
+					"Unable to read EDID block.\n");
+				kfree(buf);
+				buf = NULL;
+			}
+		}
 	}
-	msgs[1].buf = buf;
 
-	if (i2c_transfer(&chan->adapter, msgs, 2) == 2)
-		return buf;
-	dev_dbg(&chan->par->pcidev->dev, "Unable to read EDID block.\n");
-	kfree(buf);
-	return NULL;
+	return buf;
 }
 
 int savagefb_probe_i2c_connector(struct savagefb_par *par, u8 **out_edid)
diff -Nru a/drivers/video/savage/savagefb.c b/drivers/video/savage/savagefb.c
--- a/drivers/video/savage/savagefb.c	2004-10-30 19:10:43 +08:00
+++ b/drivers/video/savage/savagefb.c	2004-11-11 09:55:43 +08:00
@@ -738,7 +738,7 @@
 		}
 	}
 
-	if (!mode_valid && !list_empty(&info->modelist))
+	if (!mode_valid && info->monspecs.modedb_len)
 		return -EINVAL;
 
 	/* Is the mode larger than the LCD panel? */
@@ -1821,43 +1821,43 @@
 		break;
 	case FB_ACCEL_SAVAGE_MX_MV:
 		par->chip = S3_SAVAGE_MX;
-		snprintf (info->fix.id, 16, "S3 Savage/MX-MV");
+		snprintf (info->fix.id, 16, "Savage/MX-MV");
 		break;
 	case FB_ACCEL_SAVAGE_MX:
 		par->chip = S3_SAVAGE_MX;
-		snprintf (info->fix.id, 16, "S3 Savage/MX");
+		snprintf (info->fix.id, 16, "Savage/MX");
 		break;
 	case FB_ACCEL_SAVAGE_IX_MV:
 		par->chip = S3_SAVAGE_MX;
-		snprintf (info->fix.id, 16, "S3 Savage/IX-MV");
+		snprintf (info->fix.id, 16, "Savage/IX-MV");
 		break;
 	case FB_ACCEL_SAVAGE_IX:
 		par->chip = S3_SAVAGE_MX;
-		snprintf (info->fix.id, 16, "S3 Savage/IX");
+		snprintf (info->fix.id, 16, "Savage/IX");
 		break;
 	case FB_ACCEL_PROSAVAGE_PM:
 		par->chip = S3_PROSAVAGE;
-		snprintf (info->fix.id, 16, "S3 ProSavage");
+		snprintf (info->fix.id, 16, "ProSavagePM");
 		break;
 	case FB_ACCEL_PROSAVAGE_KM:
 		par->chip = S3_PROSAVAGE;
-		snprintf (info->fix.id, 16, "S3 ProSavage");
+		snprintf (info->fix.id, 16, "ProSavageKM");
 		break;
 	case FB_ACCEL_S3TWISTER_P:
 		par->chip = S3_PROSAVAGE;
-		snprintf (info->fix.id, 16, "S3 Twister");
+		snprintf (info->fix.id, 16, "TwisterP");
 		break;
 	case FB_ACCEL_S3TWISTER_K:
 		par->chip = S3_PROSAVAGE;
-		snprintf (info->fix.id, 16, "S3 TwisterK");
+		snprintf (info->fix.id, 16, "TwisterK");
 		break;
 	case FB_ACCEL_PROSAVAGE_DDR:
 		par->chip = S3_PROSAVAGE;
-		snprintf (info->fix.id, 16, "S3 ProSavage DDR");
+		snprintf (info->fix.id, 16, "ProSavageDDR");
 		break;
 	case FB_ACCEL_PROSAVAGE_DDRK:
 		par->chip = S3_PROSAVAGE;
-		snprintf (info->fix.id, 16, "S3 ProSavage DDR-K");
+		snprintf (info->fix.id, 16, "ProSavage8");
 		break;
 	}
 
@@ -2033,14 +2033,13 @@
 
 
 	fb_destroy_modedb(info->monspecs.modedb);
-	info->monspecs.modedb_len = 0;
 	info->monspecs.modedb = NULL;
 
 	err = register_framebuffer (info);
 	if (err < 0)
 		goto failed;
 
-	printk (KERN_INFO "fb: %s frame buffer device\n",
+	printk (KERN_INFO "fb: S3 %s frame buffer device\n",
 		info->fix.id);
 
 	/*




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
