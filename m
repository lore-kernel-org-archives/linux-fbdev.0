From: Mark Pustjens <pustjens@dds.nl>
Subject: Re: [PATCH] savagefb: vsync for twisterP
Date: Tue, 9 Jan 2007 12:12:29 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0701091211080.2709@localhost.localdomain>
References: <Pine.LNX.4.64.0612201036130.2728@localhost.localdomain>
	<Pine.LNX.4.64.0612201059100.2728@localhost.localdomain>
	<20061220083735.84ea3c5f.randy.dunlap@oracle.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H4EuH-00077W-P8 for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 09 Jan 2007 03:12:41 -0800
Received: from smtpq3.tilbu1.nb.home.nl ([213.51.146.202])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1H4EuG-0005by-Er
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 09 Jan 2007 03:12:41 -0800
Received: from [213.51.146.188] (port=33264 helo=smtp3.tilbu1.nb.home.nl)
	by smtpq3.tilbu1.nb.home.nl with esmtp (Exim 4.30)
	id 1H4EuD-0001iZ-AS for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 09 Jan 2007 12:12:37 +0100
Received: from cp210686-b.roemd1.lb.home.nl ([84.28.106.175]:50341
	helo=[192.168.1.100])
	by smtp3.tilbu1.nb.home.nl with esmtp (Exim 4.30) id 1H4Eu7-0007MP-PH
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 09 Jan 2007 12:12:32 +0100
In-Reply-To: <20061220083735.84ea3c5f.randy.dunlap@oracle.com>
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

On Wed, 20 Dec 2006, Randy Dunlap wrote:

> On Wed, 20 Dec 2006 10:59:32 +0100 (CET) Mark Pustjens wrote:
>
>> Ofcourse, I have to actually *add* the patch :)
>
> Preferably not as an attachment, but as inline text.
> Pine can usually do that without problems.
>
>
>> On Wed, 20 Dec 2006, Mark Pustjens wrote:
>>
>>> Hi,
>>>
>>> This patch add support to the savagefb driver for
>>> waiting for vsync for the TwisterP chipset.
>>>
>>> The patch adds an ioctl FBIO_WAITFORVSYNC just like the
>>> matroxfb driver.
>>>
>>> It probably needs some work.
>
> Here are some comments.
>
.... snip ....
>
> ---
> ~Randy
>

Thanks for your comments. Here is the cleaned-up patch.

Greetings,

Mark

diff -Naur linux-2.6.19.1-org/drivers/video/savage/savagefb_driver.c linux-2.6.19.1-new/drivers/video/savage/savagefb_driver.c
--- linux-2.6.19.1-org/drivers/video/savage/savagefb_driver.c	2006-12-11 20:32:53.000000000 +0100
+++ linux-2.6.19.1-new/drivers/video/savage/savagefb_driver.c	2007-01-09 11:00:01.000000000 +0100
@@ -4,6 +4,9 @@
   * Copyright (c) 2001-2002  Denis Oliver Kropp <dok@directfb.org>
   *                          Sven Neumann <neo@directfb.org>
   *
+ * Copyright (c) 2006 TPO Displays Corp
+ *                    adapted by Mark Pustjens <pustjens@dds.nl> to
+ *                    include vsync interrupt support.
   *
   * Card specific code is based on XFree86's savage driver.
   * Framebuffer framework code is based on code of cyber2000fb and tdfxfb.
@@ -526,6 +529,125 @@
  }
  #endif

