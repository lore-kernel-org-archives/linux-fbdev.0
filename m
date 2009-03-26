From: pcolodron@uvigo.es
Subject: Xilinx framebuffer
Date: Thu, 26 Mar 2009 12:28:00 +0100
Message-ID: <20090326122800.1txn5bh4lps044g0@correoweb.uvigo.es>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <pcolodron@uvigo.es>) id 1Lmnkt-0003Pi-1J
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 26 Mar 2009 11:28:15 +0000
Received: from cebola.uvigo.es ([193.146.32.124])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Lmnkj-0005TQ-7D
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 26 Mar 2009 11:28:15 +0000
Received: from millo.uvigo.es (millo.uvigo.es [193.146.32.82])
	by cebola.uvigo.es (8.13.8/8.13.8/Debian-3) with ESMTP id
	n2QBS00L018672
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 26 Mar 2009 12:28:00 +0100
Received: from millo.uvigo.es (localhost [127.0.0.1])
	by millo.uvigo.es (8.13.8/8.13.8/Debian-3) with ESMTP id n2QBS0v6018840
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 26 Mar 2009 12:28:00 +0100
Received: (from www-data@localhost)
	by millo.uvigo.es (8.13.8/8.13.8/Submit) id n2QBS0rA018839
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 26 Mar 2009 12:28:00 +0100
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

Hi all,

My name is Pablo and I am a new subscriber of this list.

I have seen many post here related to the framebuffer driver  
'xilinxfb.c' and I hope you can solve some doubts that I have about it.

I am actually trying to generate a uClinux core for my Virtex4  
development kit, which uses Microblaze and has a Xilinx TFT controller  
IP core (which I have tested and it works correctly).

When it comes to boot the kernel, I have used some printk() functions  
to follow the execution flow because I am quite unexperienced in  
device drivers. I have seen something strange in silinxfb.c, and I  
would like you to tell me if this is a common error of begginer users.  
The issue is that I added printk() in the following parts of  
'xilinxfb.c':

/* ---------------------------------------------------------------------
   * Module setup and teardown
  */

  static int __init
  xilinxfb_init(void)
  {
          int rc;
	printk("step 1\n");
          rc = xilinxfb_of_register();
	printk("step 2\n");
          if (rc)
                  return rc;
  	printk("step 3\n");
          rc = platform_driver_register(&xilinxfb_platform_driver);
	printk("step 4, devuelve rc: %d\n",rc);

          if (rc)
                  xilinxfb_of_unregister();
	printk("step 5\n");

          return rc;
  }

I also added printk() in:

/* ---------------------------------------------------------------------
   * Platform bus binding
   */

  static int
  xilinxfb_platform_probe(struct platform_device *pdev)
  {
          struct xilinxfb_platform_data *pdata;
          struct resource *res;
  	printk("step 7\n");
          /* Find the registers address */
          res = platform_get_resource(pdev, IORESOURCE_IO, 0);
          if (!res) {
                  dev_err(&pdev->dev, "Couldn't get registers resource\n");
                  return -ENODEV;
          }

Checking the message on the console when the system boots, I can see  
the following:

io scheduler deadline registered
io scheduler cfq registered (default)
step 1
step 2
step 3
step 4
paso 5
xgpio0 #0 at 0x81400000 mapped to 0x81400000 device: 10,185 not using IRQ
xgpio1 #1 at 0x81420000 mapped to 0x81420000 device: 10,186 not using IRQ

I think this means that the function xilinxfb_platform_probe() in  
'xilinxfb.c' is not being executed and, as a consequence, either  
xilinxfb_assing() is. It seems logic because there are no message  
about the framebuffer in the boot log (in xilinxfb_assign there are  
some dev_dbg() functions that should show this information messages).

Do you have any idea about why this is happening? Other devices like  
xgpio are recognized by the kernel and the structure of the drivers is  
similar to the one used in xilinxfb.c. Moreover, in my uClinux system  
I can see the following:

# ls sys/bus/platform/drivers/
i8042        uartlite     xilinx_gpio  xilinxfb
# ls sys/bus/platform/devices/
i8042          uartlite.0     xilinx_gpio.0  xilinx_gpio.1

The driver is in the folder but there are no fb0 devices.

Any hint about all this would be very helpful.

Thank you very much.

Kind Regards,

Pablo Colodron



------------------------------------------------------------------------------