+static irqreturn_t savagefb_irq(int irq, void *dev_id, struct pt_regs *fp)
+{
+	struct savagefb_par *par = dev_id;
+	u_int32_t status;
+	int handled = 0;
+	unsigned char b;
+
+	vga_out8(0x3d4, 0x11, par);
+	if ((((b = vga_in8(0x3d5, par)) & 0x30) == 0x10) && 
+			(vga_in8(0x3da, par) & 0x08)) {
+		par->vsync.cnt++;
+		wake_up_interruptible(&par->vsync.wait);
+		vga_out8(0x3d5, (b & 0xef) | 0x20, par);
+		handled = 1;
+	}
+
+	return IRQ_RETVAL(handled);
+}
+
+int savagefb_enable_irq(struct fb_info *info, int reenable)
+{
+	struct savagefb_par *par = (struct savagefb_par *)info->par;
+
+	if (info->fix.accel != FB_ACCEL_S3TWISTER_P)
+		return -EINVAL;
+
+	if (!test_and_set_bit(0, &par->irq_flags)) {
+		if (request_irq(par->pcidev->irq, savagefb_irq,
+				IRQF_SHARED, "savagefb", par)) {
+			clear_bit(0, &par->irq_flags);
+			return -EINVAL;
+		}
+		vga_out8(0x3d4, 0x11, par);
+		vga_out8(0x3d5, (vga_in8(0x3d5, par) | 0x10) & 0xdf, par);
+	} else if (reenable) {
+		unsigned char b;
+		vga_out8(0x3d4, 0x11, par);
+		b = vga_in8(0x3d5, par);
+		if ((b & 0x20) == 0x20) {
+			printk(KERN_DEBUG "savagefb: someone disabled vertical retrace interrupt [0x%02X]\n", b);
+		} else if ((b & 0x10) == 0x00) {
+			printk(KERN_DEBUG "savagefb: interrupt enabled but interrupt cleared [0x%02X]\n", b);
+		}
+		vga_out8(0x3d5, (b | 0x10) & 0xdf, par);
+	}
+	return 0;
+}
+
+static void savagefb_disable_irq(struct fb_info *info)
+{
+	struct savagefb_par *par = (struct savagefb_par *)info->par;
+
+	if (test_and_clear_bit(0, &par->irq_flags)) {
+		/* disabling the interrupt in hardware was done in
+		   the interrupt handler */
+		vga_out8(0x3d4, 0x17, par);
+		while ((vga_in8(0x3da, par) & 0x08) == 0x00);
+
+		/* wait until it is save to call free_irq */ 
+	/*	VerticalRetraceWait(par); */
+		free_irq(par->pcidev->irq, par);
+	}
+}
+
+int savagefb_wait_for_vsync(struct fb_info *info, u32 crtc)
+{
+	struct savagefb_par *par = (struct savagefb_par *)info->par;
+	struct savagefb_vsync *vs;
+	unsigned int cnt;
+	int ret;
+
+	switch (crtc) {
+	case 0: 
+		vs = &par->vsync;
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	ret = savagefb_enable_irq(info, 0);
+	if (ret)
+		return ret;
+
+	cnt = vs->cnt;
+	ret = wait_event_interruptible_timeout(vs->wait, cnt != vs->cnt, HZ*10);
+	savagefb_disable_irq(info);
+	if (ret < 0)
+		return ret;
+	if (ret == 0) {
+		savagefb_enable_irq(info, 1);
+		printk (KERN_ERR "savagefb timeout while waiting for vsync\n");
+		return -ETIMEDOUT;
+	}
+	return 0;
+}
+
+static int savagefb_ioctl(struct inode *inode, struct file *file,
+				unsigned int cmd, unsigned long arg,
+				struct fb_info *info)
+{
+	void __user *argp = (void __user *)arg;
+	struct savagefb_par *par = (struct savagefb_par *)info->par;
+
+	DBG(__FUNCTION__)
+
+	switch (cmd) {
+	case FBIO_WAITFORVSYNC:
+		{
+			u_int32_t crt;
+
+			if (get_user(crt, (__u32 __user *) arg))
+				return -EFAULT;
+
+			return savagefb_wait_for_vsync(info, crt);
+		}
+	}
+	return -ENOTTY;
+}
+
  /* --------------------------------------------------------------------- */

  static void savage_get_default_par(struct savagefb_par *par, struct savage_reg *reg)
@@ -1458,6 +1580,10 @@
  	vga_out8(0x3d4, 0x3a, par);
  	vga_out8(0x3d5, cr3a, par);

+	/* enable the possibility of irqs */
+	vga_out8 (0x3d4, 0x32, par);
+	vga_out8 (0x3d5, vga_in8(0x3d5, par) | 0x10, par);
+
  	SavageSetup2DEngine(par);
  	vgaHWProtect(par, 0);
  }
@@ -1616,6 +1742,7 @@
  	.fb_setcolreg   = savagefb_setcolreg,
  	.fb_pan_display = savagefb_pan_display,
  	.fb_blank       = savagefb_blank,
+	.fb_ioctl       = savagefb_ioctl,
  	.fb_save_state  = savagefb_save_state,
  	.fb_restore_state = savagefb_restore_state,
  #if defined(CONFIG_FB_SAVAGE_ACCEL)
@@ -2169,6 +2296,9 @@
  		goto failed_enable;
  	}

+	init_waitqueue_head(&par->vsync.wait);
+	par->irq_flags = 0;
+
  	err = -ENOMEM;

  	if ((err = savage_init_fb_info(info, dev, id)))
diff -Naur linux-2.6.19.1-org/drivers/video/savage/savagefb.h linux-2.6.19.1-new/drivers/video/savage/savagefb.h
--- linux-2.6.19.1-org/drivers/video/savage/savagefb.h	2006-12-11 20:32:53.000000000 +0100
+++ linux-2.6.19.1-new/drivers/video/savage/savagefb.h	2007-01-09 10:37:56.000000000 +0100
@@ -50,7 +50,16 @@
  #define PCI_CHIP_SUPSAV_IXCSDR		0x8c2e
  #define PCI_CHIP_SUPSAV_IXCDDR		0x8c2f

-
+#define S3_TWISTERP_INT_VSYNC	0x00000001
+#define S3_TWISTERP_INT_GEBSY	0x00000002 /* 2D graphics engine busy */
+#define S3_TWISTERP_INT_BFF	0x00000004 /* bfifo full */
+#define S3_TWISTERP_INT_BFE	0x00000008 /* bfifo empty */
+#define S3_TWISTERP_INT_CFF	0x00000010 /* cfifo full */
+#define S3_TWISTERP_INT_CFE	0x00000020 /* cfifo empty */
+#define S3_TWISTERP_INT_BCI	0x00000040
+#define S3_TWISTERP_INT_CBUT	0x00010000 /* command overflow upper threshold */
+#define S3_TWISTERP_INT_CBLT	0x00020000 /* command overflow lower threshold */
+#define S3_TWISTERP_INT_MASK	0x0003007F

  #define S3_SAVAGE3D_SERIES(chip)  ((chip>=S3_SAVAGE3D) && (chip<=S3_SAVAGE_MX))

@@ -60,6 +69,9 @@

  #define S3_SAVAGE_SERIES(chip)    ((chip>=S3_SAVAGE3D) && (chip<=S3_SAVAGE2000))

+ /* ioctls */
+#define FBIO_WAITFORVSYNC     _IOW('F', 0x20, u_int32_t)
+
  /* Chip tags.  These are used to group the adapters into
   * related families.
   */
@@ -183,10 +195,16 @@
  	u32   reg;
  };

+struct savagefb_vsync {
+	wait_queue_head_t       wait;
+	unsigned int            cnt;
+};
+
  struct savagefb_par {
  	struct pci_dev *pcidev;
  	savage_chipset  chip;
  	struct savagefb_i2c_chan chan;
+	struct savagefb_vsync vsync;
  	struct savage_reg state;
  	struct savage_reg save;
  	unsigned char   *edid;
@@ -223,6 +241,8 @@
  	u32           cob_size;
  	int           cob_index;

+	unsigned long irq_flags;
+
  	void (*SavageWaitIdle) (struct savagefb_par *par);
  	void (*SavageWaitFifo) (struct savagefb_par *par, int space);


-- 
The night is always old. He'd walked too often down dark streets in the secret
hours and felt the night stretching away, and known in his blood that while
days and kings and empires come and go, the night is always the same age,
always aeons deep. Terrors unfolded in the velvet shadows and while the nature
of the talons may change, the nature of the beast does not.
   (Jingo)


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
